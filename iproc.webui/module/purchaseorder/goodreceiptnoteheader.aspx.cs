using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_goodreceiptnoteheader : BasePage
{
    private static string TABLE_NAME_DETAIL = "GOOD_RECEIPT_NOTE_DETAIL";
    private static string TABLE_NAME_HEADER = "GOOD_RECEIPT_NOTE_HEADER";
    private static string TABLE_NAME_DOC_DETAIL = "GRN_DOCUMENT";
    private static string GET_MULTIPLE_BRANCH = "GET_IS_AGAS"; // (+) Ari 04-07-2022 ket : enhancement 2022

    //Untuk Total Amount GRN
    //private decimal dTotalAmount = 0;
    //private decimal dUnitPrice = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        LoadInit();
        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;

            //btnLookUpPurchaseOrderCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=POGRN&acol_0={0}&bcol_1={1}&ccol_3={2}&dcol_4={3}&parc_branch_code={4}');", txtPurchaseOrderCode.ClientID, lblPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, txtBranch.ClientID);
            LoadDataagas(); // (+) Ari 30-12-2022 ket : enhancement 2022
            if (lblMultiplebranch.Text == "1")
            {
                btnLookUpPurchaseOrderCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=POGRN&acol_0={0}&bcol_1={1}&ccol_3={2}&dcol_4={3}&parc_branch_code={4}');", txtPurchaseOrderCode.ClientID, lblPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, ddlBranch.ClientID);
            }
            else
            {
                btnLookUpPurchaseOrderCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=POGRN&acol_0={0}&bcol_1={1}&ccol_3={2}&dcol_4={3}&parc_branch_code={4}');", txtPurchaseOrderCode.ClientID, lblPOCode.ClientID, txtSupplierID.ClientID, lblSupplierName.ClientID, txtBranch.ClientID);
                
            }
         
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            btnPrint.Visible = false;
            btnPrintBAST.Visible = false;
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
                BindDataDocRequest();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnLookUpPurchaseOrderCode.Enabled = false;
                btnDeleteRequestDetail.OnClientClick = "return confirm('Delete selected data?');";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                ddlBranch.Enabled = false;
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
               
                txtReceiveDate.Enabled = false;

                if (lblTransFlagCode.Text == "POST")
                {
                    btnDeleteRequestDetail.Visible = false;
                    btnSave.Visible = btnPost.Visible = false;
                    txtReceiveDate.Enabled = false;
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlRating.Enabled = false;
                    ddlBranch.Enabled = ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = ddlUnits.Enabled = false;
                    btnPrint.Visible = true;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;

                    if (lblOrderType.Text == "SPK")
                    {
                        btnPrintBAST.Visible = true;
                    }
                    else
                    {
                        btnPrintBAST.Visible = false;
                    }
                }
                else if (lblTransFlagCode.Text == "CLOSED")
                {
                    btnDeleteRequestDetail.Visible = false;
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    txtReceiveDate.Enabled = false;
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlRating.Enabled = false;
                    ddlBranch.Enabled = ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = ddlUnits.Enabled = false;
                    btnPrint.Visible = true;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;

                    if (lblOrderType.Text == "SPK")
                    {
                        btnPrintBAST.Visible = true;
                    }
                    else
                    {
                        btnPrintBAST.Visible = false;
                    }
                }
                else if (lblTransFlagCode.Text == "CANCEL")
                {
                    btnDeleteRequestDetail.Visible = false;
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    txtReceiveDate.Enabled = false;
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlDepartment.Enabled = ddlDivision.Enabled = false;
                    btnPrint.Visible = true;
                    btnPrintBAST.Visible = false;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;
                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnDeleteRequestDetail.Visible = false;
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    txtReceiveDate.Enabled = false;
                    btnLookUpPurchaseOrderCode.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlDepartment.Enabled = ddlDivision.Enabled = false;
                    btnPrint.Visible = true;
                    btnPrintBAST.Visible = false;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;

                }


                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;


                btnViewHistory.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/purchaseorderview.aspx?action=edit&codebarcode={0}');", txtPurchaseOrderCode.Text);
            }

            else
            {
                LoadDataagas(); // (+) Ari 30-12-2022 ket : enhancement 2022
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlSubDepartment.SelectedValue = Shared.CurrentEmployeeSubDepartmentCode;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                txtReceiveDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtReceiveDate.Enabled = false;
                btnDeleteRequestDetail.Visible = false;
                btnReject.Visible = btnPost.Visible = false;
                pnlItemList.Visible = false;
                btnApprovalTiered.Visible = false;
                ddlBranch.Enabled = false;
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                //btnViewHistory.Visible = false;

                // (+) Ari 30-06-2022 ket : enhancement 2022 (jika Role Flag Is Agas bisa edit ddlBranch)
                if (lblMultiplebranch.Text == "1")
                {
                    ddlBranch.Enabled = true;
                }
            }

           
           
        }
        
        //btnViewHistory.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/purchaseorderview.aspx?action=edit&codebarcode={0}');", txtPurchaseOrderCode.Text);
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/goodreceiptnoteheaderlist.aspx";
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000023&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblBranch.ClientID, lblAmount.ClientID, lblBranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000023&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblBranch.ClientID, lblAmount.ClientID, lblBranch.ClientID, txtRemarks.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000024&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblBranch.ClientID);
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
            // (+) Ari 02-01-2023 ket : enhancement 2022
            _ht["p_user_id"] = Shared.CurrentUID;
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            //Shared.BindBranchEmployee(ddlBranch);
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

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("goodreceiptnoteheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));            
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
        Response.Redirect("goodreceiptnoteheaderlist.aspx");
    }

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
       

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


    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_code_barcode"] = lblCodeBarcode.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_GOOD_RECEIPT_NOTE", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }

    protected void btnPrintBAST_Click(object sender, EventArgs e)
    {
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_code_barcode"] = lblCodeBarcode.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_BERITA_ACARA_SERAH_TERIMA", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }

    #region GRN Detail
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
        BindData();
    }

    protected void btnDeleteRequestDetail_Click(object sender, EventArgs e)
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
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("goodreceiptnotedetail.aspx?action=edit&id={0}&codebarcode={1}&status={2}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, lblTransFlagCode.Text));

    }
    protected void gvwList_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //dUnitPrice = dUnitPrice + decimal.Parse(e.Row.Cells[7].Text);
            //dTotalAmount = dTotalAmount + decimal.Parse(e.Row.Cells[8].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            //e.Row.Cells[7].Text = dUnitPrice.ToString("N2");
            //e.Row.Cells[8].Text = dTotalAmount.ToString("N2");
        }
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
            _ht["p_grn_code"] = lblCodeBarcode.Text;
            //_ht["p_id"] = Request.Params["id"];

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

    private void UpdateDataDetail(string GRN_CODE, string GENERAL_DOC_CODE, string FILE_NAME, string PATHS, string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_GRN_code"] = GRN_CODE;
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
        Response.Redirect("grndocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text + "&flagprocess=" + lblTransFlagCode.Text);
        // Response.Redirect("purchaserequestdocument.aspx?action=add&id=" + gvwList.SelectedDataKey[0] + "&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text + "&flagprocess=" + lblTransFlagCode.Text);
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
                                UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["GRN_CODE"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());
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
        catch (Exception)
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
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];

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

    protected void btnReject_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataRow _dr = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht.Add("p_code", lblPOCode.Text.Trim());
            DataTable dt = _dal.GetRows("grn", _ht);
            if (dt == null || dt.Rows.Count == 0)
            {
                throw new Exception("Data tidak ditemukan");
            }

             bool isSudahDibayar = false;
             foreach (DataRow dr in dt.Rows)
             {
                 string poCode = Convert.ToString(dr["PO_CODE"]);
                 string poQty = Convert.ToString(dr["PO_QTY"]);
                 string poRemainQty = Convert.ToString(dr["PO_REMAIN_QTY"]);
                 string grnCode = Convert.ToString(dr["GRN_CODE"]);
                 string grnQty = Convert.ToString(dr["GRN_PO_QTY"]);
                 string grnReceive = Convert.ToString(dr["GRN_RECEIVE"]);
                 string grnRemainQty = Convert.ToString(dr["GRN_REMAIN_QTY"]);
                 string itemCode = Convert.ToString(dr["POD_ITEM_CODE"]);
                 string invCode = Convert.ToString(dr["INVOICE_REGIS_CODE"]);
                 string invStatus = Convert.ToString(dr["INVOICE_REGIS_STATUS"]);
                 string payemtnReqCode = Convert.ToString(dr["PAYMENT_REQ_CODE"]);
                 string paymentStatus = Convert.ToString(dr["PAYMENT_REQ_STATUS"]);
                 string paymentStatusBayar = Convert.ToString(dr["PAYMENT_STATUS_BAYAR"]);

                 if (paymentStatusBayar == "1")
                 {
                     throw new Exception(
                         "GRN tidak dapat dibatalkan, karena sudah dilakukan pembayaran.");
                 }
                 if (!string.IsNullOrEmpty(invStatus) && invStatus.Equals("POST", StringComparison.OrdinalIgnoreCase))
                 {
                     throw new Exception(
                         "GRN tidak dapat dibatalkan, karena invoice telah diposting dengan nomor invoice " + invCode + ".");
                 }
                 if (!string.IsNullOrEmpty(invStatus) && invStatus.Equals("NEW", StringComparison.OrdinalIgnoreCase))
                 {
                     throw new Exception(
                         "Telah terdapat invoice dengan nomor " + invCode +". Silahkan melakukan cancel invoice terlebih dahulu.");
                 }
                 if (!string.IsNullOrEmpty(invStatus) && invStatus.Equals("ONPROGRESS", StringComparison.OrdinalIgnoreCase))
                 {
                     throw new Exception(
                         "Telah terdapat invoice dengan nomor " + invCode + ". Silahkan melakukan cancel invoice terlebih dahulu.");
                 }
                 //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000024&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblBranch.ClientID);
                 _dal.Cancel("good_receipt_note_header", _ht);
                 Shared.ShowSuccessGritter(this, string.Format("goodreceiptnoteheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));  
             }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
        finally
        {
            _dal = null;
            _ht = null;
            _dr = null;
        }
    }
    private void ProsesReject(string poCode, string grnCode, string paymentStatus)
    {       
    }
}
