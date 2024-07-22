using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_supplier_supplierinfobank : BasePage
{
    private static string TABLE_NAME = "MASTER_SUPPLIER_BANK";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&parc_curr_code={3}');", txtAccNo.ClientID, lblAccNo.ClientID, lblName.ClientID, ddlCurrency.ClientID);
        btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MBG&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_1={3}');", txtBankCode.ClientID, lblBankCode.ClientID, txtBankName.ClientID, lblBankName.ClientID);
        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyCode(ddlCurrency);
            //Shared.BindGeneralSubCode(ddlBankName, "BANKLIST");
            //Shared.BindBranch(ddlBranch);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
            else
            {

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

            _ht["p_id"] = Request.Params["id_dt"];

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
        //string sNextURL = "";
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            _ht["p_id"] = Request.Params["id"];
            _ht["p_supplier_code"] = Request.Params["suppliercode"];

            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                //lblbranchcode.Text = Request.Params["branchcode"].ToString();
                //
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblId.Text = iNextID.ToString();

                Shared.ShowSuccessGritter(this, string.Format("supplierinfobank.aspx?action=edit&suppliercode={0}&id={1}&id_dt={2}", Request.Params["suppliercode"], Request.Params["id"], lblId.Text));
            }

            else
            {

                _dal.Update(TABLE_NAME, _ht);

                Shared.ShowSuccessGritter(this, string.Format("supplierinfobank.aspx?action=edit&suppliercode={0}&id={1}&id_dt={2}", Request.Params["suppliercode"], Request.Params["id"], lblId.Text));
            }

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
        Response.Redirect(string.Format("supplierinfo.aspx?action=edit&suppliercode={0}&id={1}", Request.Params["suppliercode"], Request.Params["id"]));
    }

}
