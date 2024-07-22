using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_apinvoice_apadvanceallocationdetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "AP_ADVANCE_ALLOCATION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        
        LoadInit();
        txtEmpCode.Text = Request.Params["empcode"];
        if (!Page.IsPostBack)
        {
            lblCodeBarcode.Text = Request.Params["codebarcode"];
            btnLookUpInvoice.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=INVRG&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&gcol_5={6}&hcol_6={7}&icol_7={8}&jcol_8={9}&gcol_5={10}&hcol_5={11}&icol_10={12}&jcol_11={13}&kcol_12={14}&lcol_13={15}&parc_emp_code={16}');", lblInvoiceDesc.ClientID, txtInvoiceNo.ClientID, lblInvoiceDate.ClientID, lblCurrencyDesc.ClientID, txtDescription.ClientID, lblBill.ClientID, lblNetBill.ClientID, lblPPN.ClientID, lblPPH.ClientID, lblDiscount.ClientID, lblPayment.ClientID, txtpayment.ClientID, txtDepartmentCode.ClientID, lblDepartmentDesc.ClientID, txtDivision.ClientID, lblDivision.ClientID, txtEmpCode.ClientID);
            txtRemainingBill.Enabled = false;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;

                btnCancel.Text = "Back";

                if (!lblAAStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    btnLookUpInvoice.Enabled = false;
                }
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
            DataRow _dr = _dal.GetRow("AP_ADVANCE_ALLOCATION_HEADER", _ht);

            lblNo.Text = _dr["code"].ToString();
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
        //
        try
        {

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

            Shared.ShowSuccessGritter(this, string.Format("apadvanceallocationdetail.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, lblCodeBarcode.Text));
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
        Response.Redirect("apadvanceallocationheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text);
    }  
}
