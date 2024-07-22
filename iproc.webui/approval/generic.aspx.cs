using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class approval_generic : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            txtPassword.Text = "";
    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        //System.Diagnostics.Debugger.Launch();
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = Shared.CurrentUID;
            _ht["p_password"] = txtPassword.Text;

            //execute sp untuk validate password
            //DataRow dr = _dal.GetRow("", "xsp_master_user_main_validate_for_password_approval", _ht);
            
            //jika valid
            //if (dr["UPASSAPPROVAL"].ToString().Equals(dr["UPASSAPPROVALMD5"].ToString()))

            /*(+) Author Rovi 2017-06-15 */
            if (Shared.Approval(txtPassword.Text))
            {
                //jalankan sp start approval

                //_ht["p_object_id"] = Request.Params["object_id"];

                for (int i = 0; i < Request.Params.Count; i++)
                {
                    if (Request.Params.AllKeys[i] != null)
                    {
                        if (Request.Params.AllKeys[i].StartsWith("par_"))
                        {
                            string par = Request.Params.AllKeys[i].Substring(4);

                            _ht["p_" + par] = Request.Params[i];
                        }
                        else if (Request.Params.AllKeys[i].StartsWith("parc_"))
                        {
                            string par = Request.Params.AllKeys[i].Substring(5);

                            _ht["p_" + par] = Request.Params[i];

                        }
                    }
                }


              
                Shared.ApplyDefaultProp(_ht);

                _ht["p_approval_code"] = Request.Params["code"];
                _ht["p_user"] = Shared.CurrentUID;
                _ht["p_priority_code"] = "Low";
                _ht["p_remark"] = "";

                _dal.ExecRawSP("approval_request_start_by_approval_type", _ht);

                //tutup modal dialog
                string script = "";
            
                string sNextURL = Request.Params["nexturl"];

                if (sNextURL != null)
                    script += "parent.$('#ApprovalPassword').modal('hide'); parent.location.href='" + sNextURL + "';";
                else
                    script += "parent.$('#ApprovalPassword').modal('hide'); parent.location.href=parent.location.href";

                ScriptManager.RegisterStartupScript(this, GetType(), "fn2", script, true);
            }
            //jika tidak valid
            else
            {
                lblValidate.Text = "Invalid Password !";

            }
        }
        catch (Exception ex)
        {
            //tutup modal dialog
            string script = "";

            script += "parent.$('#ApprovalPassword').modal('hide'); " + Shared.GenerateErrorDialogFromApproval(ex);

            ScriptManager.RegisterStartupScript(this, GetType(), "fn2", script, true);
        }

    }
}
