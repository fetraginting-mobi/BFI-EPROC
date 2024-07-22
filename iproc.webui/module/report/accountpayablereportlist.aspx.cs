using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_report_accountpayablereportlist : BasePageList
{
    private static string TABLE_NAME = "MASTER_REPORT";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "MASTER_REPORT";
        NEXT_PAGE = "rptitemlist.aspx";
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

            gvwList.DataSource = _dal.GetRows("","xsp_master_report_ap_getrows", _ht);
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
        string sFileName = gvwList.SelectedDataKey[1].ToString() + "?rptid=" + gvwList.SelectedDataKey[0].ToString();

        Response.Redirect(sFileName);
    }
}
