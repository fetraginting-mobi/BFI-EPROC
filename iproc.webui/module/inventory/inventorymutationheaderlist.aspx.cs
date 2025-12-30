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
        
        try
        {
            Stream excelStream = FileUploadControlMutation.PostedFile.InputStream;
            string ext = Path.GetExtension(FileUploadControlMutation.FileName).ToLower();

            if (ext == ".xls")
                excelReader = ExcelReaderFactory.CreateBinaryReader(excelStream);
            else if (ext == ".xlsx")
                excelReader = ExcelReaderFactory.CreateOpenXmlReader(excelStream);
            else
                throw new Exception("Format file tidak didukung");

            int excelRowIndex = 0;           

            Hashtable headerMap = new Hashtable();
            Hashtable headerItemMap = new Hashtable();

            while (excelReader.Read())
            {
                excelRowIndex++;
                if (excelRowIndex == 1)
                    continue;

                int rowNumber = (excelRowIndex-1);
                try
                {               
                    if (IsRowEmpty(excelReader))
                        break;
                    // ================= Add Mandatory Validation =================
                    if (IsEmpty(excelReader, 1))
                        throw new Exception("From Location wajib diisi (baris " + rowNumber + ")");
                    if (IsEmpty(excelReader, 2))
                        throw new Exception("To Branch wajib diisi (baris " + rowNumber + ")");
                    if (IsEmpty(excelReader, 3))
                        throw new Exception("To Location wajib diisi (baris " + rowNumber + ")");
                    if (IsEmpty(excelReader, 4))
                        throw new Exception("Description wajib diisi (baris " + rowNumber + ")");
                    if (IsEmpty(excelReader, 5))
                        throw new Exception("ITEM_CODE wajib diisi (baris " + rowNumber + ")");

                    object qtyValue = excelReader.GetValue(6);
                    if (qtyValue == null || qtyValue == DBNull.Value)
                        throw new Exception("Quantity wajib diisi (baris " + rowNumber + ")");
                    int qty;
                    if (!TryConvertToInt(qtyValue, out qty))
                        throw new Exception("Quantity harus angka (baris " + rowNumber + ")");
                    if (qty <= 0)
                        throw new Exception("Quantity harus lebih dari 0 (baris " + rowNumber + ")");

                    string p_from_location = excelReader.GetString(1).Trim();
                    string p_to_branch = excelReader.GetString(2).Trim();
                    string p_to_location = excelReader.GetString(3).Trim();
                    string p_expedition_description = excelReader.GetString(4).Trim();
                    string p_item_code = excelReader.GetString(5).Trim();
                    int p_quantity = qty;

                    string headerKey = p_from_location + "|" + p_to_branch + "|" + p_to_location;

                    if (!headerItemMap.ContainsKey(headerKey))
                        headerItemMap[headerKey] = new Hashtable();

                    Hashtable itemMap = (Hashtable)headerItemMap[headerKey];
                    if (itemMap.ContainsKey(p_item_code))
                        throw new Exception(
                            "ITEM_CODE '" + p_item_code + "'duplikat pada kombinasi lokasi yang sama (baris " + rowNumber + ")"
                        );
                    itemMap[p_item_code] = true;
                    string mutationBarcode = "";

                    if (!headerMap.ContainsKey(headerKey))
                    {
                        Hashtable _ht = new Hashtable();
                        _ht["p_mutation_date"] = DateTime.Now;
                        _ht["p_expedition_description"] = p_expedition_description;
                        _ht["p_branch_code"] = "KPO";
                        _ht["p_department_code"] = Shared.CurrentEmployeeDeptCodeDefault;
                        _ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
                        _ht["p_sub_department_code"] = Shared.CurrentEmployeeSubDepartmentCode;
                        _ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
                        //_ht["p_remarks"] = description;
                        _ht["p_from_location"] = p_from_location;
                        _ht["p_to_branch"] = p_to_branch;
                        _ht["p_to_location"] = p_to_location;
                        _ht["p_requestor"] = Shared.CurrentUID;
                        _ht["p_cre_date"] = DateTime.Now;
                        _ht["p_cre_by"] = Shared.CurrentUID;
                        _ht["p_cre_ip_address"] = Shared.CurrentIPAddress;
                        _ht["p_mod_date"] = DateTime.Now;
                        _ht["p_mod_by"] = Shared.CurrentUID;
                        _ht["p_mod_ip_address"] = Shared.CurrentIPAddress;

                        mutationBarcode = _dal.UploadWithReturnString("INVENTORY_MUTATION_HEADER", _ht);
                        headerMap[headerKey] = mutationBarcode;
                    }
                    else
                    {
                        mutationBarcode = headerMap[headerKey].ToString();    
                    }

                    int onhandQty = _dal.GetOnhandStock(p_item_code, p_from_location, "KPO");
                    if (onhandQty < p_quantity)
                    {
                        throw new Exception(
                            "Stock tidak mencukupi. Onhand: "
                            + onhandQty
                            + ", Request: "
                            + p_quantity
                            + " (baris " + rowNumber + ")"
                        );
                    }

                    Hashtable _htDetail = new Hashtable();
                    _htDetail["p_im_code"] = mutationBarcode;
                    _htDetail["p_item_code"] = p_item_code;
                    _htDetail["p_quantity"] = qty;
                    _htDetail["p_remarks"] = "";
                    _htDetail["p_cre_date"] = DateTime.Now;
                    _htDetail["p_cre_by"] = Shared.CurrentUID;
                    _htDetail["p_cre_ip_address"] = Shared.CurrentIPAddress;
                    _htDetail["p_mod_date"] = DateTime.Now;
                    _htDetail["p_mod_by"] = Shared.CurrentUID;
                    _htDetail["p_mod_ip_address"] = Shared.CurrentIPAddress;
                    _htDetail["p_from_branch_code"] = "KPO";
                    _htDetail["p_from_location_code"] = p_from_location;
                    _htDetail["p_to_branch_code"] = p_to_branch;
                    _htDetail["p_to_location_code"] = p_to_location;
                    _htDetail["p_status"] = "NEW";
                    _dal.ExecSPReturnInt("xsp_inventory_mutation_detail_upload", _htDetail);
                }
                catch (Exception exRow)
                {
                    Hashtable htLog = new Hashtable();
                    htLog["p_process_name"] = "INVENTORY_MUTATION_UPLOAD";
                    htLog["p_file_name"] = fileName;
                    htLog["p_row_number"] = rowNumber;
                    htLog["p_error_message"] = exRow.Message;
                    htLog["p_raw_data"] = "ITEM=" + (excelReader.GetValue(5) == null ? "" : excelReader.GetValue(5).ToString());
                    htLog["p_cre_by"] = Shared.CurrentUID;
                    htLog["p_cre_ip_address"] = Shared.CurrentIPAddress;
                    try
                    {
                        _dal.InsertProcessErrorLog(htLog);
                    }
                    catch (Exception logEx)
                    {
                        System.Diagnostics.Trace.WriteLine("LOG FAILED: " + logEx.Message);
                    }
                    continue;
                }
            }
        }
        finally
        {
            if (excelReader != null)
                excelReader.Close();
        }
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
}
