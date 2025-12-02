using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masteritemgroupdetail : BasePage
{
    private static string TABLE_NAME = "MASTER_ITEM_GROUP_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {

        btnLookUpACCExpensePO.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtACCExpensePO.ClientID, lblNoExpensePO.ClientID, lblNameExpensePO.ClientID,txtPADExpensePO.ClientID, ddlCurrency.ClientID);
        btnLookUpACCAssetPO.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtACCAssetPO.ClientID, lblNoAssetPO.ClientID, lblNameAssetPO.ClientID, txtPADAssetPO.ClientID, ddlCurrency.ClientID);

        btnLookupAllocExpenseNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtAllocExpenseAccNo.ClientID, lblNoAllocExpenseAccNo.ClientID, lblNameAllocExpenseAccName.ClientID, txtPADAllocExpenseAccName.ClientID, ddlCurrency.ClientID);
        
        btnLookUpACCNoINV.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtACCNoINV.ClientID, lblNoINV.ClientID, lblNameNoINV.ClientID,txtPADINV.ClientID, ddlCurrency.ClientID);
        
        btnLookUpACCCOGS.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&parc_curr_code={3}');", txtACCCOGS.ClientID, lblNoACCCOGS.ClientID, lblNameACCCOGS.ClientID, ddlCurrency.ClientID);
        btnLookUpACCAssetinprogressPO.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtACCAssetinprogressPO.ClientID, lblNoAssetinprogressPO.ClientID, lblNameAssetinprogressPO.ClientID, txtPADAssetinprogressPO.ClientID, ddlCurrency.ClientID);
        btnLookupRentAccNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtRentAccNo.ClientID, lblNoRentAccNo.ClientID, lblNameRentAccNo.ClientID, txtPADRentAccNo.ClientID, ddlCurrency.ClientID);

        btnLookupRentAccNoUp1.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtRentAccNoUp1.ClientID, lblNoRentAccNoUp1.ClientID, lblNameRentAccNoUp1.ClientID, txtPADRentAccNoUp1.ClientID, ddlCurrency.ClientID);
        btnLookUpACCExpensePOUp1.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtACCExpensePOUp1.ClientID, lblNoExpensePOUp1.ClientID, lblNameExpensePOUp1.ClientID, txtPADExpensePOUp1.ClientID, ddlCurrency.ClientID);


        btnLookupRentRefundAccNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtRentRefundAccNo.ClientID, lblNoRentRefundAccNo.ClientID, lblNameRentRefundAccNo.ClientID, txtPadRentRefundAccNo.ClientID, ddlCurrency.ClientID);
        btnLookupRentRefundAccNoUp1.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtRentRefundAccNoUp1.ClientID, lblNoRentRefundAccNoUp1.ClientID, lblNameRentRefundAccNoUp1.ClientID, txtPadRentRefundAccNoUp1.ClientID, ddlCurrency.ClientID);
        btnLookUpExpenseRefund.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtAccExpenseRefund.ClientID, lblNoExpenseRefund.ClientID, lblNameExpenseRefund.ClientID, txtPadExpenseRefund.ClientID, ddlCurrency.ClientID);
        btnLookUpExpenseRefundUp1.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&parc_curr_code={4}');", txtAccExpenseRefundUp1.ClientID, lblNoExpenseRefundUp1.ClientID, lblNameExpenseRefundUp1.ClientID, txtPadExpenseRefundUp1.ClientID, ddlCurrency.ClientID);
        LoadInit();

        if (!Page.IsPostBack)
        {
            lblID.Text = Request.Params["id"];
            lblCategory.Text = Request.Params["groupcategorytype"];
            lblCategoryCode.Text = Request.Params["categorycode"];
            lblAssetPeriodHakGuna.Text = Request.Params["assetperiodhakguna"];

            Shared.BindCurrencyCode(ddlCurrency);

            if (lblCategory.Text == "IT")
            {
                //FaAssetInprogress.Visible = Expanse.Visible = FaAsset.Visible = false; //(+)gustian 09/11/2022 enhance Prepaid
                //FaAssetInprogress.Visible = Expanse.Visible = FaAsset.Visible = Expese2.Visible = false;
                FaAssetInprogress.Visible = Expanse.Visible = FaAsset.Visible = Expese2.Visible = Rent.Visible = ExpenseUp1.Visible = RentUp1.Visible = false;

                RentRefund.Visible = ExpenseRefund.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
            }
            else if (lblCategory.Text == "FA")
            {
                //Inventory.Visible = COGS.Visible = false;
                Inventory.Visible = COGS.Visible = Rent.Visible = ExpenseUp1.Visible = RentUp1.Visible = false;

                RentRefund.Visible = ExpenseRefund.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
            }
            else if (lblCategory.Text == "ET")
            {
                //FaAssetInprogress.Visible = FaAsset.Visible = Inventory.Visible = COGS.Visible = false;
                FaAssetInprogress.Visible = FaAsset.Visible = Inventory.Visible = COGS.Visible = Rent.Visible = ExpenseUp1.Visible = RentUp1.Visible = false;

                RentRefund.Visible = ExpenseRefund.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
            }
            else if (lblCategory.Text == "IC")
            {
                FaAssetInprogress.Visible = FaAsset.Visible = COGS.Visible = Inventory.Visible = false;
                if (Convert.ToInt32(lblAssetPeriodHakGuna.Text) > 12)
                {
                    Rent.Visible = Expanse.Visible = RentRefund.Visible = ExpenseRefund.Visible = false;

                }
                else if (Convert.ToInt32(lblAssetPeriodHakGuna.Text) <= 12 && Convert.ToInt32(lblAssetPeriodHakGuna.Text) != 0)
                {
                    RentUp1.Visible = ExpenseUp1.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
                }
                else
                {
                    RentRefund.Visible = ExpenseRefund.Visible = false;
                    RentUp1.Visible = ExpenseUp1.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
                }
            }
            
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";

                if (lblCategory.Text == "IT")
                {
                    //FaAssetInprogress.Visible = Expanse.Visible = FaAsset.Visible = false; //(+)gustian 09/11/2022 enhance Prepaid
                    //FaAssetInprogress.Visible = Expanse.Visible = FaAsset.Visible = Expese2.Visible = false;
                    FaAssetInprogress.Visible = Expanse.Visible = FaAsset.Visible = Expese2.Visible = Rent.Visible = ExpenseUp1.Visible = RentUp1.Visible = false;

                    RentRefund.Visible = ExpenseRefund.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
                }
                else if (lblCategory.Text == "FA")
                {
                    //Inventory.Visible = COGS.Visible = false;
                    Inventory.Visible = COGS.Visible = Rent.Visible = ExpenseUp1.Visible = RentUp1.Visible = false;

                    RentRefund.Visible = ExpenseRefund.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
                }
                else if (lblCategory.Text == "ET")
                {
                    //FaAssetInprogress.Visible = FaAsset.Visible = Inventory.Visible = COGS.Visible = false;
                    FaAssetInprogress.Visible = FaAsset.Visible = Inventory.Visible = COGS.Visible = Rent.Visible = ExpenseUp1.Visible = RentUp1.Visible = false;

                    RentRefund.Visible = ExpenseRefund.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
                }
                else if (lblCategory.Text == "IC")
                {
                    FaAssetInprogress.Visible = FaAsset.Visible = COGS.Visible = Inventory.Visible = false;
                    if (Convert.ToInt32(lblAssetPeriodHakGuna.Text) > 12)
                    {
                        Rent.Visible = Expanse.Visible = RentRefund.Visible = ExpenseRefund.Visible = false;
                        
                    }
                    else if (Convert.ToInt32(lblAssetPeriodHakGuna.Text) <= 12 && Convert.ToInt32(lblAssetPeriodHakGuna.Text) != 0)
                    {
                        RentUp1.Visible = ExpenseUp1.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
                    }
                    else
                    {
                        RentRefund.Visible = ExpenseRefund.Visible = false;
                        RentUp1.Visible = ExpenseUp1.Visible = RentRefundUp1.Visible = ExpenseRefundUp1.Visible = false;
                    }
                }

            }
        } LoadAfterInit();
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            if (lblCategory.Text == "IT")
            {
               btnLookUpACCAssetinprogressPO.Visible =  btnLookUpACCAssetPO.Visible = FaAsset.Visible = txtACCAssetPO.Visible = lblNoAssetPO.Visible = lblNameAssetPO.Visible = false;

                rfvACCAssetPO.Enabled = false;
            }
            else if (lblCategory.Text == "FA")
            {
                btnLookUpACCNoINV.Visible = Inventory.Visible = lblNameNoINV.Visible = btnLookUpACCCOGS.Visible = COGS.Visible = lblNameACCCOGS.Visible = false;

                rfvACCExpensePO.Enabled = rfvACCNoINV.Enabled = rfvACCCOGS.Enabled = false;

            }
            else if (lblCategory.Text == "ET")
            {
                btnLookUpACCAssetinprogressPO.Visible = btnLookUpACCAssetPO.Visible = FaAsset.Visible = txtACCAssetPO.Visible = lblNoAssetPO.Visible = lblNameAssetPO.Visible = btnLookUpACCNoINV.Visible = lblNameNoINV.Visible = lblNoINV.Visible = Inventory.Visible = btnLookUpACCCOGS.Visible = COGS.Visible = lblNoACCCOGS.Visible = lblNameACCCOGS.Visible = false;

                rfvACCAssetPO.Enabled = rfvACCNoINV.Enabled = rfvACCCOGS.Enabled = false;
            }
            else if (lblCategory.Text == "IC")
            {
               btnLookUpACCAssetinprogressPO.Visible = btnLookUpACCAssetPO.Visible = FaAsset.Visible = txtACCAssetPO.Visible = lblNoAssetPO.Visible = lblNameAssetPO.Visible = btnLookUpACCNoINV.Visible = lblNameNoINV.Visible = lblNoINV.Visible = Inventory.Visible = btnLookUpACCCOGS.Visible = COGS.Visible = lblNoACCCOGS.Visible = lblNameACCCOGS.Visible = false;

                rfvACCAssetPO.Enabled = rfvACCNoINV.Enabled = rfvACCCOGS.Enabled = false;
            }

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
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

           
            Shared.ShowSuccessGritter(this, string.Format("masteritemgroup.aspx?action=edit&id={0}&categorycode={1}&type={2}", lblID.Text, lblCategoryCode.Text, lblCategory.Text));
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
        Response.Redirect("masteritemgroup.aspx?action=edit&id=" + lblID.Text + "&categorycode=" + lblCategoryCode.Text + "&type=" + Request.Params["type"]);
    }

}
