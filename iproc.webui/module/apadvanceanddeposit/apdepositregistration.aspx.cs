using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
using System.Web.Services;

public partial class module_apadvanceanddeposit_apdepositregistration : BasePage
{
    private static string TABLE_NAME = "AP_DEPOSIT_REGISTRATION";
    private static string TABLE_NAME_DOC_DETAIL = "DEPOSIT_DOCUMENT";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (chbIsPo.Checked)
        {
            btnLookUpPurchaseOrderCode.Enabled = true;
            RequiredFieldValidator3.Enabled = true;
            rfvPaymentBy.Enabled = false;
            ddlPaymentBy.Enabled = false;
            btnLookUpToBank.Enabled = true;
            txtType.Text = "1";
            txtAddAmount.Visible = true;
            Adddepo.Visible = true;
            

        }
        else
        {
            btnLookUpPurchaseOrderCode.Enabled = true;
            RequiredFieldValidator3.Enabled = true;
            rfvPaymentBy.Enabled = false;
            ddlPaymentBy.Enabled = false;
            btnLookUpToBank.Enabled = false;
            btnLookUpRequestor.Enabled = false;
            txtType.Text = "0";
            txtAddAmount.Visible = false;
        }
           
        if (!Page.IsPostBack)
        {

            btnLookUpPurchaseOrderCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PODEP&acol_0={0}&bcol_1={1}&ccol_6={2}&dcol_3={3}&ecol_5={4}&parc_branch_code={5}&parc_type={6}&parc_deposit_date={6}');", txtReferenceNo.ClientID, lblPOCode.ClientID, txtSupplier.ClientID, lblSupplier.ClientID, txtAmount.ClientID, ddlBranch.ClientID, txtType.ClientID,txtDepositDate.ClientID);
            btnLookUpRequestor.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtSupplier.ClientID, lblSupplier.ClientID);
            btnLookUpToBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&parc_code={4}');", txtToBank.ClientID, lblBankName.ClientID, txtToRekName.ClientID, txtToRekNo.ClientID, ddlBranch.ClientID);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);

            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindEmpBranch(ddlBranch);

            Shared.BindCurrencyCode(ddlCurrencyCode);
            ddlBranch.Enabled = true;

            if (chbIsPo.Checked)
            {
                btnLookUpPurchaseOrderCode.Enabled = true;
                RequiredFieldValidator3.Enabled = true;
                rfvPaymentBy.Enabled = false;
                ddlPaymentBy.Enabled = false;
                btnLookUpToBank.Enabled = true;
                txtType.Text = "1";
                txtAddAmount.Visible = true;
                Adddepo.Visible = true;


            }
            else
            {
                btnLookUpPurchaseOrderCode.Enabled = true;
                RequiredFieldValidator3.Enabled = true;
                rfvPaymentBy.Enabled = false;
                ddlPaymentBy.Enabled = false;
                btnLookUpToBank.Enabled = false;
                btnLookUpRequestor.Enabled = false;
                txtType.Text = "0";
                txtAddAmount.Visible = false;
                Adddepo.Visible = false;
            }
           
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataDocRequest();
                btnReject.Text = "Cancel";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnPost.OnClientClick = "return confirm('Post selected data?');";
                btnReject.OnClientClick = "return confirm('Cancel selected data?');";
                btnLookUpPurchaseOrderCode.Enabled = false;
                btnLookUpRequestor.Enabled = false;
                txtDepositDate.Enabled = false;
                chbIsPo.Enabled = false;
                ddlPaymentBy.Enabled = false;
                btnLookUpToBank.Enabled = false;
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (chbIsPo.Checked)
                {
                    btnLookUpPurchaseOrderCode.Enabled = true;
                    RequiredFieldValidator3.Enabled = true;
                    rfvPaymentBy.Enabled = false;
                    ddlPaymentBy.Enabled = false;
                    btnLookUpToBank.Enabled = true;
                    txtType.Text = "1";
                    txtAddAmount.Visible = true;
                    Adddepo.Visible = true;


                }
                else
                {
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    RequiredFieldValidator3.Enabled = true;
                    rfvPaymentBy.Enabled = false;
                    ddlPaymentBy.Enabled = false;
                    btnLookUpToBank.Enabled = false;
                    btnLookUpRequestor.Enabled = false;
                    txtType.Text = "0";
                    txtAmount.Enabled = false;
                    txtAddAmount.Visible = false;
                    Adddepo.Visible = false;
                }
                if (ddlPaymentBy.SelectedValue == "HO")
                {
                    //ToBank.Visible = true;
                    btnLookUpToBank.Enabled = false;
                    lblBankName.Visible = true;
                    ToRekName.Visible = true;
                    ToRekNo.Visible = true;
                    rfvToBank.Enabled = false;
                    



                }
                if (ddlPaymentBy.SelectedValue == "BRANCH")
                {
                    btnLookUpToBank.Enabled = false;
                    lblBankName.Visible = true;
                    ToRekName.Visible = true;
                    ToRekNo.Visible = true;
                    rfvToBank.Enabled = true;

                }


                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    txtDepositDate.Enabled = false;
                    ddlBranch.Enabled = false;
                    //txtRentFrom.Enabled = false;
                    //txtRentTo.Enabled = false;
                    ddlDivision.Enabled = false;
                    txtReferenceNo.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    btnLookUpRequestor.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    txtAmount.Enabled = false;
                    txtDescription.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;
                }
                //  if (lblReffType.Text == "PO")
                //{
                //    txtReferenceNo.Visible = false;
                //    lblReferenceNo.Visible = true;
                //}

                //if (lblReffType.Text == "NON_PO")
                // {
                //     txtReferenceNo.Enabled = true;
                //     lbl.Visible = false;
                // }
                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;
            }
            else
            {
                btnReject.Visible = btnPost.Visible = false;

                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;

                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                txtDepositDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtDepositDate.Enabled = false;
                pnlDetail.Visible = false;

              

            }
        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/apadvanceanddeposit/apdepositregistrationlist.aspx";
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000053&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblBranch.ClientID, lblAmount.ClientID, lblBranch.ClientID, txtDescription.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
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
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            
            btnLookUpRequestor.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtSupplier.ClientID, txtSupplier.ClientID);

           
            DBToUI.Map(this.Controls, _dr);

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
            Shared.BindBranchEmployee(ddlBranch);
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
        String sNextBarcode = "";
        
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("apdepositregistration.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            _dal.ExecRawSP("xsp_ap_deposit_registration_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apdepositregistrationlist.aspx"));
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

            _dal.ExecRawSP("xsp_ap_deposit_registration_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apdepositregistration.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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


    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

       

        //updDep.Update();
    }

    protected void ddlPaymentBy_SelectedIndex(object sender, EventArgs e)
    {
        if (ddlPaymentBy.SelectedValue == "HO")
        {
            //ToBank.Visible = true;
            btnLookUpToBank.Enabled = false;
            lblBankName.Visible = true;
            ToRekName.Visible = true;
            ToRekNo.Visible = true;
            rfvToBank.Enabled = false;
            txtToBank.Text = "--";
            txtToRekName.Text = "--";
            txtToRekNo.Text = "--";
            lblBankName.Text = "--";


        }
        else
        {
            btnLookUpToBank.Enabled = true;
            lblBankName.Visible = true;
            ToRekName.Visible = true;
            ToRekNo.Visible = true;
            rfvToBank.Enabled = true;
            txtToBank.Text = "--";
            txtToRekName.Text = "--";
            txtToRekNo.Text = "--";
            lblBankName.Text = "--";

        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("apdepositregistrationlist.aspx");
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        CancelData();
    }

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

            _ht["p_deposit_code"] = CODE_BARCODE;
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
        Response.Redirect("depositdocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text);
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
                        UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["DEPOSIT_CODE"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());
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