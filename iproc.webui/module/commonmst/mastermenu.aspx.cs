using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_mastermenu : BasePage
{
    private static string TABLE_NAME = "MASTER_MENU";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            btnLookUpModule.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MMGM&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&ecol_2={4}&ecol_3={5}');", txtModule.ClientID, lblModule.ClientID, lblModuleDesc.ClientID, lblId.ClientID, txtId.ClientID, lblName.ClientID);
            btnLookUpParent.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PRTMN&acol_0={0}&bcol_0={1}&ccol_1={2}&parc_module={3}');", txtId.ClientID, lblId.ClientID, lblName.ClientID, txtModule.ClientID);
            btnLookUpRole.Attributes["href"]   = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ROSEC&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtRoleCode.ClientID, lblRoleCode.ClientID, lblRoleDesc.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
        }
        LoadAfterInit();
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = Request.Params["id"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int iNextID = 0;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblMenuId.Text = iNextID.ToString();
            }
            else

                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("mastermenu.aspx?action=edit&id={0}", lblMenuId.Text));   
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("mastermenulist.aspx");
    }
}
