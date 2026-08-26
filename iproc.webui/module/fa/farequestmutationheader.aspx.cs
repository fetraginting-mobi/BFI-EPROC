using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_farequestmutationheader : BasePage
{
    private static string TABLE_NAME_DETAIL = "FA_REQUEST_MUTATION_DETAIL";
    private static string TABLE_NAME_HEADER = "FA_REQUEST_MUTATION_HEADER";
    private static string TABLE_NAME_POST_HISTORY = "INVENTORY_POST_MUTATION_UPLOAD_HISTORY";
    private static Boolean EMPLOYEE_HO = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        txtBranch.Text = Shared.CurrentEmployeeBranchCode;
        EMPLOYEE_HO = IsEmployeeHo(txtBranch.Text);

        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            txtBranchRequest.Text = Shared.CurrentEmployeeBranchCode;
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindBranchEmployeeAll1SEL(ddlTocc);
            Shared.BindFaLocationAllMut(ddlToLocationCode, ddlTocc.SelectedValue);
            Shared.BindUnitsItemOwnMutation(ddlOwner);

            //(+)gustian 19102023 
            if (EMPLOYEE_HO)
            {
                Shared.BindFaLocationAllMut(ddlFromLocationCode, txtBranch.Text);
            }
            else
            {
                Shared.BindFaLocationAllMut(ddlFromLocationCode, ddlBranch.SelectedValue);
            }
            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
                SetMutationUploadLogVisibility();

                btnDeleteRequestDetail.OnClientClick = "return confirm('Delete selected data?');";
                txtRequestDate.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";

                ddlBranch.Enabled = false;
                ddlUnits.Enabled = false;
                ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = false;
                ddlFromLocationCode.Enabled = false;
                ddlToLocationCode.Enabled = false;
                ddlOwner.Enabled = false;
                ddlTocc.Enabled = false;

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "PENDING")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddRequestDetail.Visible = btnDeleteRequestDetail.Visible = false;
                    txtRemarks.Enabled = false;
                    txtRequestDate.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlBranch.Enabled = false;
                    ddlUnits.Enabled = false;
                    btnPost.OnClientClick = "";
                    ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = false;
                    ddlFromLocationCode.Enabled = false;
                    ddlToLocationCode.Enabled = false;
                    ddlTocc.Enabled = false;
                }
            }
            else
            {
                lblRequestor.Text = Shared.CurrentEmpName;
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                Shared.BindBranchEmployeeAll1SEL(ddlTocc);
                Shared.BindFaLocationAllMut(ddlToLocationCode, ddlTocc.SelectedValue);

                //(+)gustian 19102023 
                if (EMPLOYEE_HO)
                {
                    Shared.BindFaLocationAllMut(ddlFromLocationCode, txtBranch.Text);
                }
                else
                {
                    Shared.BindFaLocationAllMut(ddlFromLocationCode, ddlBranch.SelectedValue);
                }

                btnReject.Visible = btnPost.Visible = false;
                btnAddRequestDetail.Visible = btnDeleteRequestDetail.Visible = false;
                pnlInventoryRequest.Visible = false;
                txtRequestDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtRequestDate.Enabled = false;
                SetMutationUploadLogVisibility();
            }
        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/fa/farequestmutationheaderlist.aspx";

        btnPost.Attributes.Remove("href");
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0068&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);

        if (Request.Params["action"] != null && Request.Params["action"].Equals("edit"))
        {
            if (lblProcess != null && (lblProcess.Text.Trim().ToUpper() == "UPLOAD" || lblProcess.Text.Trim().ToUpper() == "UPL"))
            {
                //btnSave.Visible = false;
                btnPost.Visible = false;
                btnReject.Visible = false;
                btnAddRequestDetail.Visible = false;
                btnDeleteRequestDetail.Visible = false;
                //txtRemarks.Enabled = false;
                txtRequestDate.Enabled = false;
                if (gvwList != null && gvwList.Columns.Count > 1)
                {
                    gvwList.Columns[1].Visible = false;
                }
            }
        }
        LoadAfterInit();
    }

    private void SetMutationUploadLogVisibility()
    {
        bool isUploadProcess = lblProcess.Text.Trim().Equals("UPLOAD", StringComparison.OrdinalIgnoreCase)
            || lblProcess.Text.Trim().Equals("UPL", StringComparison.OrdinalIgnoreCase);

        liMutationUploadLog.Visible = isUploadProcess;

        if (isUploadProcess)
            BindMutationUploadLog();
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
            BindUploadId();
            ddlTocc.SelectedValue = _dr["TO_COST_CENTER"].ToString();
            //ddlFromLocationCode.SelectedValue = _dr["FROM_LOCATION_CODE"].ToString();
            Shared.BindFaLocationAllMut(ddlToLocationCode, ddlTocc.SelectedValue);
            if (EMPLOYEE_HO)
            {
                Shared.BindFaLocationAllMut(ddlFromLocationCode, txtBranch.Text);
            }
            else
            {
                Shared.BindFaLocationAllMut(ddlFromLocationCode, ddlBranch.SelectedValue);
            }
            //Shared.BindFaLocationAllMut(ddlFromLocationCode, ddlBranch.SelectedValue);//disini
            //Shared.BindFaLocationAllMut(ddlFromLocationCode, txtBranch.Text);//disini
            //ddlToLocationCode.SelectedValue = _dr["TO_LOCATION_CODE"].ToString(); 
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void BindUploadId()
    {
        lblUploadId.Text = "-";

        if (lblProcess.Text.Trim().ToUpper() != "UPLOAD" && lblProcess.Text.Trim().ToUpper() != "UPL")
            return;

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _ht["p_code_barcode"] = Request.Params["codebarcode"];

            DataTable dtUpload = _dal.GetRows("", "xsp_fa_request_mutation_upload_id_getrow", _ht);
            if (dtUpload.Rows.Count == 0)
                return;

            DataRow _dr = dtUpload.Rows[0];
            if (_dr["upload_id"] != DBNull.Value && _dr["upload_id"].ToString() != "")
                lblUploadId.Text = _dr["upload_id"].ToString();
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

            Shared.ShowSuccessGritter(this, string.Format("farequestmutationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
        Response.Redirect("farequestmutationheaderlist.aspx");
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        try
        {
            ValidatePostData();

            string approvalUrl = GetPostApprovalUrl();
            string script = String.Format("fnShowApprovalWithCommentDialog('{0}');", EscapeJavaScript(approvalUrl));
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenFaRequestMutationPostApproval", script, true);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void ValidatePostData()
    {
        GeneralDAL dal = new GeneralDAL();
        Hashtable ht = new Hashtable();

        ht["p_code_barcode"] = lblCodeBarcode.Text;
        Shared.ApplyDefaultProp(ht);

        dal.ExecRawSP("xsp_fa_request_mutation_header_post_validate", ht);
    }

    private string GetPostApprovalUrl()
    {
        return String.Format(
            "../../approval/genericapplication.aspx?code=APP0067&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}",
            lblCodeBarcode.ClientID,
            Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY],
            "POST",
            lblbranch.ClientID,
            lblAmount.ClientID,
            lblbranch.ClientID,
            txtRemarks.ClientID,
            lblCode.ClientID);
    }

    private string EscapeJavaScript(string value)
    {
        if (String.IsNullOrEmpty(value))
            return String.Empty;

        return value
            .Replace("\\", "\\\\")
            .Replace("'", "\\'")
            .Replace("\r", "\\r")
            .Replace("\n", "\\n");
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


    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (EMPLOYEE_HO)
        {
            Shared.BindFaLocationAllMut(ddlFromLocationCode, txtBranch.Text);
        }
        else
        {
            Shared.BindFaLocationAllMut(ddlFromLocationCode, ddlBranch.SelectedValue);
        }
        //(+)gustian 19102023 
        //Shared.BindFaLocationAllMut(ddlFromLocationCode, txtBranch.Text);
        //Shared.BindFaLocationAllMut(ddlFromLocationCode, ddlBranch.SelectedValue); //disini
        //(+)
        //updDep.Update();
    }

    protected void ddlToBranch_SelectedIndexChanged(object sender, EventArgs e)
    {


        Shared.BindFaLocationAllMut(ddlToLocationCode, ddlTocc.SelectedValue);

        //updDep.Update();
    }


    //protected void btnPrint_Click(object sender, EventArgs e)
    //{
    //    Hashtable htParams = new Hashtable();
    //    htParams["p_user_id"] = Shared.CurrentUID;
    //    htParams["p_code_barcode"] = lblCodeBarcode.Text;

    //    string sFilename = "";

    //    sFilename = Shared.ExecuteReport(this, "RPT_INVENTORY_REQUEST_ISSUE", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

    //    Shared.PreviewReport(this, sFilename);
    //}

    #region IR detail
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

    protected void btnAddRequestDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect("farequestmutationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text + "&branch=" + lblbranch.Text + "&location=" + ddlFromLocationCode.SelectedValue + "&owner=" + ddlOwner.SelectedValue);
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
        Response.Redirect(string.Format("farequestmutationdetail.aspx?action=edit&id={0}&codebarcode={1}&code={2}&branch={3}&location={4}&owner={5}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, lblCode.Text, lblbranch.Text, ddlFromLocationCode.SelectedValue, ddlOwner.SelectedValue));
    }
    #endregion

    public Boolean IsEmployeeHo(String branchCode)
    {
        try
        {
            GeneralDAL _dal = null;
            Hashtable _ht = null;

            DataRow _dtUser = null;
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = branchCode;
            _dtUser = _dal.GetRow("", "xsp_master_branch_getrow", _ht);
            if (_dtUser["IS_HO"].ToString().Equals("1"))
            {
                return true;
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
        return false;
    }

    #region Bulk Upload 
    protected void gvwListMutationUploadlog_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListmutationuploadlog.PageIndex = e.NewPageIndex;
        BindMutationUploadLog();
    }

    private void BindMutationUploadLog()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_im_code"] = lblCodeBarcode.Text;

            gvwListmutationuploadlog.DataSource = _dal.GetRows(TABLE_NAME_POST_HISTORY, _ht);
            gvwListmutationuploadlog.DataBind();
            updmutationuploadlog.Update();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    #endregion
}
