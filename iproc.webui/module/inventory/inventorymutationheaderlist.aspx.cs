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
public partial class module_inventory_inventorymutationheaderlist : BasePageList
{
    private static string TABLE_NAME = "INVENTORY_MUTATION_HEADER";

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
            ControlPostButton();
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


            string pdfName = "upload_mutation_list"+ ".xlsx"; ;
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
    protected void btnUploadRowFormat_Click(object sender, EventArgs e)
    {
        if (!FileUploadControlMutation.HasFile)
            return;

        IExcelDataReader excelReader = null;
        string fileName = FileUploadControlMutation.FileName;
        GeneralDAL _dal = new GeneralDAL();

        Hashtable headerMap = new Hashtable();
        Hashtable headerItemMap = new Hashtable();
        Hashtable headerDetailBuffer = new Hashtable();

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

            int excelRowIndex = 0;

            while (excelReader.Read())
            {
                excelRowIndex++;

                // ===== HEADER VALIDATION =====
                if (excelRowIndex == 1)
                {
                    if (!ValidateInventoryMutationTemplate(excelReader, fileName))
                        return;

                    continue;
                }

                int rowNumber = excelRowIndex - 1;

                try
                {
                    if (IsRowEmpty(excelReader))
                        break;

                    // ===== VALIDATION =====
                    if (IsEmpty(excelReader, 1)) throw new Exception("From Location wajib diisi (baris " + rowNumber + ")");
                    if (IsEmpty(excelReader, 2)) throw new Exception("To Branch wajib diisi (baris " + rowNumber + ")");
                    if (IsEmpty(excelReader, 3)) throw new Exception("To Location wajib diisi (baris " + rowNumber + ")");
                    if (IsEmpty(excelReader, 4)) throw new Exception("Description wajib diisi (baris " + rowNumber + ")");
                    if (IsEmpty(excelReader, 5)) throw new Exception("ITEM_CODE wajib diisi (baris " + rowNumber + ")");

                    int qty;
                    if (!TryConvertToInt(excelReader.GetValue(6), out qty) || qty <= 0)
                        throw new Exception("Quantity harus angka > 0 (baris " + rowNumber + ")");

                    string p_from_location = excelReader.GetString(1).Trim();
                    string p_to_branch = excelReader.GetString(2).Trim();
                    string p_to_location = excelReader.GetString(3).Trim();
                    string p_desc = excelReader.GetString(4).Trim();
                    string p_item_code = excelReader.GetString(5).Trim();

                    string headerKey = p_from_location + "|" + p_to_branch + "|" + p_to_location;

                    // === DUPLICATE ITEM CHECK ===
                    if (!headerItemMap.ContainsKey(headerKey))
                        headerItemMap[headerKey] = new Hashtable();

                    Hashtable itemMap = (Hashtable)headerItemMap[headerKey];
                    if (itemMap.ContainsKey(p_item_code))
                        throw new Exception("ITEM_CODE duplikat (baris " + rowNumber + ")");
                    itemMap[p_item_code] = true;

                    // === STOCK CHECK ===
                    int onhandQty = _dal.GetOnhandStock(p_item_code, p_from_location, "KPO");
                    if (onhandQty < qty)
                        throw new Exception("Stock tidak mencukupi (baris " + rowNumber + ")");

                    // === BUFFER DETAIL ===
                    if (!headerDetailBuffer.ContainsKey(headerKey))
                        headerDetailBuffer[headerKey] = new List<Hashtable>();

                    Hashtable detail = new Hashtable();
                    detail["p_item_code"] = p_item_code;
                    detail["p_quantity"] = qty;
                    detail["p_from_location"] = p_from_location;
                    detail["p_to_branch"] = p_to_branch;
                    detail["p_to_location"] = p_to_location;
                    detail["p_desc"] = p_desc;

                    ((List<Hashtable>)headerDetailBuffer[headerKey]).Add(detail);
                }
                catch (Exception exRow)
                {
                    Hashtable htLog = new Hashtable();
                    htLog["p_process_name"] = "INVENTORY_MUTATION_UPLOAD";
                    htLog["p_file_name"] = fileName;
                    htLog["p_row_number"] = rowNumber;
                    htLog["p_error_message"] = exRow.Message;
                    htLog["p_raw_data"] = "ITEM=" + excelReader.GetValue(5);
                    htLog["p_cre_by"] = Shared.CurrentUID;
                    htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;
                    _dal.InsertProcessErrorLog(htLog);
                    continue;
                }
            }

            // ===== INSERT HEADER & DETAIL (ONLY VALID GROUPS) =====
            foreach (DictionaryEntry entry in headerDetailBuffer)
            {
                string headerKey = entry.Key.ToString();
                List<Hashtable> details = (List<Hashtable>)entry.Value;

                if (details.Count == 0)
                    continue;

                string[] key = headerKey.Split('|');

                Hashtable htHeader = new Hashtable();
                htHeader["p_mutation_date"] = DateTime.Now;
                htHeader["p_expedition_description"] = details[0]["p_desc"];
                htHeader["p_branch_code"] = "KPO";
                htHeader["p_department_code"] = Shared.CurrentEmployeeDeptCodeDefault;
                htHeader["p_division_code"] = Shared.CurrentEmployeeDivCode;
                htHeader["p_sub_department_code"] = Shared.CurrentEmployeeSubDepartmentCode;
                htHeader["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
                //htHeader["p_remarks"] = description;
                htHeader["p_from_location"] = key[0];
                htHeader["p_to_branch"] = key[1];
                htHeader["p_to_location"] = key[2];
                htHeader["p_requestor"] = Shared.CurrentUID;
                htHeader["p_cre_date"] = DateTime.Now;
                htHeader["p_cre_by"] = Shared.CurrentUID;
                htHeader["p_cre_ip_address"] = Shared.CurrentIPAddress;
                htHeader["p_mod_date"] = DateTime.Now;
                htHeader["p_mod_by"] = Shared.CurrentUID;
                htHeader["p_mod_ip_address"] = Shared.CurrentIPAddress;

                string barcode = _dal.UploadWithReturnString("INVENTORY_MUTATION_HEADER", htHeader);

                foreach (Hashtable d in details)
                {
                    Hashtable htDetail = new Hashtable();
                    htDetail["p_im_code"] = barcode;
                    htDetail["p_item_code"] = d["p_item_code"];
                    htDetail["p_quantity"] = d["p_quantity"];
                    htDetail["p_remarks"] = "";
                    htDetail["p_cre_date"] = DateTime.Now;
                    htDetail["p_cre_by"] = Shared.CurrentUID;
                    htDetail["p_cre_ip_address"] = Shared.CurrentIPAddress;
                    htDetail["p_mod_date"] = DateTime.Now;
                    htDetail["p_mod_by"] = Shared.CurrentUID;
                    htDetail["p_mod_ip_address"] = Shared.CurrentIPAddress;
                    htDetail["p_from_branch_code"] = "KPO";
                    htDetail["p_from_location_code"] = d["p_from_location"];
                    htDetail["p_to_branch_code"] = d["p_to_branch"];
                    htDetail["p_to_location_code"] = d["p_to_location"];
                    htDetail["p_status"] = "NEW";                    

                    _dal.ExecSPReturnInt("xsp_inventory_mutation_detail_upload", htDetail);
                }
            }
        }
        finally
        {
            if (excelReader != null)
                excelReader.Close();
            BindData();
        }
    }
    private static readonly string[] INVENTORY_MUTATION_TEMPLATE_HEADERS =
    {
        "No",
        "From Location*",
        "To Branch*",
        "To Location*",
        "Description*",
        "ITEM_CODE*",
        "Quantity*"
    };
    private bool ValidateInventoryMutationTemplate(IExcelDataReader reader, string fileName)
    {
        GeneralDAL _dal = new GeneralDAL();
        Hashtable htLog = new Hashtable();

        // === VALIDASI JUMLAH KOLOM ===
        if (reader.FieldCount != INVENTORY_MUTATION_TEMPLATE_HEADERS.Length)
        {
            htLog["p_process_name"] = "INVENTORY_MUTATION_UPLOAD";
            htLog["p_file_name"] = fileName;
            htLog["p_row_number"] = 0; // HEADER
            htLog["p_error_message"] = "Format file tidak sesuai template. Jumlah kolom tidak valid.";
            htLog["p_raw_data"] = "HEADER VALIDATION";
            htLog["p_cre_by"] = Shared.CurrentUID;
            htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;

            _dal.InsertProcessErrorLog(htLog);
            return false;
        }

        // === VALIDASI NAMA HEADER ===
        for (int i = 0; i < INVENTORY_MUTATION_TEMPLATE_HEADERS.Length; i++)
        {
            string actualHeader = reader.GetValue(i) == null
                ? ""
                : reader.GetValue(i).ToString().Trim();

            if (!actualHeader.Equals(
                    INVENTORY_MUTATION_TEMPLATE_HEADERS[i],
                    StringComparison.OrdinalIgnoreCase
                ))
            {
                htLog.Clear();
                htLog["p_process_name"] = "INVENTORY_MUTATION_UPLOAD";
                htLog["p_file_name"] = fileName;
                htLog["p_row_number"] = 0;
                htLog["p_error_message"] =
                    "Header kolom ke-" + (i + 1)
                    + " tidak sesuai. Seharusnya: "
                    + INVENTORY_MUTATION_TEMPLATE_HEADERS[i];
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
    private bool TryConvertToInt(object value, out int result)
    {
        result = 0;
        if (value == null) return false;

        if (value is double)
        {
            result = Convert.ToInt32((double)value);
            return true;
        }

        return int.TryParse(value.ToString().Trim(), out result);
    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        if (ddlStatus.SelectedValue != "NEW" || ddlIsUpload.SelectedValue != "TRUE")
        {
            throw new Exception("Post hanya boleh untuk Status NEW dan IsUpload TRUE");
        }

        bool anyChecked = false;

        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("chkSelect");
            if (chk != null && chk.Checked)
            {
                anyChecked = true;
                break;
            }
        }

        if (!anyChecked)
        {
            throw new Exception("Pilih minimal 1 data untuk diposting");
        }
    }
    private void ControlPostButton()
    {
        bool isStatusNew = ddlStatus.SelectedValue == "NEW";
        bool isUploadTrue = ddlIsUpload.SelectedValue == "1";
        bool hasData = gvwList.Rows.Count > 0;

        if (isStatusNew && isUploadTrue && hasData)
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

}
