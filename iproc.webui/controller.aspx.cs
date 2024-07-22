using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class controller : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!CheckToken())
            Response.Redirect("logout.aspx");
        else
        {
            Response.Redirect("main.aspx");
        }
    }

    private bool CheckToken()
    {
        //validate token
        //valid token : harus punya 'uid', harus punya 'branch'

        GeneralDAL _dal = null;
        Hashtable _ht = null;
        ArrayList _al = null;

        DataTable _dtUser = null;
        DataTable _dtRoles = null;

        bool isValid = false;

        if (Request.Params["uid"] != null && Request.Params["branchcode"] != null)
        {
            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();
                _al = new ArrayList();


                _ht["p_uid"] = Request.Params["uid"];
                _ht["p_emp_code"] = Request.Params["uid"]; ;
                _ht["p_branch_code"] = Request.Params["branchcode"];
                _ht["p_application_code"] = "PR";

                _ht["p_code"] = Request.Params["branchcode"];

                //get user profile
                _dtUser = _dal.GetRows("", "xsp_master_user_main_validate_no_pass", _ht);

                //save user profile ke session
                Session[SessionKey.CURRENT_USER_SESSION_KEY] = _dtUser;


                //save user ip address
                if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null)
                    Session[SessionKey.CURRENT_USER_IP_ADDRESS_SESSION_KEY] = Request.ServerVariables["REMOTE_ADDR"];
                else
                    Session[SessionKey.CURRENT_USER_IP_ADDRESS_SESSION_KEY] = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

                //save user branch code ke session
                Session[SessionKey.CURRENT_USER_BRANCH_CODE] = Request.Params["branchcode"];


                //save user branch name ke session
                DataRow drBranch = _dal.GetRow("MASTER_BRANCH", _ht);
                Session[SessionKey.CURRENT_USER_BRANCH_DESC] = drBranch["DESCRIPTION"].ToString();


                //save user app ke session
                Session[SessionKey.CURRENT_USER_APP_CODE] = "PR";
                Session[SessionKey.CURRENT_USER_APP_DESC] = "iProcurement";



                //get user roles
                _dtRoles = _dal.GetRows("", "xsp_master_role_sec_getrows_by_emp_branch", _ht);

                foreach (DataRow drRole in _dtRoles.Rows)
                {
                    _al.Add(drRole["CODE"]);
                }

                Session[SessionKey.CURRENT_USER_ROLE_SESSION_KEY] = _al;


                isValid = true;
            }
            catch (Exception ex)
            {
                isValid = false;
            }

        }

        return isValid;

    }
}
