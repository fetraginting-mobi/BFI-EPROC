using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apinvoice_apinvoiceregistrationtermin : BasePage
{
    private static string TABLE_NAME_DETAIL = "AP_INVOICE_REGISTRATION_TERMIN";

    protected void Page_Load(object sender, EventArgs e)
    {
        txtPocode.Text = Request.Params["pocode"];
        txtCodeBarcode.Text = Request.Params["codebarcode"];
        btnLookUpReffNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=GRNIN&acol_0={0}&bcol_0={1}&parc_po_no={2}');", txtReffNo.ClientID, lblReffNo.ClientID, txtPocode.ClientID);

        Shared.BindGeneralSubCode(ddlTrxCode, "TRX");
 
        LoadInit();
        if (!Page.IsPostBack)
        {
            lblCodeBarcode.Text = Request.Params["codebarcode"];
            lblType.Text = Request.Params["type"];
 

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                //btnCancel.Text = "Back";

                 
            }
            else
            {
                GetCode();
            }
        }
        LoadAfterInit();
    }

    private void GetCode()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow("AP_INVOICE_REGISTRATION_HEADER", _ht);

            lblCodeBarcode.Text = _dr["code"].ToString();
            lblType.Text = Request.Params["type"];
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void GetDetail(string PO, string Termin)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_po_code"] = PO;
            _ht["p_termin"] = Termin;
            DataRow _dr = _dal.GetRow("","xsp_ap_invoice_registration_termin_getrow_detail", _ht);

            lblPercentage.Text = _dr["PERCENTAGE"].ToString();
            lblAmount.Text = _dr["AMOUNT"].ToString();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);   
        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        lblType.Text = Request.Params["type"];
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = Request.Params["id"];
            lblType.Text = Request.Params["type"];

            DataRow _dr = _dal.GetRow(TABLE_NAME_DETAIL, _ht);

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
            //
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME_DETAIL, _ht);

            Shared.ShowSuccessGritter(this, string.Format("apinvoiceregistrationtermin.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, lblCodeBarcode.Text));
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
        Response.Redirect("apinvoiceregistrationheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text);
    }

}
