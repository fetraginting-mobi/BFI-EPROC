using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_fa_famutationreceiptlistlist : BasePageList
{
    private static string TABLE_NAME = "FA_REQUEST_MUTATION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();


        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            Shared.BindBranchAll(ddlBranch);
            Shared.BindFaLocationAll(ddlToLocationCode, txtBranch.Text);
            btnCancel.OnClientClick = "return confirm('Cancel selected data?');";

            BindData();
        }

        LoadAfterInit();
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        // DataView dv = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            //_ht["p_user_id"] = Shared.CurrentUID;

            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_branch_to"] = txtBranch.Text;
            _ht["p_to_location"] = ddlToLocationCode.SelectedValue;
            _ht["p_status_received"] = ddlStatus.SelectedValue;




            gvwList.DataSource = _dal.GetRows("", "xsp_fa_mutation_receipt_list_getrows", _ht);
            gvwList.DataBind();
            
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    private void SaveData(string IR_CODE, DateTime Date)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_im_code"] = IR_CODE;
            _ht["p_receive_date"] = Date;

            Shared.ApplyDefaultProp(_ht);

            _dal.Update("", "xsp_fa_mutation_receipt_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("famutationreceiptlistlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void CancelData(string code, string remark)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = code;
            _ht["p_remark_unpost"] = remark;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_fa_mutation_receipt_list_cancel", _ht);
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Int16 iRowSelected = 0;

        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                iRowSelected++;

                DateTime Date = Shared.ToDateTime(((TextBox)row.Cells[5].Controls[1]).Text);
             
                SaveData(gvwList.DataKeys[row.RowIndex][0].ToString(), Date);
            }
        }



        BindData();
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Int16 iRowSelected = 0;

        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                iRowSelected++;
                String Remark = (((TextBox)row.Cells[6].Controls[1]).Text);
             

                CancelData(gvwList.DataKeys[row.RowIndex][0].ToString(),Remark);
            }
        }

        BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //if (Request.Params["action"].Equals("edit"))
        BindData();
    }

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("famutationreceiptlist.aspx?action=edit&fm_code=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlToLocationCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

}