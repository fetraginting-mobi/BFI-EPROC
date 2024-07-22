using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_purchaserequesttenderlist : BasePageList
{
    private static string TABLE_NAME_REQUEST = "PURCHASE_REQUEST_TENDER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "PURCHASE_REQUEST_TENDER";
        NEXT_PAGE = "purchaserequesttender.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            Shared.BindBranchEmployee(ddlBranch);
            ddlBranch.Items.Insert(0, "ALL");

            //(+) Ari 11-07-2022 ket : enhancement 2022
            if (string.IsNullOrEmpty(txtToDate.Text))
            {
                //set tgl skrg
                txtToDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

                //set tgl 30 hari sebelum hari ini
                DateTime date = new DateTime(DateTime.Now.Year, 1, 1).AddDays(DateTime.Now.DayOfYear - 30);
                txtFromDate.Text = date.ToString("dd/MM/yyyy");

            }

            BindData();
            btnPublish.OnClientClick = "return confirm('Publish selected data?');";

        }
        LoadAfterInit();
    }

    #region Request
    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_supplier_code"] = Shared.CurrentUID;
            _ht["p_status"] = "NEW";
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            //(+) Ari 11-07-2022 ket : enhancement 2022
            _ht["p_from_date"] = Shared.ToStartDateTime(txtFromDate.Text);
            _ht["p_to_date"] = Shared.ToStartDateTime(txtToDate.Text);
            _ht["p_emp_code"] = Shared.CurrentUID;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_REQUEST, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void Publish(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        //if (!SelectedExist())
        //{
        //    Exception ex = null;
        //    ex = new Exception("No Transaction Selected !");
        //    Shared.ShowErrorDialog(this, ex);
        //    return;
        //}
         

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = code;
            Shared.ApplyDefaultProp(_ht);
            _dal.ExecRawSP("xsp_purchase_request_tender_publish", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    public void SaveChecklist()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        
        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }
        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(upd.Controls, _ht);

        try
        {


            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    TextBox txtExpDate = (row.Cells[6].Controls[1] as TextBox);

                    _ht["p_code_barcode"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_exp_date"] = Shared.ToDateTime(txtExpDate.Text);

                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "xsp_purchase_request_tender_update_exp_date", _ht);
                }


            }
            Shared.ShowSuccessGritter(this, string.Format("purchaserequesttenderlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("purchaserequesttender.aspx?action=edit&codebarcode={0}", gvwList.SelectedDataKey[0].ToString()));
    }
    protected void btnPublish_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                Publish(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindData();
    }

    protected void btnSaveChecklist_Click(object sender, EventArgs e)
    {
        SaveChecklist();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
    #endregion

    //(+) Ari 11-07-2022 ket : enhancement 2022
    //protected void txtFromDate_TextChanged(object sender, EventArgs e)
    //{
    //    BindData();
    //}
    protected void txtToDateChanged(object sender, EventArgs e)
    {

        BindData();
    }
}
