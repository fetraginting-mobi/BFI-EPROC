using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_accrecurringheader : BasePage
{
    private static string TABLE_NAME = "ACC_RECURRING_HEADER";
    private static string TABLE_NAME_DETAIL = "ACC_RECURRING_DETAIL";
    private static string TABLE_NAME_SCHEDULE = "ACC_RECURRING_SCHEDULE";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindPayment(ddlFrequency);
            btnLookUpBranch.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRN&acol_0={0}&bcol_1={1}');", txtBranchCode.ClientID, txtBranch.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataDetail();
                BindSchedule();
                btnCancel.Text = "Back";
                btnCancel.Text = "<i class='icon-arrow-left'></i> Back";

                 
            }

            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
           
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_recurring_no"] = Request.Params["recurringno"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);
            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string sNextCode = string.Empty;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextCode);
                lblRecNo.Text = sNextCode;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("accrecurringheader.aspx?action=edit&recurringno={0}", lblRecNo.Text));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_recurring_no"] = lblRecNo.Text;
            Shared.ApplyDefaultProp(_ht);


            _dal.ExecRawSP("xsp_acc_recurring_schedule_generate", _ht);
       
            

            Shared.ShowSuccessGritter(this, string.Format("accrecurringheader.aspx?action=edit&recurringno={0}", lblRecNo.Text));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("accrecurringheaderlist.aspx");
    }

    #region DETAIL
    private void BindDataDetail()
    {
       
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //sorting gridview
        DataView dv = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDetail.Text;
            _ht["p_header_code"] = Request.Params["recurringno"];

            //Add sorting griedview - 5/27/2016 9:06:30 AM - Lian  
            dv = _dal.GetRows(TABLE_NAME_DETAIL, _ht).DefaultView;

            if (dir == SortDirection.Ascending)
                dv.Sort = expression + " ASC";
            else
                dv.Sort = expression + " DESC";

            gvwListDetail.DataSource = dv;

            //gvwListDetail.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwListDetail.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchDetail_Click(object sender, EventArgs e)
    {
        BindDataDetail();
    }
    protected void gvwListDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDetail.PageIndex = e.NewPageIndex;
        BindDataDetail();
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("accrecurringdetail.aspx?action=add&recurringno={0}", lblRecNo.Text));
    }
    private void DeleteData(string HEADER_CODE, string CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();


            _ht["p_header_code"] = HEADER_CODE;
            _ht["p_code"] = CODE;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(Request.Params["recurringno"], gvwListDetail.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindDataDetail();
    }
    protected void gvwListDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("accrecurringdetail.aspx?action=edit&recurringno=" + lblRecNo.Text + "&code=" + gvwListDetail.SelectedDataKey[0].ToString());
    }

    protected void gvwListDetail_Sorting(object sender, GridViewSortEventArgs e)
    {
        {
            if (dir == SortDirection.Ascending)
                dir = SortDirection.Descending;
            else
                dir = SortDirection.Ascending;

            expression = e.SortExpression;
        }

        BindDataDetail();
    }

    public SortDirection dir
    {

        get
        {
            if (ViewState["dirState"] == null)
            {
                ViewState["dirState"] = SortDirection.Ascending;
            }

            return (SortDirection)ViewState["dirState"];
        }

        set { ViewState["dirState"] = value; }
    }

    public string expression
    {

        get
        {
            if (ViewState["expressionState"] == null)
            {
                ViewState["expressionState"] = "COA_NAME";
            }

            return (string)ViewState["expressionState"];
        }

        set { ViewState["expressionState"] = value; }
    }
    #endregion

    # region Schedule
    private void BindSchedule()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchSchedule.Text;
            _ht["p_header_code"] = lblRecNo.Text;


            gvwListSchedule.DataSource = _dal.GetRows(TABLE_NAME_SCHEDULE, _ht);
            gvwListSchedule.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListSchedule_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListSchedule.PageIndex = e.NewPageIndex;
        BindSchedule();
    }

    protected void btnSearchSchedule_Click(object sender, EventArgs e)
    {
        if (lblRecNo.Text != string.Empty)
            BindSchedule();
    }

    # endregion
}
