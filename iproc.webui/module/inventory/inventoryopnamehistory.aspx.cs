using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_inventory_inventoryopnamehistory : BasePage
{
    private static string TABLE_NAME = "INVENTORY_CARD";
  

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "INVENTORY_CARD";
        NEXT_PAGE = "inventorycardheaderlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
            BindData();
            gvwList.Columns[1].Visible = false;
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
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_inventory_opname_history_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    //protected override void SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}
    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
        BindData();
    }

    //protected void ddlBranchList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
    //    BindData();

    //}




}      
