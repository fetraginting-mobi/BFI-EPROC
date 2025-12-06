using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_apinvoice_apinvoiceregistrationdetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "AP_INVOICE_REGISTRATION_DETAIL";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        txtPocode.Text = Request.Params["pocode"];
        txtCodeBarcode.Text = Request.Params["codebarcode"];
        btnLookUpAcceptNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACGD&acol_0={0}&bcol_1={1}&ccol_1={2}&dcol_2={3}&parc_code={4}&parc_po_code={5}&ecol_1={6}');", lblAcceptDesc.ClientID, txtRemainingAmount.ClientID, lblRemaingAmount.ClientID, txtAcceptNo.ClientID, txtCodeBarcode.ClientID, txtPocode.ClientID, txtPurchaseAmount.ClientID);


        Shared.BindDivision(ddlDivision);
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
     
        LoadInit();
        //validasiAM();
        if (!Page.IsPostBack)
        {
            lblCodeBarcode.Text = Request.Params["codebarcode"];
            lblType.Text = Request.Params["type"];
            lblIdTarget.Text = Request.Params["idtarget"];
            
            Shared.BindCurrencyCode(ddlCurrency);
            Shared.BindTaxScreme(ddlTaxType);
            Shared.BindBranch(ddlBranch);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
             lblBranch.Text = Shared.CurrentDefaultEmployeeBranchCode;

           // Shared.BindTaxScreme(ddlTaxType);
             validasiAM();

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                ddlTaxType.Enabled = true;
                txtPurchaseAmount.Enabled = false;
                txtDiscount.Enabled = true;
                btnSave.Visible = true;
                //btnCancel.Text = "Back";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
               
                
                if (lblIRStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = true;
                    btnLookUpAcceptNo.Enabled = true;
                    //txtNo.Enabled = false;
                    ddlCurrency.Enabled = true;
                    txtRemarks.Enabled = true;
                    ddlBranch.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlTaxType.Enabled = false;
                    if (lblBranch.Text.Equals("KPO"))
                    {

                        ddlTaxType.Enabled = true;

                    }

                 
                }
                if (lblIRStatus.Text.Equals("ONPROGRESS"))
                {
                    if (lblIdTarget.Text.Equals(""))
                    {
                        btnSave.Visible = true;
                       
                       
                    }
                    else
                    {
                        btnSave.Visible = false;
                    }
                   
                    btnLookUpAcceptNo.Enabled = false;
                    //txtNo.Enabled = false;
                    ddlCurrency.Enabled = false;
                    txtPurchaseAmount.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlTaxType.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlTaxType.Enabled = true;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    txtDiscount.Enabled = false;


                }

               

                if (lblIRStatus.Text.Equals("POST"))
                {
                    btnSave.Visible = false;
                    btnLookUpAcceptNo.Enabled = false;
                    //txtNo.Enabled = false;
                    ddlCurrency.Enabled = false;
                    txtPurchaseAmount.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlTaxType.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlTaxType.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;

                }
            }
            else
            {
                GetCode();
            }
        }
        LoadAfterInit();
    }
    private void validasiAM()
    {
        if (lbladditionalamount.Text == "0.00")
        {
            txtDiscountaditional.Enabled = false;
        }
        else
        {
            txtDiscountaditional.Enabled = true;
        }
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

            lblInvoiceNo.Text = _dr["code"].ToString();
            lblType.Text = Request.Params["type"];
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
            Shared.BindBranch(ddlBranch);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            validasiAM();
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

            Shared.ShowSuccessGritter(this, string.Format("apinvoiceregistrationdetail.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, lblCodeBarcode.Text));
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
        Response.Redirect("apinvoiceregistrationheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text +  "&idartarget=" + Request.Params["idtarget"]);
    }

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);



        //updDep.Update();
    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
    }

    protected void ddlSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {

        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
    }


}
