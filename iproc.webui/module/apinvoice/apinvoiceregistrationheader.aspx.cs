using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apinvoice_apinvoiceregistrationheader : BasePage
{


    private static string TABLE_NAME_HEADER = "AP_INVOICE_REGISTRATION_HEADER";
    private static string TABLE_NAME_DETAIL = "AP_INVOICE_REGISTRATION_DETAIL";
    private static string TABLE_NAME_TERMIN = "AP_INVOICE_REGISTRATION_TERMIN";
    private static string TABLE_NAME_EXPENSE = "AP_INVOICE_REGISTRATION_EXPENSE";
    private static string TABLE_NAME_DETAIL_FEE = "AP_INVOICE_REGISTRATION_FEE";
    private static string TABLE_NAME_ADVANCE_DEPOSIT = "AP_INVOICE_REGISTRATION_ADVANCE";
    private static string TABLE_NAME_DOCUMENT= "INVOICE_DOCUMENT";
    private static string GET_MULTIPLE_BRANCH = "GET_IS_AGAS"; // (+) Ari 04-07-2022 ket : enhancement 2022

    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindCurrencyCode(ddlCurrencyCode);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindGeneralSubCode(ddlFlagAdvDps, "FAD");
            Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "FAKB");
            //BindDataDocRequest();
            //ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;

            ddlBranch.Enabled = false;
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            //Shared.BindTaxScreme(ddlTaxType);

            btnDeleteDetail.OnClientClick = "return confirm('Delete selected data?');";

           // btnLookUpPurchaseOrderCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PUROR&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&gcol_6={6}&hcol_7={7}&icol_8={8}&jcol_9={9}&kcol_10={10}&lcol_13={11}&mcol_14={12}&ncol_15={13}&ocol_16={14}&parc_branch_code={15}');", txtPurchaseOrderCode.ClientID, txtPurchaseOrder.ClientID, txtPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, txtInvoiceAmount.ClientID, txtDiscount.ClientID, txtPPNTax.ClientID, txtPPHTax.ClientID, ddlCurrencyCode.ClientID, txtTotalFee.ClientID, ddlDivision.ClientID, ddlDepartment.ClientID, ddlSubDepartment.ClientID, ddlUnits.ClientID, txtBranch.ClientID);

            //btnLookUpPurchaseOrderCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PUROR&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&gcol_6={6}&hcol_7={7}&icol_8={8}&jcol_9={9}&kcol_10={10}&parc_branch_code={11}');", txtPurchaseOrderCode.ClientID, txtPurchaseOrder.ClientID, txtPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, txtInvoiceAmount.ClientID, txtDiscount.ClientID, txtPPNTax.ClientID, txtPPHTax.ClientID, ddlCurrencyCode.ClientID, txtTotalFee.ClientID, txtBranch.ClientID);
            //btnLookUpPurchaseOrderCodeTOP.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PUTOP&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&gcol_6={6}&hcol_7={7}&icol_8={8}&jcol_9={9}&kcol_10={10}&parc_branch_code={11}');", txtPurchaseOrderCode.ClientID, txtPurchaseOrder.ClientID, txtPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, txtInvoiceAmount.ClientID, txtDiscount.ClientID, txtPPNTax.ClientID, txtPPHTax.ClientID, ddlCurrencyCode.ClientID, txtTotalFee.ClientID, txtBranch.ClientID);
            btnLookUpPurchaseFaAdjust.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FAJLU&acol_0={0}&parc_branch_code={1}');", txtFaAdjustCode.ClientID, txtBranch.ClientID);
            btnLookUpDepositRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=POINV&acol_0={0}&parc_branch_code={1}');", txtDepositNo.ClientID, txtBranch.ClientID);

            LoadDataagas(); // (+) Ari 30-12-2022 ket : enhancement 2022
            // (+) Ari 30-06-2022 ket : enhancement 2022 jika Role Flag Is Multiplebranch saat pemilihan po diurutkan berdasarkan branch yang dipilih
            if (lblMultiplebranch.Text == "1")
            {
                //(+) Ari 30-12-2022 ket : enhancement 2022
                btnLookUpPurchaseOrderCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PUROR&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&gcol_6={6}&hcol_7={7}&icol_8={8}&jcol_9={9}&kcol_10={10}&parc_branch_code={11}');", txtPurchaseOrderCode.ClientID, txtPurchaseOrder.ClientID, txtPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, txtInvoiceAmount.ClientID, txtDiscount.ClientID, txtPPNTax.ClientID, txtPPHTax.ClientID, ddlCurrencyCode.ClientID, txtTotalFee.ClientID, ddlBranch.ClientID);
                btnLookUpPurchaseOrderCodeTOP.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PUTOP&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&gcol_6={6}&hcol_7={7}&icol_8={8}&jcol_9={9}&kcol_10={10}&parc_branch_code={11}');", txtPurchaseOrderCode.ClientID, txtPurchaseOrder.ClientID, txtPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, txtInvoiceAmount.ClientID, txtDiscount.ClientID, txtPPNTax.ClientID, txtPPHTax.ClientID, ddlCurrencyCode.ClientID, txtTotalFee.ClientID, ddlBranch.ClientID);
            }
            else
            {
                btnLookUpPurchaseOrderCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PUROR&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&gcol_6={6}&hcol_7={7}&icol_8={8}&jcol_9={9}&kcol_10={10}&parc_branch_code={11}');", txtPurchaseOrderCode.ClientID, txtPurchaseOrder.ClientID, txtPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, txtInvoiceAmount.ClientID, txtDiscount.ClientID, txtPPNTax.ClientID, txtPPHTax.ClientID, ddlCurrencyCode.ClientID, txtTotalFee.ClientID, txtBranch.ClientID);
                btnLookUpPurchaseOrderCodeTOP.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PUTOP&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&gcol_6={6}&hcol_7={7}&icol_8={8}&jcol_9={9}&kcol_10={10}&parc_branch_code={11}');", txtPurchaseOrderCode.ClientID, txtPurchaseOrder.ClientID, txtPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, txtInvoiceAmount.ClientID, txtDiscount.ClientID, txtPPNTax.ClientID, txtPPHTax.ClientID, ddlCurrencyCode.ClientID, txtTotalFee.ClientID, txtBranch.ClientID);
            }


            // btnLookUpSupplierID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=POSUP&acol_0={0}&bcol_1={1}&parc_code={2}');", txtSupplierID.ClientID, lblSupplierName.ClientID, txtPurchaseOrderCode.ClientID);

            btnLookUpSupplierID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtSupplierID.ClientID, lblSupplierName.ClientID);

            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=STAFF&acol_0={0}&bcol_1={1}');", txtSupplierID.ClientID, lblSupplierName.ClientID);

            btnLookUpPreviousInvoiceNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=IRSBM&acol_1={0}&bcol_1={1}&parc_code={2}');", txtPreviousInvoiceNo.ClientID, lblCodePreviousInvoiceNo.ClientID, txtPurchaseOrderCode.ClientID);

            btnAddDetail.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=INVDET&parc_invoice_code={0}&gvw={1}');", txtCodeBarcode.ClientID, btnSearchDetail.UniqueID);
            btnAddTermin.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=INVTER&parc_invoice_code={0}&gvw={1}&parc_code_barcode={2}');", txtCodeBarcode.ClientID, btnSearchTermin.UniqueID, txtPurchaseOrderCode.ClientID);
            btnAddAdDep.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=INADV&parc_invoice_code={0}&gvw={1}&parc_supplier_code={2}');", txtCodeBarcode.ClientID, btnSearchAdDep.UniqueID, txtSupplierID.ClientID);
            btnAddDep.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=INDPS&parc_invoice_code={0}&gvw={1}&parc_supplier_code={2}');", txtCodeBarcode.ClientID, btnSearchAdDep.UniqueID, txtSupplierID.ClientID);
            //if (ddlInvoiceTypeCode.SelectedValue.Equals("FAKB") || ddlInvoiceTypeCode.SelectedValue.Equals("FAKUM"))
            //{
                btnLookUpPreviousInvoiceNo.Enabled = false;
            //}
            //else
            //    btnLookUpPreviousInvoiceNo.Enabled = true;
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "tab();", true);

            btnAddAdDep.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=INADV&parc_invoice_code={0}&gvw={1}&parc_supplier_code={2}');", txtCodeBarcode.ClientID, btnSearchAdDep.UniqueID, txtSupplierID.ClientID);

            

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                //btnCancel.Text = "Back";
                btnReject.Text = "Cancel";

                BindData();
                BindFee();
                BindExpense();
                BindTermin();
                Shared.BindDivision(ddlDivision);
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                rblBillType.Enabled = false;
                ddlCurrencyCode.Enabled = false;
                BindDataDocRequest();
                BindAdDep();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
              
                txtInvoiceDate.Enabled = false;
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                //txtInvoiceAmount.Enabled = false;
                ddlFlagAdvDps.Enabled = false;
                txtFaAdjustCode.Enabled = false;
                btnLookUpPurchaseFaAdjust.Enabled = false;
                btnLookUpSupplierID.Enabled = false;

                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
                // btnPost.OnClientClick = "return confirm('Post selected data?');";
                // btnReject.OnClientClick = "return confirm('Cancel selected data?');";

                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (ddlInvoice.SelectedValue == "N")
                {
                    txtInvoiceNo.Visible = true;
                    rfvInvoiceNo.Enabled = false;
                    txtInvoiceNo.Enabled = false;

                   
                }

                if (ddlInvoice.SelectedValue == "Y")
                {
                    txtInvoiceNo.Visible = true;

                    rfvInvoiceNo.Enabled = true;
                    txtInvoiceNo.Enabled = true;

                    RIN.Visible = true;

                }



                if (ddlFlagAdvDps.SelectedValue == "FAV")
                {
                    btnAddAdDep.Visible = true;
                    btnAddDep.Visible = false;
                    btnDeleteAdDep.Visible = true;
                    btnAddDetail.Visible = false;
                    btnDeleteDetail.Visible = false;
                    btnSaveDetail.Visible = false;
                    btnLookUpPurchaseFaAdjust.Visible = true;
                    FANO.Visible = true;
                    txtFaAdjustCode.Visible = false;

                }

               if (ddlFlagAdvDps.SelectedValue == "FDS")
                {
                    btnAddDep.Visible = false;
                    btnAddAdDep.Visible = false;
                    btnDeleteAdDep.Visible = false;
                    btnLookUpPurchaseFaAdjust.Visible = false;
                    FANO.Visible = false;
                    txtFaAdjustCode.Visible = false;
                    DEPO.Visible = true;
                    txtDepositNo.Enabled = false;
                    btnLookUpDepositRequest.Enabled = false;

                }

               else if (ddlFlagAdvDps.SelectedValue == "FDA")
                    {
                    btnAddDep.Visible = true;
                    btnAddAdDep.Visible = false;
                    btnDeleteAdDep.Visible = true;
                    btnLookUpPurchaseFaAdjust.Visible = false;
                    FANO.Visible = false;
                    txtFaAdjustCode.Visible = false;
                    DEPO.Visible = false;
                    txtDepositNo.Visible = false;
                    }   

                else
                {
                    liAdvanceDeposit.Visible = false;
                    btnAddDep.Visible = false;
                    btnAddAdDep.Visible = false;
                    btnDeleteAdDep.Visible = false;
                }

                    
            
                if (rblBillType.SelectedValue == "OT")
                {
                    mandatory.Visible = false;
                    spasi.Visible = true;
                   // rfvPurchaseOrderCode.Enabled = false;

                }
                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    btnAddTermin.Visible = btnDeleteTermin.Visible = false;
                    txtInvoiceDate.Enabled = false;
                    rblBillType.Enabled = false;
                    ddlInvoiceTypeCode.Enabled = false;
                    btnLookUpPreviousInvoiceNo.Enabled = false;
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    btnLookUpSupplierID.Enabled = false;
                    txtInvoiceNo.Enabled = false;
                    txtTaxInvoiceDate.Enabled = false;
                    txtMaturityDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    //txtBaseTax.Enabled = false;
                    //txtInvoiceAmount.Enabled = false;
                    txtTaxInvoiceNo.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    txtInstallmentNo.Enabled = false;
                    btnLookUpSupplierID.Enabled = false;
                    btnLookUpPreviousInvoiceNo.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlFlagAdvDps.Enabled = false;
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    btnDeleteDetail.Visible = false;
                    btnSaveDetail.Visible = false;
                    btnAddDetail.Visible = false;
                    gvwListDetail.Columns[1].Visible = false;
                    ddlUnits.Enabled = false;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;
                    btnAddAdDep.Visible = false;
                    btnAddDep.Visible = false;
                    btnDeleteAdDep.Visible = false;
                    btnSaveTermin.Visible = false;
                    txtDepositNo.Enabled = false;
                    btnLookUpDepositRequest.Enabled = false;
                    txtFaAdjustCode.Enabled = false;
                    btnLookUpPurchaseFaAdjust.Enabled = false;

                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = btnAddTermin.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    txtInvoiceDate.Enabled = false;
                    rblBillType.Enabled = false;
                    ddlInvoiceTypeCode.Enabled = false;
                    btnLookUpPreviousInvoiceNo.Enabled = false;
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    btnLookUpSupplierID.Enabled = false;
                    txtInvoiceNo.Enabled = false;
                    txtTaxInvoiceDate.Enabled = false;
                    txtMaturityDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    //txtBaseTax.Enabled = false;
                    //txtInvoiceAmount.Enabled = false;
                    txtTaxInvoiceNo.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    txtInstallmentNo.Enabled = false;
                    btnLookUpSupplierID.Enabled = false;
                    btnLookUpPreviousInvoiceNo.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlFlagAdvDps.Enabled = false;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;
                    btnDeleteDetail.Visible = false;
                    btnSaveDetail.Visible = false;
                    btnAddDetail.Visible = false;
                    gvwListDetail.Columns[1].Visible = false;
                    ddlUnits.Enabled = false;
                    btnSaveTermin.Visible = false;
                    txtDepositNo.Enabled = false;
                    btnLookUpDepositRequest.Enabled = false;
                    txtFaAdjustCode.Enabled = false;
                    btnLookUpPurchaseFaAdjust.Enabled = false;
                    btnDeleteTermin.Visible = false;
                   


                    if (!lblApprovalRequestTargetID.Text.Equals(""))
                        btnApprovalTiered.Visible = true;

                } 
                if (rblBillType.SelectedValue == "APA")
                {
                    Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "APA");
                    btnLookUpPurchaseOrderCode.Visible = false;
                    btnLookUpPurchaseOrderCodeTOP.Visible = true;
                    btnLookUpSupplierID.Visible = false;
                    lblSupplier.Visible = true;
                    btnLookUpUserRequest.Visible = false;
                    lblUser.Visible = false;
                    btnLookUpPreviousInvoiceNo.Enabled = true;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    //txtInvoiceAmount.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    txtInstallmentNo.Enabled = false;
                    btnLookUpSupplierID.Enabled = false;
                    btnLookUpPreviousInvoiceNo.Enabled = false;
                    txtDepositNo.Enabled = false;
                    btnLookUpDepositRequest.Enabled = false;
                    txtFaAdjustCode.Enabled = false;
                    btnLookUpPurchaseFaAdjust.Enabled = false;


                    liFee.Visible = true;
                    liAdvanceDeposit.Visible = true;
                   
                   
                    ddlFlagAdvDps.Visible = true;

                    rfvFlagAdvDps.Enabled = true;
                    lblRemainingBalance.Visible = true;
                    txtRemainingBalance.Visible = true;
                    txtFaAdjustCode.Visible = false;
                    DEPO.Visible = false;
                    txtDepositNo.Visible = false;
                    btnLookUpPurchaseFaAdjust.Visible = false;
                    FANO.Visible = false;


                    if (ddlFlagAdvDps.SelectedValue == "FDS")
                    {
                        liFee.Visible = false;
                        liDetail.Visible = false;
                        liTermin.Visible = false;
                        FANO.Visible = false;
                        btnLookUpSupplierID.Enabled = false;
                        btnLookUpPurchaseFaAdjust.Visible = false;
                        txtFaAdjustCode.Visible = false;
                        DEPO.Visible = true;
                        txtDepositNo.Visible = true;

                    }

                    if (ddlFlagAdvDps.SelectedValue == "FDA")
                    {
                        liFee.Visible = true;
                        liDetail.Visible = true;
                        liTermin.Visible = false;
                        FANO.Visible = false;
                        btnLookUpSupplierID.Enabled = false;
                        btnLookUpPurchaseFaAdjust.Visible = false;
                        txtFaAdjustCode.Visible = false;
                        DEPO.Visible = false;
                        txtDepositNo.Visible = false;

                    }

                    if (ddlFlagAdvDps.SelectedValue == "FAV")
                    {
                        liFee.Visible = true;
                        liDetail.Visible = true;
                        liTermin.Visible = false;
                        btnLookUpSupplierID.Enabled = false;
                        btnLookUpPurchaseFaAdjust.Visible = true;
                        FANO.Visible = true;
                        txtFaAdjustCode.Visible = true;
                        DEPO.Visible = false;
                        txtDepositNo.Visible = false;
                    }

               
                    
                }
                else if (rblBillType.SelectedValue == "OT" )
                {
                    Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "OT");
                    btnLookUpSupplierID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtSupplierID.ClientID, lblSupplierName.ClientID);
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    btnLookUpPurchaseOrderCodeTOP.Visible = false;
                    btnLookUpUserRequest.Visible = false;
                    btnLookUpPurchaseFaAdjust.Visible = true;
                  
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    btnLookUpUserRequest.Visible = false;
                    lblUser.Visible = false;
                    btnLookUpSupplierID.Visible = true;
                    lblSupplier.Visible = true;
                    //txtInvoiceAmount.Enabled = true;
                    txtInstallmentNo.Enabled = false;
                    btnLookUpSupplierID.Enabled = true;
                    btnLookUpPreviousInvoiceNo.Enabled = false;
                    lblRemainingBalance.Visible = false;
                    txtRemainingBalance.Visible = false;
                    liTermin.Visible = false;
                   
                    if (ddlFlagAdvDps.SelectedValue == "FDS")
                    {
                        liFee.Visible = false;
                        liDetail.Visible = false;
                        liTermin.Visible = false;
                        FANO.Visible = false;
                        btnLookUpSupplierID.Enabled = false;
                        btnLookUpPurchaseFaAdjust.Visible = false;
                        txtFaAdjustCode.Visible = false;
                        DEPO.Visible = true;
                        txtDepositNo.Visible = true;
                    }

                    if (ddlFlagAdvDps.SelectedValue == "FDA")
                    {
                        liFee.Visible = true;
                        liDetail.Visible = true;
                        liTermin.Visible = false;
                        FANO.Visible = false;
                        btnLookUpSupplierID.Enabled = false;
                        btnLookUpPurchaseFaAdjust.Visible = false;
                        txtFaAdjustCode.Visible = false;
                        DEPO.Visible = false;
                        txtDepositNo.Visible = false;
                    }

                    if (ddlFlagAdvDps.SelectedValue == "FAV")
                    {
                        liFee.Visible = true;
                        liDetail.Visible = true;
                        liTermin.Visible = false;
                        btnLookUpSupplierID.Enabled = false;
                        btnLookUpPurchaseFaAdjust.Visible = true;
                        FANO.Visible = true;
                        txtFaAdjustCode.Visible = true;
                        DEPO.Visible = false;
                        txtDepositNo.Visible = false;
                    }

                  
                }
                else if (rblBillType.SelectedValue == "PO")
                {
                    Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "PO");
                    btnLookUpSupplierID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=POSUP&acol_0={0}&bcol_1={1}&parc_code={2}');", txtSupplierID.ClientID, lblSupplierName.ClientID, txtPurchaseOrderCode.ClientID);
                    btnLookUpPurchaseOrderCode.Enabled = true;
                    btnLookUpUserRequest.Visible = false;
                    btnLookUpPurchaseFaAdjust.Visible = false;
                    lblUser.Visible = false;
                    btnLookUpSupplierID.Visible = false;
                    lblSupplier.Visible = true;
                    ddlCurrencyCode.Enabled = false;
                    //txtInvoiceAmount.Enabled = false;
                    txtInstallmentNo.Enabled = false;
                    btnLookUpSupplierID.Enabled = false;
                    btnLookUpPreviousInvoiceNo.Enabled = false;
                    btnLookUpUserRequest.Enabled = false;
                    btnLookUpPurchaseOrderCodeTOP.Visible = false;
                  
                    liTermin.Visible = false;
                    liDetail.Visible = false;
                    lblRemainingBalance.Visible = false;
                    txtRemainingBalance.Visible = false;
                    DEPO.Visible = false;
                    txtDepositNo.Visible = false;
                  
                    if (ddlFlagAdvDps.SelectedValue == "FDS")
                    {
                        liFee.Visible = false;
                        liDetail.Visible = false;
                        liTermin.Visible = false;
                        FANO.Visible = false;
                        btnLookUpSupplierID.Enabled = false;
                        btnLookUpPurchaseFaAdjust.Visible = false;
                        txtFaAdjustCode.Visible = false;
                    }

                    if (ddlFlagAdvDps.SelectedValue == "FDA")
                    {
                        liFee.Visible = true;
                        liDetail.Visible = true;
                        liTermin.Visible = false;
                        FANO.Visible = false;
                        btnLookUpSupplierID.Enabled = false;
                        btnLookUpPurchaseFaAdjust.Visible = false;
                        txtFaAdjustCode.Visible = false;
                    }

                    if (ddlFlagAdvDps.SelectedValue == "FAV")
                    {
                        liFee.Visible = true;
                        liDetail.Visible = true;
                        liTermin.Visible = false;
                        btnLookUpSupplierID.Enabled = false;
                        btnLookUpPurchaseFaAdjust.Visible = true;
                        FANO.Visible = true;
                        txtFaAdjustCode.Visible = true;
                    }

                }
                else
                {
                    Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "PO");
                   
                }

            }
            else
            {
                rblBillType.SelectedValue = "PO";
                pnlDetail.Visible = false;
                rfvFlagAdvDps.Enabled = false;
                txtInvoiceDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtInvoiceDate.Enabled = false;
                txtInvoiceNo.Visible = false;
                txtInvoiceNo.Text = "-";
                //ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                //ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                ddlFlagAdvDps.Enabled = true;
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;

                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

                // (+) Ari 10-08-2022 ket: enhancement 2022
                txtRate.Enabled = false;
                //LoadDataagas(); // (+) Ari 30-12-2022 ket : enhancement 2022
                // (+) Ari 30-06-2022 ket : enhancement 2022 (jika Role Flag Is Agas bisa edit ddlBranch)
                if (lblMultiplebranch.Text == "1")
                {
                    ddlBranch.Enabled = true;
                }


                if (rblBillType.SelectedValue == "PO")
                {
                    Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "PO");
                    btnLookUpUserRequest.Visible = false;
                    btnLookUpPurchaseFaAdjust.Visible = false;
                    lblUser.Visible = false;
                    btnLookUpSupplierID.Enabled = false;
                    //txtInvoiceAmount.Enabled = false;
                    mandatory.Visible = true;
                    //rfvPurchaseOrderCode.Enabled = true;
                    spasi.Visible = true;
                    ddlCurrencyCode.Enabled = false;
                    btnLookUpPurchaseOrderCode.Enabled = true;
                    lblRemainingBalance.Visible = false;
                    txtRemainingBalance.Visible = false;
                    btnLookUpPurchaseOrderCodeTOP.Visible = false;
                    FANO.Visible = false;
                    btnLookUpPurchaseFaAdjust.Visible = false;
                    DEPO.Visible = false;
                    btnLookUpDepositRequest.Visible = false;
                    ddlFlagAdvDps.Enabled = false;
                    ddlFlagAdvDps.Text = "FPO";
                }
                if (rblBillType.SelectedValue == "APA")
                {
                    btnLookUpPurchaseOrderCode.Visible = false;
                    FANO.Visible = false;
                    btnLookUpPurchaseOrderCodeTOP.Visible = true;
                    ddlFlagAdvDps.Enabled = false;
                    ddlFlagAdvDps.Text = "FPO";
                }
               

                btnReject.Visible = btnPost.Visible = false;
                btnAdd.Visible = btnDelete.Visible = false;

                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
              
                btnLookUpPurchaseOrderCode.Enabled = true;
                ddlCurrencyCode.Enabled = false;
               

            }
        }
       

        if (rblBillType.SelectedValue == "PO")
        {
            mandatory.Visible = true;
            spasi.Visible = false;

            FANO.Visible = false;
            ddlFlagAdvDps.Enabled = false;
            ddlFlagAdvDps.Text = "FPO";
            //rfvPurchaseOrderCode.Enabled = true;
           
        }
        if (rblBillType.SelectedValue == "OT")
        {
            mandatory.Visible = false;
            spasi.Visible = true;
            FANO.Visible = false;
            ddlFlagAdvDps.Enabled = true;

            // rfvPurchaseOrderCode.Enabled = false;
            liInvoice.Visible = true;
            liTermin.Visible = false;

            if (ddlFlagAdvDps.SelectedValue == "FAV")
            {
                liFee.Visible = true;
                liDetail.Visible = true;
                liTermin.Visible = false;
                btnLookUpSupplierID.Enabled = false;
                btnLookUpPurchaseFaAdjust.Visible = true;
                FANO.Visible = true;
                txtFaAdjustCode.Visible = true;
                btnLookUpSupplierID.Enabled = false;
                DEPO.Visible = false;
                txtDepositNo.Visible = false;
            }

            if (ddlFlagAdvDps.SelectedValue == "FDS")
            {
                liFee.Visible = false;
                liDetail.Visible = false;
                liTermin.Visible = false;
                FANO.Visible = false;
                btnLookUpSupplierID.Enabled = false;
                btnLookUpPurchaseFaAdjust.Visible = false;
                txtFaAdjustCode.Visible = false;
                btnLookUpSupplierID.Enabled = false;
                DEPO.Visible = true;
                txtDepositNo.Visible = true;
                btnLookUpDepositRequest.Visible = true;
            
            }

            if (ddlFlagAdvDps.SelectedValue == "FDA")
            {
                liFee.Visible = true;
                liDetail.Visible = true;
                liTermin.Visible = false;
                FANO.Visible = false;
                btnLookUpSupplierID.Enabled = false;
                btnLookUpPurchaseFaAdjust.Visible = false;
                txtFaAdjustCode.Visible = false;
                 btnLookUpSupplierID.Enabled = false;
                 DEPO.Visible = false;
                 txtDepositNo.Visible = false;
            
            }

         

        }

       

        //else if (rblBillType.SelectedValue == "OT")
        //{
        //    mandatory.Visible = false;
        //    spasi.Visible = true;
        //    FANO.Visible = false;

        //    // rfvPurchaseOrderCode.Enabled = false;
        //    liInvoice.Visible = true;
        //    liTermin.Visible = false;

        //    if (ddlFlagAdvDps.SelectedValue == "FDS")
        //    {
        //        liFee.Visible = false;
        //        liDetail.Visible = false;
        //        liTermin.Visible = false;
        //        FANO.Visible = false;
        //        btnLookUpSupplierID.Enabled = false;
        //        btnLookUpPurchaseFaAdjust.Visible = false;
        //        txtFaAdjustCode.Visible = false;
        //    }

        //    if (ddlFlagAdvDps.SelectedValue == "FDA")
        //    {
        //        liFee.Visible = true;
        //        liDetail.Visible = true;
        //        liTermin.Visible = false;
        //        FANO.Visible = false;
        //        btnLookUpSupplierID.Enabled = false;
        //        btnLookUpPurchaseFaAdjust.Visible = false;
        //        txtFaAdjustCode.Visible = false;
        //    }

        //    if (ddlFlagAdvDps.SelectedValue == "FAV")
        //    {
        //        liFee.Visible = true;
        //        liDetail.Visible = true;
        //        liTermin.Visible = false;
        //        btnLookUpSupplierID.Enabled = false;
        //        btnLookUpPurchaseFaAdjust.Visible = true;
        //        FANO.Visible = true; 
        //        txtFaAdjustCode.Visible = true;
        //    }

        //}

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/apinvoice/apinvoiceregistrationheaderlist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000027&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblTotalAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000027&parc_object_id={0}&parc_object_branch={1}&parc_object_amount={2}&parc_branch_code={3}&parc_object_description={4}');", lblCodeBarcode.ClientID, lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000028&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000028&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
        LoadAfterInit();
        if (ddlCurrencyCode.SelectedValue.ToLower() == "idr")
        {
            txtRate.Enabled = false;
            txtRate.Text = "1";
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

            if (rblBillType.SelectedValue == "PO")
            {
                mandatory.Visible = true;

                //rfvPurchaseOrderCode.Enabled = true;

                rfvFlagAdvDps.Enabled = false;
            }
            else if (rblBillType.SelectedValue == "OT")
            {
                mandatory.Visible = false;

                //rfvPurchaseOrderCode.Enabled = false;

            }

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            _ht["p_user_id"] = Shared.CurrentUID;
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindBranchEmployee(ddlBranch);
            BindDataDocRequest();
           
            
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    // (+) Ari 01-07-2022 ket : enhancement 2022 cek Role IS_AGAS
    private void LoadDataagas()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();


            _ht["p_user_id"] = Shared.CurrentUID;
            Shared.ApplyDefaultProp(_ht);
            DataRow _dr = _dal.GetRow(GET_MULTIPLE_BRANCH, _ht);

            //DBToUI.Map(this.Controls, _dr);
            lblMultiplebranch.Text = _dr.ItemArray[0].ToString();


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
        string sNextBarcode = "";
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
         
            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_rate"] = txtRate.Text; // (+) Ari 08-08-2022 ket : enhancement 2022
            _ht["p_total_amount_idr"] = txtTotalAmountIDR.Text; // (+) Ari 08-08-2022 ket : enhancement 2022
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("apinvoiceregistrationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
        Response.Redirect("apinvoiceregistrationheaderlist.aspx");
    }
  
    protected void rblBillType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblBillType.SelectedValue == "APA")
        {
            Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "APA");
            btnLookUpPurchaseOrderCode.Visible = false;
            btnLookUpSupplierID.Visible = false;
            lblSupplier.Visible = false;
            btnLookUpUserRequest.Visible = true;
            lblUser.Visible = true;
            btnLookUpPreviousInvoiceNo.Enabled = false;
            txtPurchaseOrderCode.Text = "";
            txtPurchaseOrder.Text = "";
            txtSupplierID.Text = "";
            lblSupplierName.Text = "";
            txtPreviousInvoiceNo.Text = "";
            //txtInvoiceAmount.Enabled = true;
            ddlCurrencyCode.Enabled = false;
            btnAdd.Visible = false;
            btnLookUpPurchaseOrderCodeTOP.Visible = true;
            txtFaAdjustCode.Enabled = false;
            DEPO.Visible = false;
            btnLookUpPurchaseFaAdjust.Visible = false;
            ddlFlagAdvDps.Enabled = false;
            ddlFlagAdvDps.Text = "FPO";
            txtPurchaseOrderCode.Text = "";
            txtPOCode.Text = "";

        }
        else if (rblBillType.SelectedValue == "APD")
        {
            Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "APD");
            btnLookUpPurchaseOrderCode.Enabled = false;
            txtPurchaseOrderCode.Text = "";
            txtPOCode.Text = "";

        }
        else if (rblBillType.SelectedValue == "OT")
        {
            Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "OT");
            btnLookUpPurchaseOrderCode.Enabled = false;
            btnLookUpPreviousInvoiceNo.Enabled = false;
            txtPurchaseOrderCode.Text = "";
            txtPurchaseOrder.Text = "";
            txtSupplierID.Text = "";
            lblSupplierName.Text = "";
            txtPreviousInvoiceNo.Text = "";
            mandatory.Visible = false;
           // rfvPurchaseOrderCode.Enabled = false;
            spasi.Visible = true;
            btnLookUpSupplierID.Visible = true;
            btnLookUpSupplierID.Enabled = true;
            lblSupplier.Visible = true;
            btnLookUpUserRequest.Visible = false;
            lblUser.Visible = false;
            //txtInvoiceAmount.Enabled = true;
            ddlCurrencyCode.Enabled = true;
            btnLookUpPurchaseOrderCodeTOP.Visible = false;
             
            rfvFlagAdvDps.Enabled = true;
            txtPurchaseOrderCode.Text = "";
            txtPOCode.Text = "";


            if (ddlFlagAdvDps.SelectedValue == "FDS")
            {
                liFee.Visible = false;
                liDetail.Visible = false;
                liTermin.Visible = false;
                FANO.Visible = false;
                btnLookUpSupplierID.Enabled = false;
                btnLookUpPurchaseFaAdjust.Visible = false;
                txtFaAdjustCode.Visible = false;
                DEPO.Visible = true;
                txtDepositNo.Visible = true;
            }

            if (ddlFlagAdvDps.SelectedValue == "FDA")
            {
                liFee.Visible = true;
                liDetail.Visible = true;
                liTermin.Visible = false;
                FANO.Visible = false;
                btnLookUpSupplierID.Enabled = false;
                btnLookUpPurchaseFaAdjust.Visible = false;
                txtFaAdjustCode.Visible = false;
                DEPO.Visible = false;
                txtDepositNo.Visible = false;
            }

            if (ddlFlagAdvDps.SelectedValue == "FAV")
            {
                liFee.Visible = true;
                liDetail.Visible = true;
                liTermin.Visible = false;
                btnLookUpSupplierID.Enabled = false;
                btnLookUpPurchaseFaAdjust.Visible = true;
                FANO.Visible = true;
                txtFaAdjustCode.Visible = true;
                DEPO.Visible = false;
                txtDepositNo.Visible = false;
            }
        }
        else
        {
            Shared.BindGeneralSubCode(ddlInvoiceTypeCode, "PO");
            btnLookUpPurchaseOrderCode.Enabled = true;
            btnLookUpPurchaseOrderCode.Visible = true;
            btnLookUpUserRequest.Visible = false;
            lblUser.Visible = false;
            btnLookUpSupplierID.Visible = true;
            btnLookUpPurchaseFaAdjust.Visible = false;
            mandatory.Visible = true;
            //rfvPurchaseOrderCode.Enabled = true;
            spasi.Visible = false;
            btnLookUpSupplierID.Enabled = false;
            lblSupplier.Visible = true;
            txtFaAdjustCode.Enabled = false;
            //txtInvoiceAmount.Enabled = false;
            ddlCurrencyCode.Enabled = false;
            btnLookUpPurchaseOrderCodeTOP.Visible = false;
            DEPO.Visible = false;


            ddlFlagAdvDps.Enabled = false;
            ddlFlagAdvDps.Text = "FPO";
            txtPurchaseOrderCode.Text = "";
            txtPOCode.Text = "";

        }


    }

    protected void ddlInvoice_SelectedIndex(object sender, EventArgs e)
    {
        if (ddlInvoice.SelectedValue == "N")
        {
            txtInvoiceNo.Visible = true;
            rfvInvoiceNo.Enabled = false;
            txtInvoiceNo.Enabled = false;

        }

        if (ddlInvoice.SelectedValue == "Y")
        {
            txtInvoiceNo.Visible = true;
            txtInvoiceNo.Enabled = true;
            rfvInvoiceNo.Enabled = true;
            RIN.Visible = true;

        }
    }

    #region InvoiceReg detail

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_code_barcode"] = lblCodeBarcode.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = code;
            Shared.ApplyDefaultProp(_ht);
            _dal.Delete(TABLE_NAME_DETAIL, _ht);

            BindFee();
            LoadData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("apinvoiceregistrationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&type=" + rblBillType.SelectedValue + "&pocode=" + txtPurchaseOrderCode.Text);
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindData();
        LoadData();
        UpdatePanel3.Update();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("apinvoiceregistrationdetail.aspx?action=edit&id={0}&codebarcode={1}&pocode={2}&idtarget={3}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, txtPurchaseOrderCode.Text, Request.Params["idartarget"]));
    }


    #endregion
    protected void ddlInvoiceTypeCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlInvoiceTypeCode.SelectedValue.Equals("FAKB") || ddlInvoiceTypeCode.SelectedValue.Equals("FAKUM"))
        {
            btnLookUpPreviousInvoiceNo.Enabled = false;
        }
        else
            btnLookUpPreviousInvoiceNo.Enabled = true;
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


    #region Fee
    private void BindFee()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchFee.Text;
            _ht["p_invoice_code"] = lblCodeBarcode.Text;


            gvwListFee.DataSource = _dal.GetRows(TABLE_NAME_DETAIL_FEE, _ht);
            gvwListFee.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    
    protected void gvwListFee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListFee.PageIndex = e.NewPageIndex;
        BindFee();
    }
     
     
    protected void btnSearchFee_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindFee();
    }
    
    #endregion

    #region Expense
    private void BindExpense()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDetail.Text;
            _ht["p_invoice_code"] = lblCodeBarcode.Text;


            gvwListDetail.DataSource = _dal.GetRows(TABLE_NAME_EXPENSE, _ht);
            gvwListDetail.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataExpense(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_EXPENSE, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void SaveDataDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExistDetail())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
        try
        {
            foreach (GridViewRow row in gvwListDetail.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    DropDownList Currency = ((DropDownList)row.Cells[3].Controls[1]);
                    string AmountFee = ((TextBox)row.Cells[4].Controls[1]).Text;

                    _ht["p_id"] = gvwListDetail.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_currency_code"] = Currency.SelectedValue;
                    _ht["p_amount_fee"] = AmountFee;

                    

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_ap_invoice_registration_expense_update", _ht);
                   
                }
            }
            Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
           
            Shared.ShowSuccessGritter(this, string.Format("apinvoiceregistrationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
            BindExpense();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwListDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDetail.PageIndex = e.NewPageIndex;
        BindExpense();
    }
    protected void gvwListDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtAmountDetail = (TextBox)e.Row.FindControl("txtAmountDetail");
            DropDownList ddlCurrencyCodeDetail = (DropDownList)e.Row.FindControl("ddlCurrencyCodeDetail");


            Shared.BindCurrency(ddlCurrencyCodeDetail);
            txtAmountDetail.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "AMOUNT_FEE"));
            ddlCurrencyCodeDetail.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CURRENCY_CODE"));
            if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL")
            {
                ddlCurrencyCodeDetail.Enabled = false;
                txtAmountDetail.Enabled = false;
            }

        }
    }
    protected void btnDeleteDetail_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataExpense(gvwListDetail.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindExpense();

    }
    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {
        SaveDataDetail();
    }
    protected void btnSearchDetail_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindExpense();
    }
    private Boolean SelectedExistDetail()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
    #endregion

    #region Termin
    private void BindTermin()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchTermin.Text;
            _ht["p_invoice_code"] = lblCodeBarcode.Text;


            gvwListTermin.DataSource = _dal.GetRows(TABLE_NAME_TERMIN, _ht);
            gvwListTermin.DataBind();

            LoadData();
            
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveDataTermin()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExistTermin())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
        try
        {
            foreach (GridViewRow row in gvwListTermin.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {

                    string Discount = ((TextBox)row.FindControl("txtDiscount")).Text;
                    string DiscountAdditional = ((TextBox)row.FindControl("txtDiscountAdditional")).Text;
                    DropDownList ddlTax = ((DropDownList)row.FindControl("ddlTax"));
                    DropDownList ddlTaxType = ((DropDownList)row.FindControl("ddlTaxType"));

                    _ht["p_id"] = gvwListTermin.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_discount"] = Discount;
                    _ht["p_discount_additional"] = DiscountAdditional;
                    _ht["p_tax"] = ddlTax.SelectedValue;
                    _ht["p_tax_type"] = ddlTaxType.SelectedValue;

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_ap_invoice_registration_termin_discount_update", _ht);

                }
            }
            Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

            Shared.ShowSuccessGritter(this, string.Format("apinvoiceregistrationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
            BindTermin();
            
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSaveTermin_Click(object sender, EventArgs e)
    {
        SaveDataTermin();
    }

    protected void gvwListTermin_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlTax = (DropDownList)e.Row.FindControl("ddlTax");
            DropDownList ddlTaxType = (DropDownList)e.Row.FindControl("ddlTaxType");
            TextBox txtDiscount = (TextBox)e.Row.FindControl("txtDiscount");
            TextBox txtDiscountAdditional = (TextBox)e.Row.FindControl("txtDiscountAdditional");

            Shared.BindTaxScreme(ddlTax);
            ddlTax.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TAX"));

            ddlTaxType.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TAX_TYPE"));
          
            txtDiscount.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DISCOUNT"));

            txtDiscountAdditional.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DISCOUNT_ADDITIONAL"));

            txtDiscountAdditional.Text = string.Format("{0:#,##0.00}", double.Parse(txtDiscountAdditional.Text));

            txtDiscount.Text = string.Format("{0:#,##0.00}", double.Parse(txtDiscount.Text));

            //System.Diagnostics.Debugger.Launch();
            if (lbladditionalamount.Text.Equals("0.00"))
            {
                txtDiscountAdditional.Enabled = false;
            }
            else
            {
                txtDiscountAdditional.Enabled = true;
            }

            if (lblTransFlagCode.Text == "POST"|| lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ON-PROGRESS")
            {

                txtDiscount.Enabled = false;
                ddlTax.Enabled = false;
                
            }

            if (ddlTax.SelectedValue == "TS00005" )
            {

                ddlTaxType.Enabled = false;
            }

        }
    }
   

    private void DeleteDataTermin(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;
            _dal.Delete(TABLE_NAME_TERMIN, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListTermin_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListTermin.PageIndex = e.NewPageIndex;
        BindTermin();
    }

    protected void btnDeleteTermin_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListTermin.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataTermin(gvwListTermin.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindTermin();

    }

    protected void btnSearchTermin_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindTermin();
    }
    private Boolean SelectedExistTermin()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListTermin.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
    #endregion


    #region AdvanceDeposit
    private void BindAdDep()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchAdDep.Text;
            _ht["p_code_barcode"] = Request.Params["codebarcode"];


            gvwListAdDep.DataSource = _dal.GetRows(TABLE_NAME_ADVANCE_DEPOSIT, _ht);
            gvwListAdDep.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    ////private void SaveDataAdDep()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    if (!SelectedExistAdDep())
    //    {
    //        Exception ex = null;
    //        ex = new Exception("No Transaction Selected !");
    //        Shared.ShowErrorDialog(this, ex);
    //        return;
    //    }

    //    _dal = new GeneralDAL();
    //    _ht = new Hashtable();

    //    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //    try
    //    {
    //        foreach (GridViewRow row in gvwListAdDep.Rows)
    //        {
    //            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //            if (chb.Checked)
    //            {
                    
    //                string Amount = ((TextBox)row.Cells[4].Controls[1]).Text;

    //                _ht["p_id"] = gvwListAdDep.DataKeys[row.RowIndex][0].ToString();
    //                _ht["p_amount"] = Amount;

    //                Shared.ApplyDefaultProp(_ht);

    //                _dal.ExecRawSP("dbo.xsp_ap_invoice_registration_advance_update", _ht);

    //            }
    //        }
    //        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

    //        Shared.ShowSuccessGritter(this, string.Format("apinvoiceregistrationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //        BindAdDep();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    private void DeleteDataAdDep(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_ADVANCE_DEPOSIT, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListAdDep_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListAdDep.PageIndex = e.NewPageIndex;
        BindAdDep();
    }

    protected void btnDeleteAdDep_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListAdDep.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataAdDep(gvwListAdDep.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindAdDep();

    }
    //protected void btnSaveAdDep_Click(object sender, EventArgs e)
    //{
    //    SaveDataAdDep();
    //}

    protected void btnSearchAdDep_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindAdDep();
    }

    //protected void btnAddAdDep_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("apinvoiceregistrationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&type=" + rblBillType.SelectedValue + "&pocode=" + txtPurchaseOrderCode.Text);
    //}

    protected void gvwListAdDep_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("apinvoiceregistrationdetail.aspx?action=edit&id={0}&codebarcode={1}&pocode={2}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, txtPurchaseOrderCode.Text));
    }
    private Boolean SelectedExistAdDep()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListAdDep.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
    #endregion

   
    #region purchase quotation doc detail
    private void BindDataDocRequest()
    {
    
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataView dvQUOTATIONDOC = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

           _ht["p_keywords"] = txtSearchDocReq.Text;
            _ht["p_invoice_code"] = Request.Params["codebarcode"];
            //_ht["p_id_detail"] = Request.Params["id"];

            dvQUOTATIONDOC = _dal.GetRows(TABLE_NAME_DOCUMENT, _ht).DefaultView;

            if (dirQUOTATIONDOC == SortDirection.Ascending)
                dvQUOTATIONDOC.Sort = expressionQUOTATIONDOC + " ASC";
            else
                dvQUOTATIONDOC.Sort = expressionQUOTATIONDOC + " DESC";

            gvwListDocReq.DataSource = dvQUOTATIONDOC;

            //DataTable _dt = _dal.GetRows(TABLE_NAME_DOC_DETAIL, _ht);

            //gvwListDocReq.DataSource = _dt;
            gvwListDocReq.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void UpdateDataDetail(string INVOICE_CODE, string GENERAL_DOC_CODE, string FILE_NAME, string PATHS, string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_invoice_code"] = INVOICE_CODE;
            _ht["p_general_doc_code"] = GENERAL_DOC_CODE;
            _ht["p_file"] = FILE_NAME;
            _ht["p_paths"] = PATHS;
            _ht["p_id"] = ID;

            Shared.ApplyDefaultProp(_ht);

            _dal.Update(TABLE_NAME_DOCUMENT, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void DeleteData(string ID)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_id"] = ID;

    //        _dal.Delete(TABLE_NAME_DOC_DETAIL, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}


    protected void gvwListDocReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDocReq.PageIndex = e.NewPageIndex;
        BindDataDocRequest();
    }

    protected void btnAddUploadDoc_Click(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("invoicedocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text);
    }

    protected void btnSaveDocumentDetail_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        FileUpload fupFile;
        string lblFileName;
        string sFileName;
        String filePath;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            foreach (GridViewRow gvr in gvwListDocReq.Rows)
            {
                fupFile = (FileUpload)gvr.FindControl("fupFilename");
                lblFileName = ((Label)gvr.FindControl("lblFileName")).Text;
                sFileName = System.IO.Path.GetFileName(fupFile.FileName);

                filePath = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/" + lblCodeBarcode.Text));

                if (fupFile.HasFile)
                {
                    string sFullPath = filePath + '/' + sFileName;

                    string sFileType = System.IO.Path.GetExtension(fupFile.FileName);  // (+) Ari 13-09-2022 ket : validasi extension
                    if (
                                  sFileType == ".xls" || sFileType == ".xlsx"     // EXCEL
                                   || sFileType == ".doc" || sFileType == ".docx"     // WORD
                                   || sFileType == ".jpeg" || sFileType == ".jpg"      // Image
                                   || sFileType == ".png" //|| sFileType == ".gif"
                                   || sFileType == ".pdf" //|| sFileType == ".csv"      // PDF
                                   || sFileType == ".zip" || sFileType == ".rar"      // File
                                   || sFileType == ".7z"

                                  )
                        {
                            if (!System.IO.Directory.Exists(filePath))
                                System.IO.Directory.CreateDirectory(filePath);

                            if (!System.IO.File.Exists(sFullPath))
                                fupFile.SaveAs(sFullPath);

                            sFullPath = Shared.GetUploadPath("ADD_DOCUMENT/" + lblCodeBarcode.Text) + sFileName;
                            UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["INVOICE_CODE"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());
                        }
                        else
                        {
                            Shared.ShowValidationError(this, "Please upload file with format type (.pdf .zip .doc .xlx .png .jpg .jpeg). Max file size allowed is 3 mb.");
                            return;
                        }
                }

                MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

                int fileSize = fupFile.PostedFile.ContentLength;

                if (fupFile.PostedFile.ContentLength > 3000000) // (+) Ari 13-09-2022 ket : cek size file Max 3MB.
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "fx", "fnShowErrorNotif('Maximum file size allowed is 3 mb.', '');", true);
                    return;
                }


            }

            Shared.ShowSuccessGritter(this, null);
            BindDataDocRequest();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListDocReq_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        LinkButton btn = null;
        GridViewRow row = null;
        int rowIndex = 0;

        try
        {
            //dapatkan tombol mana yang diklik
            btn = ((LinkButton)e.CommandSource);

            //dapatkan row dimana tombol tersebut terletak
            row = (GridViewRow)(btn.NamingContainer);

            if (row.RowType == DataControlRowType.DataRow)
            {
                rowIndex = row.RowIndex;

                if (e.CommandName == "del")
                {
                    try
                    {
                        //string ApplicationNo = lblApplicationNo.Text;
                        string PQ_CODE = (string)gvwListDocReq.DataKeys[rowIndex][1];
                        //string GENERAL_DOC_CODE = (string)gvwListDocReq.DataKeys[rowIndex][0];
                        string FileName = ((Label)row.Cells[2].Controls[1]).Text;
                        int ID = (int)gvwListDocReq.DataKeys[rowIndex][4];


                        //delete data di database server
                        DeleteDoc(ID);

                        //delete file di app server 
                        //DeleteDocFile(ApplicationNo, FileName);
                    }
                    catch (Exception ex)
                    {
                        Shared.ShowErrorDialog(this, ex);
                    }

                    BindDataDocRequest();
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    private void DeleteDoc(int ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            Shared.ApplyDefaultProp(_ht);
            _ht["p_id"] = ID;
            _dal.Delete(TABLE_NAME_DOCUMENT, _ht);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void gvwListDocReq_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string FileName = ((Label)e.Row.Cells[2].Controls[1]).Text;

            if (FileName.Length != 0)
            {
               
                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];

                btnDelete.OnClientClick = "return confirm('Delete selected data?');";

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "PROCESSED" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "VERIFIED" || lblTransFlagCode.Text == "REJECTED")
                {
                    btnDelete.Visible = false;

                }
                FileName = gvwListDocReq.DataKeys[e.Row.RowIndex]["PATHS"].ToString();
                btnPreview.Attributes["onclick"] = "javascript:window.open('../../" + FileName + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";
            }
            else
            {
                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[3];

                btnPreview.Visible = false;
                btnDelete.Visible = false;
            }
        }
    }

    protected void btnSearchDocReq_Click(object sender, EventArgs e)
    {
        BindDataDocRequest();
    }


    protected void gvwListDocReq_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("auditdetail.aspx?action=edit&auditno={0}&id={1}", gvwListDocReq.SelectedDataKey["BATCH_NO"].ToString(), gvwListDocReq.SelectedDataKey["GENERAL_DOC_CODE"].ToString()));
    }

    protected void chbCheckedAllDocRew_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListDocReq.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedDocReq") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    protected void gvwListDocReq_Sorting(object sender, GridViewSortEventArgs e)
    {
        {
            if (dirQUOTATIONDOC == SortDirection.Ascending)
                dirQUOTATIONDOC = SortDirection.Descending;
            else
                dirQUOTATIONDOC = SortDirection.Ascending;

            expressionQUOTATIONDOC = e.SortExpression;
        }

        BindDataDocRequest();
    }

    public SortDirection dirQUOTATIONDOC
    {

        get
        {
            if (ViewState["dirStateQUOTATIONDOC"] == null)
            {
                ViewState["dirStateQUOTATIONDOC"] = SortDirection.Descending;
            }

            return (SortDirection)ViewState["dirStateQUOTATIONDOC"];
        }

        set { ViewState["dirStateQUOTATIONDOC"] = value; }
    }

    public string expressionQUOTATIONDOC
    {

        get
        {
            if (ViewState["expressionStateQUOTATIONDOC"] == null)
            {
                ViewState["expressionStateQUOTATIONDOC"] = "MOD_DATE";
            }

            return (string)ViewState["expressionStateQUOTATIONDOC"];
        }

        set { ViewState["expressionStateQUOTATIONDOC"] = value; }
    }
    #endregion
}
