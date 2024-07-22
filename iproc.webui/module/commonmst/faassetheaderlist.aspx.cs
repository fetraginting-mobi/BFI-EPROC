using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_commonmst_faassetheaderlist : BasePageList
{
    private static string TABLE_NAME = "FA_ASSET";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "FA_ASSET";
        NEXT_PAGE = "faassetlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            BindData();
           
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


            gvwList.DataSource = _dal.GetRows(TABLE_NAME, "xsp_fa_asset_getrows_header", _ht);
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
        Response.Redirect("faassetlist.aspx?action=edit&catcode="   + gvwList.SelectedDataKey[0].ToString() 
                                                                    + "&loccode=" + gvwList.SelectedDataKey[1].ToString() 
                                                                    + "&branchcode=" + gvwList.SelectedDataKey[2].ToString()
                                                                    + "&astcode=" + gvwList.SelectedDataKey[3].ToString());
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
     
}
