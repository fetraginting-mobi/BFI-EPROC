using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;

public partial class module_inventory_refundinventoryamortizationheaderlist : BasePageList
{
    private static string TABLE_NAME = "REFUND_INVENTORY_AMORTIZATION_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "REFUND_INVENTORY_AMORTIZATION_HEADER";
        NEXT_PAGE = "refundinventoryamortizationheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll(ddlBranch);

            BindData();
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
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
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_paid_status"] = ddlPaidStatus.SelectedValue;
            Shared.ApplyDefaultProp(_ht);
            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = code;
            Shared.ApplyDefaultProp(_ht);
            _dal.Delete(TABLE_NAME, _ht);
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
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("refundinventoryamortizationheader.aspx?action=add");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindData();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("refundinventoryamortizationheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());
    }

 
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }


    protected void ddlPaidStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
