using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;

using System.Linq;
using System.Web;

using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
using System.IO;
using Excel;



public partial class module_accounting_financialrptgen : BasePage
{
    private static string TABLE_NAME = "SYS_MASTER_REPORT_FINANCIAL";

    private static string TABLE_NAME_ROW = "SYS_MASTER_REPORT_FINANCIAL_ROW";

    private static string TABLE_NAME_COLUMN = "SYS_MASTER_REPORT_FINANCIAL_COLUMN";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            //Shared.TypeGroup(ddlType);
            Shared.BindCurrencyCode(ddlCurrencyCode);
            BindFormula();
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataRow();
                //BindDataColumn();
                btnSave.Visible = true;
                btnCancel.Visible = true;
                //btnAddColumn.Visible = true;
                // btnDeleteColumn.Visible = true;
                btnAddRow.Visible = true;
                btnDeleteRow.Visible = true;

                btnCancel.Text = "Back";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                //btnCancel.OnClientClick = "return confirm('Delete selected data?');";
                btnDeleteRow.OnClientClick = "return confirm('Delete selected data?');";
                //btnDeleteColumn.OnClientClick = "return confirm('Delete selected data?');";
                txtCode.Enabled = false;

            }
            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

            //else
            //{
            //    btnSave.Visible = btnCancel.Visible = true;
            //    btnAddRow.Visible = btnDeleteRow.Visible = true;
            //    pnlFinance.Visible = false;
            //}
        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = Request.Params["code"];
            //_ht["p_col_no"] = lblCol.Text;
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht);
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("financialrptgen.aspx?action=edit&code={0}", txtCode.Text));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void BindFormula()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddlFormula.DataSource = _dal.GetRows("SYS_MASTER_REPORT_FINANCIAL_FORMULA", _ht);
            ddlFormula.DataTextField = "DESCRIPTION";
            ddlFormula.DataValueField = "CODE";
            ddlFormula.DataBind();

        }
        catch (Exception)
        {
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("financialrptgenlist.aspx");
    }

    #region Row
    private void BindDataRow()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchRow.Text;
            _ht["p_report_code"] = txtCode.Text;

            gvwListRow.DataSource = _dal.GetRows(TABLE_NAME_ROW, _ht);
            gvwListRow.DataBind();
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

            _dal.Delete(TABLE_NAME_ROW, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
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
            _htParameters["p_report_code"] = txtCode.Text;


            string pdfName = "upload_row_format" + Shared.CurrentUID + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx"; ;
            string pdfPath = Server.MapPath(@"..\..\template\" + pdfName);
            //string filetype = "xls";
            

            // menampilkan pdf yang sudah dibuat
            Shared.ExecuteReportExportExcel(this, null, "xsp_sys_master_report_financial_row_download", _htParameters, pdfPath);
            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../template/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
        }

        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnUploadRowFormat_Click(object sender, EventArgs e)
    {
     
        //string asd = "";
        bool valid = true;
        //DateTime datetime;
        if (FileUploadControlAmort.HasFile)
        {
            string filename, saveAsFileName;
            string extension;
            int ctr;
            //int iNextID = 0;
            filename = FileUploadControlAmort.FileName.ToString();
            string[] s = filename.Split('.');
            extension = s[s.Length - 1];
            saveAsFileName = "row_format" + DateTime.Now.ToString("yyyyMMddhhmmss") + "." + extension;
            string contenttype = FileUploadControlAmort.PostedFile.ContentType.ToString();
            string log = "";

            Hashtable _htParameters = null;
            GeneralDAL _dal = null;
            Hashtable _ht = null;
            int iNextID2 = 0;

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

                                _htParameters["p_id"] = 0;
                                _htParameters["p_row_no"] = excelReader.GetString(0);
                                _htParameters["p_report_code"] = txtCode.Text;
                                _htParameters["p_fmt_1"] = excelReader.GetString(1);
                                _htParameters["p_fmt_2"] = excelReader.GetString(2);
                                _htParameters["p_fmt_3"] = excelReader.GetString(3);
                                _htParameters["p_page"] = excelReader.GetDecimal(4);
                                _htParameters["p_acc_code"] = excelReader.GetString(5);
                                _htParameters["p_fmt_desc"] = excelReader.GetString(6);

                                Shared.ApplyDefaultProp(_htParameters);
                                _dal.Insert(TABLE_NAME_ROW, _htParameters, ref iNextID2);
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
                        Shared.ShowSuccessGritter(this, "financialrptgen.aspx?action=edit" + "&code=" + txtCode.Text);
                    else
                        Shared.ShowSuccessGritter(this, "financialrptgen.aspx?action=edit" + "&code=" + txtCode.Text);
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

    protected void gvwListRow_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListRow.PageIndex = e.NewPageIndex;
        BindDataRow();
    }

    protected void btnAddRow_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("financialrptgenrow.aspx?action=add&reportcode={0}", txtCode.Text));
    }

    protected void btnDeleteRow_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListRow.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwListRow.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataRow();
    }

    protected void btnSearchRow_Click(object sender, EventArgs e)
    {
        BindDataRow();
    }
    protected void gvwListRow_SelectedIndexChangedRow(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("financialrptgenrow.aspx?action=edit&reportcode={0}&id={1}", txtCode.Text, gvwListRow.SelectedDataKey[0].ToString()));
    }

    protected void chbCheckedAllRow_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListRow.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedRow") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    #endregion

    #region Column
    private void BindDataColumn()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;


        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //_ht["p_col_no"] = Request.Params["col_no"];
            _ht["p_report_code"] = Request.Params["code"];

            DataRow _dr = _dal.GetRow(TABLE_NAME_COLUMN, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnAddColumn_Click(object sender, EventArgs e)
    {
        //Response.Redirect(string.Format("financialrptgencolumn.aspx?action=add&reportcode={0}", txtCode.Text));
    }

    protected void btnDeleteColumn_Click(object sender, EventArgs e)
    {
        //foreach (GridViewRow row in gvwListColumn.Rows)
        //{
        //    CheckBox chbColumn = (CheckBox)row.Cells[1].Controls[1];
        //    if (chbColumn.Checked)
        //    {
        //        DeleteDataColumn(gvwListColumn.DataKeys[row.RowIndex][0].ToString());
        //    }
        //}
        //BindDataColumn();
    }

    protected void txtOnTextChanged(object sender, EventArgs e)
    {

        // Call the base OnTextChanged method. 


    }


    protected void Formula_CheckedChanged(object sender, EventArgs e)
    {

        // Call the base OnTextChanged method. 


    }

    private void SaveDataColumn()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        // 
        try
        {

            _dal = new GeneralDAL();
            _ht = new Hashtable();

            // _ht["p_col_no"] = lblCol.Text;
            _ht["p_report_code"] = txtCode.Text;
            _ht["p_formula"] = ddlFormula.SelectedValue;
            //_ht["p_rbl1"] = rbl1.GetType();
            //_ht["p_rbl2"] = rbl2.GetType();
            //_ht["p_rbl3"] = rbl3.GetType();
            //_ht["p_rbl4"] = rbl4.GetType();
            //_ht["p_rbl5"] = rbl5.GetType();
            //_ht["p_rbl6"] = rbl6.GetType();
            //_ht["p_rbl7"] = rbl7.GetType();
            //_ht["p_rbl8"] = rbl8.GetType();
            //_ht["p_rbl9"] = rbl9.GetType();
            //_ht["p_rbl10"] = rbl10.GetType();
            //_ht["p_rbl11"] = rbl11.GetType();
            //_ht["p_rbl12"] = rbl12.GetType();
            //_ht["p_rbl13"] = rbl13.GetType();
            //_ht["p_rbl14"] = rbl14.GetType();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            //if (Request.Params["action"].Equals("add"))
            //{
            //    _dal.Insert(TABLE_NAME_COLUMN, _ht);
            //}
            //else
            _dal.Update(TABLE_NAME_COLUMN, _ht);

            Shared.ShowSuccessGritter(this, string.Format("financialrptgen.aspx?action=edit&code={0}", txtCode.Text));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }


    }

    protected void btnSaveColumn_Click(object sender, EventArgs e)
    {
        if (rbl1.Checked)
        {
            txtFormula1.Text = txtFormula1.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl2.Checked)
        {
            txtFormula2.Text = txtFormula2.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl3.Checked)
        {
            txtFormula3.Text = txtFormula3.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl4.Checked)
        {
            txtFormula4.Text = txtFormula4.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl5.Checked)
        {
            txtFormula5.Text = txtFormula5.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl6.Checked)
        {
            txtFormula6.Text = txtFormula6.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl7.Checked)
        {
            txtFormula7.Text = txtFormula7.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl8.Checked)
        {
            txtFormula8.Text = txtFormula8.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl9.Checked)
        {
            txtFormula9.Text = txtFormula9.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl10.Checked)
        {
            txtFormula10.Text = txtFormula10.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl11.Checked)
        {
            txtFormula11.Text = txtFormula11.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl12.Checked)
        {
            txtFormula12.Text = txtFormula12.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl13.Checked)
        {
            txtFormula13.Text = txtFormula13.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
        else if (rbl14.Checked)
        {
            txtFormula14.Text = txtFormula14.Text.Trim() + ' ' + ddlFormula.SelectedValue + ' ';
            SaveDataColumn();
        }
    }

    private void DeleteDataColumn(string ID)
    {
        //GeneralDAL _dal = null;
        //Hashtable _ht = null;

        try
        {
            //_dal = new GeneralDAL();
            //_ht = new Hashtable();

            //Shared.ApplyDefaultProp(_ht);

            //_ht["p_col_no"] = ID;

            //_dal.Delete(TABLE_NAME_COLUMN, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListColumn_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gvwListColumn.PageIndex = e.NewPageIndex;
        //BindDataColumn();
    }

    protected void btnSearchColumn_Click(object sender, EventArgs e)
    {
        BindDataColumn();
    }
    protected void gvwListColumn_SelectedIndexChangedColumn(object sender, EventArgs e)
    {
        //Response.Redirect(string.Format("financialrptgencolumn.aspx?action=edit&reportcode={0}&id={1}", txtCode.Text, gvwListColumn.SelectedDataKey[0].ToString()));
    }

    protected void chbCheckedAllColumn_CheckedChanged(object sender, EventArgs e)
    {
        //foreach (GridViewRow gvr in gvwListColumn.Rows)
        //{
        //    CheckBox cbSelect = gvr.FindControl("chbCheckedColumn") as CheckBox;
        //    cbSelect.Checked = ((CheckBox)sender).Checked;
        //}
    }

    #endregion

}
