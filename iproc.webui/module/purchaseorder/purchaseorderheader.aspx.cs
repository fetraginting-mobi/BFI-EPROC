using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_purchaseorderheader : BasePage
{
    private static string TABLE_NAME_HEADER = "PURCHASE_ORDER_HEADER";
    private static string TABLE_NAME_DETAIL = "PURCHASE_ORDER_DETAIL";
    private static string TABLE_NAME_DETAIL_2 = "TERM_OF_PAYMENT";
    private static string TABLE_NAME_DETAIL_FEE = "PURCHASE_ORDER_FEE";
    private static string TABLE_NAME_DOC_DETAIL = "ORDER_DOCUMENT";
    private static string GET_MULTIPLE_BRANCH = "GET_IS_AGAS"; // (+) Ari 04-07-2022 ket : enhancement 2022

    //Untuk Total Amount PO
    //private decimal dUnitPrice = 0;
    private decimal dSubTotal = 0;


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
            Shared.BindBranchEmployee(ddlBranch);

            Shared.BindCurrencyCode(ddlCurrency);
            btnLookUpSupplier.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPO&acol_0={0}&bcol_1={1}');", txtSupplierCode.ClientID, txtSupplier.ClientID);
            //LoadDataagas(); // (+) Ari 30-12-2022 ket : enhancement 2022
            //if (lblMultiplebranch.Text == "1") // (+) Ari 02-01-2022 ket : enhancement 2022, jika group role multiplebranch memliki akses pilih branch
            //{
            //    //txtBranchCode.Text = ddlBranch.SelectedValue;
            //    btnLookUpSupplier.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPO&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtSupplierCode.ClientID, txtSupplier.ClientID, ddlBranch.ClientID);
            //}
            //else
            //{
            //    btnLookUpSupplier.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPO&acol_0={0}&bcol_1={1}');", txtSupplierCode.ClientID, txtSupplier.ClientID);
            //}
            btnAddFee.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=POFEE&parc_po_code={0}&gvw={1}');", txtCodeBarcode.ClientID, btnSearchFee.UniqueID);
            //btnLookUpToBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&parc_code={4}');", txtToBank.ClientID, lblBankName.ClientID, txtToRekName.ClientID, txtToRekNo.ClientID, ddlBranch.ClientID);
            //  Arjun Baru Penambahan Parameter
            btnLookUpToBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&parc_code={4}&par_code_barcode={5}&par_type={6}');", txtToBank.ClientID, lblBankName.ClientID, txtToRekName.ClientID, txtToRekNo.ClientID, ddlBranch.ClientID, Request.Params["codebarcode"], ddlPaymentBy.SelectedValue);
            txtPPN.Enabled = false;
            txtPPH.Enabled = false;
            txtTotalAmount.Enabled = false;
            //txtStampDuty.Enabled = false;
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteTOP.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteFee.OnClientClick = "return confirm('Delete selected data?');";
            btnClose.OnClientClick = "return confirm('Closed This PO?');";
            BtnCancelPO.OnClientClick = "return confirm('Cancel This PO?');";
            btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";


            if (Request.Params["action"].Equals("edit"))
            {

                LoadData();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";

                txtOrderDate.Enabled = false;

                lblCodeBarcode.Enabled = false;
                btnClose.Visible = false;
                btnPrint.Visible = false;
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;


                BindOrderDetail();
                BindTOP();
                BindFee();
                BindDataDocRequest();
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (ddlPaymentBy.SelectedValue == "BRANCH")
                {
                    ToBank.Visible = true;
                    ToRekName.Visible = true;
                    ToRekNo.Visible = true;
                    rfvToBank.Enabled = true;
                    btnLookUpToBank.Enabled = true;

                }
                else
                {
                    ToBank.Visible = true;
                    ToRekName.Visible = true;
                    ToRekNo.Visible = true;
                    rfvToBank.Enabled = false;
                    btnLookUpToBank.Enabled = true;

                }

                if (chbIsDefaultFlag.Checked)
                {
                    txtRentFlag.Text = "1";
                }
                else
                {
                    txtRentFlag.Text = "0";
                }

                if (txtSupplierCode.Text == "SP9999")
                {
                    btnLookUpSupplier.Enabled = true;
                }
                else
                {
                    btnLookUpSupplier.Enabled = false;
                }
                //if (lblTransFlagDesc.Text == "POST" || lblTransFlagDesc.Text == "REJECTED")
                //{
                //    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                //    btnClose.Visible = true;
                //    BtnCancelPO.Visible = true;
                //    btnPrint.Visible = true;
                //    btnAdd.Visible = false;
                //    btnDelete.Visible = false;
                //    txtDiscount.Enabled = false;
                //    txtOrderDate.Enabled = false;
                //    txtPPH.Enabled = false;
                //    txtPPN.Enabled = false;
                //    txtRemarks.Enabled = false;
                //    btnLookUpSupplier.Enabled = false;
                //    //ddlTaxType.Enabled = false;
                //    rblOrderType.Enabled = false;
                //    btnPrint.Visible = true;
                //    gvwList.Columns[1].Visible = false;
                //    ddlCurrency.Enabled = false;
                //    ddlDepartment.Enabled = false;
                //    ddlDivision.Enabled = false;
                //    btnAddFee.Visible = false;
                //    btnSaveFee.Visible = false;
                //    btnDeleteFee.Visible = false;
                //    btnAddTOP.Visible = false;
                //    btnDeleteTOP.Visible = false;
                //    gvwListFee.Columns[1].Visible = false;
                //    btnAdd.Visible = false;
                //    btnDelete.Visible = false;
                //    //btnAddUploadDoc.Visible = false;
                //    btnAddUploadDoc.Visible = true; // (+) Ari 30-06-2022
                //    btnSaveDocumentDetail.Visible = false;
                //    btnApprovalTiered.Visible = false;
                //    txtDueDate.Enabled = false;
                //    txtEstimateArrivedDate.Enabled = false;
                //    txtDepositAmount.Enabled = false;
                //    ddlBranch.Enabled = false;
                //    ddlSubDepartment.Enabled = false;
                //    //ddlSubBranch.Enabled = false;
                //    ddlUnits.Enabled = false;
                //    ddlPaymentBy.Enabled = false;
                //    ddlReceiptBy.Enabled = false;
                //    chbIsDefaultFlag.Enabled = false; //nirmala(12-12-2019)(no ticket : 1912000131)

                //    //List TOP
                //    btnAddTOP.Visible = false;
                //    btnDeleteTOP.Visible = false;
                //    gvwListTOP.Columns[1].Visible = false;

                //    //List Fee
                //    btnAddFee.Visible = false;
                //    btnDeleteTOP.Visible = false;
                //    gvwListFee.Columns[1].Visible = false;



                //}

                if (lblTransFlagDesc.Text == "POST") // (+) Ari 27-12-2022 ket : pisah antara post dan reject , error list BFI_QA
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnClose.Visible = true;
                    BtnCancelPO.Visible = true;
                    btnPrint.Visible = true;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    txtDiscount.Enabled = false;
                    txtOrderDate.Enabled = false;
                    txtPPH.Enabled = false;
                    txtPPN.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    //ddlTaxType.Enabled = false;
                    rblOrderType.Enabled = false;
                    btnPrint.Visible = true;
                    gvwList.Columns[1].Visible = false;
                    ddlCurrency.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    btnAddFee.Visible = false;
                    btnSaveFee.Visible = false;
                    btnDeleteFee.Visible = false;
                    btnAddTOP.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListFee.Columns[1].Visible = false;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    //btnAddUploadDoc.Visible = false;
                    btnAddUploadDoc.Visible = true; // (+) Ari 30-06-2022
                    btnSaveDocumentDetail.Visible = false;
                    btnApprovalTiered.Visible = false;
                    txtDueDate.Enabled = false;
                    txtEstimateArrivedDate.Enabled = false;
                    txtDepositAmount.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    //ddlSubBranch.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlPaymentBy.Enabled = false;
                    ddlReceiptBy.Enabled = false;
                    chbIsDefaultFlag.Enabled = false; //nirmala(12-12-2019)(no ticket : 1912000131)

                    //List TOP
                    btnAddTOP.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListTOP.Columns[1].Visible = false;

                    //List Fee
                    btnAddFee.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListFee.Columns[1].Visible = false;



                }

                if (lblTransFlagDesc.Text == "CANCEL" || lblTransFlagDesc.Text == "REJECTED") // (+) Ari 27-12-2022 ket : cancel sama reject disamain, Error List BFI_QA
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnClose.Visible = false;
                    BtnCancelPO.Visible = false;
                    btnPrint.Visible = true;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    txtDiscount.Enabled = false;
                    txtOrderDate.Enabled = false;
                    txtPPH.Enabled = false;
                    txtPPN.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    //ddlTaxType.Enabled = false;
                    rblOrderType.Enabled = false;
                    btnPrint.Visible = true;
                    gvwList.Columns[1].Visible = false;
                    ddlCurrency.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    btnAddFee.Visible = false;
                    btnSaveFee.Visible = false;
                    btnDeleteFee.Visible = false;
                    btnAddTOP.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListFee.Columns[1].Visible = false;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    //btnAddUploadDoc.Visible = false;
                    btnAddUploadDoc.Visible = true; // (+) Ari 30-06-2022
                    btnSaveDocumentDetail.Visible = false;
                    btnApprovalTiered.Visible = false;
                    txtDueDate.Enabled = false;
                    txtEstimateArrivedDate.Enabled = false;
                    txtDepositAmount.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    //ddlSubBranch.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlPaymentBy.Enabled = false;
                    ddlReceiptBy.Enabled = false;

                    //List TOP
                    btnAddTOP.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListTOP.Columns[1].Visible = false;

                    //List Fee
                    btnAddFee.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListFee.Columns[1].Visible = false;



                }
                if (lblTransFlagDesc.Text == "CLOSED" || lblTransFlagDesc.Text == "CLOSED FULL" || lblTransFlagDesc.Text == "CLOSED PARTIAL")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnClose.Visible = false;
                    BtnCancelPO.Visible = false;
                    btnPrint.Visible = true;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    txtDiscount.Enabled = false;
                    txtOrderDate.Enabled = false;
                    txtPPH.Enabled = false;
                    txtPPN.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    //ddlTaxType.Enabled = false;
                    rblOrderType.Enabled = false;
                    btnPrint.Visible = true;
                    gvwList.Columns[1].Visible = false;
                    ddlCurrency.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    btnAddFee.Visible = false;
                    btnSaveFee.Visible = false;
                    btnDeleteFee.Visible = false;
                    btnAddTOP.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListFee.Columns[1].Visible = false;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    //btnAddUploadDoc.Visible = false;
                    btnAddUploadDoc.Visible = true; // (+) Ari 30-06-2022
                    btnSaveDocumentDetail.Visible = false;
                    btnApprovalTiered.Visible = false;
                    txtDueDate.Enabled = false;
                    txtEstimateArrivedDate.Enabled = false;
                    txtDepositAmount.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    //ddlSubBranch.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlPaymentBy.Enabled = false;
                    ddlReceiptBy.Enabled = false;
                    //List TOP
                    btnAddTOP.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListTOP.Columns[1].Visible = false;

                    //List Fee
                    btnAddFee.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListFee.Columns[1].Visible = false;



                }
                else if (lblTransFlagDesc.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnClose.Visible = false;
                    BtnCancelPO.Visible = false;
                    btnPrint.Visible = true;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    txtDiscount.Enabled = false;
                    txtOrderDate.Enabled = false;
                    txtPPH.Enabled = false;
                    txtPPN.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtEstimateArrivedDate.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    //ddlTaxType.Enabled = false;
                    rblOrderType.Enabled = false;
                    btnPrint.Visible = true;
                    gvwList.Columns[1].Visible = false;
                    ddlCurrency.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    btnAddFee.Visible = false;
                    btnSaveFee.Visible = false;
                    btnDeleteFee.Visible = false;
                    btnAddTOP.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListFee.Columns[1].Visible = false;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    btnClose.Visible = false;
                    ddlPaymentBy.Enabled = false;
                    ddlReceiptBy.Enabled = false;
                    txtDueDate.Enabled = false; //nirmala(12-12-2019)(no ticket : 1912000131)
                    chbIsTermin.Enabled = false; //nirmala(12-12-2019)(no ticket : 1912000131)
                    chbIsDefaultFlag.Enabled = false; //nirmala(12-12-2019)(no ticket : 1912000131)
                    txtDepositAmount.Enabled = false; //nirmala(12-12-2019)(no ticket : 1912000131)
                    //List TOP
                    btnAddTOP.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListTOP.Columns[1].Visible = false;

                    //List Fee
                    btnAddFee.Visible = false;
                    btnDeleteTOP.Visible = false;
                    gvwListFee.Columns[1].Visible = false;

                    string Typeapp = "";
                    int idTarget = 0;
                    Typeapp = Request.Params["type"];



                    if (Typeapp == "approval")
                    {
                        var idTargetCondition = string.IsNullOrEmpty(Request.Params["idartarget"]) ? "0" : Request.Params["idartarget"];

                        if (!Request.Params["idartarget"].Equals(""))
                        {
                            idTarget = Int32.Parse(idTargetCondition);
                        }
                        else
                        {
                            idTarget = 0;
                        }

                        idTarget = idTarget == null ? 0 : idTarget;
                        //btnApprovalTiered.Visible = true;

                    }
                    else
                    {
                        idTarget = 0;
                    }

                    if (Typeapp == "approval" && idTarget != 0)
                    {
                        btnAddUploadDoc.Visible = true; // (+) Ari 06-09-2022

                    }
                    if (Typeapp == "approval" && idTarget == 0)
                    {
                        btnAddUploadDoc.Visible = false; // (+) Ari 06-09-2022

                    }
                    else
                    {
                        btnAddUploadDoc.Visible = true; // (+) Ari 06-09-2022

                    }
                }


                else
                {

                    if (lblFlagProcess.Text == "GNR")
                    {
                        btnAdd.Visible = false;
                        btnDelete.Visible = false;
                        chbIsTermin.Enabled = false;
                        gvwList.Columns[1].Visible = false;

                        if (ddlPaymentBy.SelectedValue == "BRANCH")
                        {
                            ToBank.Visible = true;
                            ToRekName.Visible = true;
                            ToRekNo.Visible = true;
                            rfvToBank.Enabled = true;

                        }
                        else
                        {
                            ToBank.Visible = true;
                            ToRekName.Visible = true;
                            ToRekNo.Visible = true;
                            rfvToBank.Enabled = false;

                        }

                    }




                }

                btnReject.Visible = false;

                if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                    txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

                if (!lblApprovalRequestTargetID.Text.Equals(""))
                {
                    btnApprovalTiered.Visible = true;
                    //btnAddUploadDoc.Visible = false; // jaka 
                    btnAddUploadDoc.Visible = true; // Ari 29-08-2022
                }

                string typeRequest = string.IsNullOrEmpty(Request.Params["type"]) ? "" : Request.Params["type"];
                if (typeRequest.ToLower() == "approval" && (lblApprovalRequestTargetID.Text == "0" || string.IsNullOrEmpty(lblApprovalRequestTargetID.Text)))
                {
                    btnApprovalTiered.Visible = false;
                    BtnCancelPO.Visible = false;
                    btnClose.Visible = false;
                    btnAddUploadDoc.Visible = false; // Ari 29-08-2022
                }
            }

            else
            {
                LoadDataagas(); // (+) Ari 30-12-2022 ket : enhancement 2022
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlSubDepartment.SelectedValue = Shared.CurrentEmployeeSubDepartmentCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

                txtOrderDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtOrderDate.Enabled = false;

                btnAdd.Visible = btnDelete.Visible = false;

                btnReject.Visible = btnPost.Visible = btnCancel.Visible = btnClose.Visible = btnPrint.Visible = BtnCancelPO.Visible = false;
                pnlDetail.Visible = false;
                gvwList.Columns[1].Visible = true;
                btnApprovalTiered.Visible = false;
                //(+) Ari 18-08-2022 ket : enhancement 2022
                ddlCurrency.Enabled = true;
                // (+) Ari 30-06-2022 ket : enhancement 2022 (jika Role Flag Is Agas bisa edit ddlBranch)
                if (lblMultiplebranch.Text == "1")
                {
                    ddlBranch.Enabled = true;
                }
            }


            //if (lblFlagProcess.Text == "MNL" || lblTransFlagDesc.Text == "POST")
            //{
            //    btnAdd.Visible = false;
            //    btnDelete.Visible = false;
            //    gvwList.Columns[1].Visible = false;
            //}
            //if (lblFlagProcess.Text == "MNL" || lblTransFlagDesc.Text == "NEW")
            //{
            //    btnAdd.Visible = true;
            //    btnDelete.Visible = true;
            //    gvwList.Columns[1].Visible = true;
            //}
        }
        LoadAfterInit();

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/purchaseorderheaderlist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000005&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblBranch.ClientID, lblTotalPO.ClientID, lblBranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000006&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblBranch.ClientID);
        if (ddlCurrency.SelectedValue.ToLower() == "idr")
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

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            _ht["p_branch_code"] = Shared.CurrentDefaultEmployeeBranchCode;
            _ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
            //(+) Ari 02-01-2023 ket : enhancement 2022
            _ht["p_user_id"] = Shared.CurrentUID;

            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            //(+) fetra 2060406 ket : Iproc Phase III
            if (_dr != null && _dr.Table.Columns.Contains("is_termin"))
            {
                string isTermin = _dr["is_termin"].ToString();
                if (isTermin == "0" || isTermin.ToLower() == "false")
                {
                    liTermin.Visible = false;
                }
                else
                {
                    liTermin.Visible = true;
                }
            }


            DBToUI.Map(this.Controls, _dr);

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            btnLookUpToBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&parc_code={4}&par_code_barcode={5}&par_type={6}');", txtToBank.ClientID, lblBankName.ClientID, txtToRekName.ClientID, txtToRekNo.ClientID, ddlBranch.ClientID, Request.Params["codebarcode"], ddlPaymentBy.SelectedValue);

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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_rate"] = txtRate.Text; // (+) Ari 29-07-2022 ket : enhancement 2022, + parameter rate
            _ht["p_total_amount_idr"] = txtTotalPOIDR.Text;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode;
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void PostData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_purchase_order_header_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteBack()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            if (Request.Params["action"].Equals("edit"))
            {
                _dal.ExecRawSP("xsp_purchase_order_header_delete_back", _ht);
            }

            //Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    private void CloseData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_purchase_order_close_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void CancelData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_purchase_order_cancel_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);

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


    protected void ddlPaymentBy_SelectedIndex(object sender, EventArgs e)
    {
        string b;
        if (ddlPaymentBy.SelectedValue == "BRANCH")
        {
            ToBank.Visible = true;
            ToRekName.Visible = true;
            ToRekNo.Visible = true;
            rfvToBank.Enabled = true;
            btnLookUpToBank.Enabled = true;
            txtToBank.Text = "--";
            txtToRekName.Text = "--";
            txtToRekNo.Text = "--";
            lblBankName.Text = "--";
            b = "BRANCH";
        }
        else
        {
            ToBank.Visible = true;
            ToRekName.Visible = true;
            ToRekNo.Visible = true;
            rfvToBank.Enabled = false;
            btnLookUpToBank.Enabled = true;
            txtToBank.Text = "--";
            txtToRekName.Text = "--";
            txtToRekNo.Text = "--";
            lblBankName.Text = "--";
            b = "HO";
        }
        btnLookUpToBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&parc_code={4}&par_code_barcode={5}&par_type={6}');", txtToBank.ClientID, lblBankName.ClientID, txtToRekName.ClientID, txtToRekNo.ClientID, ddlBranch.ClientID, Request.Params["codebarcode"], b);
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {



        //updDep.Update();
    }

    protected void ddlCurrency_SelectedIndex(object sender, EventArgs e)
    {
        if (ddlCurrency.SelectedValue.ToLower() == "idr")
        {
            txtRate.Enabled = false;
            txtRate.Text = "1";
        }
        else
        {
            txtRate.Enabled = true;
        }
    }

    //private void CancelData()
    //{ 
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //        Shared.ApplyDefaultProp(_ht);

    //        _dal.ExecRawSP("xsp_purchase_order_header_cancel", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        // DeleteBack();
        Response.Redirect("purchaseorderheaderlist.aspx");
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }

    //protected void btnReject_Click(object sender, EventArgs e)
    //{
    //    CancelData();
    //}
    protected void btnClose_Click(object sender, EventArgs e)
    {
        CloseData();
    }

    protected void btnCancelPO_Click(object sender, EventArgs e)
    {
        CancelData();
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {

        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_code_barcode"] = lblCodeBarcode.Text;

        string sFilename = "";

        if (rblOrderType.SelectedValue == "PO")
        {
            sFilename = Shared.ExecuteReportExcel(this, "rpt_po_eksternal", htParams, CrystalDecisions.Shared.ExportFormatType.Excel);
        }
        else
        {
            //sFilename = Shared.ExecuteReport(this, "RPT_PURCHASE_ORDER", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            sFilename = Shared.ExecuteReportExcel(this, "rpt_purchase_order_spk", htParams, CrystalDecisions.Shared.ExportFormatType.Excel);
        }
        Shared.PreviewReport(this, sFilename);
    }

    protected void btnPrintPDF_Click(object sender, EventArgs e)
    {

        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_code_barcode"] = lblCodeBarcode.Text;

        string sFilename = "";

        if (rblOrderType.SelectedValue == "PO")
        {
            sFilename = Shared.ExecuteReport(this, "rpt_po_eksternal", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
        }
        else
        {
            //sFilename = Shared.ExecuteReport(this, "RPT_PURCHASE_ORDER", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            sFilename = Shared.ExecuteReport(this, "rpt_purchase_order_spk", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
        }
        Shared.PreviewReport(this, sFilename);
    }



    #region purchase order detail

    private void BindOrderDetail()
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

    private void DeleteData(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindOrderDetail();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        //Response.Redirect("purchaseorderdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&currency_code=" + ddlCurrency.SelectedValue + "&currency_desc=" + ddlCurrency.SelectedItem + "&flagprocess=" + lblFlagProcess.Text + "&flagrent=" + txtRentFlag.Text + "&suppliercode=" + txtSupplierCode.Text);
        // (+) Ari 09-01-2023 ket : + parameter kiriman branch code
        Response.Redirect("purchaseorderdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&currency_code=" + ddlCurrency.SelectedValue + "&currency_desc=" + ddlCurrency.SelectedItem + "&flagprocess=" + lblFlagProcess.Text + "&flagrent=" + txtRentFlag.Text + "&suppliercode=" + txtSupplierCode.Text + "&branch_code=" + txtBranchCode.Text);
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

        BindOrderDetail();

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindOrderDetail();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        //Response.Redirect(string.Format("purchaseorderdetail.aspx?action=edit&id={0}&codebarcode={1}&currency_code={2}&currency_desc={3}&status={4}&flagprocess={5}&flagrent={6}&idtarget={7}&suppliercode={8}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, ddlCurrency.SelectedValue, ddlCurrency.SelectedItem, lblTransFlagDesc.Text, lblFlagProcess.Text, txtRentFlag.Text, Request.Params["idartarget"],txtSupplierCode.Text));

        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        int idTarget = 0;
        String Type = "";

        Type = Request.Params["type"];

        var idTargetCondition = string.IsNullOrEmpty(Request.Params["idartarget"]) ? "0" : Request.Params["idartarget"];

        if (Type == "approval")
        {
            idTarget = Int32.Parse(idTargetCondition);

        }
        else
        {
            idTarget = 0;
        }

        if (Type == "approval")
        {
            //Response.Redirect("masterorderdocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text + "&type=" + Type + "&idartarget=" + idTarget);
            Response.Redirect(string.Format("purchaseorderdetail.aspx?action=edit&id={0}&codebarcode={1}&currency_code={2}&currency_desc={3}&status={4}&flagprocess={5}&flagrent={6}&idtarget={7}&suppliercode={8}&type={9}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, ddlCurrency.SelectedValue, ddlCurrency.SelectedItem, lblTransFlagDesc.Text, lblFlagProcess.Text, txtRentFlag.Text, Request.Params["idartarget"], txtSupplierCode.Text, Request.Params["type"]));
        }
        else
        {
            Response.Redirect(string.Format("purchaseorderdetail.aspx?action=edit&id={0}&codebarcode={1}&currency_code={2}&currency_desc={3}&status={4}&flagprocess={5}&flagrent={6}&idtarget={7}&suppliercode={8}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, ddlCurrency.SelectedValue, ddlCurrency.SelectedItem, lblTransFlagDesc.Text, lblFlagProcess.Text, txtRentFlag.Text, Request.Params["idartarget"], txtSupplierCode.Text));
        }
    }
    protected void gvwList_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //dUnitPrice = dUnitPrice + decimal.Parse(e.Row.Cells[5].Text);
            dSubTotal = dSubTotal + decimal.Parse(e.Row.Cells[6].Text);

            LinkButton btn4 = e.Row.FindControl("btnViewDocument") as LinkButton;
            btn4.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/documentrevieworder.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);

        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            //e.Row.Cells[5].Text = dUnitPrice.ToString("N2");
            e.Row.Cells[6].Text = dSubTotal.ToString("N2");
        }

    }
    #endregion

    # region term of payment
    private void BindTOP()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchTOP.Text;
            //_ht["p_id"] = Request.Params["id"];
            _ht["p_code_barcode"] = lblCodeBarcode.Text;


            gvwListTOP.DataSource = _dal.GetRows(TABLE_NAME_DETAIL_2, _ht);
            gvwListTOP.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataTOP(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_DETAIL_2, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListTOP_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListTOP.PageIndex = e.NewPageIndex;
        BindTOP();
    }

    protected void btnAddTOP_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("termofpayment.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text);
    }

    protected void btnDeleteTOP_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListTOP.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataTOP(gvwListTOP.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindTOP();

    }

    protected void btnSearchTOP_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindTOP();
    }

    protected void gvwListTOP_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        //Response.Redirect(string.Format("termofpayment.aspx?action=edit&id={0}&codebarcode={1}", gvwListTOP.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));

        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        int idTarget = 0;
        String Type = "";

        Type = Request.Params["type"];

        var idTargetCondition = string.IsNullOrEmpty(Request.Params["idartarget"]) ? "0" : Request.Params["idartarget"];
        if (Type == "approval")
        {
            idTarget = Int32.Parse(idTargetCondition);

        }
        else
        {
            idTarget = 0;
        }

        if (Type == "approval")
        {
            //Response.Redirect("masterorderdocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text + "&type=" + Type + "&idartarget=" + idTarget);
            Response.Redirect(string.Format("termofpayment.aspx?action=edit&id={0}&codebarcode={1}&idtarget={2}&type={3}", gvwListTOP.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, Request.Params["idartarget"], Request.Params["type"]));
        }
        else
        {

            Response.Redirect(string.Format("termofpayment.aspx?action=edit&id={0}&codebarcode={1}", gvwListTOP.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
        }
    }

    # endregion

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
            _ht["p_po_code"] = lblCodeBarcode.Text;


            gvwListFee.DataSource = _dal.GetRows(TABLE_NAME_DETAIL_FEE, _ht);
            gvwListFee.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataFee(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;
            _dal.Delete(TABLE_NAME_DETAIL_FEE, _ht);

            Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));


        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void SaveDataFee()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExistItem())
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
            foreach (GridViewRow row in gvwListFee.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    DropDownList ChargedTo = ((DropDownList)row.Cells[4].Controls[1]);
                    DropDownList Currency = ((DropDownList)row.Cells[3].Controls[1]);
                    string AmountFee = ((TextBox)row.Cells[5].Controls[1]).Text;

                    _ht["p_id"] = gvwListFee.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_currency_code"] = Currency.SelectedValue;
                    _ht["p_charged_to"] = ChargedTo.SelectedValue;
                    _ht["p_amount_fee"] = AmountFee;

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_purchase_order_fee_update", _ht);
                }
            }
            Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
            BindFee();
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
    protected void gvwListFee_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtAmountFee = (TextBox)e.Row.FindControl("txtAmountFee");
            DropDownList ddlCurrencyCode = (DropDownList)e.Row.FindControl("ddlCurrencyCode");
            DropDownList ddlChargedTo = (DropDownList)e.Row.FindControl("ddlChargedTo");

            Shared.BindCurrency(ddlCurrencyCode);
            Shared.BindGeneralSubCode(ddlChargedTo, "CHGTO");
            txtAmountFee.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "AMOUNT_FEE"));
            ddlCurrencyCode.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CURRENCY_CODE"));
            ddlChargedTo.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CHARGED_TO"));
            ddlCurrencyCode.Enabled = false;
            if (lblTransFlagDesc.Text == "ON-PROGRESS" || lblTransFlagDesc.Text == "POST" || lblTransFlagDesc.Text == "CANCEL" || lblTransFlagDesc.Text == "CLOSED" || lblTransFlagDesc.Text == "REJECTED")
            {
                txtAmountFee.Enabled = false;
                ddlChargedTo.Enabled = false;
            }
        }
    }
    protected void btnDeleteFee_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListFee.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataFee(gvwListFee.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindFee();

    }
    protected void btnSaveFee_Click(object sender, EventArgs e)
    {
        SaveDataFee();
    }
    protected void btnSearchFee_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindFee();
    }
    private Boolean SelectedExistItem()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListFee.Rows)
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

    #region doc detail
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
            _ht["p_po_code"] = lblCodeBarcode.Text;


            dvQUOTATIONDOC = _dal.GetRows(TABLE_NAME_DOC_DETAIL, _ht).DefaultView;

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

    private void UpdateDataDetail(string CODE_BARCODE, string GENERAL_DOC_CODE, string FILE_NAME, string PATHS, string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_po_code"] = CODE_BARCODE;
            _ht["p_general_doc_code"] = GENERAL_DOC_CODE;
            _ht["p_file"] = FILE_NAME;
            _ht["p_paths"] = PATHS;
            _ht["p_id"] = ID;

            Shared.ApplyDefaultProp(_ht);

            _dal.Update(TABLE_NAME_DOC_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListDocReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDocReq.PageIndex = e.NewPageIndex;
        BindDataDocRequest();
    }

    protected void btnAddUploadDoc_Click(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        //Response.Redirect("masterorderdocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text + "&idartarget=" + Request.Params["idartarget"]);

        int idTarget = 0;
        String Type = "";

        Type = Request.Params["type"];

        var idTargetCondition = string.IsNullOrEmpty(Request.Params["idartarget"]) ? "0" : Request.Params["idartarget"];
        if (Type == "approval")
        {
            idTarget = Int32.Parse(idTargetCondition);

        }
        else
        {
            idTarget = 0;
        }

        if (Type == "approval")
        {
            Response.Redirect("masterorderdocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text + "&type=" + Type + "&idartarget=" + idTarget);
        }
        else
        {
            Response.Redirect("masterorderdocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text);
        }
    }

    protected void btnSaveDocumentDetail_Click(object sender, EventArgs e)
    {
        Hashtable _ht;
        FileUpload fupFile;
        string lblFileName;
        string sFileName;
        String filePath;

        foreach (GridViewRow gvr in gvwListDocReq.Rows)
        {
            fupFile = (FileUpload)gvr.FindControl("fupFilename");
            lblFileName = ((Label)gvr.FindControl("lblFileName")).Text;
            sFileName = System.IO.Path.GetFileName(fupFile.FileName);

            filePath = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/" + lblCodeBarcode.Text));

            if (fupFile.HasFile)
            {
                string sFullPath = filePath + '/' + sFileName;

                if (!System.IO.Directory.Exists(filePath))
                    System.IO.Directory.CreateDirectory(filePath);

                if (!System.IO.File.Exists(sFullPath))
                    fupFile.SaveAs(sFullPath);

                sFullPath = Shared.GetUploadPath("ADD_DOCUMENT/" + lblCodeBarcode.Text) + sFileName;
                UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["PO_CODE"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());
            }

        }

        Shared.ShowSuccessGritter(this, null);
        BindDataDocRequest();
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
            _dal.Delete(TABLE_NAME_DOC_DETAIL, _ht);
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
            FileUpload fu = (FileUpload)e.Row.FindControl("fupFilename");

            if (FileName.Length != 0)
            {

                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];

                btnDelete.OnClientClick = "return confirm('Delete selected data?');";

                if (lblFlagProcess.Text == "POST" || lblFlagProcess.Text == "PROCESSED" || lblFlagProcess.Text == "CANCEL" || lblFlagProcess.Text == "VERIFIED" || lblFlagProcess.Text == "REJECTED")
                {
                    btnDelete.Visible = false;

                }
                fu.Visible = false;


                FileName = gvwListDocReq.DataKeys[e.Row.RowIndex]["PATHS"].ToString();
                btnPreview.Attributes["onclick"] = "javascript:window.open('../../" + FileName + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";
            }
            else
            {
                fu.Visible = true;
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
        Response.Redirect(string.Format("auditdetail.aspx?action=edit&auditno={0}&id={1}&idartarget={2}", gvwListDocReq.SelectedDataKey["BATCH_NO"].ToString(), gvwListDocReq.SelectedDataKey["GENERAL_DOC_CODE"].ToString(), Request.Params["idartarget"]));
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