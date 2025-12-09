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

public partial class SSOLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSignIn_Click(object sender, EventArgs e)
    {
        GoToMain();

    }

    private void GoToMain()
    {
        //if (!GetHomeBranch())
        //{
        //    //ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('There is no default branch for this user. Please contact your MIS/IT Department.', '');", true);
        //    ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User Name or Password Not Match!', '');", true);
        //    return;
        //}

        //GetUserRole();

        //Session[SessionKey.CURRENT_USER_APP_CODE] = "PR";
        //Session[SessionKey.CURRENT_USER_APP_DESC] = "iProcurement";

        ////Shared.ClearLock("LOGIN");
        Response.Redirect("main.aspx");
    }
}
