using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_asset_wcfaassetfurniture : System.Web.UI.UserControl
{
    private static string TABLE_NAME = "FA_ASSET_FURNITURE";

    protected void Page_Load(object sender, EventArgs e)
    {
        //(+) Start - 2015/12/10 - 08:31 - Adi - mengubah label lookup menjadi textbox
        //(-) Start - 2016/01/18 -  14:21  - Gleen - 
        //btnLookUpMerkCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MERK&acol_0={0}&bcol_1={1}');", txtMerkCode.ClientID, txtMerkCodeDesc.ClientID);
        //btnLookUpModelCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MODEL&acol_0={0}&bcol_1={1}&parc_code={2}');", txtModelCode.ClientID, txtModelCodeDesc.ClientID, txtMerkCode.ClientID);
        //btnLookUpTypeCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ATYPE&acol_0={0}&bcol_1={1}&parc_code={2}');", txtTypeCode.ClientID, txtTypeCodeDesc.ClientID, txtModelCode.ClientID);
        //btnLookUpCategoryCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=CTGRY&acol_0={0}&bcol_1={1}');", txtCategoryCode.ClientID, txtCategoryCodeDesc.ClientID);
        //(-) End - 2016/01/18 -  14:21  - Gleen - 	
        //btnLookUpLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=CITY&acol_0={0}&bcol_1={1}');", txtLocation.ClientID, txtLocationDesc.ClientID);
        //(+) END - 2015/12/10 - 08:31 - Adi -

        if (!Page.IsPostBack)
        {
            //Shared.BindMadeIn(ddlMadeIn); (-) 2016/01/18 -  14:32 - Gleen -
            //Shared.BindGeneralSubCode(ddlFAType, "FA");
            btnLookUpMerk.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ITMMK&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&fcol_3={4}');", txtMerk.ClientID, lblMerk.ClientID, lblMerkName.ClientID, txtType.ClientID, lblTypeName.ClientID);

            btnLookUpType.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LUFTM&acol_0={0}&bcol_1={1}&parc_code={2}');", txtType.ClientID, lblTypeName.ClientID, txtMerk.ClientID);
            BindData();
            //if (Session[SessionKey.CURRENT_APPLICATION_MENU_SESSION_KEY].ToString() == "LEGAL")
            //{
            //    btnSaveAssetFurniture.Visible = false;
            //}
            //else if (Session[SessionKey.CURRENT_APPLICATION_MENU_SESSION_KEY].ToString() == "CREDIT REVIEW")
            //{
            //    btnSaveAssetFurniture.Visible = false;
            //}
            //else if (Session[SessionKey.CURRENT_APPLICATION_MENU_SESSION_KEY].ToString() == "CREDIT COMMITTEE")
            //{
            //    btnSaveAssetFurniture.Visible = false;
            //}
        }
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_asset_no"] = Request.Params["assetno"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            //Shared.ShowErrorDialog(this.Page, ex);
        }
    }

    public void btnSaveAssetFurniture_Click(object sender, EventArgs e)
    {
        SaveDataAssetFurniture();
    }

    private void SaveDataAssetFurniture()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {

            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_asset_no"] = Request.Params["assetno"];

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.Update(TABLE_NAME, _ht);
            BindData();
        }

        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this.Page, ex);
        }
    }
}
