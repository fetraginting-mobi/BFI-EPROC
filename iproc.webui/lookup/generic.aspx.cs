using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

using iProc.DataAccessLayer;


public partial class lookup_generic : System.Web.UI.Page
{
    private static string SPNAME = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindData();
        }
    }

    private void BindData()
    {
        Shared.BindLookUp(gvwList, Request.Params["code"], ref SPNAME);
    }

    private void SearchData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;

            gvwList.DataSource = _dal.GetRows("", SPNAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        SearchData();
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        string script = Shared.GenerateLookUpClearString(ClientQueryString);
        ScriptManager.RegisterStartupScript(this, GetType(), "fn2", script, true);
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        string script = Shared.GenerateLookUpReturnString(ClientQueryString, gvwList);
        ScriptManager.RegisterStartupScript(this, GetType(), "fn2", script, true);
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        SearchData();
    }
}
