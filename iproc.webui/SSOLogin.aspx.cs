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
        string kcBase = ConfigurationManager.AppSettings["KC_BASE_URL"];
        string realm = ConfigurationManager.AppSettings["KC_REALM"];
        string clientId = ConfigurationManager.AppSettings["KC_CLIENT_ID"];
        string redirectUri = ConfigurationManager.AppSettings["KC_REDIRECT_URI"];

        string authUrl =
            kcBase + "/realms/" + realm +
            "/protocol/openid-connect/auth" +
            "?client_id=" + clientId +
            "&response_type=code" +
            "&scope=openid%20email%20profile" +
            "&redirect_uri=" + HttpUtility.UrlEncode(redirectUri);

        Response.Redirect(authUrl);
        Response.Write(authUrl);
        Response.End();
    }
}
