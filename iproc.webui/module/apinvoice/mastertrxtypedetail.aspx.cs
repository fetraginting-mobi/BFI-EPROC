using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apinvoice_mastertrxtypedetail : BasePage
{
    private static string TABLE_NAME = "MASTER_TRX_TYPE_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {

        btnLookUpACCNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&parc_curr_code={3}');", txtACCNo.ClientID, lblACCNo.ClientID, lblACCName.ClientID, ddlCurrency.ClientID);

        LoadInit();

        if (!Page.IsPostBack)
        {

            Shared.BindCurrencyCode(ddlCurrency);

            lblTrxCode.Text = Request.Params["trxcode"];
            txtTrxCode.Text = Request.Params["trxcode"];

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();


                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
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

        //
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

            Shared.ShowSuccessGritter(this, string.Format("mastertrxtypedetail.aspx?action=edit&id={0}&trxcode={1}", lblID.Text, lblTrxCode.Text));
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
        Response.Redirect("mastertrxtypeheader.aspx?action=edit&trxcode=" + txtTrxCode.Text);
    }
}
