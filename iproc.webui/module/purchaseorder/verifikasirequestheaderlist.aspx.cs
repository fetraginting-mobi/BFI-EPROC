using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_verifikasirequestheaderlist : BasePageList
{
    private static string TABLE_NAME = "PURCHASE_REQUEST_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "PURCHASE_REQUEST_HEADER";
        NEXT_PAGE = "purchaserequestheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll(ddlBranch);
            Shared.BindOwnerAll(ddlOwner);
            txtempcode.Text = Shared.CurrentUID;

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
        }
        LoadAfterInit();
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_emp_code"] = txtempcode.Text;

            //(+) Ari 11-07-2022 ket : enhancement 2022
            _ht["p_from_date"] = Shared.ToStartDateTime(txtFromDate.Text);
            _ht["p_to_date"] = Shared.ToStartDateTime(txtToDate.Text);
            _ht["p_owner"] = ddlOwner.SelectedValue;

            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_purchase_request_header_getrows_verifikasi", _ht);
            gvwList.DataBind();
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


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("verifikasirequestheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlOwner_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
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

