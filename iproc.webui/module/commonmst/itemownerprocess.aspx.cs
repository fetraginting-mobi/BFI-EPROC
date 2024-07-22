using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_itemownerprocess : BasePage
{
    private static string TABLE_NAME = "MASTER_CREDITOR_TYPE";
    private static string TABLE_NAME_DETAIL = "MASTER_CREDITOR_TYPE_LINK_ACC";
    protected void Page_Load(object sender, EventArgs e)
    {
        //btnLookUpCapyCOA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtCapyAcc.ClientID, lblCapyAcc.ClientID, lblNameCapyAcc.ClientID);
        //btnLookUpAdvanceAcc.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAdvanceAcc.ClientID, lblAdvanceAcc.ClientID, lblNameAdvanceAcc.ClientID);
        //btnLookUpAccruedAcc.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAccruedAcc.ClientID, lblAccruedAcc.ClientID, lblNameAccruedAcc.ClientID);
        //btnLookUpDepositAcc.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtDepositAcc.ClientID, lblDepositAcc.ClientID, lblNameDepositAcc.ClientID);

        LoadInit();
        if (!Page.IsPostBack)
        {

            Shared.BindUnitsItemOwnSetting(ddlOwner);
            Shared.BindUnitsItem(ddlProcessBy);
            Shared.BindUnitsItemOwnSetting(ddlFromOwner);
            Shared.BindUnitsItem(ddlfromProcess);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";


                if (ddlUpdateFor.SelectedValue.Equals("owner"))
                {
                    owner.Visible = true;
                    ddlOwner.Visible = true;
                    fromowner.Visible = true;
                    ddlFromOwner.Visible = true;
                    rfvFromOwner.Enabled = true;
                    rfvOwner.Enabled = true;
                    process.Visible = false;
                    ddlProcessBy.Visible = false;
                    fromprocess.Visible = false;
                    ddlfromProcess.Visible = false;
                    rfvFromProcess.Enabled = false;
                    rfvProcessBy.Enabled = false;
                }

                if (ddlUpdateFor.SelectedValue.Equals("process"))
                {
                    owner.Visible = false;
                    ddlOwner.Visible = false;
                    fromowner.Visible = false;
                    ddlFromOwner.Visible = false;
                    rfvFromOwner.Enabled = false;
                    rfvOwner.Enabled = false;
                    process.Visible = true;
                    ddlProcessBy.Visible = true;
                    fromprocess.Visible = true;
                    ddlfromProcess.Visible = true;
                    rfvFromProcess.Enabled = true;
                    rfvProcessBy.Enabled = true;
                }

            }

            
            //LoadData();

           
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

            _ht["p_from_owner"] = Request.Params["owner_code"];
            _ht["p_from_process_by"] = Request.Params["code"];
            DataRow _dr = _dal.GetRow("","xsp_master_units_setting_owner_getrow", _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindUnitsItemOwnSetting(ddlFromOwner);
            Shared.BindUnitsItem(ddlfromProcess);
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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.Update("", "xsp_master_item_owner_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("itemownerprocesslist.aspx"));
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
        Response.Redirect("itemownerprocesslist.aspx");
    }

    protected void ddlJenisItem_OnSelectedIndex(object sender, EventArgs e)
    {
        if (ddlUpdateFor.SelectedValue.Equals("owner"))
        {
            owner.Visible = true;
            ddlOwner.Visible = true;
            fromowner.Visible = true;
            ddlFromOwner.Visible = true;
            rfvFromOwner.Enabled = true;
            rfvOwner.Enabled = true;
            process.Visible = false;
            ddlProcessBy.Visible = false;
            fromprocess.Visible = false;
            ddlfromProcess.Visible = false;
            rfvFromProcess.Enabled = false;
            rfvProcessBy.Enabled = false;
        }

        if (ddlUpdateFor.SelectedValue.Equals("process"))
        {
            owner.Visible = false;
            ddlOwner.Visible = false;
            fromowner.Visible = false;
            ddlFromOwner.Visible = false;
            rfvFromOwner.Enabled = false;
            rfvOwner.Enabled = false;
            process.Visible = true;
            ddlProcessBy.Visible = true;
            fromprocess.Visible = true;
            ddlfromProcess.Visible = true;
            rfvFromProcess.Enabled = true;
            rfvProcessBy.Enabled = true;
        }
    }
}