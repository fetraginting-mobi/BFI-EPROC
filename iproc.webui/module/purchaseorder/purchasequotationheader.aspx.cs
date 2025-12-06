using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_purchaseorder_purchasequotationheader : BasePage
{
    private static string TABLE_NAME_HEADER     = "PURCHASE_QUOTATION_HEADER";
    private static string TABLE_NAME_DETAIL     = "PURCHASE_QUOTATION_DETAIL";
    private static string TABLE_NAME_DOC_DETAIL = "PURCHASE_QUOTATION_DOCUMENT_DETAIL";
   

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        LinkButton btn = btnViewDocument as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/viewdocumetquotationreview.aspx?action=edit&codebarcode={0}');", lblCodeBarcode.Text);
        if (!Page.IsPostBack)
        {
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblCodeBarcode.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
              
                txtQuotationDate.Enabled = false;
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;


                //btnPostAuthority.Visible = false;
                

                BindQuotationDetail();
                BindDataDocRequest();
                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
                //btnReject.OnClientClick= "return confirm('Cancel selected data?');";

                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "REJECTED")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = btnSaveDetail.Visible = false;
                    txtExpDate.Enabled = false;
                    txtQuotationDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlBranch.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    btnPrint.Visible = true;
                    btnUnPost.Visible = false;
                    btnPostAuthority.Visible = false;
                    ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = ddlUnits.Enabled = false;

                  
                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = btnSaveDetail.Visible = false;
                    txtExpDate.Enabled = false;
                    txtQuotationDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlBranch.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    btnPrint.Visible = true;
                    btnUnPost.Visible = false;
                    ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = ddlUnits.Enabled = false;
                }
                else if (lblTransFlagCode.Text == "NEW")
                {
                    ddlBranch.Enabled = false; // (+) Ari 06-01-2023 ket : enhancement 2022, disable
                }
                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;

 
            }
             else
	        {
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                txtQuotationDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtQuotationDate.Enabled = false;


                btnAdd.Visible = btnDelete.Visible = false;
                pnlQuotation.Visible = false;
                btnReject.Visible = btnPost.Visible = false;
                btnPrint.Visible = false;
                btnApprovalTiered.Visible = false;
	        }
        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/purchasequotationheaderlist.aspx";

        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000003&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID);
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000003&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnPostAuthority.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000039&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000004&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
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

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
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
            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode;

            }
            else            
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchasequotationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
             
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
        Response.Redirect("purchasequotationheaderlist.aspx");
    }
   
    protected void btnPrint_Click(object sender, EventArgs e)
    {
         
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_pq_code"] = lblCodeBarcode.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_APPROVE_MEMO_LIST", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }

    private void RejectData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("dbo.xsp_purchase_quotation_header_reject", _ht);

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


    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

        //Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);

        //updDep.Update();
    }
    protected void btnUnPost_Click(object sender, EventArgs e)
    {
        RejectData(); 
    }


    #region purchase quotation detail

    private void BindQuotationDetail()
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

            _ht["p_id_list"] = ID;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
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

    private void SaveDataDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
  

        if (!SelectedExist())
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
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    string txtSupplierCode = ((TextBox)row.FindControl("txtSupplierCode")).Text;
                    string txtQuantity = ((TextBox)row.FindControl("txtQuantity")).Text;
                    DropDownList ddlCurrencyCode = (DropDownList)row.FindControl("ddlCurrencyCode");
                    string txtUnitPrice = ((TextBox)row.FindControl("txtUnitPrice")).Text;




                    _ht["p_id_list"] = gvwList.DataKeys[row.RowIndex][0].ToString(); 
                    _ht["p_pq_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][2].ToString(); 
                    _ht["p_currency_code"] = ddlCurrencyCode.SelectedValue;
                    _ht["p_payment_methode_code"] = "DEBIT";
                    _ht["p_supplier_code"] = txtSupplierCode;
                    _ht["p_warranty_month"] = 0;
                    _ht["p_tax_code"] = "TS00001";
                    _ht["p_warranty_part_month"] = 0;
                    _ht["p_quantity"] = txtQuantity;
                    _ht["p_approval_po_quantity"] = 0;
                    _ht["p_unit_code"] = gvwList.DataKeys[row.RowIndex][3].ToString();
                    _ht["p_unit_price"] = txtUnitPrice;
                    _ht["p_remarks"] = "-";

                    Shared.ApplyDefaultProp(_ht);
                    
                    _dal.ExecRawSP("xsp_purchase_quotation_detail_list_update", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("purchasequotationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
            BindQuotationDetail();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void CopyDataDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;


        if (!SelectedExist())
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
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                     
 
                    _ht["p_id_list"] = gvwList.DataKeys[row.RowIndex][0].ToString();
 
                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_purchase_quotation_detail_copy", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("purchasequotationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
            BindQuotationDetail();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindQuotationDetail();
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtSupplierCode = (TextBox)e.Row.FindControl("txtSupplierCode");
            Label lblSupplierName = (Label)e.Row.FindControl("lblSupplierName");
            TextBox txtQuantity = (TextBox)e.Row.FindControl("txtQuantity");
            DropDownList ddlCurrencyCode = (DropDownList)e.Row.FindControl("ddlCurrencyCode");
            TextBox txtUnitPrice = (TextBox)e.Row.FindControl("txtUnitPrice");

            Shared.BindCurrencyCode(ddlCurrencyCode);
            ddlCurrencyCode.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CURRENCY_CODE"));
            txtSupplierCode.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SUPPLIER_CODE"));
            lblSupplierName.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SUPPLIER_NAME"));
            txtQuantity.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QUANTITY"));
            txtUnitPrice.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UNIT_PRICE"));

            LinkButton btnLookUp = (LinkButton)e.Row.FindControl("btnLookUpSupplierID");
            btnLookUp.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSUPL&acol_0={0}&bcol_1={1}&parc_item_group={2}');", txtSupplierCode.ClientID, lblSupplierName.ClientID, txtItemGroup.ClientID);
            if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ON-PROGRESS")
            {
                //btnLookUp.Enabled = false;
                txtQuantity.Enabled = false;
                ddlCurrencyCode.Enabled = false;
                txtUnitPrice.Enabled = false;
            }
        }
       
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchasequotationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&groupcode=" + txtItemGroup.Text );
    }
    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {
        SaveDataDetail();
    }
    protected void btnCopy_Click(object sender, EventArgs e)
    {
        CopyDataDetail();
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

        BindQuotationDetail();

    }

    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
        BindQuotationDetail();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("purchasequotationheaderlistheader.aspx?action=edit&idlist={0}&codebarcode={1}",gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
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
            _ht["p_pq_code"] = lblCodeBarcode.Text;
            //_ht["p_id"] = Request.Params["codebarcode"];

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

    private void UpdateDataDetail(string PQ_CODE, string GENERAL_DOC_CODE, string FILE_NAME, string PATHS, string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_pq_code"] = PQ_CODE;
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
        //Response.Redirect("purchasequotationreviewdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
        Response.Redirect("purchasequotationdocumentdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text + "&flagprocess=" + lblTransFlagCode.Text);
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
                        string sFullPath = filePath + '/' + sFileName;

                        if (!System.IO.Directory.Exists(filePath))
                            System.IO.Directory.CreateDirectory(filePath);

                        if (!System.IO.File.Exists(sFullPath))
                            fupFile.SaveAs(sFullPath);

                        sFullPath = Shared.GetUploadPath("ADD_DOCUMENT/" + lblCodeBarcode.Text) + sFileName;
                        UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["PQ_CODE"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());

                    }
                    else
                    {
                        Shared.ShowValidationError(this, "Please upload file with format type (.pdf .zip .doc .xlx .png .jpg .jpeg). Max file size allowed is 3 mb.");
                        return;
                    }

                    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

                    int fileSize = fupFile.PostedFile.ContentLength;

                    if (fupFile.PostedFile.ContentLength > 3000000) // (+) Ari 13-09-2022 ket : cek size file Max 3MB.
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "fx", "fnShowErrorNotif('Maximum file size allowed is 3 mb.', '');", true);
                        return;
                    }

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
                        string PQR_CODE = (string)gvwListDocReq.DataKeys[rowIndex][1];
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
   
}      
  

