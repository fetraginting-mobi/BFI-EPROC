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

public partial class module_purchaseorder_purchaserequestheader : BasePage
{
    private static string TABLE_NAME_HEADER = "PURCHASE_REQUEST_HEADER";
    private static string TABLE_NAME_DETAIL = "PURCHASE_REQUEST_DETAIL";
    private static string GET_MULTIPLE_BRANCH = "GET_IS_AGAS"; // (+) Ari 04-07-2022 ket : enhancement 2022
    private static string TABLE_NAME_DOC_DETAIL = "PURCHASE_REQUEST_DOCUMENT";

    protected void Page_Load(object sender, EventArgs e)
    {
        lblCodeBarcode.Text = Request.Params["codebarcode"];
        LoadInit();


        if (!Page.IsPostBack)
        {
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindEmpBranch(ddlBranch);
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;

            btnLookUpRequestoro.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=RQST&acol_0={0}&bcol_1={1}&ccol_2={2}&ccol_3={3}&ccol_4={4}&parc_requestor={5}&parc_branch_code={6}');", txtRequestorCode.ClientID, lblRequestorName.ClientID, ddlBranch.ClientID, ddlDepartment.ClientID, ddlDivision.ClientID, txtEntry.ClientID, txtBranch.ClientID);
            btnLookUpParentGroup.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LFIP&acol_0={0}&bcol_1={1}');", txtParentGroup.ClientID, lblParentGroup.ClientID);

           
            //BindDataDocRequest();
           
          
			btnDelete.OnClientClick = "return confirm('Delete selected data?');";
            Shared.BindGeneralSubCode(ddlRequirementType, "RR");

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindPRDetail();
                BindDataDocRequest();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";

                
               
                //ddlType.Enabled = false;
                btnPrint.Visible = false;
                ddlBranch.Enabled = false;
               
                txtRequestDate.Enabled = false;
                chbIsPromotion.Enabled = false;
                btnLookUpParentGroup.Enabled = false;
                ddlBranch.Enabled = false;

                if (ddlReq.SelectedValue == "N")
                {
                    txtEstimasi.Visible = false;
                    txtEstimasi.Text = "0";
                    rfvEstimasi.Enabled = false;
                    EBY.Visible = false;
                    IGP.Visible = false;
                }
                if (ddlReq.SelectedValue == "P")
                {
                    txtEstimasi.Visible = true;
                    rfvEstimasi.Enabled = true;
                    EBY.Visible = true;
                    IGP.Visible = true;
                }

                if (chbIsPromotion.Checked)
                {
                    btnLookUpParentGroup.Visible = true;
                    IGP.Visible = true;
                    btnAdd.Visible = false;
                }
                else
                {
                    btnLookUpParentGroup.Visible = false;
                    IGP.Visible = false;
                }

                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                //lblApprovalRequestTargetID.Text = Request.Params["idartarget"];


                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "PROCESSED" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "VERIFIED" || lblTransFlagCode.Text == "REJECTED" )
                {
                    btnSave.Visible = btnPost.Visible = btnCancelReq.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    txtRemarks.Enabled = false;
                    txtRequestDate.Enabled = false;
                    //txtTermsOfPayment.Enabled = false;
                    btnPrint.Visible = true;
                    gvwList.Columns[1].Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    //ddlSubBranch.Enabled = false;
                    ddlRequirementType.Enabled = false;
                    btnLookUpRequestoro.Enabled = false;
                    ddlRequirementType.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlReq.Enabled = false;
                    //btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;
                    
                }
                else if (lblTransFlagCode.Text == "PENDING")
                {
                    btnSave.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    txtRemarks.Enabled = false;
                    txtRequestDate.Enabled = false;
                    //txtTermsOfPayment.Enabled = false;
                    btnPrint.Visible = true;
                    gvwList.Columns[1].Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    //ddlSubBranch.Enabled = false;
                    ddlRequirementType.Enabled = false;
                    btnLookUpRequestoro.Enabled = false;
                    ddlRequirementType.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlReq.Enabled = false;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;
                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnCancelReq.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    txtRemarks.Enabled = false;
                    txtRequestDate.Enabled = false;
                    //txtTermsOfPayment.Enabled = false;
                    btnPrint.Visible = true;
                    gvwList.Columns[1].Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    //ddlSubBranch.Enabled = false;
                    ddlRequirementType.Enabled = false;
                    btnLookUpRequestoro.Enabled = false;
                    btnPost.Visible = false;
                    //ddlSubBranch.Enabled = false;
                    ddlRequirementType.Enabled = false;
                    ddlReq.Enabled = false;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;



                    if (!lblApprovalRequestTargetID.Text.Equals(""))
                        btnApprovalTiered.Visible = true;
                    btnCancel.Visible = false;

                }
                else if (lblTransFlagCode.Text == "NEW") // (+) Ari 30-06-2022 ket : enhancement 2022
                {
                    // (+) Ari 30-06-2022 ket : enhancement 2022 (jika Role Flag Is Agas bisa edit ddlBranch)
                    if (lblIsAgas.Text == "1")
                    {
                        ddlBranch.Enabled = true;
                    }
                }

            }


            else //if (Request.Params["action"].Equals("add"))
            {
                LoadDataagas(); // (+) Ari 04-07-2022 ket : enhancement 2022
                lblRequestorUID.Text = Shared.CurrentUID;
                lblEntry.Text = Shared.CurrentEmpName;
                txtEntry.Text = Shared.CurrentUID;
                txtRequestorCode.Text = Shared.CurrentUID;
                lblRequestorName.Text = Shared.CurrentEmpName;
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
              
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;


                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                ddlSubDepartment.SelectedValue = Shared.CurrentEmployeeSubDepartmentCode;
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                

                btnPrint.Visible = false;
                btnCancelReq.Visible = btnPost.Visible = false;
                btnAdd.Visible = btnDelete.Visible = false;
                pnlItemList.Visible = false;
                EBY.Visible = false;
                IGP.Visible = false;
                txtRequestDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtRequestDate.Enabled = false;
                ddlBranch.Enabled = false;

                // (+) Ari 30-06-2022 ket : enhancement 2022 (jika Role Flag Is Agas bisa edit ddlBranch)
                if (lblIsAgas.Text == "1")
                {
                    ddlBranch.Enabled = true;
                }

            }
          
        }


        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/purchaserequestheaderlist.aspx";

        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000001&parc_object_id={0}&nexturl={1}&spname={2}&status={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}');", lblNo.ClientID, HttpUtility.UrlEncode(Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY].ToString()), "xsp_application_approve_comment_insert", "APPROVED", lblTotal.ClientID, lblbranch.ClientID, txtRemarks.ClientID);
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000001&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "PROCESSED", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnCancelReq.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000002&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
        LoadAfterInit();

    }

    protected void txtRequestorCode_TextChanged(object sender, EventArgs e)
    {
        //

        //ddlDepartment.SelectedValue = // (+) Ari 28-07-2022 ket : enhancement 2022
        
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
            _ht["p_user_id"] = Shared.CurrentUID;
            Shared.ApplyDefaultProp(_ht);
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            DBToUI.Map(this.Controls, _dr);


            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
            Shared.BindBranchEmployee(ddlBranch);


            ddlBranch.SelectedValue = _dr["BRANCH_CODE"].ToString();
            ddlDivision.SelectedValue = _dr["DIVISION_CODE"].ToString();
            ddlDepartment.SelectedValue = _dr["DEPARTMENT_CODE"].ToString();
            ddlSubDepartment.SelectedValue = _dr["SUB_DEPARTMENT_CODE"].ToString();
            ddlUnits.SelectedValue = _dr["UNITS_CODE"].ToString();
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
            lblIsAgas.Text = _dr.ItemArray[0].ToString();


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
                lblCodeBarcode.Text = sNextBarcode;
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaserequestheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
        Response.Redirect("purchaserequestheaderlist.aspx");
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


    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        //Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);

        //updDep.Update();
    }

    protected void chbIsPromotion_CheckedChanged(object sender, EventArgs e)
    {
        if (chbIsPromotion.Checked)
        {
            IGP.Visible = true;
            //btnLookUpParentGroup.Visible = true;
            //lblParentGroup.Visible = true;
            //lblPlafond.Visible = true;
        }
        else
        {
            IGP.Visible = false;
        }
    }
    

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_code_barcode"] = lblCodeBarcode.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_PURCHASE_REQUEST_ROUTINE", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }
    protected void ddlReq_SelectedIndex(object sender, EventArgs e)
    {
        if (ddlReq.SelectedValue == "N")
        {
            txtEstimasi.Visible = false;
            txtEstimasi.Text = "0";
            EBY.Visible = false;
        }
        if (ddlReq.SelectedValue == "P")
        {
            txtEstimasi.Visible = true;
            txtEstimasi.Text = "0";
            EBY.Visible = true;
        }
    }
   
    #region PR Detail
    private void BindPRDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchList.Text;
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
        BindPRDetail();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchaserequestdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
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

        BindPRDetail();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindPRDetail();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("purchaserequestdetail.aspx?action=edit&id={0}&codebarcode={1}&status={2}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, lblTransFlagCode.Text));
    }

     

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //
        if (e.Row.RowType == DataControlRowType.DataRow)
        {    
            TextBox tx = (TextBox)e.Row.FindControl("txtItemCode");
            Label lbl = (Label)e.Row.FindControl("lblItemCode");
            Label lblM = (Label)e.Row.FindControl("lblMerkName");
           // string aa = tx.ClientID;
           // tx.Text = aa;
            lbl.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ITEM_NAME"));
            lblM.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MERK_NAME"));
            LinkButton btn = (LinkButton)e.Row.FindControl("btnTestLookUP");
            btn.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MITEM&acol_0={0}&bcol_1={1}&ccol_2={2}');", tx.ClientID, lbl.ClientID,lblM.ClientID);
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
            _ht["p_pr_code"] = lblCodeBarcode.Text;
            _ht["p_id"] = Request.Params["id"];

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

    private void UpdateDataDetail(string PR_CODE, string GENERAL_DOC_CODE, string FILE_NAME, string PATHS, string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_pr_code"] = PR_CODE;
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
        Response.Redirect("purchaserequestdocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text + "&flagprocess=" + lblTransFlagCode.Text);
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
                                UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["PR_CODE"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());
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
