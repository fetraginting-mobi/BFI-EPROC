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

public partial class module_purchaseorder_purchaseticketheader : BasePage
{
    private static string TABLE_NAME_HEADER = "PURCHASE_TICKET_HEADER";
    private static string TABLE_NAME_DETAIL = "PURCHASE_TICKET_DETAIL";
    private static string TABLE_NAME_DOC_DETAIL = "PURCHASE_TICKET_DOCUMENT";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["barcode"]);

        if (!Page.IsPostBack)
        {
            //btnLookUpRequestor.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STAFF&acol_0={0}&bcol_1={1}');", txtRequestorCode.ClientID, lblRequestorName.ClientID);
            Shared.BindBranchEmployee(ddlBranch);
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;

            btnAddAdDep.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=PTREF&parc_code_barcode={0}&gvw={1}&parc_branch={2}');", txtCode.ClientID, btnSearch.UniqueID, txtBranch.ClientID);

            btnDelete.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataDocRequest();
                BindDetail();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                ddlBranch.Enabled = false;
                ddlType.Enabled = false;
                txtTrxDate.Enabled = false;
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
                if (lblTransFlagCode.Text == "NEW" )
                {
                    btnReject.Visible = false;
                    btnRefund.Visible = false;
                    btnConfirm.Visible = false;

                    if (ddlType.SelectedValue == "RET")
                    {

                        btnAddAdDep.Visible = true;
                        btnAdd.Visible = false;
                        gvwList.Columns[9].Visible = true;
                        gvwList.Columns[8].Visible = false;
                        gvwList.Columns[10].Visible = false;
                    }

                    else
                    {
                        btnAddAdDep.Visible = false;
                        btnAdd.Visible = true;
                        gvwList.Columns[8].Visible = false;
                        gvwList.Columns[9].Visible = false;
                    }

                    
                }


                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "REJECTED" || lblTransFlagCode.Text == "REFUND" || lblTransFlagCode.Text == "ONPROGRESS" || lblTransFlagCode.Text == "CANCEL")
                {
                        btnSave.Visible = btnPost.Visible = false;
                        btnAdd.Visible = btnDelete.Visible = false;
                        btnAddAdDep.Visible = false;
                        txtRemarks.Enabled = false;
                        btnAddAdDep.Visible = false;
                        btnAddDocument.Visible = false;
                        btnSaveDocumentDetail.Visible = false;
                        gvwListDocReq.Columns[4].Visible = false;
                        

                        if (lblTransFlagCode.Text == "ONPROGRESS")
                        {
                            btnAddDocument.Visible = true;
                            btnSaveDocumentDetail.Visible = true;
                        }
                      


                        if (txtBranch.Text == "KPO" || txtUnits.Text == "S0922")
                        {

                            btnReject.Visible = true;
                            btnRefund.Visible = true;
                            btnConfirm.Visible = false;
                            btnAddAdDep.Visible = false;
                          
                            if (ddlType.SelectedValue == "RET")
                            {
                                btnConfirm.Visible = true;
                                btnRefund.Visible = false;
                                btnReject.Visible = false;
                                btnAddAdDep.Visible = false;
                                btnAdd.Visible = false;

                                gvwList.Columns[9].Visible = true;
                                gvwList.Columns[8].Visible = true;
                                gvwList.Columns[10].Visible = false;
                                if (lblTransFlagCode.Text == "REFUND")
                                {
                                    btnConfirm.Visible = true;
                                    
                                }

                                if (txtStatus.Text == "REJECTED")
                                {
                                    btnAdd.Visible = false;
                                    btnReject.Visible = false;
                                    btnAddAdDep.Visible = false;

                                }

                              
                            }

                            else
                            {
                                btnAddAdDep.Visible = false;
                                btnAdd.Visible = true;
                                gvwList.Columns[9].Visible = false;
                                gvwList.Columns[8].Visible = false;
                            }

                            if (lblTransFlagCode.Text == "REFUND")
                            {
                                btnConfirm.Visible = false;

                            }

                            if (txtStatus.Text == "REJECTED")
                            {
                                btnAdd.Visible = false;
                                btnReject.Visible = false;

                            }

                            if (txtStatus.Text == "POST")
                            {
                                btnAdd.Visible = false;
                              

                            }



                            
                        }

                       
                        else
                        {

                            btnReject.Visible = false;
                            btnRefund.Visible = false;
                            btnConfirm.Visible = false;

                           // gvwList.Columns[8].Visible = false;
                            //gvwList.Columns[8].Visible = false;
                           // btnAddAdDep.Visible = false;
                        }
                    
                }
               
                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;
                //btnConfirm.Visible = false;
            }
            else
            {
                btnPost.Visible = btnReject.Visible = false;
                btnAdd.Visible = btnDelete.Visible = false;
                btnRefund.Visible = false;
                //detail.Visible = false;
                txtTrxDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtTrxDate.Enabled = false;
                pnlItemList.Visible = false;
                
                
            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/purchaseticketheaderlist.aspx";
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0063&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
       // btnApprove.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0063&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "APPROVED", lblbranch.ClientID);
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0062&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "REJECT" , ddlBranch.ClientID);
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

            _ht["p_barcode"] = Request.Params["barcode"];

            Shared.ApplyDefaultProp(_ht);
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            DBToUI.Map(this.Controls, _dr);

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

            Shared.ShowSuccessGritter(this, string.Format("purchaseticketheader.aspx?action=edit&barcode={0}", lblCodeBarcode.Text));
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
        Response.Redirect("purchaseticketheaderlist.aspx");
    }

    #region Ticket Detail
    private void BindDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_barcode"] = lblCodeBarcode.Text;

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
        BindDetail();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchaseticketdetail.aspx?action=add&barcode=" + lblCodeBarcode.Text + "&type=" + ddlType.SelectedValue);
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

        BindDetail();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindDetail();
    }

     private void Refund()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
       

        if (!SelectedExist())
        {
            Exception ex=null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }
         
        _dal = new GeneralDAL();
        _ht = new Hashtable();

            foreach (GridViewRow row in gvwList.Rows)
            {

                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                   

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_purchase_ticket_detail_refund", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("purchaseticketheader.aspx?action=edit&barcode={0}", lblCodeBarcode.Text));
        
            BindDetail();
        }

     private void Reject()
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

         foreach (GridViewRow row in gvwList.Rows)
         {

             CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
             if (chb.Checked)
             {
                 _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();


                 Shared.ApplyDefaultProp(_ht);

                 _dal.ExecRawSP("xsp_purchase_ticket_detail_reject", _ht);
             }
         }

         Shared.ShowSuccessGritter(this, string.Format("purchaseticketheader.aspx?action=edit&barcode={0}", lblCodeBarcode.Text));

         BindDetail();
     }

     private void Confirm()
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
                    
                     DateTime Date = Shared.ToDateTime(((TextBox)row.Cells[8].Controls[1]).Text);



                     _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                   
                     _ht["p_refund_date"] = Date;


                     //if (AuthorityBranch.Checked == true)
                     //    _ht["p_is_authority_branch"] = "1";
                     //else
                     //    _ht["p_is_authority_branch"] = "0";

                     Shared.ApplyDefaultProp(_ht);

                     _dal.ExecRawSP("xsp_purchase_ticket_detail_confirm", _ht);
                 }
             }

             Shared.ShowSuccessGritter(this, string.Format("purchaseticketheader.aspx?action=edit&barcode={0}", lblCodeBarcode.Text));
             BindDetail();
         }
         catch (Exception ex)
         {
             Shared.ShowErrorDialog(this, ex);
         }
      
     }




     protected void gvwList_OnRowDataBound(object sender, GridViewRowEventArgs e)
     {

         if (e.Row.RowType == DataControlRowType.DataRow)
         {
             GeneralDAL _dal = null;
             Hashtable _ht = null;
             try
             {
                 _dal = new GeneralDAL();
                 _ht = new Hashtable();


                 TextBox txtConfirmDate = (e.Row.FindControl("txtReceiveDate") as TextBox);


                 if (txtStatus.Text == "RETURNED")
                 {
                     txtConfirmDate.Enabled = false;

                 }
                 if (txtStatus.Text == "ON-PROGRESS")
                 {
                     txtConfirmDate.Enabled = false;

                 }

                 LinkButton btn4 = e.Row.FindControl("btnViewDocument") as LinkButton;
                 btn4.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/cancelledticket.aspx?action=edit&status=POST&code_booking={0}');", gvwList.DataKeys[e.Row.RowIndex][1].ToString());

                 




             }
             catch (Exception)
             {

             }
         }
     }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("purchaseticketdetail.aspx?action=edit&id={0}&barcode={1}&status={2}&type={3}&idtarget={4}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, lblTransFlagCode.Text, ddlType.SelectedValue, Request.Params["idartarget"]));
    }
    protected void btnReject_Click(object sender, EventArgs e)
    {
        Reject();
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        Confirm();
    }
    protected void btnRefund_Click(object sender, EventArgs e)
    {
        Refund();
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
            // _ht["p_fa_code"] = lblFaSaleCode.Text;
            _ht["p_code_barcode"] = Request.Params["barcode"];
           
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

    private void UpdateDataDetail(string TRX_CODE, string GENERAL_DOC_CODE, string FILE_NAME, string PATHS, string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_trx_code"] = TRX_CODE;
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

    protected void btnAddDocument_Click(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("purchaseticketdocument.aspx?action=add&id" + Request.Params["id"] + "&trxcode=" + lblCodeBarcode.Text + "&iddetail=" + Request.Params["id"] + "&code=" + lblCode.Text);
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
                            UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["TRX_CODE"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());
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

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "PROCESSED" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ONPROGRESS" || lblTransFlagCode.Text == "REJECTED")
                {
                    btnDelete.Enabled = false;

                }

                FileName = gvwListDocReq.DataKeys[e.Row.RowIndex]["PATHS"].ToString();
                btnPreview.Attributes["onclick"] = "javascript:window.open('../../" + FileName + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";
            }
            else
            {
                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[3];

                btnPreview.Enabled = false;
                btnDelete.Enabled = false;
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
