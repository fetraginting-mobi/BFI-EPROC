using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_returnperalatankerja : BasePage
{
    private static string TABLE_NAME_HEADER = "RETURN_PERALATAN_KERJA_HEADER";
    private static string TABLE_NAME_DETAIL = "RETURN_PERALATAN_KERJA_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            btnBack.Text = "<i class=\"icon-arrow-left\"></i> Back";
            btnBack.CssClass = "btn btn-custome";
            //txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            txtEmpCode.Text = Shared.CurrentUID;
            btnLookUpBranch.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRN&acol_0={0}&bcol_1={1}&parc_code={2}');", txtBranchCode.ClientID, lblBranchName.ClientID, txtEmpCode.ClientID);
            //btnLookUpStaff.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STALL&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtStaffCode.ClientID, lblStaffName.ClientID, txtBranchCode.ClientID);
            btnLookUpStaff.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STALL&acol_0={0}&bcol_1={1}&ccol_2={2}&ccol_3={3}&ccol_4={4}&ccol_5={5}&parc_branch_code={6}');", txtStaffCode.ClientID, lblStaffName.ClientID, lblDepartment.ClientID, lblUnits.ClientID, lblDivision.ClientID, lblPosition.ClientID, txtBranchCode.ClientID);

            txtReqDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            
            if (Request.Params["action"].Equals("edit"))
            {

                LoadData();
                BindData();
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
                btnCancel.OnClientClick = "return confirm('Apakah Data Ingin Dicancel? Jika Ya Silahkan Tekan OK Untuk Melanjutkan Proses');";
                btnPost.Visible = true;
                btnPrint.Visible = true;
                btnCancel.Visible = true;
                //btnCancel.Visible = true;
                pnl.Visible = true;
                //btnAdd.Visible = false; // (+) Ari 20-01-2023 ket : enhancement 2023
                //lblReturnNo.Enabled = false;

                if (string.IsNullOrEmpty(lblPaths.Text) | lblPaths.Text == "-")
                {
                    btnPreview.Visible = false;
                }

                if (lblStatus.Text == "POST")
                {
                    btnCancel.Visible = false;
                    btnPrint.Visible = true;
                    btnPost.Visible = false;
                    btnSave.Visible = false;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    btnLookUpBranch.Enabled = false;
                    btnLookUpStaff.Enabled = false;
                    fuInvoice.Enabled = false;
                    txtReqDate.Enabled = false;
                    ddlResult.Enabled = false;
                    txtRemarks.Enabled = false;
                }
                else if (lblStatus.Text != "NEW")
                {
                    btnCancel.Visible = false;
                    btnPrint.Visible = false;
                    btnPost.Visible = false;
                    btnSave.Visible = false;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                    pnlupload.Visible = false;
                    btnLookUpBranch.Enabled = false;
                }
                else
                {
                    btnLookUpBranch.Enabled = false;
                    btnLookUpStaff.Enabled = false;
                }
            }
            else
            {
                btnPost.Visible = false;
                btnPrint.Visible = false;
                btnBack.Visible = true;
                pnl.Visible = false;
                btnPreview.Visible = false;
                btnCancel.Visible = false;
                pnlupload.Visible = false;

            }
            //txtBranch.Text = Shared.CurrentEmployeeBranchCode;
        }


        // btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000033&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "VERIFI", lblBranchCode.ClientID, lblCode.ClientID);
        //btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        //btnUnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000034&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "UN-POST", lblBranchCode.ClientID, lblCode.ClientID);
        //btnLookUpStaff.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STALL&acol_0={0}');", lblStaffName.ClientID);
        //btnLookUpStaff.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STALL&acol_0={0}&parc_branch_code={1}');", lblStaffName.ClientID, lblBranchCode.ClientID);
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

            _ht["p_return_no"] = Request.Params["return_no"];
            DataRow _dr = _dal.GetRow("", "xsp_return_peralatan_kerja_header_getrow", _ht);

            DBToUI.Map(this.Controls, _dr);
            //gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            Shared.ApplyDefaultProp(_ht);
            _ht["p_return_no"] = lblReturnNo.Text;
            //_ht["p_return_date"] = Shared.ToDateTime(txtReqDate.Text);
            //_ht["p_staff"] = txtStaffCode.Text;
            //_ht["p_status"] = "CANCEL";
            //_ht["p_receipt"] = lblReceipt.Text;
            //_ht["p_paths"] = lblPaths.Text;
            //_ht["p_remarks"] = txtRemarks.Text;

            _dal.ExecRawSP("xsp_return_peralatan_kerja_header_cancel", _ht);
            //_dal.Update(TABLE_NAME_HEADER, _ht);
        }
        catch(Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
            return;
        }

      Shared.ShowSuccessGritter(this, string.Format("returnperalatankerja.aspx?action=edit&return_no={0}", lblReturnNo.Text));
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("returnperalatankerjalist.aspx");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
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

            //MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_return_date"] = Shared.ToDateTime(txtReqDate.Text);
            _ht["p_staff"] = txtStaffCode.Text;
            //_ht["p_status"] = lblStatus.Text;
            _ht["p_remarks"] = txtRemarks.Text;
            _ht["p_branch_code"] = txtBranchCode.Text;
            _ht["p_result"] = ddlResult.SelectedValue;

            string sFileType = System.IO.Path.GetExtension(fuInvoice.FileName);

            if (fuInvoice.HasFile)
            {
                if (
                    sFileType == ".xls" || sFileType == ".xlsx"     // EXCEL
                    || sFileType == ".doc" || sFileType == ".docx"     // WORD
                    //|| sFileType == ".ppt" || sFileType == ".pptx"     // Powepoint
                    //|| sFileType == ".one" || sFileType == ".txt"      // OneNote & Notepad
                    || sFileType == ".jpeg" || sFileType == ".jpg"      // Image
                    || sFileType == ".png" //|| sFileType == ".gif"
                    || sFileType == ".pdf" //|| sFileType == ".csv"      // PDF
                    || sFileType == ".zip" || sFileType == ".rar"      // File
                    || sFileType == ".7z"

                    )
                {

                    string sFileName = System.IO.Path.GetFileName(fuInvoice.FileName);
                    string sFilePath = Shared.GetUploadPath("FA_RETURN_PERALATAN_KERJA/DOCUMENT") + lblReturnNo.Text + "/";

                    _ht["p_receipt"] = sFileName;
                    _ht["p_paths"] = sFilePath + sFileName;

                    string sFileDirectory = Server.MapPath("~/" + sFilePath);
                    string sFileFullPath = sFileDirectory + sFileName;

                    if (!System.IO.Directory.Exists(sFileDirectory))
                        System.IO.Directory.CreateDirectory(sFileDirectory);

                    if (!System.IO.File.Exists(sFileFullPath))
                        fuInvoice.SaveAs(sFileFullPath);


                    int fileSize = fuInvoice.PostedFile.ContentLength;

                    if (fuInvoice.PostedFile.ContentLength > 3000000) // (+) Ari 13-09-2022 ket : cek size file Max 3MB.
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "fx", "fnShowErrorNotif('Maximum file size allowed is 3 mb.', '');", true);
                        return;
                    }

                    //if (!Shared.CheckFileUploadSize(this, fuInvoice)) // Cek Size
                    //{
                    //    return;
                    //}


                    if (!string.IsNullOrEmpty(lblPaths.Text) & !string.IsNullOrEmpty(lblReceipt.Text))
                    {
                        if (!sFileName.Equals(lblReceipt.Text))
                        {
                            string sFilePathOld = Server.MapPath("~/" + lblPaths.Text);

                            System.IO.File.Delete(sFilePathOld);
                        }
                    }

                    lblReceipt.Text = sFileName;
                    lblPaths.Text = sFilePath + sFileName;
                }
                else
                {
                    //Shared.ShowValidationError(this, "Please upload file with format type (.pdf .zip .doc .xlx .png .jpg .jpeg)");
                    Shared.ShowValidationError(this, "Please upload file with format type (.pdf .zip .doc .xlx .png .jpg .jpeg). Max file size allowed is 3 mb.");
                    return;
                }
            }


            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblReturnNo.Text = sNextBarcode;
            }
            else
            {
                if (string.IsNullOrEmpty(lblReceipt.Text) | lblReceipt.Text == "-")
                {
                    _ht["p_receipt"] = "-";
                    _ht["p_paths"] = "-";
                }
                else
                {
                    _ht["p_receipt"] = lblReceipt.Text;
                    _ht["p_paths"] = lblPaths.Text;
                }

                _ht["p_return_no"] = lblReturnNo.Text;
                _dal.Update(TABLE_NAME_HEADER, _ht);
            }

            Shared.ShowSuccessGritter(this, string.Format("returnperalatankerja.aspx?action=edit&return_no={0}", lblReturnNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
            return;
        }
    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(lblPaths.Text) | lblPaths.Text == "-")
        {
            Shared.ShowValidationError(this, "Please Upload Tanda Terima.");
            return;
        }
        else if (gvwList.Rows.Count == 0)
        {
            Shared.ShowValidationError(this, "Item Not Found !");
            return;
        }
        else
        {
            Post();
        }
    }
    private void Post()
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            Shared.ApplyDefaultProp(_ht);
            _ht["p_return_no"] = lblReturnNo.Text;
            //_ht["p_return_date"] = Shared.ToDateTime(txtReqDate.Text);
            //_ht["p_staff"] = txtStaffCode.Text;
            //_ht["p_status"] = "POST";
            //_ht["p_receipt"] = lblReceipt.Text;
            //_ht["p_paths"] = lblPaths.Text;
            //_ht["p_remarks"] = txtRemarks.Text;
            //_ht["p_result"] = ddlResult.SelectedValue;

            //_dal.Update(TABLE_NAME_HEADER, _ht);
            _dal.ExecRawSP("xsp_return_peralatan_kerja_header_post", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        Shared.ShowSuccessGritter(this, string.Format("returnperalatankerja.aspx?action=edit&return_no={0}", lblReturnNo.Text));
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Report", "window.open('../../" + lblPaths.Text + "', 'report', 'fullscreen=0, menubar=0, status=0, scrollbars=0, resizable=1, toolbar=0, width=600, height=400');", true);
    }


    protected void btnPrint_Click(object sender, EventArgs e)
    {
        if (gvwList.Rows.Count == 0)
        {
            Shared.ShowValidationError(this, "Item Not Found !");
            return;
        }
        else
        {
            Print();
        }

    }
    private void Print()
    {
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_return_no"] = lblReturnNo.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_RETURN_PERALATAN_KERJA", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("returnperalatankerjadetail.aspx?action=add&return_no=" + lblReturnNo.Text + "&ket=" + "return" + "&staff_code=" + txtStaffCode.Text);
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
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {

            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_return_no"] = Request.Params["return_no"];
            _ht["p_keywords"] = txtSearch.Text;

            gvwList.DataSource = _dal.GetRows("", "xsp_return_peralatan_kerja_detail_getrows", _ht);
            gvwList.DataBind();
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
            Shared.ShowSuccessGritter(this, string.Format("returnperalatankerja.aspx?action=edit&return_no={0}", lblReturnNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("returnperalatankerjadetail.aspx?action=edit&return_no=" + Request.Params["return_no"] + "&id=" + gvwList.SelectedDataKey[0].ToString() + "&ket=" + "return" + "&status=" + lblStatus.Text);
    }
    protected void ddlResult_SelectedIndexChanged(object sender, EventArgs e)
    { 
    
    }
}
