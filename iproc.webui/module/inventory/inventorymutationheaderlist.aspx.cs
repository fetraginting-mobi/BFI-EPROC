using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using Excel;
using System.IO;
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

            while (excelReader.Read())
            {
                excelRowIndex++;

                // ======================
                // SKIP HEADER
                // ======================
                if (excelRowIndex == 1)
                    continue;

                int rowNumber = excelRowIndex;

                // ======================
                // STOP JIKA BARIS KOSONG
                // ======================
                if (IsRowEmpty(excelReader))
                    break;

                // ======================
                // VALIDASI KOLOM WAJIB
                // ======================
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

                // ======================
                // QUANTITY (NUMERIC SAFE)
                // ======================
                object qtyValue = excelReader.GetValue(6);
                if (qtyValue == null || qtyValue == DBNull.Value)
                    throw new Exception("Quantity wajib diisi (baris " + rowNumber + ")");

                int qty;
                if (!TryConvertToInt(qtyValue, out qty))
                    throw new Exception("Quantity harus angka (baris " + rowNumber + ")");

                if (qty <= 0)
                    throw new Exception("Quantity harus lebih dari 0 (baris " + rowNumber + ")");

                // ======================
                // SET PARAMETER SP
                // ======================
                Hashtable ht = new Hashtable();
                ht["p_from_location"] = excelReader.GetString(1).Trim();
                ht["p_to_branch"] = excelReader.GetString(2).Trim();
                ht["p_to_location"] = excelReader.GetString(3).Trim();
                ht["p_description"] = excelReader.GetString(4).Trim();
                ht["p_item_code"] = excelReader.GetString(5).Trim();
                ht["p_quantity"] = qty;

                // ======================
                // EXEC SP
                // ======================
                // ExecRawSP("sp_insert_inventory", ht);
            }

            // lblMessage.Text = "Upload berhasil";
            // lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        catch (Exception ex)
        {
            // lblMessage.Text = ex.Message;
            // lblMessage.ForeColor = System.Drawing.Color.Red;
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
        try
        {
            if (value is double)
            {
                result = Convert.ToInt32((double)value);
                return true;
            }
            if (value is int)
            {
                result = (int)value;
                return true;
            }
            return int.TryParse(value.ToString().Trim(), out result);
        }
        catch
        {
            result = 0;
            return false;
        }
    }


}
