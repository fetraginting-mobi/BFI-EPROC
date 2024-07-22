using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_faadjustheader : BasePage
{
    private static string TABLE_NAME_HEADER = "FA_ADJUST_HEADER";
    private static string TABLE_NAME_DETAIL = "FA_ADJUST_DETAIL";
    private static string TABLE_NAME_DETAIL_UPLOAD = "FA_ADJUST_UPLOAD"; // (+) Ari 19-07-2022
   

    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        //btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);

            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            //Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);


            //btnLookUpFaAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FAMGL&acol_0={0}&bcol_0={1}&ccol_1={2}&ecol_3={3}&parc_location={4}');", lblBarcode.ClientID, txtBarcode.ClientID, lblAssetName.ClientID, txtFromLocation.ClientID, ddlBranch.ClientID);
            btnLookUpFaAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FADJS&acol_0={0}&bcol_0={1}&ccol_1={2}&ecol_3={3}&fcol_4={4}&jcol_1={5}&parc_location={6}');", txtBarcode2.ClientID, txtBarcode.ClientID, lblAssetName.ClientID, txtFromLocation.ClientID, txtFromLocationCode.ClientID,txtItemCode.ClientID, ddlBranch.ClientID);
           // btnAddDetail.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=FAJAST&parc_fa_adjust_code={0}&gvw={1}&parc_branch_code={2}&parc_location={3}');", txtCodeBarcode.ClientID, btnSearch.UniqueID, ddlBranch.ClientID, txtFromLocation.ClientID);
            btnAddDetail.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=FAINV&parc_adjust_code={0}&gvw={1}');", txtCodeBarcode.ClientID, btnSearchDetail.UniqueID);
            btnLookUpToBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&parc_code={4}');", txtToBank.ClientID, lblBankName.ClientID, txtToRekName.ClientID, txtToRekNo.ClientID, ddlBranch.ClientID);
            btnLookUpSupplier.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSUPO&acol_0={0}&bcol_1={1}&parc_item_code={2}');", txtSupplierCode.ClientID, txtSupplier.ClientID,txtItemCode.ClientID);

           
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                //ddlFromLocationCode.Enabled = false;

                BindExpense();
                BindData();
                btnDeleteDetail.OnClientClick = "return confirm('Delete selected data?');";
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                txtFadjustDate.Enabled = false;
                ddlBranch.Enabled = false;
                btnReject.Visible = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnReject.OnClientClick = "return confirm('Cancel selected data?');";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
                gvwListDetail.Columns[1].Visible = true;
                btnAddDetail.Visible = btnDeleteDetail.Visible = true;
                
                

                //pnl1.Visible = true;
                //pnl2.Visible = true;

                //(+) Ari 19-07-2022 ket : enhancement 2022
                //if (!string.IsNullOrEmpty(txtPaths.Text))
                //{
                //    btnPreview.Visible = true;
                //}
                //else
                //{
                //    btnPreview.Visible = false;                
                //}

                if (lblAdjustType.Text == "PLUS")
                {
                    ddlPaymentBy.Enabled = true;
                }

                else
                {
                    ddlPaymentBy.Enabled = false;
                }

             

                         if (ddlPaymentBy.SelectedValue == "HO")
                        {
                             if (lblAdjustType.Text == "PLUS")
                                {
                                    btnLookUpToBank.Enabled = false;
                                    ToBank.Visible = true;
                                    lblBankName.Visible = true;
                                    ToRekName.Visible = true;
                                    ToRekNo.Visible = true;
                                    rfvToBank.Enabled = false;
                                }

                            else
                                {

                                    //ToBank.Visible = true;
                                    btnLookUpToBank.Visible = false;
                                    ddlBranch.Visible = false;
                                    ToBank.Visible = false;
                                    lblBankName.Visible = false;
                                    ToRekName.Visible = false;
                                    ToRekNo.Visible = false;
                                    rfvToBank.Enabled = false;
                                }


                        }
                        else
                        {
                            if (lblAdjustType.Text == "PLUS")
                            {
                                btnLookUpToBank.Visible = true;
                                ToBank.Visible = true;
                                lblBankName.Visible = true;
                                ToRekName.Visible = true;
                                ToRekNo.Visible = true;
                                rfvToBank.Enabled = true;
                            }
                            else
                            {
                                btnLookUpToBank.Visible = false;
                                ToBank.Visible = false;
                                lblBankName.Visible = false;
                                ToRekName.Visible = false;
                                ToRekNo.Visible = false;
                                rfvToBank.Enabled = false;
                                ddlBranch.Visible = false;
                            }
                        }
                    
                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "CLOSED")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                    btnReject.Visible = true;
                    txtFadjustDate.Enabled = false;
                    //ddlFromLocationCode.Enabled = false;
                    ddlBranch.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    btnLookUpFaAsset.Enabled = false;
                    txtDescription.Enabled = false;
                    gvwListDetail.Columns[1].Visible = false;
                    btnViewHistory.Visible = true;
                    btnSaveDetail.Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlPaymentBy.Enabled = false;

                    //btnPreview.Visible = true; // (+) Ari 29-06-2022 ket : enhancement 2022 upload
                    //btnSaveupload.Visible = false;
                    //fuInvoice.Visible = false;
                    btnAddUploadDoc.Visible = false; // (+) Ari 29-06-2022 ket : enhancement 2022 upload
                    

                }
                if (lblTransFlagCode.Text == "CLOSED" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "POST")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                    btnReject.Visible = false;
                    txtFadjustDate.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    btnLookUpFaAsset.Enabled = false;
                    //ddlFromLocationCode.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtDescription.Enabled = false;
                    gvwListDetail.Columns[1].Visible = false;
                    btnViewHistory.Visible = true;
                    btnSaveDetail.Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;

                   // btnPreview.Visible = true; // (+) Ari 29-06-2022 ket : enhancement 2022 upload
                    //btnSaveupload.Visible = false;
                    //fuInvoice.Visible = false;
                    btnAddUploadDoc.Visible = false; // (+) Ari 29-06-2022 ket : enhancement 2022 upload

                }

                if (lblIsUsed.Text == "0" || lblTransFlagCode.Text == "POST")
                {
                    btnReject.Visible = true;
                    btnSave.Visible = btnPost.Visible  = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                    txtFadjustDate.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    btnLookUpFaAsset.Enabled = false;
                    //ddlFromLocationCode.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtDescription.Enabled = false;
                    gvwListDetail.Columns[1].Visible = false;
                    btnViewHistory.Visible = true;
                    btnSaveDetail.Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                }
                if (lblTransFlagCode.Text == "ONPROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnPost.Visible = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                    txtFadjustDate.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    btnLookUpFaAsset.Enabled = false;
                    //ddlFromLocationCode.Enabled = false;
                    txtDescription.Enabled = false;
                    gvwListDetail.Columns[1].Visible = false;
                    ddlBranch.Enabled = false;
                    btnSaveDetail.Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlPaymentBy.Enabled = false;

                    //btnPreview.Visible = true; // (+) Ari 29-06-2022 ket : enhancement 2022 upload
                    //btnSaveupload.Visible = false;
                    //fuInvoice.Visible = false;
                    btnAddUploadDoc.Visible = false; // (+) Ari 29-06-2022 ket : enhancement 2022 upload



                }
                if (lblTransFlagCode.Text == "NEW")
                {
                    btnReject.Visible = false;
                    btnSave.Visible = btnPost.Visible = true;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = true;
                  
                    txtFadjustDate.Enabled = false;
                    //ddlFromLocationCode.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtDescription.Enabled = true;
                    gvwListDetail.Columns[1].Visible = true;
                    btnViewHistory.Visible = true;
                    btnSaveDetail.Visible = true;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                }

                //nirmala (12-12-2019) (no ticket :  1912000089)
                if (lblTransFlagCode.Text == "REJECTED")
                {
                    txtFadjustDate.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtBarcode.Enabled = false;
                    ddlDivision.Enabled = false;
                    txtFromLocationCode.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    txtDescription.Enabled = false;
                    ddlUnits.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    ddlPaymentBy.Enabled = false;
                    txtToRekName.Enabled = false;
                    btnLookUpToBank.Enabled = false;
                }

                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;

                //if (!string.IsNullOrEmpty(txtFileName.Text))
                //{
                //    btnPreview.Visible = true;
                //}

                if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                    txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

            }
            else
            {
                btnReject.Visible = pnlDisposal.Visible = btnPost.Visible = false;
                btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                
                txtFadjustDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtFadjustDate.Enabled = false;
                Shared.BindBranchEmployee(ddlBranch);
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;


                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                ddlSubDepartment.SelectedValue = Shared.CurrentEmployeeSubDepartmentCode;
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                //Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);
                btnViewHistory.Visible = false;
                ToBank.Visible = false;
                ToRekName.Visible = false;
                ToRekNo.Visible = false;
                ddlPaymentBy.Enabled = false;
               // btnPreview.Visible = false; // (+) Ari 29-06-2022 ket : enhancement 2022
                //pnl1.Visible = false;
                //pnl2.Visible = false;
                //if (!string.IsNullOrEmpty(txtFileName.Text)) // (+) Ari 29-06-2022 ket : enhancement 2022
                //{
                //    btnPreview.Visible = true;
                //}
            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/fa/faadjustlist.aspx";
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000052&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtDescription.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000021&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000022&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0069&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
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

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindBranchEmployee(ddlBranch);

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
            //Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);

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

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("faadjustheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

            _dal.ExecRawSP("xsp_fa_disposal_header_post", _ht);

          Shared.ShowSuccessGritter(this, string.Format("faadjustheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

            _dal.ExecRawSP("xsp_fa_disposal_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("faadjustheader.aspx?action=edit&adjustno={0}", lblAdjustType.Text));
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

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddlPaymentBy_SelectedIndex(object sender, EventArgs e)
    {
        if (ddlPaymentBy.SelectedValue == "HO")
        {

            if (lblAdjustType.Text == "PLUS")
            {
                btnLookUpToBank.Enabled = false;
                ToBank.Visible = true;
                lblBankName.Visible = true;
                ToRekName.Visible = true;
                ToRekNo.Visible = true;
                rfvToBank.Enabled = false;
            }

            else
            {

                //ToBank.Visible = true;
                btnLookUpToBank.Visible = false;
                ddlBranch.Visible = false;
                ToBank.Visible = false;
                lblBankName.Visible = false;
                ToRekName.Visible = false;
                ToRekNo.Visible = false;
                rfvToBank.Enabled = false;
            }


        }
        else
        {
            if (lblAdjustType.Text == "PLUS")
            {
                btnLookUpToBank.Enabled = true;
                btnLookUpToBank.Visible = true;
                ToBank.Visible = true;
                lblBankName.Visible = true;
                ToRekName.Visible = true;
                ToRekNo.Visible = true;
                rfvToBank.Enabled = true;
            }
            else
            {
                btnLookUpToBank.Visible = false;
                ddlBranch.Visible = false;
                ToBank.Visible = false;
                lblBankName.Visible = false;
                ToRekName.Visible = false;
                ToRekNo.Visible = false;
                rfvToBank.Enabled = false;
            }
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("faadjustlist.aspx");
    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }
    protected void btnReject_Click(object sender, EventArgs e)
    {
        CancelData();
    }
    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlDepartment.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);

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

    #region Upload Doc
    //Upload (+) Ari 28-06-2022 ket : enhancement 2022
    //protected void btnSaveupload_Click(object sender, EventArgs e)
    //{
    //    if (!fuInvoice.HasFile & string.IsNullOrEmpty(txtFileName.Text))
    //    {
    //        Shared.ShowValidationError(this, "Please upload file!");
    //        return;
    //    }
    //    //else if(string.IsNullOrEmpty(txtFileName.Text))
    //    //{
    //    //    Shared.ShowValidationError(this, "Please upload file!");
    //    //    return;
    //    //}
    //    SaveDataUpload();
    //}
    //private void SaveDataUpload()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    //string nextID = "";

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //        Shared.ApplyDefaultProp(_ht);

    //        _ht["p_code_barcode"] = Request.Params["codebarcode"];
    //        //_ht["p_type"] = "MANUAL";
    //        //_ht["p_cross_no"] = "-";

    //        string sFileType = System.IO.Path.GetExtension(fuInvoice.FileName); // (+) Ari 29-06-2022

    //        if (fuInvoice.HasFile)
    //        {
    //            if (
    //                sFileType == ".xls" || sFileType == ".xlsx"     // EXCEL
    //                || sFileType == ".doc" || sFileType == ".docx"     // WORD
    //                //|| sFileType == ".ppt" || sFileType == ".pptx"     // Powepoint
    //                //|| sFileType == ".one" || sFileType == ".txt"      // OneNote & Notepad
    //                || sFileType == ".jpeg" || sFileType == ".jpg"      // Image
    //                || sFileType == ".png" //|| sFileType == ".gif"
    //                || sFileType == ".pdf" //|| sFileType == ".csv"      // PDF
    //                || sFileType == ".zip" || sFileType == ".rar"      // File
    //                || sFileType == ".7z"

    //                )
    //            {

    //                string sFileName = System.IO.Path.GetFileName(fuInvoice.FileName);
    //                string sFilePath = Shared.GetUploadPath("FAADJUSTMENT/DOCUMENT") + Request.Params["codebarcode"] + "/";

    //                _ht["p_file_name"] = sFileName;
    //                _ht["p_paths"] = sFilePath + sFileName;

    //                string sFileDirectory = Server.MapPath("~/" + sFilePath);
    //                string sFileFullPath = sFileDirectory + sFileName;

    //                if (!System.IO.Directory.Exists(sFileDirectory))
    //                    System.IO.Directory.CreateDirectory(sFileDirectory);

    //                if (!System.IO.File.Exists(sFileFullPath))
    //                    fuInvoice.SaveAs(sFileFullPath);

    //                int fileSize = fuInvoice.PostedFile.ContentLength;

    //                //if (!Shared.CheckFileUploadSize(this, fuInvoice)) // Cek Size
    //                //{
    //                //    return;
    //                //}


    //                if (!string.IsNullOrEmpty(txtPaths.Text) & !string.IsNullOrEmpty(txtFileName.Text))
    //                {
    //                    if (!sFileName.Equals(txtFileName.Text))
    //                    {
    //                        string sFilePathOld = Server.MapPath("~/" + txtPaths.Text);

    //                        System.IO.File.Delete(sFilePathOld);
    //                    }
    //                }
    //            }
    //            else
    //            {
    //                Shared.ShowValidationError(this, "Please upload file with format type (.pdf .zip .doc .xlx .png .jpg .jpeg)");
    //                return;
    //            }
    //        }
    //        else
    //        {
    //            _ht["p_file_name"] = txtFileName.Text;
    //            _ht["p_paths"] = txtPaths.Text;
    //        }
    //        _dal.Update(TABLE_NAME_HEADER, _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("faadjustheader.aspx?action=edit&codebarcode=" + Request.Params["codebarcode"]));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}
    //protected void btnPreview_Click(object sender, EventArgs e)
    //{
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Report", "window.open('../../" + txtPaths.Text + "', 'report', 'fullscreen=0, menubar=0, status=0, scrollbars=0, resizable=1, toolbar=0, width=600, height=400');", true);
    //}

    protected void btnAddUploadDoc_Click(object sender, EventArgs e)
    {
        Response.Redirect("faadjustheaderupload.aspx?action=add&codebarcode=" + Request.Params["codebarcode"]);
    }
    protected void btnSearchDoc_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected void gvwListDoc_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDoc.PageIndex = e.NewPageIndex;
        BindData();
    }
    protected void gvwListDoc_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("faadjustheaderupload.aspx?action=edit&id={0}&codebarcode={1}", gvwListDoc.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
    }
    private void DeleteDoc(string FileNo)
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //_ht["p_file_name"] = DBNull.Value;
            _ht["p_id"] = FileNo;

            Shared.ApplyDefaultProp(_ht);

            _dal.Delete(TABLE_NAME_DETAIL_UPLOAD, _ht);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    private void DeleteDocFile(string FileName)
    {
        // get file/ (karena saat proses ada 2x file/file/)
        string file = FileName.Remove(0, 4);
        //FileName = FileName.Substring(5, lenght);

        string sFilename = Server.MapPath("~/" + Shared.GetUploadPath(file));

        //ambil lenght sfilename
        int lenght = sFilename.Length-1;

        sFilename = sFilename.Remove((lenght), 1);
        System.IO.File.Delete(sFilename);
    }
    protected void gvwListDoc_RowCommand(object sender, GridViewCommandEventArgs e)
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
                        string FileNo = gvwListDoc.DataKeys[rowIndex][0].ToString();
                        //string FileName = ((Label)row.Cells[2].Controls[1]).Text;
                        string FileName = gvwListDoc.DataKeys[rowIndex][1].ToString();

                        //delete data di database server
                        DeleteDoc(FileNo);

                        //delete file di app server 
                        DeleteDocFile(FileName);

                        Shared.ShowSuccessGritter(this, Request.Url.ToString());
                    }
                    catch (Exception ex)
                    {
                        Shared.ShowErrorDialog(this, ex);
                    }

                    BindData();
                }
                //else if (e.CommandName == "preview")
                //{
                //    try
                //    {
                //        string transaction;//= ((Label)e.Row.Cells[3].Controls[1]).Text;

                //        LinkButton btnPreviewDoc = (LinkButton)row.Cells[4].Controls[1];

                //        transaction = gvwListDoc.DataKeys[rowIndex]["PATHS"].ToString();
                //        btnPreviewDoc.Attributes["onclick"] = "javascript:window.open('../../" + transaction + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";
                //    }
                //    catch (Exception ex)
                //    {
                //        Shared.ShowErrorDialog(this, ex);
                //    }
                //}
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
            _dal.Delete(TABLE_NAME_DETAIL_UPLOAD, _ht);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //protected void gvwListDoc_OnRowDataBound(object sender, GridViewRowEventArgs e)
    //{

    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        string FileName = ((Label)e.Row.Cells[2].Controls[1]).Text;

    //        //if (FileName.Length != 0)
    //        //{

    //        //    LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
    //        //    LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];

    //        //    btnDelete.OnClientClick = "return confirm('Delete selected data?');";

    //        //    if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "ON-PROGRESS" || lblTransFlagCode.Text == "CLOSED" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "REJECTED")
    //        //    {
    //        //        btnDelete.Visible = false;

    //        //    }


    //        //    FileName = gvwListDoc.DataKeys[e.Row.RowIndex]["PATHS"].ToString();
    //        //    btnPreview.Attributes["onclick"] = "javascript:window.open('../../" + FileName + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";

    //        //}
    //        //else
    //        //{
    //        //    LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
    //        //    LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];

    //        //    btnPreview.Visible = false;
    //        //    btnDelete.Visible = false;
    //        //}
    //    }
    //}


    protected void gvwListDoc_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string FileName = ((Label)e.Row.Cells[2].Controls[1]).Text;

            if (FileName.Length != 0)
            {

                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];

                btnDelete.OnClientClick = "return confirm('Delete selected data?');";

                //if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "PROCESSED" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "VERIFIED" || lblTransFlagCode.Text == "REJECTED")
                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "ON-PROGRESS" || lblTransFlagCode.Text == "CLOSED" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "REJECTED")
                {
                    btnDelete.Visible = false;

                }
                FileName = gvwListDoc.DataKeys[e.Row.RowIndex]["PATHS"].ToString();
                btnPreview.Attributes["onclick"] = "javascript:window.open('../../" + FileName + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";
            }
            else
            {
                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[3];

                btnPreview.Visible = false;
                btnDelete.Visible = false;
            }
            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

        }
    }

    private void BindData()
    { 
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDetail.Text;
            _ht["p_adjust_no"] = lblCodeBarcode.Text;


            gvwListDoc.DataSource = _dal.GetRows(TABLE_NAME_DETAIL_UPLOAD, _ht);

            gvwListDoc.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }



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
            _ht["p_adjust_code"] = lblCodeBarcode.Text;


            gvwListDetail.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);

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

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
            Shared.ShowSuccessGritter(this, string.Format("faadjustheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

                    _dal.ExecRawSP("fa_adjust_detail_update", _ht);

                }
            }
            //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

            Shared.ShowSuccessGritter(this, string.Format("faadjustheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
            ddlCurrencyCodeDetail.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CURENNCY_CODE"));
            if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ONPROGRESS")
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

    //#region fa mutation detail

    //private void BindData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_keywords"] = txtSearch.Text;
    //        _ht["p_code_barcode"] = lblCodeBarcode.Text;

    //        gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
    //        gvwList.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //private void DeleteData(string id)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_id"] = id;

    //        _dal.Delete(TABLE_NAME_DETAIL, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    gvwList.PageIndex = e.NewPageIndex;
    //    BindData();
    //}

    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("faadjustheader.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&location=" + txtFromLocation.Text);
    //}

    //protected void btnDelete_Click(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in gvwList.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
    //        }
    //    }

    //    BindData();
    //}

    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    if (lblCodeBarcode.Text != string.Empty)
    //        BindData();
    //}
    //protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Response.Redirect(string.Format("fadisposaldetail.aspx?action=edit&id={0}&codebarcode={1}&location={2}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, txtFromLocation.Text));
    //}

    //protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow gvr in gvwList.Rows)
    //    {
    //        CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
    //        cbSelect.Checked = ((CheckBox)sender).Checked;
    //    }
    //}

    //private void SaveDataQty()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    if (!SelectedExist())
    //    {
    //        Exception ex = null;
    //        ex = new Exception("No Transaction Selected !");
    //        Shared.ShowErrorDialog(this, ex);
    //        return;
    //    }

    //    _dal = new GeneralDAL();
    //    _ht = new Hashtable();
    //    try
    //    {
    //        foreach (GridViewRow row in gvwList.Rows)
    //        {
    //            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //            if (chb.Checked)
    //            {

    //                string Qty = ((TextBox)row.Cells[7].Controls[1]).Text;

    //                _ht["p_ast_code"] = gvwList.DataKeys[row.RowIndex][0].ToString();

    //                _ht["p_fa_adjust_code"] = txtCodeBarcode.Text;

    //                _ht["p_new_cost_price"] = Qty;


    //                Shared.ApplyDefaultProp(_ht);

    //                _dal.ExecRawSP("xsp_fa_adjust_amount_update", _ht);

    //            }
    //        }

    //        Shared.ShowSuccessGritter(this, string.Format("faadjustheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //        BindData();

    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //        TextBox txtQty = (TextBox)e.Row.FindControl("txtQty");




    //        txtQty.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NEW_COST_PRICE"));



    //    }
    //}

    //protected void btnSaveQty_Click(object sender, EventArgs e)
    //{
    //    SaveDataQty();
    //}

    //private Boolean SelectedExist()
    //{
    //    int _RowCount = 0;
    //    foreach (GridViewRow row in gvwList.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            _RowCount += 1;
    //        }
    //    }

    //    if (_RowCount > 0)
    //        return true;
    //    else
    //        return false;
    //}


    ////private void SaveDataDetail()
    ////{
    ////    GeneralDAL _dal = null;
    ////    Hashtable _ht = null;

    ////    if (!SelectedExistItem())
    ////    {
    ////        Exception ex = null;
    ////        ex = new Exception("No Transaction Selected !");
    ////        Shared.ShowErrorDialog(this, ex);
    ////        return;
    ////    }

    ////    _dal = new GeneralDAL();
    ////    _ht = new Hashtable();

    ////    // MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    ////    // System.Diagnostics.Debugger.Break();
    ////    try
    ////    {
    ////        foreach (GridViewRow row in gvwList.Rows)
    ////        {
    ////            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    ////            if (chb.Checked)
    ////            {

    ////                string SaleValue = ((TextBox)row.Cells[5].Controls[1]).Text;

    ////                _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
    ////                //_ht["p_sale_value"] = SaleValue;

    ////                Shared.ApplyDefaultProp(_ht);

    ////                _dal.ExecRawSP("xsp_fa_disposal_update", _ht);
    ////            }
    ////        }

    ////        Shared.ShowSuccessGritter(this, string.Format("fadisposalheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));

    ////        BindData();
    ////    }
    ////    catch (Exception ex)
    ////    {
    ////        Shared.ShowErrorDialog(this, ex);
    ////    }
    ////}


    //////protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    //////{
    //////    if (e.Row.RowType == DataControlRowType.DataRow)
    //////    {

    //////        TextBox txtSaleValue = (TextBox)e.Row.FindControl("txtSaleValue");

    //////        txtSaleValue.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SALE_VALUE"));

    //////    }
    //////}

    ////protected void btnSaveDetail_Click(object sender, EventArgs e)
    ////{
    ////    SaveDataDetail();
    ////}

    ////private Boolean SelectedExistItem()
    ////{
    ////    int _RowCount = 0;
    ////    foreach (GridViewRow row in gvwList.Rows)
    ////    {
    ////        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    ////        if (chb.Checked)
    ////        {
    ////            _RowCount += 1;
    ////        }
    ////    }

    ////    if (_RowCount > 0)
    ////        return true;
    ////    else
    ////        return false;
    ////}

    //#endregion


}