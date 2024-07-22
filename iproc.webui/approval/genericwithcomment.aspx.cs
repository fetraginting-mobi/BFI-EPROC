using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class approval_genericwithcomment : System.Web.UI.Page
{
    /*(+) Author Chandra - 29-Dec-2015, 5:41:38 PM*/

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            txtPassword.Text = "";
    }

    protected void btnApproval_Click(object sender, EventArgs e)
    {
        ApproveProcess();
    }

    private void ApprovalRequest(out string errorScript, out string objValue)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        errorScript = string.Empty;
        objValue = string.Empty;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //get required parameter for approval request process
            for (int i = 0; i < Request.Params.Count; i++)
            {
                if (Request.Params.AllKeys[i] != null)
                {
                    if (Request.Params.AllKeys[i].StartsWith("par_"))
                    {
                        string par = Request.Params.AllKeys[i].Substring(4);

                        _ht["p_" + par] = Request.Params[i];
                        objValue = "par_object_id";
                    }
                    else if (Request.Params.AllKeys[i].StartsWith("parc_"))
                    {
                        string par = Request.Params.AllKeys[i].Substring(5);

                        _ht["p_" + par] = Request.Params[i];
                        objValue = "parc_object_id";
                    }
                }
            }

            _ht["p_approval_code"] = Request.Params["code"];
            _ht["p_user"] = Shared.CurrentUID;
            _ht["p_priority_code"] = "LOW";
            _ht["p_remark"] = "";
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("approval_request_start_by_approval_type", _ht);
        }
        catch (Exception ex)
        {
            errorScript += Shared.GenerateErrorDialogFromApproval(ex);
        }
    }

    private void ExecuteRequestedSP(string objValue, out string errorScript)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        errorScript = string.Empty;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_data_key"] = Request.Params[objValue];
            _ht["p_remark"] = txtRemark.Text;
            /*(+)for sp that require status (etc : ff application) - Chandra - 04-Jan-2016, 3:49:29 PM*/
            _ht["p_status"] = (string.IsNullOrEmpty(Request.Params["status"])) ? "" : Request.Params["status"];
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP(Request.Params["spname"], _ht);
        }
        catch (Exception ex)
        {
            errorScript += Shared.GenerateErrorDialogFromApproval(ex);
        }
    }

    private void ApproveProcess()
    {
        string errorScript = string.Empty;
        string objValue = string.Empty;

        //if (Shared.Approval(txtPassword.Text))
        //{
        //    lblError.Visible = false;

        //    ApprovalRequest(out errorScript, out objValue);

        //    if (string.IsNullOrEmpty(errorScript))
        //    {
        //        if (Request.Params["spname"] != null & !string.IsNullOrEmpty(Request.Params["spname"].ToString()))
        //        {
        //            ExecuteRequestedSP(objValue, out errorScript);
        //        }

        //        if (string.IsNullOrEmpty(errorScript))
        //        {
        //            //closing modal 
        //            string script = "";
        //            string sNextURL = Request.Params["nexturl"];

        //            if (sNextURL != null)
        //                script += string.Format("parent.$('#ApprovalPasswordWithComment').modal('hide'); parent.location.href='{0}';", sNextURL);
        //            else
        //                script += "parent.$('#ApprovalPasswordWithComment').modal('hide');";// parent.location.href=parent.location.href";

        //            ScriptManager.RegisterStartupScript(this, GetType(), "fn2", script, true);
        //        }
        //        else
        //        {
        //            ErrorMessage(errorScript);
        //        }
        //    }
        //    else
        //    {
        //        ErrorMessage(errorScript);
        //        return;
        //    }
        //}
        //else
        //    lblError.Visible = true;
    }

    private void ErrorMessage(string errorMsg)
    {
        string script = string.Format("parent.$('#ApprovalPasswordWithComment').modal('hide'); {0}", errorMsg);
        ScriptManager.RegisterStartupScript(this, GetType(), "fn2", script, true);
    }
}
