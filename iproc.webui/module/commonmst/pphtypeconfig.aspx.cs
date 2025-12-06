using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_pphtypeconfig : BasePage
{
    //private static string TABLE_NAME = "MASTER_CREDITOR_TYPE";
    //private static string TABLE_NAME_DETAIL = "MASTER_CREDITOR_TYPE_LINK_ACC";
    protected void Page_Load(object sender, EventArgs e)
    {
        //btnLookUpCapyCOA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtCapyAcc.ClientID, lblCapyAcc.ClientID, lblNameCapyAcc.ClientID);
        //btnLookUpAdvanceAcc.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAdvanceAcc.ClientID, lblAdvanceAcc.ClientID, lblNameAdvanceAcc.ClientID);
        //btnLookUpAccruedAcc.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAccruedAcc.ClientID, lblAccruedAcc.ClientID, lblNameAccruedAcc.ClientID);
        //btnLookUpDepositAcc.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtDepositAcc.ClientID, lblDepositAcc.ClientID, lblNameDepositAcc.ClientID);

        LoadInit();
        if (!Page.IsPostBack)
        {
            ddlUpdateFor.Enabled = false;

            LoadData();


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

            _ht["p_pph_type"] = Request.Params["CODE"];
            DataRow _dr = _dal.GetRow("","xsp_pph_type_getrow", _ht);

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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.Update("", "xsp_pph_type_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("pphtypeconfiglist.aspx"));
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
        Response.Redirect("pphtypeconfiglist.aspx");
    }

    protected void ddlUpdateFor_OnSelectedIndex(object sender, EventArgs e)
    {
        LoadData();
    }
}
