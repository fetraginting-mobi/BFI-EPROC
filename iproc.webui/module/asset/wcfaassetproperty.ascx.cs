using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_asset_wcfaassetproperty : System.Web.UI.UserControl
{
    private static string TABLE_NAME = "FA_ASSET_PROPERTY";
    protected void Page_Load(object sender, EventArgs e)
    {
        //(+) Start - 2015/12/10 - 08:31 - Adi - mengubah label lookup menjadi textbox
        //btnLookUpZipCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ZIP&acol_0={0}&bcol_0={1}');", txtZipCode.ClientID, txtZipCodeDesc.ClientID);
        //btnLookUpLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=CITY&acol_0={0}&bcol_1={1}');", txtLocation.ClientID, txtLocationDesc.ClientID);
        //(+) End - 2015/12/10 - 08:31 - Adi -

        if (!Page.IsPostBack)
        {
            //Shared.BindMadeIn(ddlMadeIn); (-) 2016/01/18 -  14:39 - Gleen -
            //Shared.BindGeneralSubCode(ddlFAType, "FA");

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
}

