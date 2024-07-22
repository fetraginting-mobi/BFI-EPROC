using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

//using AjaxControlToolkit;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonsec_mastergrouprolesec : BasePage
{
    private static string TABLE_NAME = "MASTER_GROUP_ROLE_SEC";
    private static string TABLE_NAME_2 = "MASTER_GROUP_SEC";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            GetGroupName();

            lblGroupCode.Text = Request.Params["groupcode"];

            btnLookUpRole.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ROSEC&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtRoleCode.ClientID, lblRoleCode.ClientID, lblRoleDesc.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadDataGroupRole();

                btnCancelGroupRole.Text = "Back";
            }

        }
    }

    private void GetGroupName()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = Request.Params["groupcode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME_2, _ht);

            DBToUI.Map(pnlGroupName.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void LoadDataGroupRole()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_group_code"] = Request.Params["groupcode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveDataGroupRole()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht);
            }
            else

                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("mastergrouprolesec.aspx?action=edit&groupcode={0}", lblGroupCode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSaveGroupRole_Click(object sender, EventArgs e)
    {
        SaveDataGroupRole();
    }

    protected void btnCancelGroupRole_Click(object sender, EventArgs e)
    {
        Response.Redirect("mastergroupsec.aspx?action=edit&code=" + lblGroupCode.Text);
    }
}