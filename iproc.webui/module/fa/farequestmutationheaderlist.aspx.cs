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

            BindData();
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
        }
        LoadAfterInit();
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_is_upload"] = ddlIsUpload.SelectedValue;

            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
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
    protected void ddlIsUpload_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
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
            _htParameters["p_code"] = Request.Params["code"];


            string pdfName = "upload_famutation_list" + ".xlsx"; ;
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
    //protected void btnUploadRowFormat_Click(object sender, EventArgs e)
    //{
    //    if (!FileUploadControlMutation.HasFile)
    //        return;

    //    IExcelDataReader excelReader = null;
    //    string fileName = FileUploadControlMutation.FileName;
    //    GeneralDAL _dal = new GeneralDAL();
    //    Hashtable headerDetailBuffer = new Hashtable();
    //    DataRow drAsset = null;

    //    try
    //    {
    //        Stream excelStream = FileUploadControlMutation.PostedFile.InputStream;
    //        string ext = Path.GetExtension(fileName).ToLower();

    //        if (ext == ".xls")
    //            excelReader = ExcelReaderFactory.CreateBinaryReader(excelStream);
    //        else if (ext == ".xlsx")
    //            excelReader = ExcelReaderFactory.CreateOpenXmlReader(excelStream);
    //        else
    //            throw new Exception("Format file tidak didukung");
    //        int excelRowIndex = 0;

    //        while (excelReader.Read())
    //        {
    //            excelRowIndex++;
    //            // === HEADER VALIDATION ===
    //            if (excelRowIndex == 1)
    //            {
    //                string errorMsg;
    //                if (!ValidateFAMutationTemplate(excelReader, fileName, out errorMsg))
    //                {
    //                    Shared.ShowErrorDialog(this, new Exception(errorMsg));
    //                    return;
    //                }
    //                continue;
    //            }

    //            int rowNumber = excelRowIndex - 1;
    //            try
    //            {
    //                if (IsRowEmpty(excelReader))
    //                    break;

    //                if (IsEmpty(excelReader, 1)) throw new Exception("From Cost Center kosong (baris " + rowNumber + ")");
    //                if (IsEmpty(excelReader, 2)) throw new Exception("From Location kosong (baris " + rowNumber + ")");
    //                if (IsEmpty(excelReader, 3)) throw new Exception("To Cost Center kosong (baris " + rowNumber + ")");
    //                if (IsEmpty(excelReader, 4)) throw new Exception("To Location kosong (baris " + rowNumber + ")");
    //                if (IsEmpty(excelReader, 5)) throw new Exception("Owner kosong (baris " + rowNumber + ")");
    //                if (IsEmpty(excelReader, 6)) throw new Exception("Asset Code kosong (baris " + rowNumber + ")");

    //                string fromCostCenter = excelReader.GetString(1).Trim();
    //                string fromLocation = excelReader.GetString(2).Trim();
    //                string toCostCenter = excelReader.GetString(3).Trim();
    //                string toLocation = excelReader.GetString(4).Trim();
    //                string owner = excelReader.GetString(5).Trim();
    //                string assetCode = excelReader.GetString(6).Trim();
    //                string description = excelReader.IsDBNull(7) ? "" : excelReader.GetString(7).Trim();

    //                string headerKey =
    //                    fromCostCenter + "|" +
    //                    fromLocation + "|" +
    //                    toCostCenter + "|" +
    //                    toLocation + "|" +
    //                    owner;

    //                drAsset = _dal.GetAssetProcessRow(assetCode);
    //                ValidateAssetProcess(drAsset, assetCode, rowNumber);

    //                if (!headerDetailBuffer.ContainsKey(headerKey))
    //                    headerDetailBuffer[headerKey] = new List<Hashtable>();

    //                    Hashtable detail = new Hashtable();
    //                    detail["p_item_code"] = assetCode;
    //                    detail["p_desc"] = description;
    //                    detail["p_branch_code"] = fromCostCenter;
    //                    detail["p_from_location"] = fromLocation;
    //                    detail["p_to_branch_code"] = toCostCenter;
    //                    detail["p_to_location"] = toLocation;
    //                    detail["p_row_number"] = rowNumber;
    //                    ((List<Hashtable>)headerDetailBuffer[headerKey]).Add(detail);
    //            }
    //            catch (Exception exRow)
    //            {
    //                Hashtable htLog = new Hashtable();
    //                htLog["p_process_name"] = "UPLOAD_FA_MUTATION";
    //                htLog["p_file_name"] = fileName;
    //                htLog["p_row_number"] = rowNumber;
    //                htLog["p_error_message"] = exRow.Message;
    //                htLog["p_raw_data"] = excelReader.GetValue(6);
    //                htLog["p_cre_by"] = Shared.CurrentUID;
    //                htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;

    //                _dal.InsertProcessErrorLog(htLog);
    //                continue;
    //            }
    //        }

    //        // ================= INSERT HEADER & DETAIL =================
    //        foreach (DictionaryEntry entry in headerDetailBuffer)
    //        {
    //            string[] key = entry.Key.ToString().Split('|');
    //            List<Hashtable> details = (List<Hashtable>)entry.Value;

    //            if (details.Count == 0)
    //                continue;

    //            // === INSERT HEADER ===
    //            Hashtable htHeader = new Hashtable();
    //            htHeader["p_request_date"] = DateTime.Now;
    //            htHeader["p_remarks"] = "Upload Fix Asset";
    //            htHeader["p_branch_code"] = key[0];
    //            htHeader["p_branch_req"] = key[0];
    //            htHeader["p_department_code"] = Shared.CurrentEmployeeDeptCodeDefault;
    //            htHeader["p_division_code"] = Shared.CurrentEmployeeDivCode;
    //            htHeader["p_sub_department_code"] = Shared.CurrentEmployeeSubDepartmentCode;
    //            htHeader["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
    //            htHeader["p_from_location_code"] = key[1];
    //            htHeader["p_to_cost_center"] = key[2];
    //            htHeader["p_to_location_code"] = key[3];
    //            htHeader["p_owner"] = key[4];
    //            htHeader["p_requestor"] = Shared.CurrentUID;
    //            htHeader["p_cre_date"] = DateTime.Now;
    //            htHeader["p_cre_by"] = Shared.CurrentUID;
    //            htHeader["p_cre_ip_address"] = Shared.CurrentIPAddress;
    //            htHeader["p_mod_date"] = DateTime.Now;
    //            htHeader["p_mod_by"] = Shared.CurrentUID;
    //            htHeader["p_mod_ip_address"] = Shared.CurrentIPAddress;

    //            string irCode = _dal.UploadWithReturnString("fa_request_mutation_header",htHeader);

    //            // === INSERT DETAIL (PER ITEM, TIDAK STOP) ===
    //            foreach (Hashtable d in details)
    //            {
    //                try
    //                {
    //                    Hashtable htDetail = new Hashtable();
    //                    htDetail["p_ir_code"] = irCode;
    //                    htDetail["p_item_code"] = d["p_item_code"];
    //                    htDetail["p_item_description"] = d["p_desc"];
    //                    htDetail["p_branch_code"] = d["p_branch_code"];
    //                    htDetail["p_cre_date"] = DateTime.Now;
    //                    htDetail["p_cre_by"] = Shared.CurrentUID;
    //                    htDetail["p_cre_ip_address"] = Shared.CurrentIPAddress;
    //                    htDetail["p_mod_date"] = DateTime.Now;
    //                    htDetail["p_mod_by"] = Shared.CurrentUID;
    //                    htDetail["p_mod_ip_address"] = Shared.CurrentIPAddress;
    //                    htDetail["p_location_code"] = d["p_from_location"];
    //                    htDetail["p_to_branch_code"] = d["p_to_branch_code"];
    //                    htDetail["p_to_location_code"] = d["p_to_location"];

    //                    _dal.ExecSPReturnInt("xsp_fa_request_mutation_detail_upload",htDetail);
    //                }

    //                catch (Exception exDetail)
    //                {
    //                    string errMsg = GetRealErrorMessage(exDetail);
    //                    Hashtable htLog = new Hashtable();
    //                    htLog["p_process_name"] = "UPLOAD_FA_MUTATION";
    //                    htLog["p_file_name"] = fileName;
    //                    htLog["p_row_number"] = d["p_row_number"];
    //                    htLog["p_error_message"] = errMsg;
    //                    htLog["p_raw_data"] = d["p_item_code"];
    //                    htLog["p_cre_by"] = Shared.CurrentUID;
    //                    htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;
    //                    _dal.InsertProcessErrorLog(htLog);
    //                    continue; 
    //                }
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //    finally
    //    {
    //        if (excelReader != null)
    //            excelReader.Close();
    //        BindData();
    //    }
    //}

    #region upload mutasi 
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
                throw new Exception("Format file tidak didukung");

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
            ExecuteBulkProcess(uploadId);
            ClientScript.RegisterStartupScript(this.GetType(),"alert","alert('Upload berhasil diproses.');",true);
        }
        catch (Exception ex)
        {
        }
        finally
        {
            if (excelReader != null)
                excelReader.Close();
        }
    }
    private void LogBulkError(GeneralDAL _dal,Guid uploadId,int rowNumber,string message,string rawData)
    {
        Hashtable htLog = new Hashtable();

        htLog["p_process_name"] = "BULK_FA_MUTATION";
        htLog["p_upload_id"] = uploadId;     
        htLog["p_row_number"] = rowNumber;
        htLog["p_error_message"] = message;
        htLog["p_raw_data"] = rawData;
        htLog["p_cre_by"] = Shared.CurrentUID;
        htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;

        _dal.InsertProcessErrorLog(htLog);
    }


    private void ExecuteBulkProcess(Guid uploadId)
    {
        GeneralDAL _dal = new GeneralDAL();
        Hashtable htParam = new Hashtable();
        htParam["p_upload_id"] = uploadId;

        DataTable dtStaging =
            _dal.GetRows(
                "fa_mutation_upload_staging",
                "xsp_fa_mutation_upload_staging_getrows_by_upload_id",
                htParam
            );

        if (dtStaging == null || dtStaging.Rows.Count == 0)
            return;

        Hashtable headerBuffer = new Hashtable();

        foreach (DataRow row in dtStaging.Rows)
        {
            string fromCC = row["from_cost_center"].ToString();
            string fromLoc = row["from_location"].ToString();
            string toCC = row["to_cost_center"].ToString();
            string toLoc = row["to_location"].ToString();
            string owner = row["owner"].ToString();

            string headerKey = fromCC + "|" + fromLoc + "|" + toCC + "|" + toLoc + "|" + owner;

            if (!headerBuffer.ContainsKey(headerKey))
                headerBuffer[headerKey] = new List<DataRow>();

            ((List<DataRow>)headerBuffer[headerKey]).Add(row);
        }

        foreach (DictionaryEntry entry in headerBuffer)
        {
            string[] key = entry.Key.ToString().Split('|');
            List<DataRow> detailRows = (List<DataRow>)entry.Value;

            if (detailRows.Count == 0)
                continue;

            string barcode = "";

            try
            {
                Hashtable htHeader = new Hashtable();
                htHeader["p_request_date"] = DateTime.Now;
                htHeader["p_department_code"] = Shared.CurrentEmployeeDeptCodeDefault;
                htHeader["p_remarks"] = "Upload Fix Asset";
                htHeader["p_cre_date"] = DateTime.Now;
                htHeader["p_cre_by"] = Shared.CurrentUID;
                htHeader["p_cre_ip_address"] = Shared.CurrentIPAddress;
                htHeader["p_mod_date"] = DateTime.Now;
                htHeader["p_mod_by"] = Shared.CurrentUID;
                htHeader["p_mod_ip_address"] = Shared.CurrentIPAddress;
                htHeader["p_from_location_code"] = key[1];
                htHeader["p_to_location_code"] = key[3];
                htHeader["p_to_cost_center"] = key[2];
                htHeader["p_branch_req"] = key[0];
                htHeader["p_branch_code"] = key[0];
                htHeader["p_division_code"] = Shared.CurrentEmployeeDivCode;
                htHeader["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
                htHeader["p_sub_department_code"] = Shared.CurrentEmployeeSubDepartmentCode;
                htHeader["p_owner"] = key[4];

                barcode = _dal.UploadWithReturnString(
                    "fa_request_mutation_header",
                    htHeader
                );
            }
            catch (Exception exHeader)
            {
                LogBulkError(_dal, uploadId, 0, exHeader.Message, entry.Key.ToString());
                continue;
            }
            foreach (DataRow row in detailRows)
            {
                int rowNumber = 0;

                if (row.Table.Columns.Contains("row_number") &&
                    row["row_number"] != DBNull.Value)
                {
                    rowNumber = Convert.ToInt32(row["row_number"]);
                }

                try
                {
                    Hashtable htDetail = new Hashtable();

                    htDetail["p_ir_code"] = barcode;
                    htDetail["p_item_code"] = row["asset_code"] == DBNull.Value ? "" : row["asset_code"].ToString();
                    htDetail["p_item_description"] = row["description"] == DBNull.Value ? "" : row["description"].ToString();
                    htDetail["p_branch_code"] = key[0];
                    htDetail["p_cre_date"] = DateTime.Now;
                    htDetail["p_cre_by"] = Shared.CurrentUID;
                    htDetail["p_cre_ip_address"] = Shared.CurrentIPAddress;
                    htDetail["p_mod_date"] = DateTime.Now;
                    htDetail["p_mod_by"] = Shared.CurrentUID;
                    htDetail["p_mod_ip_address"] = Shared.CurrentIPAddress;
                    htDetail["p_location_code"] = key[1];
                    htDetail["p_to_branch_code"] = key[2];
                    htDetail["p_to_location_code"] = key[3];

                    _dal.ExecSPReturnInt(
                        "xsp_fa_request_mutation_detail_upload",
                        htDetail
                    );

                    Hashtable htUpdate = new Hashtable();
                    htUpdate["p_upload_id"] = uploadId;
                    htUpdate["p_row_number"] = rowNumber;
                    htUpdate["p_mod_by"] = Shared.CurrentUID;

                    _dal.ExecuteNonQuery(
                        "xsp_fa_mutation_upload_staging_update_process",
                        htUpdate
                    );
                }
                catch (Exception exDetail)
                {
                    string cleanMessage = exDetail.InnerException != null? exDetail.InnerException.Message: exDetail.Message;

                    LogBulkError(_dal,uploadId,rowNumber,cleanMessage,row.Table.Columns.Contains("asset_code")? row["asset_code"].ToString(): "");
                }
                
            }
        }
    }

    private void BulkInsertToStaging(DataTable dt)
    {
        GeneralDAL _dal = new GeneralDAL();
        _dal.BulkInsert(dt, "fa_mutation_upload_staging");
    }
    private DataTable BuildStagingTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("upload_id", typeof(Guid));
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
    private string GetStringSafe(IExcelDataReader reader, int index)
    {
        if (reader.IsDBNull(index))
            return "";

        return reader.GetValue(index).ToString().Trim();
    }


    #endregion
    protected void btnPost_Click(object sender, EventArgs e)
    {
        try
        {     
            ArrayList selectedCodes = new ArrayList();

            for (int i = 0; i < gvwList.Rows.Count; i++)
            {
                GridViewRow row = gvwList.Rows[i];
                CheckBox chk = row.FindControl("chbSelect") as CheckBox;

                if (chk != null && chk.Checked)
                {
                    string codeBarcode =
                        gvwList.DataKeys[row.RowIndex].Value.ToString();

                    selectedCodes.Add(codeBarcode);
                }
            }

            if (selectedCodes.Count == 0)
            {
                Shared.ShowErrorDialog(this,
                    new Exception("Pilih minimal 1 data untuk diposting"));
                return;
            }

            // SIMPAN KE SESSION (BULK LIST)
            Session[SessionKey.POST_MUTATION_LIST] = selectedCodes;
            Session[SessionKey.POST_MUTATION_RESULTS] = new List<PostMutationResult>();

            // REDIRECT KE GENERIC APPLICATION (PASSWORD 1x)
            string url = string.Format(
            "../../approval/genericapplication.aspx?code=APP0067&nexturl={0}",
            Server.UrlEncode("../module/fa/farequestmutationheaderlist.aspx")
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
    private string GetRealErrorMessage(Exception ex)
    {
        try
        {
            Exception currentEx = ex;
            while (currentEx.InnerException != null)
            {
                currentEx = currentEx.InnerException;
            }

            return currentEx.Message;
        }
        catch
        {
            return ex.Message;
        }
    }

    private static readonly string[] FA_MUTATION_TEMPLATE_HEADERS =
    {
        "No",
        "From Cost Center*",
        "From Location*",
        "To Cost Center*",
        "To Location*",
        "Owner*",
        "Asset Code*",
        "Deskripsi"
    };

    private bool ValidateFAMutationTemplate(IExcelDataReader reader, string fileName, out string errorMessage)
    {
        errorMessage = string.Empty;
        GeneralDAL _dal = new GeneralDAL();
        Hashtable htLog = new Hashtable();

        if (reader.FieldCount != FA_MUTATION_TEMPLATE_HEADERS.Length)
        {
            errorMessage = "Format file tidak sesuai template. Jumlah kolom tidak valid.";
            htLog["p_process_name"] = "FA_MUTATION_UPLOAD";
            htLog["p_file_name"] = fileName;
            htLog["p_row_number"] = 0; // HEADER
            htLog["p_error_message"] = errorMessage;
            htLog["p_raw_data"] = "HEADER VALIDATION";
            htLog["p_cre_by"] = Shared.CurrentUID;
            htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;

            _dal.InsertProcessErrorLog(htLog);
            return false; 
        }
        for (int i = 0; i < FA_MUTATION_TEMPLATE_HEADERS.Length; i++)
        {
            string actualHeader = reader.GetValue(i) == null
                ? ""
                : reader.GetValue(i).ToString().Trim();

            if (!actualHeader.Equals(
                    FA_MUTATION_TEMPLATE_HEADERS[i],
                    StringComparison.OrdinalIgnoreCase
                ))
            {
                errorMessage = "Template file tidak sesuai. Header kolom ke-" + (i + 1) + " harus '" + FA_MUTATION_TEMPLATE_HEADERS[i] + "'.";
                htLog.Clear();
                htLog["p_process_name"] = "FA_MUTATION_UPLOAD";
                htLog["p_file_name"] = fileName;
                htLog["p_row_number"] = 0;
                htLog["p_error_message"] = errorMessage;
                htLog["p_raw_data"] = "HEADER=" + actualHeader;
                htLog["p_cre_by"] = Shared.CurrentUID;
                htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;
                _dal.InsertProcessErrorLog(htLog);
                return false;
            }
        }
        return true;
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
    private void ValidateAssetProcess(DataRow dr,string assetCode,int rowNumber)
    {
        if (dr == null)
            throw new Exception(
                "Asset tidak ditemukan / tidak AVAILABLE (" + assetCode +
                ", baris " + rowNumber + ")"
            );

        if (dr["sale"].ToString() != "")
            throw new Exception(
                "Asset sedang dalam proses SALE (Ref: " +
                dr["sale"].ToString() + ", baris " + rowNumber + ")"
            );

        if (dr["dispose"].ToString() != "")
            throw new Exception(
                "Asset sedang dalam proses DISPOSAL (Ref: " +
                dr["dispose"].ToString() + ", baris " + rowNumber + ")"
            );

        if (dr["mutasi"].ToString() != "")
            throw new Exception(
                "Asset sedang dalam proses MUTATION (Ref: " +
                dr["mutasi"].ToString() + ", baris " + rowNumber + ")"
            );
        if (dr["item_group"].ToString() != "")
            throw new Exception(
                "Asset terdaftar dalam Item Group (Ref: " +
                dr["item_group"].ToString() + ", baris " + rowNumber + ")"
            );
    }   
}

