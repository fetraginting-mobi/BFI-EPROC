using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Excel;
using System.IO;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterbudgetinggrouplist : BasePageList
{
    private static string TABLE_NAME = "MASTER_BUDGETING_GROUP";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "MASTER_BUDGETING_GROUP";
        NEXT_PAGE = "masterbudgetinggroup.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll(ddlBranch);
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

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

            _ht["p_code"] = code;
           


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
        Response.Redirect("masterbudgetinggroup.aspx?action=add");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][4].ToString());
            }
        }

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


            string pdfName = "upload_row_format" + Shared.CurrentUID + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx"; ;
            string pdfPath = Server.MapPath(@"..\..\template\" + pdfName);
            string filetype = "xls";


            // menampilkan pdf yang sudah dibuat
            Shared.ExecuteReportExportExcel(this, null, "xsp_master_budgeting_group_getrows_list_all", _htParameters, pdfPath);
            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../template/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
        }

        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnUploadRowFormat_Click(object sender, EventArgs e)
    {
        //System.Diagnostics.Debugger.Break();
        //string asd = "";
        bool valid = true;
        DateTime datetime;
        if (FileUploadControlAmort.HasFile)
        {
            string filename, saveAsFileName;
            string extension;
            int ctr;
            int iNextID = 0;
            filename = FileUploadControlAmort.FileName.ToString();
            string[] s = filename.Split('.');
            extension = s[s.Length - 1];
            saveAsFileName = "row_format" + DateTime.Now.ToString("yyyyMMddhhmmss") + "." + extension;
            string contenttype = FileUploadControlAmort.PostedFile.ContentType.ToString();
            string log = "";

            Hashtable _htParameters = null;
            GeneralDAL _dal = null;
            Hashtable _ht = null;
            //int iNextID2 = 0;

            try
            {
                _htParameters = new Hashtable();
                _ht = new Hashtable();
                _dal = new GeneralDAL();
                if (contenttype == "application/octet-stream" || contenttype == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" || contenttype == "application/vnd.ms-excel")
                {
                    FileUploadControlAmort.SaveAs(Server.MapPath(@"../../temp/xls/") + saveAsFileName);
                    log += "Upload file " + filename + " success.\t" + DateTime.Now.ToString() + "\n\r";
                    FileStream stream = null;
                    stream = File.Open(Server.MapPath(@"../../temp/xls/") + saveAsFileName, FileMode.Open, FileAccess.Read);
                    IExcelDataReader excelReader = null;

                    if (filename.Substring(filename.Length - 1, 1).ToString() == "x")
                    {
                        excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                    }
                    else
                        excelReader = ExcelReaderFactory.CreateBinaryReader(stream);

                    ctr = 0;
                    while (excelReader.Read())
                    {
                        if (ctr >= 1)
                        {
                            try
                            {
                                _htParameters.Clear();

                                _htParameters.Clear();

                                _htParameters["p_code"] = "";
                               // _htParameters["p_budget_sequence"] = excelReader.GetString(1);
                                _htParameters["p_branch_code"] = excelReader.GetString(2);
                                _htParameters["p_department_code"] = excelReader.GetString(3);
                                _htParameters["p_division_code"] = excelReader.GetString(4);
                                _htParameters["p_sub_department_code"] = excelReader.GetString(5);
                                _htParameters["p_units_code"] = excelReader.GetString(6);
                                _htParameters["p_budget_jan_qty"] = excelReader.GetDecimal(7);
                                _htParameters["p_budget_feb_qty"] = excelReader.GetDecimal(8);
                                _htParameters["p_budget_mar_qty"] = excelReader.GetDecimal(9);
                                _htParameters["p_budget_apr_qty"] = excelReader.GetDecimal(10);
                                _htParameters["p_budget_mai_qty"] = excelReader.GetDecimal(11);
                                _htParameters["p_budget_jun_qty"] = excelReader.GetDecimal(12);
                                _htParameters["p_budget_jul_qty"] = excelReader.GetDecimal(13);
                                _htParameters["p_budget_agt_qty"] = excelReader.GetDecimal(14);
                                _htParameters["p_budget_sep_qty"] = excelReader.GetDecimal(15);
                                _htParameters["p_budget_okt_qty"] = excelReader.GetDecimal(16);
                                _htParameters["p_budget_nov_qty"] = excelReader.GetDecimal(17);
                                _htParameters["p_budget_des_qty"] = excelReader.GetDecimal(18);
                                _htParameters["p_item_group_code"] = excelReader.GetString(19);
                                _htParameters["p_budget_jan_amount"] = excelReader.GetDecimal(20);
                                _htParameters["p_budget_feb_amount"] = excelReader.GetDecimal(21);
                                _htParameters["p_budget_mar_amount"] = excelReader.GetDecimal(22);
                                _htParameters["p_budget_apr_amount"] = excelReader.GetDecimal(23);
                                _htParameters["p_budget_mai_amount"] = excelReader.GetDecimal(24);
                                _htParameters["p_budget_jun_amount"] = excelReader.GetDecimal(25);
                                _htParameters["p_budget_jul_amount"] = excelReader.GetDecimal(26);
                                _htParameters["p_budget_agt_amount"] = excelReader.GetDecimal(27);
                                _htParameters["p_budget_sep_amount"] = excelReader.GetDecimal(28);
                                _htParameters["p_budget_okt_amount"] = excelReader.GetDecimal(29);
                                _htParameters["p_budget_nov_amount"] = excelReader.GetDecimal(30);
                                _htParameters["p_budget_des_amount"] = excelReader.GetDecimal(31);
                                _htParameters["p_year"] = excelReader.GetString(32);
                                _htParameters["p_cre_date"] = excelReader.GetString(33);
                                _htParameters["p_cre_by"] = excelReader.GetString(34);
                                _htParameters["p_cre_ip_address"] = excelReader.GetString(35);
                                _htParameters["p_mod_date"] = excelReader.GetString(36);
                                _htParameters["p_mod_by"] = excelReader.GetString(37);
                                _htParameters["p_mod_ip_address"] = excelReader.GetString(38);
                                _htParameters["p_group_level"] = excelReader.GetString(39);
                                _htParameters["p_is_use"] = "0";
                                _htParameters["p_is_use_amount"] = "0";

                                Shared.ApplyDefaultProp(_htParameters);
                                _dal.Insert("", "xsp_master_budgeting_group_upload_insert", _htParameters);
                                log += "Insert row_format : row " + ctr.ToString() + " Success.\t" + DateTime.Now.ToString() + "\n\r";
                            }
                            catch (Exception exc)
                            {
                                log += "Insert row_format : row " + ctr.ToString() + " Failed.\t" + exc.InnerException.Message + "\t" + DateTime.Now.ToString() + "\n\r";
                                valid = false;
                            }
                        }
                        ctr++;
                    }
                    excelReader.Close();
                    if (stream != null)
                    {
                        stream.Close();
                        stream.Dispose();
                    }

                    if (valid)
                        Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggrouplist.aspx"));
                    else
                        Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggrouplist.aspx"));
                }
                else
                {
                    Shared.ShowErrorDialog(this, null);
                }
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }

            //simpan log
            FileStream fs = null;
            StreamWriter sw = null;
            string filepath = Server.MapPath(@"../../temp/txt/") + "row_format.txt";
            try
            {
                fs = new FileStream(filepath, FileMode.Create, FileAccess.ReadWrite);

                sw = new StreamWriter(fs);
                sw.WriteLine(log);
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
            finally
            {
                if (sw != null)
                {
                    sw.Close();
                    sw.Dispose();
                }

                if (fs != null)
                {
                    fs.Close();
                    fs.Dispose();
                }
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("masterbudgetinggroup.aspx?action=edit&code=" + gvwList.SelectedDataKey[4].ToString() + "&year=" + gvwList.SelectedDataKey[3].ToString());
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
