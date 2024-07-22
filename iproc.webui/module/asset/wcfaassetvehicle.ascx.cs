using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_asset_wcfaassetvehicle : System.Web.UI.UserControl
{
    private static string TABLE_NAME = "FA_ASSET_VEHICLE";
    private static string TABLE_NAME_ASSET = "FA_ASSET";
    protected void Page_Load(object sender, EventArgs e)
    {
        //(+) Start - 2015/12/10 - 08:31 - Adi - mengubah label lookup menjadi textbox
        //(-) Start - 2016/01/18 -  14:38  - Gleen - 
        //btnLookUpMerkCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MERK&acol_0={0}&bcol_1={1}');", txtMerkCode.ClientID, txtMerkCodeDesc.ClientID);
        //btnLookUpModelCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MODEL&acol_0={0}&bcol_1={1}&parc_code={2}');", txtModelCode.ClientID, txtModelCodeDesc.ClientID, txtMerkCode.ClientID);
        //btnLookUpTypeCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ATYPE&acol_0={0}&bcol_1={1}&parc_code={2}');", txtTypeCode.ClientID, txtTypeCodeDesc.ClientID, txtModelCode.ClientID);
        //btnLookUpCategoryCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=CTGRY&acol_0={0}&bcol_1={1}');", txtCategoryCode.ClientID, txtCategoryCodeDesc.ClientID);
        //(-) End - 2016/01/18 -  14:38  - Gleen -
        //btnLookUpLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=CITY&acol_0={0}&bcol_1={1}');", txtLocation.ClientID, txtLocationDesc.ClientID);
        //(+) END - 2015/12/10 - 08:31 - Adi -
        //System.Diagnostics.Debugger.Break();

        

        if (!Page.IsPostBack)
        {
            //Shared.BindMadeIn(ddlMadeIn); -- (-) 2016/01/18 -  14:47 - Gleen -    
            //Shared.BindGeneralSubCode(ddlFAType, "FA");
            //btnLookUpMerk.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ITMMK&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&fcol_3={4}');", txtMerk.ClientID, lblMerk.ClientID, lblMerkName.ClientID, txtType.ClientID, lblTypeName.ClientID);

            //btnLookUpType.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LUFTM&acol_0={0}&bcol_1={1}&parc_code={2}');", txtType.ClientID, lblTypeName.ClientID, txtMerk.ClientID);
            BindData();
            //if (Session[SessionKey.CURRENT_APPLICATION_MENU_SESSION_KEY].ToString() == "LEGAL")
            //{
            //    btnSave.Visible = false;
            //}
            //else if (Session[SessionKey.CURRENT_APPLICATION_MENU_SESSION_KEY].ToString() == "CREDIT REVIEW")
            //{
            //    btnSave.Visible = false;
            //}
            //else if (Session[SessionKey.CURRENT_APPLICATION_MENU_SESSION_KEY].ToString() == "CREDIT COMMITTEE")
            //{
            //    btnSave.Visible = false;
            //}
        }
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            //System.Diagnostics.Debugger.Break();
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_asset_no"] = Request.Params["assetno"];
          
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(pnlAll.Controls, _dr);
        }
        catch (Exception ex)
        {
            //Shared.ShowErrorDialog(this.Page, ex);
        }
    }
    //checkdata untuk 
    private void CheckData()
    {
        //System.Diagnostics.Debugger.Break();
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_asset_no"] = Request.Params["assetno"];

            DataRow _dr = _dal.GetRow(TABLE_NAME_ASSET, _ht);

            if ((_dr["ASSET_CONDITION"].ToString().Equals("USED")) || (_dr["ASSET_TYPE"].ToString().Equals("VHCL")))
            {

                rfvPlatNo1.Enabled = false;
                rfvPlatNo2.Enabled = false;
                rfvPlatNo3.Enabled = false;
                //rfvBPKBNo.Enable = false;
                rfvFakturNumber.Enabled = false;
                rfvSTNKNumber.Enabled = false;
                rfvSTNKName.Enabled = false;
                rfvSTNKExpiredDate.Enabled = false;
                rfvSTNKTaxDate.Enabled = false;
                //rfvBuiltYear.Enabled = false;
                rfvColour.Enabled = false;
                //rfvFakturType.Enabled = false;
                rfvBPKBName.Enabled = false;
                rfvBPKBAddress.Enabled = false;
            }
            else
            {
                rfvPlatNo1.Enabled = true;
                rfvPlatNo2.Enabled = true;
                rfvPlatNo3.Enabled = true;
                //rfvBPKBNo.Enable = true;
                rfvFakturNumber.Enabled = true;
                rfvSTNKNumber.Enabled = true;
                rfvSTNKName.Enabled = true;
                rfvSTNKExpiredDate.Enabled = true;
                rfvSTNKTaxDate.Enabled = true;
                //rfvBuiltYear.Enabled = true;
                rfvColour.Enabled = true;
                //rfvFakturType.Enabled = true;
                rfvBPKBName.Enabled = true;
                rfvBPKBAddress.Enabled = true;

            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this.Page, ex);
        }
    }



    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_asset_no"] = Request.Params["assetno"];

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.Update(TABLE_NAME, _ht);
            //Shared.ShowSuccessGritter(this, string.Format("wfcaassetvehicle.aspx"));
            BindData();
          
        }

        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this.Page, ex);
        }
    }
    public void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }
    protected void rblFakturType_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
}

