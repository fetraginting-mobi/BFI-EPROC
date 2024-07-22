using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apadvanceanddeposit_apadvanceregistrationpo : BasePage
{
    private static string TABLE_NAME_PO = "AP_ADVANCE_REGISTRATION_PO";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        txtSupplierCode.Text = Request.Params["suppliercode"];
        if (!Page.IsPostBack)
        {


            lblBarcode.Text = Request.Params["codebarcode"];
           


            btnLookUpPurchaseOrderCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=POADV&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_supplier_code={3}&parc_ar_code={3}');", txtPurchaseOrderCode.ClientID, txtPOCode.ClientID, txtPoAmount.ClientID, txtSupplierCode.ClientID, lblBarcode.ClientID);
            
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                //btnCancel.Text = "Back";

                if (!lblIIStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    txtAmount.Enabled = false;
                    txtDescription.Enabled = false;
                     
                }
            }
            else
            {
                //lblDivision.Text = Request.Params["divisioncode"];
                //lblDepartment.Text = Request.Params["departmentcode"];
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
            DataRow _dr = _dal.GetRow("AP_ADVANCE_REGISTRATION", _ht);

            lblIICode.Text = _dr["code"].ToString();
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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = Request.Params["id"];
            DataRow _dr = _dal.GetRow(TABLE_NAME_PO, _ht);

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
        int inextid = 0;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_PO, _ht, ref inextid);
                lblId.Text = inextid.ToString();
            }
            else
                _dal.Update(TABLE_NAME_PO, _ht);

            Shared.ShowSuccessGritter(this, string.Format("apadvanceregistrationpo.aspx?action=edit&id={0}&codebarcode={1}", lblId.Text, lblBarcode.Text));
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
        Response.Redirect("apadvanceregistration.aspx?action=edit&codebarcode=" + lblBarcode.Text);
    }
}
