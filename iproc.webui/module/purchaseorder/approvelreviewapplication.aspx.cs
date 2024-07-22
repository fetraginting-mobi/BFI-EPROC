using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_purchaseorder_approvelreviewapplication : BasePage
{
   

    //protected void Page_Init(object sender, EventArgs e)
    //{
    //    PAGE_LIST = "INVENTORY_HISTORY_MAINTENANCE";
    //    NEXT_PAGE = "historyinventorymaintenancelist.aspx";
    //}

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

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            _ht["p_keywords"] = txtSearch.Text;
            //_ht["p_location_code"] = ddlLocation.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "dbo.xsp_approvel_review_application_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void DeleteData(string ID)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_id"] = ID;

    //        _dal.Delete(TABLE_NAME, _ht);
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected void btnCancel_Click(object sender, EventArgs e) // (+) Ari 19-09-2022 
    {
        Response.Redirect("transactioninquiry.aspx");
    }
}
