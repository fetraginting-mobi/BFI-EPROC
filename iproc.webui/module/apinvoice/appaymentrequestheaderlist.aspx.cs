using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_apinvoice_appaymentrequestheaderlist : BasePageList
{
    private static string TABLE_NAME_HEADER = "AP_PAYMENT_REQUEST_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "AP_PAYMENT_REQUEST_HEADER";
        NEXT_PAGE = "appaymentrequestheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindOwnerAll(ddlOwner);

            //(+) Ari 11-07-2022 ket : enhancement 2022
            ddlBranch.Items.Insert(0, "ALL");
            if (string.IsNullOrEmpty(txtToDate.Text))
            {
                //set tgl skrg
                txtToDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

                //set tgl 30 hari sebelum hari ini
                DateTime date = new DateTime(DateTime.Now.Year, 1, 1).AddDays(DateTime.Now.DayOfYear - 30);
                txtFromDate.Text = date.ToString("dd/MM/yyyy");

            }
            BindData();
            //btnDeleteAPPaymentReqHeader.OnClientClick = "return confirm('Delete selected data?');";
        }
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            //(+) Ari 11-07-2022 ket : enhancement 2022
            _ht["p_from_date"] = Shared.ToStartDateTime(txtFromDate.Text);
            _ht["p_to_date"] = Shared.ToStartDateTime(txtToDate.Text);
            _ht["p_emp_code"] = Shared.CurrentUID;
            _ht["p_owner"] = ddlOwner.SelectedValue;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_HEADER, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void DeleteData(string code)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_code_barcode"] = code;

    //        _dal.Delete(TABLE_NAME_HEADER, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    //protected void btnAddAPPaymentReqHeader_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("appaymentrequestheader.aspx?action=add");
    //}

    //protected void btnDeleteAPPaymentReqHeader_Click(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in gvwList.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
    //        }
    //    }

    //    BindData();
    //}

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("appaymentrequestheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());
    }

   
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    //(+) Ari 11-07-2022 ket : enhancement 2022
    protected void txtToDateChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlOwner_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
