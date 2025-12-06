using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_inventory_inventoryviewstock : BasePageList
{
    //private static string TABLE_NAME = "INVENTORY_CARD";

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

            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindLocationProcurement(ddlLocation);
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
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_item_code"] = Request.Params["itemcode"];
            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("","dbo.xsp_inventory_card_stock_getrows", _ht);
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
    //protected override void SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    base.SelectedIndexChanged(sender, e);
    //    Response.Redirect("faasset.aspx?action=edit&id=" + gvwList.SelectedDataKey[0].ToString());
    //}
    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

}      

