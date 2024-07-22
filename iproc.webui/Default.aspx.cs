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
using System.Xml;
using System.Net;
using System.IO;
using Newtonsoft.Json;

public partial class _Default : System.Web.UI.Page 
{

    private String _NIK;

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    /*
     * validate user
     * if row > 0, maka ambil role user tersebut
     * redirect ke main.aspx
     * jika tidak, show error
    */

    private void ValidateLogin()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        bool IsValidUser = true;
        bool IsValidPassword = true;
        bool IsActiveUser = true;

        DataTable _dtUser = null;
        
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = txtUID.Text;
            _ht["p_password"] = txtPassword.Text;

            _dtUser = _dal.GetRows("", "xsp_master_user_main_validate", _ht);

            //dr null jika tidak ada record, langsung lari ke catch
            if (_dtUser != null && _dtUser.Rows.Count > 0)
            {
                DataRow dr = _dtUser.Rows[0];

                if (dr["UPASS"].ToString().Equals(dr["UPASSMD5"].ToString()))
                {
                    if (((int)dr["LAST_FAIL_COUNT"]) >= 5)
                        IsValidPassword = false;
                    else
                    {
                        if (dr["IS_ACTIVE"].ToString().Equals("1")) //artinya user aktif
                        {
                            //reset fail count
                            _dal.Update("", "xsp_master_user_main_reset_fail_count", _ht);

                            //update last login
                            _ht["p_login_date"] = DateTime.Now;
                            _dal.Update("", "xsp_master_user_main_update_last_login", _ht);

                            //save user profile ke session
                            Session[SessionKey.CURRENT_USER_SESSION_KEY] = _dtUser;

                            //save user role ke session
                            //Session[SessionKey.CURRENT_USER_ROLE_SESSION_KEY] = _dal.GetRows("", "xsp_master_user_main_getroles", _ht);

                            //save user ip address
                            if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null)
                                Session[SessionKey.CURRENT_USER_IP_ADDRESS_SESSION_KEY] = Request.ServerVariables["REMOTE_ADDR"];
                            else
                                Session[SessionKey.CURRENT_USER_IP_ADDRESS_SESSION_KEY] = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

                            //insert master user login log
                            _ht["p_ip_address"] = Shared.CurrentIPAddress;
                            _ht["p_flag_code"] = "Success";
                            Shared.ApplyDefaultProp(_ht);
                            _dal.Insert("", "xsp_master_user_login_log_insert", _ht);
                            GoToMain();

                            //if (((DateTime)dr["NEXT_CHANGE_PASS"]) <= DateTime.Today)
                            //{
                            //    ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowModalChangePassword();", true);
                            //}
                            //else
                            //{
                            //    //SelectBranch();

                            //    //redirect ke halaman main
                            //    GoToMain();
                            //}
                        }
                        else
                            IsActiveUser = false;
                    }
                }
                else
                    IsValidPassword = false;
            }
            else
                IsValidUser = false;
        }
        catch
        {
            IsValidUser = false;
        }


        if (!IsActiveUser)
        {
            //show ke user message box, jika user dia tidak aktif
            //ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User not active. Please contact your MIS/IT Department.', '');", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User Name or Password Not Match!', '');", true);
        }
        else if (!IsValidPassword)
        {
            //cek last fail count untuk uid yang login
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = txtUID.Text;

            DataRow dr = _dal.GetRow("", "xsp_master_user_main_getrow", _ht);

            _ht["p_login_date"] = DateTime.Now;
            _ht["p_cre_date"] = DateTime.Now;
            _ht["p_cre_by"] = txtUID.Text;
            _ht["p_cre_ip_address"] = "127.0.0.1";

            if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null)
                _ht["p_ip_address"] = Request.ServerVariables["REMOTE_ADDR"];
            else
                _ht["p_ip_address"] = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];


            if (((int)dr["LAST_FAIL_COUNT"]) >= 5)
            {
                _ht["p_flag_code"] = "Fail Max Attempt";

                //insert master user login log
                _dal.Insert("", "xsp_master_user_login_log_insert", _ht);

                //show warning max login attempt reached
                //ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('Maximum try login reached. Please contact your MIS/IT Department.', '');", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User Name or Password Not Match!', '');", true);
            }
            else // jika uid tersebut tidak ada berarti invalid user, langsung di catch
            {
                _ht["p_flag_code"] = "Fail Password";

                //insert master user login log
                _dal.Insert("", "xsp_master_user_login_log_insert", _ht);

                //update last fail count -> ditambahkan 1
                _dal.Update("", "xsp_master_user_main_increment_fail_count", _ht);

                //ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('Invalid password', '');", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User Name or Password Not Match!', '');", true);
            }
        }
        else if (!IsValidUser)
        {
            //ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('Invalid user', '');", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User Name or Password Not Match!', '');", true);
        }
    }

    private void ConfinsValidateLogin()
    {
       
        DataTable _dtUser = null;
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        bool gotoMain = false;

        if (Shared.ValidateLoginConfins(txtUID.Text, txtPassword.Text, ref _NIK))
        {
            try
            {
                Session[SessionKey.CURRENT_EXT_USER_SESSION_KEY] = txtUID.Text;

                _dal = new GeneralDAL();
                _ht = new Hashtable();

                _ht["p_uid"] = _NIK;
                _dtUser = _dal.GetRows("", "xsp_master_user_main_login", _ht);

                if (_dtUser != null && _dtUser.Rows.Count > 0)
                {
                    _ht["p_login_date"] = DateTime.Now;
                    _dal.Update("", "xsp_master_user_main_update_last_login", _ht);

                    //save user profile ke session
                    Session[SessionKey.CURRENT_USER_SESSION_KEY] = _dtUser;

                    //save user ip address
                    if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null)
                        Session[SessionKey.CURRENT_USER_IP_ADDRESS_SESSION_KEY] = Request.ServerVariables["REMOTE_ADDR"];
                    else
                        Session[SessionKey.CURRENT_USER_IP_ADDRESS_SESSION_KEY] = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

                    //insert master user login log
                    _ht["p_ip_address"] = Shared.CurrentIPAddress;
                    _ht["p_flag_code"] = "Success";
                    Shared.ApplyDefaultProp(_ht);

                    _dal.Insert("", "xsp_master_user_login_log_insert", _ht);

                    gotoMain = true;

                }

            }
            catch
            {
                if (_dtUser == null || _dtUser.Rows.Count == 0)
                {
                    //ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User not exists!', '');", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User Name or Password Not Match!', '');", true);
                }
            }

            if (gotoMain)
                GoToMain();
        }
        else
        {
            //ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('Invalid User ID or Password!', '');", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User Name or Password Not Match!', '');", true);
        }

    }

    protected void btnSignIn_Click(object sender, EventArgs e)
    {

        if (Shared.IsLoginLocal())
        {
            ValidateLogin();
        }
        else
        {
            ConfinsValidateLogin();
        }

    }

    private void GetUserRole()
    {/*(+)Chandra - 13-Nov-2015, 10:13:25 AM*/

        GeneralDAL _dal = null;
        Hashtable _ht = null;
        ArrayList _al = null;

        try
        {
           
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _al = new ArrayList();

            // LOGIN CONFINS USING _NIK FROM API
            _ht["p_uid"] = (Shared.IsLoginLocal() ? txtUID.Text : _NIK);

            DataTable dt = _dal.GetRows("", "xsp_master_user_main_getrows_all_role", _ht);

            if (dt != null)
            {
                foreach (DataRow dr in dt.Rows)
                    _al.Add(dr["ROLE_CODE"]);
            }

            Session[SessionKey.CURRENT_USER_ROLE_SESSION_KEY] = _al;
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void GoToMain()
    {/*(+) - Chandra - 14-Jan-2016, 9:03:47 AM*/
        if (!GetHomeBranch())
        {
            //ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('There is no default branch for this user. Please contact your MIS/IT Department.', '');", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('User Name or Password Not Match!', '');", true);
            return;
        }

        GetUserRole();

        Session[SessionKey.CURRENT_USER_APP_CODE] = "PR";
        Session[SessionKey.CURRENT_USER_APP_DESC] = "iProcurement";

        //Shared.ClearLock("LOGIN");
        Response.Redirect("main.aspx");
    }

    #region Branch
    //private void SelectBranch()
    //{
    //    LoadBranch();
    //    ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowModalBranch();", true);
    //}

    //private void LoadBranch()
    //{
    //    Shared.BindEmpBranch(ddlBranch);
    //}

    //protected void btnProcess_Click(object sender, EventArgs e)
    //{
    //    //save user branch ke session
    //    Session[SessionKey.CURRENT_USER_BRANCH_CODE] = ddlBranch.SelectedValue;
    //    Session[SessionKey.CURRENT_USER_BRANCH_DESC] = ddlBranch.SelectedItem.Text;
    //    //
    //    Session[SessionKey.CURRENT_USER_APP_CODE] = "PR";
    //    Session[SessionKey.CURRENT_USER_APP_DESC] = "iProcurement";

    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    ArrayList _al = null;
    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();
    //        _al = new ArrayList();

    //        _ht["p_emp_code"] = txtUID.Text;
    //        _ht["p_branch_code"] = ddlBranch.SelectedValue;
    //        _ht["p_application_code"] = Shared.CurrentEmployeeAppCode;
            
    //        DataRow drw = _dal.GetRow("", "xsp_master_employee_getrow_dept", _ht);

    //        Session[SessionKey.CURRENT_USER_DEPT_CODE] = drw["CODE"].ToString();
    //        Session[SessionKey.CURRENT_USER_DEPT_DESC] = drw["DEPARTMENT_DESC"].ToString();
            
    //        DataTable dt = _dal.GetRows("", "xsp_master_role_sec_getrows_by_emp_branch", _ht);         
            
    //        foreach(DataRow dr in dt.Rows)
    //        {
    //            _al.Add(dr["CODE"]);
    //        }

    //        Session[SessionKey.CURRENT_USER_ROLE_SESSION_KEY] = _al;
    //    }
    //    catch(Exception)
    //    {
    //    }
       
    //    Response.Redirect("main.aspx");
    //}

    private Boolean GetHomeBranch()
    {/*(+) - Chandra - 13-Jan-2016, 12:41:37 PM*/
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            // LOGIN CONFINS USING _NIK FROM API
            _ht["p_uid"] = (Shared.IsLoginLocal() ? txtUID.Text : _NIK);

            DataRow dr = _dal.GetRow("", "xsp_sys_branch_employee_getrow_branch_base", _ht);

            if (dr != null)
            {
                Session[SessionKey.CURRENT_USER_BRANCH_CODE] = dr["BRANCH_CODE"].ToString();
                Session[SessionKey.CURRENT_USER_BRANCH_DESC] = dr["BRANCH_NAME"].ToString();
            }

            return true;
        }
        catch //(Exception ex)
        {
            //Shared.ShowErrorDialog(this, ex);
            return false;
        }
    }

    #endregion

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_uid"] = txtResetUID.Text;

    //        _dal.ExecRawSP("xsp_master_user_main_reset_password", _ht);

    //        //--------------------------------
    //        _ht["p_login_date"] = DateTime.Now;
    //        _ht["p_flag_code"] = "Reset Password";
    //        _ht["p_cre_date"] = DateTime.Now;
    //        _ht["p_cre_by"] = txtResetUID.Text;
    //        _ht["p_cre_ip_address"] = "127.0.0.1";

    //        if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null)
    //            _ht["p_ip_address"] = Request.ServerVariables["REMOTE_ADDR"];
    //        else
    //            _ht["p_ip_address"] = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

    //        //insert master user login log
    //        _dal.Insert("", "xsp_master_user_login_log_insert", _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('" + Shared.DefaultErrorMessage + "', '" + Shared.MakeSingleLine(ex) + "');", true);
    //    }
    //}


    //protected void btnChangePassword_Click(object sender, EventArgs e)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_uid"] = txtUID.Text;
    //        _ht["p_new_password"] = txtNewPassword.Text;

    //        _dal.ExecRawSP("xsp_master_user_main_change_password", _ht);


    //        //-----------------------------------
    //        _ht["p_login_date"] = DateTime.Now;
    //        _ht["p_flag_code"] = "Change Password";
    //        _ht["p_cre_date"] = DateTime.Now;
    //        _ht["p_cre_by"] = txtUID.Text;
    //        _ht["p_cre_ip_address"] = "127.0.0.1";

    //        if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null)
    //            _ht["p_ip_address"] = Request.ServerVariables["REMOTE_ADDR"];
    //        else
    //            _ht["p_ip_address"] = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

    //        //insert master user login log
    //        _dal.Insert("", "xsp_master_user_login_log_insert", _ht);

    //        //SelectBranch();
    //    }
    //    catch (Exception ex)
    //    {
    //        ScriptManager.RegisterStartupScript(this, GetType(), "fx", "fnShowErrorNotif('" + Shared.DefaultErrorMessage + "', '" + Shared.MakeSingleLine(ex) + "');", true); ;
    //    }
    //}

}