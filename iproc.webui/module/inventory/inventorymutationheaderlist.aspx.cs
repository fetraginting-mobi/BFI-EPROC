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


public partial class module_inventory_inventorymutationheaderlist : BasePageList
{
    private static string TABLE_NAME = "INVENTORY_MUTATION_HEADER";
    private static string TABLE_UPLOAD_NAME = "INVENTORY_MUTATION_UPLOAD_HEADER";
    private static string TABLE_UPLOAD_LOG = "INVENTORY_MUTATION_UPLOAD_STAGING_LOG";
    private const string INV_MUTATION_UPLOAD_TEMPLATE_CODE = "INV_MUTATION_UPLOAD";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "INVENTORY_MUTATION_HEADER";
        NEXT_PAGE = "inventorymutationheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "IM");
            Shared.BindGeneralLocationByBranch(ddlFromLocation, "KPO");
            ddlFromLocation.Items.Insert(0, new ListItem("ALL", ""));
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindGetBranch(ddlToBranch1);
            Shared.BindGetBranch(ddltoBranch);
            ddltoBranch.Items.Insert(0, new ListItem("ALL", ""));
            ddlToBranch1.Items.Insert(0, new ListItem("ALL", ""));
            Shared.BindGeneralLocationByBranch(ddltoLocation, "");
            ddltoLocation.Items.Insert(0, new ListItem("ALL", "ALL"));


            BindData();
            BindUploadData();
            ShowPostMutationResult();
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
        }
        LoadAfterInit();
    }

    private void ShowPostMutationResult()
    {
        object sessionResults = Session[SessionKey.POST_MUTATION_RESULTS];
        if (sessionResults == null)
            return;

        Session.Remove(SessionKey.POST_MUTATION_RESULTS);

        bool hasError = false;
        IEnumerable postResults = sessionResults as IEnumerable;
        if (postResults == null)
            return;

        foreach (object item in postResults)
        {
            PostMutationResult result = item as PostMutationResult;
            if (result != null && !result.IsSuccess)
            {
                hasError = true;
                break;
            }
        }

        if (!hasError)
            return;

        Shared.ShowErrorDialog(this, new Exception("ERROR, silahkan check log error pada tab POST Upload Mutation History di Inventory Mutation."));
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
            _ht["p_to_branch_code"] = ddlToBranch1.SelectedValue;
            _ht["p_process"] = ddlProcess.SelectedValue;

            _htupload["p_keywords"] = txtSearchUpload.Text;
            _htupload["p_branch_code"] = "KPO";
            _htupload["p_from_location"] = ddlFromLocation.SelectedValue;
            _htupload["p_to_branch"] = ddltoBranch.SelectedValue;
            _htupload["p_to_location"] = ddltoLocation.SelectedValue == "ALL" ? "" : ddltoLocation.SelectedValue;

            Shared.ApplyDefaultProp(_ht);


            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();

            //View Data Upload Mutation
            gvwListUpload.DataSource = _dal.GetRows(TABLE_UPLOAD_NAME, _htupload);
            gvwListUpload.DataBind();
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
        Response.Redirect("inventorymutationheader.aspx?action=add");
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
        Response.Redirect("inventorymutationheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlToBranch1_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlProcess_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    # region Upload bulk mutation
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

            if (fileName.Length > 100)
            {
                throw new Exception("Upload failed. File name cannot exceed 100 characters.");
            }
            if (ext != ".xlsx")
                throw new Exception("The uploaded file must be in .xlsx format.");

            excelReader = ExcelReaderFactory.CreateOpenXmlReader(excelStream);


            DataTable dt = BuildStagingTable();
            Hashtable htDefault = new Hashtable();
            Shared.ApplyDefaultProp(htDefault);
            int excelRowIndex = 0;

            while (excelReader.Read())
            {
                excelRowIndex++;
                if (excelRowIndex == 1)
                {
                    string errorMsg;
                    if (!ValidateInventoryMutationTemplate(excelReader, fileName, out errorMsg))
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
                row["upload_by"] = htDefault["p_cre_by"];
                row["row_number"] = excelRowIndex - 1;
                row["from_branch"] = GetStringSafe(excelReader, 1);
                row["from_location"] = GetStringSafe(excelReader, 2);
                row["to_branch"] = GetStringSafe(excelReader, 3);
                row["to_location"] = GetStringSafe(excelReader, 4);
                row["description"] = GetStringSafe(excelReader, 5);
                row["item_code"] = GetStringSafe(excelReader, 6);
                row["quantity"] = IsEmpty(excelReader, 7) ? (object)DBNull.Value : GetStringSafe(excelReader, 7);             

                dt.Rows.Add(row);
            }
            BulkInsertToStaging(dt);
            ExecuteBulkProcess(uploadId, fileName);
            BindUploadData();
            BindData();

            string script = @"
            $(document).ready(function () {
                $('.nav-tabs a[href=""#uploadinvmutation""]').tab('show');
                alert('File "" " + fileName + @" "" berhasil diproses.');
            });";

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
    private bool ValidateInventoryMutationTemplate(IExcelDataReader reader, string fileName, out string errorMessage)
    {
        errorMessage = string.Empty;
        GeneralDAL _dal = new GeneralDAL();
        Hashtable htLog = new Hashtable();
        DataTable dtTemplate = GetUploadTemplateHeaders(_dal, INV_MUTATION_UPLOAD_TEMPLATE_CODE);

        if (dtTemplate.Rows.Count == 0)
        {
            errorMessage = "The Inventory Mutation upload template has not been configured.";
            LogInventoryMutationTemplateError(_dal, htLog, fileName, errorMessage, "HEADER TEMPLATE NOT FOUND");
            return false;
        }

        if (reader.FieldCount != dtTemplate.Rows.Count)
        {
            errorMessage = "The uploaded file does not match the required template. Please use the provided template.";
            LogInventoryMutationTemplateError(_dal, htLog, fileName, errorMessage, "HEADER VALIDATION");
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
                errorMessage = "The uploaded file does not match the required template. Please use the provided template.";
                LogInventoryMutationTemplateError(_dal, htLog, fileName, errorMessage, "HEADER=" + actualHeader);
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

    private void LogInventoryMutationTemplateError(GeneralDAL dal, Hashtable htLog, string fileName, string errorMessage, string rawData)
    {
        htLog.Clear();
        htLog["p_process_name"] = INV_MUTATION_UPLOAD_TEMPLATE_CODE;
        htLog["p_file_name"] = fileName;
        htLog["p_row_number"] = 0;
        htLog["p_error_message"] = errorMessage;
        htLog["p_raw_data"] = rawData;
        htLog["p_cre_by"] = Shared.CurrentUID;
        htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;

        dal.InsertProcessErrorLog(htLog);
    }
    private void BulkInsertToStaging(DataTable dt)
    {
        GeneralDAL _dal = new GeneralDAL();
        _dal.BulkInsert(dt, "inv_mutation_upload_staging");
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
    private bool IsEmpty(IExcelDataReader reader, int index)
    {
        return reader.IsDBNull(index) || reader.GetValue(index).ToString().Trim() == "";
    }
    private bool TryConvertToInt(object value, out int result)
    {
        result = 0;
        if (value == null || value == DBNull.Value) return false;
        if (value is double)
        {
            result = Convert.ToInt32((double)value);
            return true;
        }
        return int.TryParse(value.ToString().Trim(), out result);
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _htParameters = null;

        try
        {
            _dal = new GeneralDAL();
            _htParameters = new Hashtable();

            _htParameters.Clear();
            _htParameters["p_code"] = INV_MUTATION_UPLOAD_TEMPLATE_CODE;


            string pdfName = "upload_invmutation" + Shared.CurrentUID + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx"; ;
            string pdfPath = Server.MapPath(@"..\..\template\" + pdfName);
            //string filetype = "xls";


            // menampilkan pdf yang sudah dibuat
            Shared.ExecuteReportExportExcel(this, null, "xsp_inventory_list_item_getrows", _htParameters, pdfPath);
            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../template/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
        }

        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }

    protected void btnPost_Click(object sender, EventArgs e)
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

            // if (selectedCodes.Count == 0)
            // {
            //     GeneralDAL _dal = new GeneralDAL();
            //     Hashtable _htupload = new Hashtable();
            //     _htupload["p_keywords"] = txtSearchUpload.Text;
            //     _htupload["p_status"] = "NEW";
            //     _htupload["p_branch_code"] = ddlFromBranch.SelectedValue;
            //     _htupload["p_from_location"] = ddlFromLocation.SelectedValue;
            //     _htupload["p_to_branch"] = ddltoBranch.SelectedValue;
            //     _htupload["p_to_location"] = ddltoLocation.SelectedValue;
            //     Shared.ApplyDefaultProp(_htupload);

            //     DataTable dtTarget = _dal.GetRows(TABLE_UPLOAD_NAME, _htupload);
            //     if (dtTarget != null)
            //     {
            //         foreach (DataRow dr in dtTarget.Rows)
            //         {
            //             selectedCodes.Add(dr["CODE_BARCODE"].ToString());
            //         }
            //     }
            // }

            if (selectedCodes.Count == 0)
            {
                Shared.ShowErrorDialog(this, new Exception("No Data Selected"));
                return;
            }

            // 3. Simpan ke Session dan buka Approval
            Session[SessionKey.POST_MUTATION_LIST] = selectedCodes;
            Session[SessionKey.POST_MUTATION_RESULTS] = new List<PostMutationResult>();

            string url = string.Format(
                "../../approval/genericapplication.aspx?code=AP000013&nexturl={0}&post_error_process_name={1}&post_error_raw_data={2}",
                Server.UrlEncode("../module/inventory/inventorymutationheaderlist.aspx"),
                Server.UrlEncode("POST_INVENTORY_MUTATION_ERROR"),
                Server.UrlEncode("Bulk POST Inventory Mutation"));

            string script = "fnShowApprovalWithCommentDialog('" + url + "');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OPEN_APPROVAL", script, true);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void ControlPostButton()
    {
        bool isStatusNew = ddlStatus.SelectedValue == "NEW";
        bool hasData = gvwList.Rows.Count > 0;

        if (isStatusNew && hasData)
        {
            btnPost.Enabled = true;
            btnPost.CssClass = "btn btn-success";
        }
        else
        {
            btnPost.Enabled = false;
            btnPost.CssClass = "btn btn-success disabled";
        }
    }

    protected void btnSearchUpload_Click(object sender, EventArgs e)
    {
        BindData();
        BindUploadData();
    }
    protected void gvwListUpload_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListUpload.PageIndex = e.NewPageIndex;
        BindData();
    }
    protected void SelectedUploadIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("inventorymutationheader.aspx?action=edit&codebarcode=" + gvwListUpload.SelectedDataKey[0].ToString());
    }
    private DataTable BuildStagingTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("upload_id", typeof(Guid));
        dt.Columns.Add("file_name", typeof(string));
        dt.Columns.Add("upload_by", typeof(string));
        dt.Columns.Add("row_number", typeof(int));
        dt.Columns.Add("from_branch", typeof(string));
        dt.Columns.Add("from_location", typeof(string));
        dt.Columns.Add("to_branch", typeof(string));
        dt.Columns.Add("to_location", typeof(string));
        dt.Columns.Add("description", typeof(string));
        dt.Columns.Add("item_code", typeof(string));
        dt.Columns.Add("quantity", typeof(int));

        return dt;
    }
    private string GetStringSafe(IExcelDataReader reader, int index)
    {
        if (reader.IsDBNull(index))
            return "";

        return reader.GetValue(index).ToString().Trim();
    }
    private void ExecuteBulkProcess(Guid uploadId, String fileName)
    {
        GeneralDAL _dal = new GeneralDAL();
        Hashtable ht = new Hashtable();

        ht["p_upload_id"] = uploadId;
        ht["p_file_name"] = fileName;
        ht["p_branch_code"] = "KPO";
        ht["p_cre_by"] = Shared.CurrentUID;
        ht["p_cre_ip_address"] = Shared.CurrentIPAddress;
        ht["p_department_code"] = Shared.CurrentEmployeeDeptCodeDefault;
        ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
        ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
        ht["p_sub_department_code"] = Shared.CurrentEmployeeSubDepartmentCode;

        _dal.ExecuteNonQuery(
            "xsp_inv_mutation_upload_bulk_process",
            ht
        );
    }
    private void BindUploadData()
    {
        GeneralDAL _dal = new GeneralDAL();
        Hashtable _ht = new Hashtable();

        DataTable dtUploadLog = _dal.GetRows(TABLE_UPLOAD_LOG, _ht);

        gvwUploadLog.DataSource = dtUploadLog;
        gvwUploadLog.DataBind();

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
                    "../inventory/inventorymutationuploadlog.aspx?uploadid={0}&filename={1}&status={2}",
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
    protected void ddlFromBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlToBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedBranch = ddltoBranch.SelectedValue;
        Shared.BindGeneralLocationByBranch(ddltoLocation, selectedBranch);
        ddltoLocation.Items.Insert(0, new ListItem("ALL", "ALL"));
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
    #endregion
}

