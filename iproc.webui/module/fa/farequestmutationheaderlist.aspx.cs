using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using Excel;
using System.IO;
using System.Collections.Generic;
using System.Data;

public partial class module_fa_farequestmutationheaderlist : BasePageList
{
    private static string TABLE_NAME = "FA_REQUEST_MUTATION_HEADER";
    private static string TABLE_UPLOAD_NAME = "FA_MUTATION_UPLOAD_HEADER";
    private static string TABLE_UPLOAD_LOG = "FA_MUTATION_UPLOAD_STAGING_LOG";
    private const string FA_MUTATION_UPLOAD_TEMPLATE_CODE = "FA_MUTATION_UPLOAD";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "FA_REQUEST_MUTATION_HEADER";
        NEXT_PAGE = "farequestmutationheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            //Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "IR");
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindBranchEmployeeSort(ddlFromBranch);
            if (ddlFromBranch.Items.Count > 0)
            {
                ddlFromBranch.Items[0].Text = "ALL";
                ddlFromBranch.Items[0].Value = "";
                ddlFromBranch.Items[1].Text = "HEAD OFFICE";
                ddlFromBranch.Items[1].Value = "KPO";
            }
            Shared.BindFaLocationAllMut(ddlFromLocation, ddlFromBranch.SelectedValue);
            if (ddlFromLocation.Items.Count > 0)
            {
                ddlFromLocation.Items[0].Text = "ALL";
                ddlFromLocation.Items[0].Value = "";
            }
            Shared.BindBranchEmployeeAll1(ddltoBranch);
            if (ddltoBranch.Items.Count > 0)
            {
                ddltoBranch.Items[0].Text = "ALL";
                ddltoBranch.Items[0].Value = "";
                ddltoBranch.Items[1].Text = "HEAD OFFICE";
                ddltoBranch.Items[1].Value = "KPO";
            }
            Shared.BindFaLocationAllMut(ddltoLocation, ddltoBranch.SelectedValue);
            if (ddltoLocation.Items.Count > 0)
            {
                ddltoLocation.Items[0].Text = "ALL";
                ddltoLocation.Items[0].Value = "";
            }

            BindData();
            BindUploadData();
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
        }
        LoadAfterInit();
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        Hashtable _htupload = null;


        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _htupload = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_process"] = ddlProcess.SelectedValue;

            _htupload["p_keywords"] = txtSearchUpload.Text;
            _htupload["p_branch_code"] = ddlFromBranch.SelectedValue;
            _htupload["p_from_location"] = ddlFromLocation.SelectedValue;
            _htupload["p_to_branch"] = ddltoBranch.SelectedValue;
            _htupload["p_to_location"] = ddltoLocation.SelectedValue;

            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();


            gvwListUpload.DataSource = _dal.GetRows(TABLE_UPLOAD_NAME, _htupload);
            gvwListUpload.DataBind();
            ApplyPostButtonState();
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

            _ht["p_code_barcode"] = code;

            _dal.Delete(TABLE_NAME, _ht);
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
        Response.Redirect("farequestmutationheader.aspx?action=add");
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
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("farequestmutationheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlProcess_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    # region Upload bulk mutation    
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _htParameters = null;

        try
        {
            _dal = new GeneralDAL();
            _htParameters = new Hashtable();

            _htParameters.Clear();
            _htParameters["p_code"] = FA_MUTATION_UPLOAD_TEMPLATE_CODE;


            string pdfName = "upload_famutation" + Shared.CurrentUID + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx"; ;
            string pdfPath = Server.MapPath(@"..\..\template\" + pdfName);
            //string filetype = "xls";


            // menampilkan pdf yang sudah dibuat
            Shared.ExecuteReportExportExcel(this, null, "xsp_famutation_list_item_getrows", _htParameters, pdfPath);
            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../template/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
        }

        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwListUpload_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListUpload.PageIndex = e.NewPageIndex;
        BindData();
    }
    protected void SelectedUploadIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("farequestmutationheader.aspx?action=edit&codebarcode=" + gvwListUpload.SelectedDataKey[0].ToString());
    }

   /* protected void btnPost_Click(object sender, EventArgs e)
    {
        try
        {
            ArrayList selectedCodes = new ArrayList();
            foreach (GridViewRow row in gvwListUpload.Rows)
            {
                CheckBox chk = row.FindControl("chbSelectUpload") as CheckBox;
                if (chk != null && chk.Checked)
                {
                    string codeBarcode = gvwListUpload.DataKeys[row.RowIndex].Value.ToString();
                    selectedCodes.Add(codeBarcode);
                }
            }
            if (selectedCodes.Count == 0)
            {
                Shared.ShowErrorDialog(this, new Exception("No Data Selected"));
                return;
            }

            string realFirstBarcode = selectedCodes[0].ToString().Trim();
            lblTempBarcode.Text = realFirstBarcode;

            // 3. Simpan ke Session dan buka Approval
            Session[SessionKey.POST_MUTATION_FA_LIST] = selectedCodes;
            Session[SessionKey.POST_MUTATION_FA_RESULTS] = new List<PostMutationResult>();

            string nextUrlRaw = "../module/fa/farequestmutationheaderlist.aspx";

            string url = string.Format(
             "../../approval/genericapplication.aspx?code=APP0067" +
             "&parc_object_id={0}" +
             "&nexturl={1}" +
             "&status={2}" +
             "&parc_object_branch={3}" +
             "&parc_object_amount={4}" +
             "&parc_branch_code={5}" +
             "&parc_object_description={6}" +
             "&parc_object_code={7}",
             lblTempBarcode.ClientID,
             Server.UrlEncode(nextUrlRaw),
             "POST",
             lblTempBranch.ClientID,
             lblTempAmount.ClientID,
             lblTempBranch.ClientID,
             lblTempRemarks.ClientID,
             lblTempCode.ClientID
         );

            string script = "fnShowApprovalWithCommentDialog('" + url + "');";

            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "OPEN_APPROVAL",
                script,
                true
            );
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void ApplyPostButtonState()
    {
        btnPost.Enabled = gvwListUpload.Rows.Count > 0;
    }
    protected void gvwUploadLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwUploadLog.PageIndex = e.NewPageIndex;
        BindUploadData();
    }
    protected void gvwUploadLog_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "VIEW_VALID" || e.CommandName == "VIEW_ERROR" || e.CommandName == "VIEW_TRX")
        {
            string[] param = e.CommandArgument.ToString().Split('|');

            string uploadid = param[0];
            string filename = param[1];
            string status = e.CommandName == "VIEW_VALID" ? "VALID" : e.CommandName == "VIEW_ERROR" ? "ERROR" : "TRX";

            string url = string.Format(
                    "../fa/farequestmutationuploadlog.aspx?uploadid={0}&filename={1}&status={2}",
                    uploadid,
                    filename,
                    status
                );

            string script = string.Format("fnShowGenericScreen('{0}');", url);

            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "popup",
                script,
                true
            );
        }
    }
    */
    protected void ddlFromBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindFaLocationAllMut(ddlFromLocation, ddlFromBranch.SelectedValue);
        if (ddlFromLocation.Items.Count > 0)
        {
            ddlFromLocation.Items[0].Text = "ALL";
            ddlFromLocation.Items[0].Value = "";
        }
        BindData();
    }
    protected void ddlToBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindFaLocationAllMut(ddltoLocation, ddltoBranch.SelectedValue);
        if (ddltoLocation.Items.Count > 0)
        {
            ddltoLocation.Items[0].Text = "ALL";
            ddltoLocation.Items[0].Value = "";
        }
        BindData();
    }
    protected void ddlFromLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlToLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void btnUploadRowFormat_Click(object sender, EventArgs e)
    {
        if (!FileUploadControlMutation.HasFile)
            return;

        IExcelDataReader excelReader = null;
        string fileName = FileUploadControlMutation.FileName;
        Guid uploadId = Guid.NewGuid();

        try
        {
            Stream excelStream = FileUploadControlMutation.PostedFile.InputStream;
            string ext = Path.GetExtension(fileName).ToLower();

            if (ext == ".xls")
                excelReader = ExcelReaderFactory.CreateBinaryReader(excelStream);
            else if (ext == ".xlsx")
                excelReader = ExcelReaderFactory.CreateOpenXmlReader(excelStream);
            else
                throw new Exception("The uploaded file must be in .xlsx or .xls format.");

            DataTable dt = BuildStagingTable();
            int excelRowIndex = 0;

            while (excelReader.Read())
            {
                excelRowIndex++;
                if (excelRowIndex == 1)
                {
                    string errorMsg;
                    if (!ValidateFAMutationTemplate(excelReader, fileName, out errorMsg))
                    {
                        Shared.ShowErrorDialog(this, new Exception(errorMsg));
                        return;
                    }
                    continue;
                }

                if (IsRowEmpty(excelReader))
                    break;

                DataRow row = dt.NewRow();
                row["upload_id"] = uploadId;
                row["file_name"] = fileName;
                row["row_number"] = excelRowIndex - 1;
                row["from_cost_center"] = GetStringSafe(excelReader, 1);
                row["from_location"] = GetStringSafe(excelReader, 2);
                row["to_cost_center"] = GetStringSafe(excelReader, 3);
                row["to_location"] = GetStringSafe(excelReader, 4);
                row["owner"] = GetStringSafe(excelReader, 5);
                row["asset_code"] = GetStringSafe(excelReader, 6);
                row["description"] = GetStringSafe(excelReader, 7);

                dt.Rows.Add(row);
            }

            BulkInsertToStaging(dt);
            ExecuteBulkProcess(uploadId, fileName);
            BindUploadData();
            // BindUploadData(uploadId, fileName);
            BindData();

            string script = @" $(document).ready(function () { $('.nav-tabs a[href=""#uploadfamutation""]').tab('show'); alert('File "" " + fileName + @" "" berhasil diproses.'); });";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ActivateUploadTab", script, true);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
        finally
        {
            if (excelReader != null)
                excelReader.Close();
        }
    }
    private bool ValidateFAMutationTemplate(IExcelDataReader reader, string fileName, out string errorMessage)
    {
        errorMessage = string.Empty;
        GeneralDAL _dal = new GeneralDAL();
        Hashtable htLog = new Hashtable();
        DataTable dtTemplate = GetUploadTemplateHeaders(_dal, FA_MUTATION_UPLOAD_TEMPLATE_CODE);

        if (dtTemplate.Rows.Count == 0)
        {
            errorMessage = "The FA Mutation upload template has not been configured.";
            LogFAMutationTemplateError(_dal, htLog, fileName, errorMessage, "HEADER TEMPLATE NOT FOUND");
            return false;
        }

        if (reader.FieldCount != dtTemplate.Rows.Count)
        {
            errorMessage = "The uploaded file does not match the required template. Please use the provided template.";
            LogFAMutationTemplateError(_dal, htLog, fileName, errorMessage, "HEADER VALIDATION");
            return false;
        }

        for (int i = 0; i < dtTemplate.Rows.Count; i++)
        {
            string actualHeader = reader.GetValue(i) == null
                ? ""
                : reader.GetValue(i).ToString().Trim();
            string expectedHeader = GetTemplateHeader(dtTemplate.Rows[i]);

            if (!actualHeader.Equals(
                    expectedHeader,
                    StringComparison.OrdinalIgnoreCase
                ))
            {
                //errorMessage = "Invalid template file. Column header - " + (i + 1) + " muse be '" + expectedHeader + "'.";
                errorMessage = "The uploaded file does not match the required template. Please use the provided template.";
                LogFAMutationTemplateError(_dal, htLog, fileName, errorMessage, "HEADER=" + actualHeader);
                return false;
            }
        }
        return true;
    }

    private DataTable GetUploadTemplateHeaders(GeneralDAL dal, string code)
    {
        Hashtable ht = new Hashtable();
        ht["p_code"] = code;

        return dal.GetRows("", "xsp_master_upload_template_getrows", ht);
    }

    private string GetTemplateHeader(DataRow row)
    {
        string description = row["description"] == null ? "" : row["description"].ToString().Trim();
        bool mandatory = row["mandatory"] != DBNull.Value && Convert.ToBoolean(row["mandatory"]);

        return mandatory ? description + "*" : description;
    }

    private void LogFAMutationTemplateError(GeneralDAL dal, Hashtable htLog, string fileName, string errorMessage, string rawData)
    {
        htLog.Clear();
        htLog["p_process_name"] = FA_MUTATION_UPLOAD_TEMPLATE_CODE;
        htLog["p_file_name"] = fileName;
        htLog["p_row_number"] = 0;
        htLog["p_error_message"] = errorMessage;
        htLog["p_raw_data"] = rawData;
        htLog["p_cre_by"] = Shared.CurrentUID;
        htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;

        dal.InsertProcessErrorLog(htLog);
    }
    private DataTable BuildStagingTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("upload_id", typeof(Guid));
        dt.Columns.Add("file_name", typeof(string));
        dt.Columns.Add("row_number", typeof(int));
        dt.Columns.Add("from_cost_center", typeof(string));
        dt.Columns.Add("from_location", typeof(string));
        dt.Columns.Add("to_cost_center", typeof(string));
        dt.Columns.Add("to_location", typeof(string));
        dt.Columns.Add("owner", typeof(string));
        dt.Columns.Add("asset_code", typeof(string));
        dt.Columns.Add("description", typeof(string));

        return dt;
    }
    private bool IsRowEmpty(IExcelDataReader reader)
    {
        for (int i = 0; i < reader.FieldCount; i++)
        {
            if (!reader.IsDBNull(i) && reader.GetValue(i).ToString().Trim() != "")
                return false;
        }
        return true;
    }
    private string GetStringSafe(IExcelDataReader reader, int index)
    {
        if (reader.IsDBNull(index))
            return "";

        return reader.GetValue(index).ToString().Trim();
    }
    private void BulkInsertToStaging(DataTable dt)
    {
        GeneralDAL _dal = new GeneralDAL();
        _dal.BulkInsert(dt, "fa_mutation_upload_staging");
    }
    private void ExecuteBulkProcess(Guid uploadId, String fileName)
    {
        GeneralDAL _dal = new GeneralDAL();
        Hashtable ht = new Hashtable();

        ht["p_upload_id"] = uploadId;
        ht["p_file_name"] = fileName;
        ht["p_cre_by"] = Shared.CurrentUID;
        ht["p_cre_ip_address"] = Shared.CurrentIPAddress;
        ht["p_department_code"] = Shared.CurrentEmployeeDeptCodeDefault;
        ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
        ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
        ht["p_sub_department_code"] = Shared.CurrentEmployeeSubDepartmentCode;

        _dal.ExecuteNonQuery(
            "xsp_fa_mutation_upload_bulk_process",
            ht
        );
    }

    private void BindUploadData()
    {
        GeneralDAL _dal = new GeneralDAL();
        Hashtable _ht = new Hashtable();

        DataTable dtUploadLog = _dal.GetRows(TABLE_UPLOAD_LOG, _ht);
        AddTotalTrxUpload(dtUploadLog);

        gvwUploadLog.DataSource = dtUploadLog;
        gvwUploadLog.DataBind();

    }

    private void AddTotalTrxUpload(DataTable dtUploadLog)
    {
        if (!dtUploadLog.Columns.Contains("total_trx_upload"))
            dtUploadLog.Columns.Add("total_trx_upload", typeof(int));

        foreach (DataRow row in dtUploadLog.Rows)
        {
            Guid uploadId;
            try
            {
                uploadId = new Guid(row["upload_id"].ToString());
            }
            catch
            {
                row["total_trx_upload"] = 0;
                continue;
            }

            row["total_trx_upload"] = GetGeneratedTrxUpload(uploadId, row["file_name"].ToString()).Rows.Count;
        }
    }

    private DataTable GetGeneratedTrxUpload(Guid uploadId, string fileName)
    {
        GeneralDAL _dal = new GeneralDAL();
        Hashtable _ht = new Hashtable();

        _ht["p_upload_id"] = uploadId;
        _ht["p_file_name"] = fileName;
        _ht["p_keywords"] = "";

        return _dal.GetRows("", "xsp_fa_mutation_upload_generated_trx_getrows", _ht);
    }
    #endregion
}

