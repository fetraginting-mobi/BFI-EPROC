using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public class BasePage : System.Web.UI.Page
{
    protected string PAGE_LIST;
    protected string NEXT_PAGE;
    protected TextBox InputSearch;
    protected GridView GridViewList;
    public BasePage()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    //protected void LoadInit()
    //{
    //    if (Session.Count == 0)
    //    {
    //        Response.Redirect(ResolveUrl("~/logout.aspx"));
    //    }
    //    bool result = Shared.IsUserRoleChanged();
    //    if (result)
    //    {
    //        Response.Redirect("~/logout.aspx", false);
    //        HttpContext.Current.Response.End();
    //    }
    //    ScriptManager.RegisterStartupScript(this, GetType(), "dp", "javascript:datepicker();", true);
    //    ScriptManager.RegisterStartupScript(this, GetType(), "num", "javascript:textBoxInit();", true);
    //}
    protected void LoadInit()
    {
        if (Session["IsLogin"] == null || !(bool)Session["IsLogin"])
        {
            Response.Redirect(ResolveUrl("~/logout.aspx"));
            return;
        }

        if (Session["UID"] == null)
        {
            Response.Redirect(ResolveUrl("~/logout.aspx"));
            return;
        }

        bool result = Shared.IsUserRoleChanged();
        if (result)
        {
            Response.Redirect("~/logout.aspx", false);
            HttpContext.Current.Response.End();
            return;
        }

        ScriptManager.RegisterStartupScript(this, GetType(), "dp",
            "javascript:datepicker();", true);
        ScriptManager.RegisterStartupScript(this, GetType(), "num",
            "javascript:textBoxInit();", true);
    }


    protected void  LoadAfterInit()
    {
        //System.Diagnostics.Debugger.Break();
        //check for role
        //cari semua LinkButton or Button
        //dapatkan role-nya
        //jika role nya TIDAK ADA pada session, maka ditampilkan

      Shared.CheckControlRole(this, Shared.CurrentUID);
    }
}
