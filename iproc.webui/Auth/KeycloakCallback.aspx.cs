using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.Script.Serialization;
using iProc.DataAccessLayer;

public partial class Auth_KeycloakCallback : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            // =====================================================
            // 1. Ambil authorization code dari Keycloak
            // =====================================================
            string code = Request.QueryString["code"];

            if (string.IsNullOrEmpty(code))
            {
                Response.Redirect("~/SSOLogin.aspx");
                return;
            }

            // =====================================================
            // 2. Tukar authorization code -> token
            // =====================================================
            string tokenResponseJson = TokenService.GetToken(code);

            JavaScriptSerializer js = new JavaScriptSerializer();
            Dictionary<string, object> tokenResponse =
                js.Deserialize<Dictionary<string, object>>(tokenResponseJson);

            if (!tokenResponse.ContainsKey("id_token"))
                throw new Exception("id_token not found in token response");

            string idToken = tokenResponse["id_token"].ToString();

            // =====================================================
            // 3. Decode JWT payload (Base64URL SAFE)
            // =====================================================
            string payloadJson = JwtHelper.DecodeJwtPayload(idToken);
            Dictionary<string, object> payload =
                js.Deserialize<Dictionary<string, object>>(payloadJson);

            // =====================================================
            // 4. Ambil identitas user dari token
            // =====================================================
            string email = payload.ContainsKey("email")
                ? payload["email"].ToString()
                : "";

            string nik = payload.ContainsKey("preferred_username")
                ? payload["preferred_username"].ToString()
                : "";

            if (string.IsNullOrEmpty(email) && string.IsNullOrEmpty(nik))
                throw new Exception("User identity not found in token");

            // =====================================================
            // 5. Mapping user ke database
            // =====================================================
            UserRepository repo = new UserRepository();
            EmployeeUser user = repo.GetUserByEmailOrNik(email, nik);

            if (user == null)
            {
                Response.Redirect("~/AccessDenied.aspx");
                return;
            }

            // =====================================================
            // 6. Update last login
            // =====================================================
            repo.UpdateLastLogin(user.EmpCode);

            // =====================================================
            // 7. SET SESSION LOGIN (LEGACY + SSO)
            // =====================================================
            Session["IsLogin"] = true;

            // --- UID legacy ---
            Session["UID"] = user.EmpCode;

            // --- Basic user ---
            Session["User"] = user;
            Session["EMP_CODE"] = user.EmpCode;
            Session["EMP_NAME"] = user.EmpName;
            Session["EMAIL"] = user.Email;
            Session["NIK"] = user.Nik;

            // --- Token (opsional) ---
            Session["ID_TOKEN"] = idToken;

            // =====================================================
            // 8. SET CURRENT_USER_SESSION_KEY (DataTable legacy)
            // =====================================================
            DataTable dtUser = new DataTable();
            dtUser.Columns.Add("EMP_CODE");
            dtUser.Columns.Add("EMP_NAME");
            dtUser.Columns.Add("EMAIL");
            dtUser.Columns.Add("NIK");

            DataRow drUser = dtUser.NewRow();
            drUser["EMP_CODE"] = user.EmpCode;
            drUser["EMP_NAME"] = user.EmpName;
            drUser["EMAIL"] = user.Email;
            drUser["NIK"] = user.Nik;
            dtUser.Rows.Add(drUser);

            Session[SessionKey.CURRENT_USER_SESSION_KEY] = dtUser;

            // =====================================================
            // 9. LOAD ROLE LEGACY & SIMPAN KE SESSION
            // =====================================================
            ArrayList roles = new ArrayList();

            GeneralDAL dal = new GeneralDAL();
            Hashtable htRole = new Hashtable();
            htRole["p_uid"] = user.EmpCode;

            DataTable dtRole =
                dal.GetRows("", "xsp_master_user_main_getrows_all_role", htRole);

            if (dtRole != null)
            {
                foreach (DataRow dr in dtRole.Rows)
                {
                    roles.Add(dr["ROLE_CODE"].ToString());
                }
            }

            Session[SessionKey.CURRENT_USER_ROLE_SESSION_KEY] = roles;

            // =====================================================
            // 10. LOAD BRANCH CODE (UNTUK Shared.CurrentEmployeeBranchCode)
            // =====================================================
            string branchCode = "";

            Hashtable htBranch = new Hashtable();
            htBranch["p_emp_code"] = user.EmpCode;

            DataTable dtBranch =
                dal.GetRows("", "xsp_employee_get_branch", htBranch);

            if (dtBranch != null && dtBranch.Rows.Count > 0)
            {
                branchCode = dtBranch.Rows[0]["BRANCH_CODE"].ToString();
            }

            Session[SessionKey.CURRENT_USER_BRANCH_CODE] = branchCode;

            // =====================================================
            // 11. Redirect ke halaman utama
            // =====================================================
            Response.Redirect("~/main.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
        catch (Exception ex)
        {
            // =====================================================
            // ERROR HANDLING (DEBUG MODE)
            // =====================================================
            Response.Write("<h3>SSO Error</h3>");
            Response.Write("<pre>");
            Response.Write(Server.HtmlEncode(ex.ToString()));
            Response.Write("</pre>");
            Response.End();
        }
    }
}
