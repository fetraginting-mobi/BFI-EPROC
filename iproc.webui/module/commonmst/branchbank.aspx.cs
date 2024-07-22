using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_branchbank : BasePage
{
    private static string TABLE_NAME = "SYS_BRANCH_BANK";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        //btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_1={0}&bcol_1={1}&ccol_2={2}');", txtAccNo.ClientID, lblAccNo.ClientID, lblName.ClientID);
        btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&parc_curr_code={3}');", txtAccNo.ClientID, lblAccNo.ClientID, lblName.ClientID, ddlCurrency.ClientID);
        btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MBG&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_1={3}');", txtBankCode.ClientID, lblBankCode.ClientID, txtBankName.ClientID, lblBankName.ClientID);
        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyCode(ddlCurrency);
           // Shared.BindGeneralSubCode(ddlBankName, "BANKLIST");

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
            else
            {
                txtAccountName.Text = Request.Params["branchname"];
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

            _ht["p_code"] = Request.Params["code"];

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
        string iNextID = "";
        //string sNextURL = "";
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            _ht["p_code"] = Request.Params["code"];
            _ht["p_branch_code"] = Request.Params["branchcode"];

            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                //lblbranchcode.Text = Request.Params["branchcode"].ToString();
                //
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblCode.Text = iNextID.ToString();

                Shared.ShowSuccessGritter(this, string.Format("branchbank.aspx?action=edit&branchcode={0}&code={1}", Request.Params["branchcode"], lblCode.Text));
            }

            else
            {

                _dal.Update(TABLE_NAME, _ht);

                Shared.ShowSuccessGritter(this, string.Format("branchbank.aspx?action=edit&branchcode={0}&code={1}", Request.Params["branchcode"], lblCode.Text));
            }

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void TypeFlag()
    //{
    //    {
    //        //

    //        GeneralDAL _dal = null;
    //        Hashtable _ht = null;

    //        try
    //        {
    //            _dal = new GeneralDAL();
    //            _ht = new Hashtable();

    //            if (ddlTypeFlag.SelectedValue == "1")
    //            {
    //                _ht["p_keywords"] = "";

    //                _dal.ExecRawSP("xsp_acc_chart_getrows_for_lookup_bank", _ht);

    //                btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ACCBK&acol_0={0}&bcol_1={1}');", txtAccNo.ClientID, lblAccNo.ClientID);
    //            }
    //            else
    //            {
    //                _ht["p_keywords"] = "";

    //                _dal.ExecRawSP("xsp_acc_chart_getrows_for_lookup_cash", _ht);

    //                btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ACCCH&acol_0={0}&bcol_1={1}');", txtAccNo.ClientID, lblAccNo.ClientID);
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //            Shared.ShowErrorDialog(this, ex);
    //        }
    //    }
    //}

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("masterbranch.aspx?action=edit&companycode={0}&code={1}", Request.Params["companycode"], Request.Params["branchcode"]));
    }

    //protected void ddlTypeFlag_SelectedOnChanged(object sender, EventArgs e)
    //{
    //    TypeFlag();
    //}
}
