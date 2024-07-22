using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_apinvoice_apdepositallocationheaderlist : BasePageList
{
    private static string TABLE_NAME_HEADER = "AP_DEPOSIT_ALLOCATION_HEADER";

  

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "AP_DEPOSIT_ALLOCATION_HEADER";
        NEXT_PAGE = "apdepositallocationheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeSort(ddlBranch);

            BindData();
            btnDeleteAPDepositAllocationHeader.OnClientClick = "return confirm('Delete selected data?');";
            
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
            _ht["p_trans_flag_code"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
        
            gvwList.DataSource = _dal.GetRows(TABLE_NAME_HEADER, _ht);
            gvwList.DataBind();
            Shared.BindBranchEmployeeSort(ddlBranch);
            
          
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

            _dal.Delete(TABLE_NAME_HEADER, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
            Shared.BindBranchEmployeeSort(ddlBranch);
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void btnAddAPDepositAllocationHeader_Click(object sender, EventArgs e)
    {
        Response.Redirect("apdepositallocationheader.aspx?action=add");
    }

    protected void btnDeleteAPDepositAllocationHeader_Click(object sender, EventArgs e)
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
        Response.Redirect("apdepositallocationheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        BindData();
    }
}
