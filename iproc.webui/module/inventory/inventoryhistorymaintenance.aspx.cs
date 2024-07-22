using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryhistorymaintenance : BasePage
{
    private static string TABLE_NAME = "INVENTORY_HISTORY_MAINTENANCE";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "INVENTORY_HISTORY_MAINTENANCE";
        NEXT_PAGE = "historyinventorymaintenancelist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            //Shared.BindLocation(ddlLocation);
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
            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            //_ht["p_location_code"] = ddlLocation.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_inventory_history_maintenance_detail_getrows", _ht);
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("historyinventorymaintenancelist.aspx");
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
    //protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    BindData();
    //}

}      

