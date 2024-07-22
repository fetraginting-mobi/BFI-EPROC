using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_finance_paymententry : BasePage
{
    private static string TABLE_NAME = "AP_PAYMENT_ENTRY";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MBSG&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_1={3}&ecol_2={4}&gcol_3={5}&parc_supplier_code={6}');", txtBankCode.ClientID, lblBankCode.ClientID, txtBankName.ClientID, lblBankName.ClientID, txtToBankAccountName.ClientID, txtToBankAccountNo.ClientID, txtRequestor.ClientID);


        if (!Page.IsPostBack)
        {
            LoadData();
        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_pr_no"] = Request.Params["prno"];

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
        //string sNextPRNO = "";
        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            
            //MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_pr_no"] = Request.Params["prno"];
            _ht["p_to_bank"] = txtBankCode.Text;
            _ht["p_to_bank_account_no"] = txtToBankAccountNo.Text;
            _ht["p_to_bank_account_name"] = txtToBankAccountName.Text;
            
            Shared.ApplyDefaultProp(_ht);

            //if (Request.Params["action"].Equals("add"))
            //{
            //    _dal.Insert(TABLE_NAME, _ht, ref sNextPRNO);
            //    lblPrNo.Text = sNextPRNO.ToString();
            //}
            //else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("paymententry.aspx?action=edit&prno={0}", lblPrNo.Text));
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

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("paymententrylist.aspx");
    }
}
