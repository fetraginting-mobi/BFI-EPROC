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

public partial class module_commonmst_masterbudgetinggroup : BasePage
{
    private static string TABLE_NAME = "MASTER_BUDGETING_GROUP";
    private static string TABLE_NAME_ROW = "MASTER_BUDGETING_GROUP";
   // string sfullname = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        
        btnDeleteItm.OnClientClick = "return confirm('Delete selected data?');";
        if (!Page.IsPostBack)
        {
            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranch(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindGroupLevel(ddlGroupLevel);

            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
            btnAddGroup.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=MBR&parc_branch_code={0}&gvw={1}&parc_division_code={2}&parc_department_code={3}&parc_sub_department_code={4}&parc_units_code={5}&parc_group_level={6}&parc_year={7}');"
                                                                                                                                , ddlBranch.ClientID, btnSearchQty.UniqueID
                                                                                                                                , ddlDivision.ClientID, ddlDepartment.ClientID
                                                                                                                                , ddlSubDepartment.ClientID, ddlUnits.ClientID
                                                                                                                                , ddlGroupLevel.ClientID, txtYear.ClientID);
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataItem();
                BindDataQty();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                ddlDepartment.Enabled = false;
                ddlDivision.Enabled = false;
                ddlBranch.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                txtYear.Enabled = false;
                ddlGroupLevel.Enabled = false;
                btnSave.Visible = false;
            }
            else
            {
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
               
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                Shared.BindGroupLevel(ddlGroupLevel);

                pnlAllBudget.Visible = false;
            }
        }
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

            _ht["p_code"] = Request.Params["code"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
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
        string iNextID = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_code"] = lblId.Text;


            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblId.Text = iNextID.ToString();
            }
            else
            {
                 _dal.Update("", "xsp_master_budgeting_group_header_update", _ht);
            }

            Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggroup.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&code={4}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, lblId.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void UploadData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    int iNextID = 0;
    //    string sFileDirectorys;
    //    FileUpload fupFile;
    //    string lblFileName;
    //    string sFileName;
    //    String sFilePath;
    //    sFilePath = string.Empty;
    //    int ctr;
    //    string filename;
    //    string log = "";
    //    //System.Diagnostics.Debugger.Break();
    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        sFileDirectorys = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/"));

    //        bool valid = true;

    //        if (fupFilename.HasFile)
    //        {
    //            sfullname = System.IO.Path.GetFileName(fupFilename.FileName);

    //            sFilePath = Shared.GetUploadPath("ADD_DOCUMENT/" + sfullname);
    //        }
    //        else
    //        {
    //            throw new Exception("Please insert file!");
    //        }

    //        fupFilename.SaveAs(sFileDirectorys + sfullname);
    //        log += "Upload file " + sfullname + " success.\t" + DateTime.Now.ToString() + "\n\r";
    //        FileStream stream = null;
    //        stream = File.Open(sFileDirectorys + sfullname, FileMode.Open, FileAccess.Read);

    //        IExcelDataReader excelReader = null;

    //        if (sfullname.Substring(sfullname.Length - 1, 1).ToString() == "x")
    //        {
    //            excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
    //        }
    //        else
    //            excelReader = ExcelReaderFactory.CreateBinaryReader(stream);

    //        ctr = 0;
    //        while (excelReader.Read())
    //        {
    //            if (ctr >= 1 && excelReader.GetString(0) != null)
    //            {
    //                try
    //                {


    //                    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //                    _ht["p_file"] = sfullname;
    //                    //_ht["p_customer_code"] = sFilePath;

    //                    _ht["p_id"] = 0;
    //                    _ht["p_customer_name"] = excelReader.GetString(0);
    //                    _ht["p_contract_no"] = excelReader.GetString(1);
    //                    _ht["p_periode"] = excelReader.GetString(2);
    //                    _ht["p_trx_type"] = excelReader.GetString(3);

    //                    // [+] Fajar 21/03/2017 15:39 Purpose :    hasil review ureq
    //                    _ht["p_tpv"] = excelReader.GetString(4);
    //                    _ht["p_tpt"] = excelReader.GetString(5);
    //                    //_ht["p_domestic_amount"] = excelReader.GetString(5);
    //                    //_ht["p_international_amount"] = excelReader.GetString(6);

    //                    //_ht["p_trx_date"] = excelReader.GetString(3);
    //                    //_ht["p_description"] = excelReader.GetString(4);
    //                    //_ht["p_currency_code"] = excelReader.GetString(5);
    //                    //_ht["p_qty"] = excelReader.GetString(6);
    //                    //_ht["p_price"] = excelReader.GetString(7);
    //                    //_ht["p_orig_amount"] = excelReader.GetString(8);
    //                    //_ht["p_ppn_tax"] = excelReader.GetString(9);
    //                    //_ht["p_pph_tax"] = excelReader.GetString(10);
    //                    //_ht["p_exch_rate"] = excelReader.GetString(11);
    //                    //_ht["p_base_amount"] = excelReader.GetString(12);
    //                    //_ht["p_doc_no"] = excelReader.GetString(13);


    //                    Shared.ApplyDefaultProp(_ht);

    //                    _dal.Insert(TABLE_NAME, _ht, ref iNextID);

    //                    _ht.Clear();

    //                }
    //                catch (Exception exc)
    //                {
    //                    log += "Insert row_format : row " + ctr.ToString() + " Failed.\t" + exc.InnerException.Message + "\t" + DateTime.Now.ToString() + "\n\r";
    //                    valid = false;
    //                }

    //            }
    //            ctr++;

    //        }

    //        Shared.ApplyDefaultProp(_ht);

    //        if (!System.IO.Directory.Exists(sFileDirectorys))
    //            System.IO.Directory.CreateDirectory(sFileDirectorys);

    //        if (fupFilename.HasFile)
    //        {
    //            if (!System.IO.File.Exists(sFileDirectorys + sfullname))
    //                fupFilename.SaveAs(sFileDirectorys + sfullname);
    //        }


    //        Shared.ShowSuccessGritter(this, string.Format("argeneratebillinglist.aspx"));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //protected void btnUpload_Click(object sender, EventArgs e)
    //{
    //    UploadData();
    //}


    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("masterbudgetinggrouplist.aspx");
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
            Shared.ExecuteReportExportExcel(this, null, "xsp_master_budgeting_group_getrows_all", _htParameters, pdfPath);
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

                                _htParameters["p_code"] = Request.Params["code"];
                                //_htParameters["p_budget_sequence"] = excelReader.GetString(1);
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
                                _htParameters["p_is_use"] = excelReader.GetString(40);
                                _htParameters["p_is_use_amount"] = excelReader.GetString(41);

                                Shared.ApplyDefaultProp(_htParameters);
                                _dal.Insert("","xsp_master_budgeting_group_upload_update", _htParameters);
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
                        Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggroup.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&code={4}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, lblId.Text));
                    else
                        Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggroup.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&code={4}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, lblId.Text));
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

    #region Qty
    private void BindDataQty()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchQty.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_division_code"] = ddlDivision.SelectedValue;
            _ht["p_department_code"] = ddlDepartment.SelectedValue;
            _ht["p_year"] = Request.Params["year"];// txtYear.Text;
            _ht["p_group_level"] = ddlGroupLevel.SelectedValue;


            var ifRowQty =  _dal.GetRows("", "xsp_master_budgeting_group_qty_getrows", _ht);

            //if (ifRowQty.Rows.Count > 0)
            //{
                gvwListQty.DataSource = ifRowQty;
                gvwListQty.DataBind();
            //}
            //else
            //{
            //    Shared.ShowValidationError(this, "There is no Qty, Please Setting First!");
            //    return;
            //}
        
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListQty_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListQty.PageIndex = e.NewPageIndex;
        BindDataQty();
    }

    protected void btnDeleteQty_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListQty.Rows)
        {
            CheckBox chbCheckedLot = (CheckBox)row.Cells[1].Controls[1];
            if (chbCheckedLot.Checked)
            {
                DeleteDataQty(gvwListQty.DataKeys[row.RowIndex][1].ToString());
            }
        }

        BindDataQty();
    }



    private void DeleteDataQty(string ITEM_GROUP_CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_item_group_code"] = ITEM_GROUP_CODE;

            _dal.ExecRawSP("xsp_master_budgeting_group_qty_delete", _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggroup.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&code={4}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, Request.Params["code"]));


        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchQty_Click(object sender, EventArgs e)
    {
        BindDataQty();

    }


    protected void chbCheckedAllQty_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListQty.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedQty") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    public void SaveQty()
    {
        //System.Diagnostics.Debugger.Break();
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }
        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(UpdQty.Controls, _ht);
      

        try
        {
         

            foreach (GridViewRow row in gvwListQty.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                CheckBox chbuse = (CheckBox)row.Cells[3].Controls[1];
                if (chb.Checked)
                {
                    TextBox txtQuantityJan = (row.Cells[4].Controls[1] as TextBox);
                    TextBox txtQuantityFeb = (row.Cells[4].Controls[5] as TextBox);
                    TextBox txtQuantityMar = (row.Cells[4].Controls[9] as TextBox);
                    TextBox txtQuantityApr = (row.Cells[4].Controls[13] as TextBox);
                    TextBox txtQuantityMei = (row.Cells[4].Controls[17] as TextBox);
                    TextBox txtQuantityJun = (row.Cells[4].Controls[21] as TextBox);
                    TextBox txtQuantityJul = (row.Cells[4].Controls[25] as TextBox);
                    TextBox txtQuantityAgust = (row.Cells[4].Controls[29] as TextBox);
                    TextBox txtQuantitySept = (row.Cells[4].Controls[33] as TextBox);
                    TextBox txtQuantityOkt = (row.Cells[4].Controls[37] as TextBox);
                    TextBox txtQuantityNov = (row.Cells[4].Controls[41] as TextBox);
                    TextBox txtQuantityDes = (row.Cells[4].Controls[45] as TextBox);

                   
                   
                    _ht["p_code"] = gvwListQty.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_budget_jan_qty"] = txtQuantityJan.Text;
                    _ht["p_budget_feb_qty"] = txtQuantityFeb.Text;
                    _ht["p_budget_mar_qty"] = txtQuantityMar.Text;
                    _ht["p_budget_apr_qty"] = txtQuantityApr.Text;
                    _ht["p_budget_mai_qty"] = txtQuantityMei.Text;
                    _ht["p_budget_jun_qty"] = txtQuantityJun.Text;
                    _ht["p_budget_jul_qty"] = txtQuantityJul.Text;
                    _ht["p_budget_agt_qty"] = txtQuantityAgust.Text;
                    _ht["p_budget_sep_qty"] = txtQuantitySept.Text;
                    _ht["p_budget_okt_qty"] = txtQuantityOkt.Text;
                    _ht["p_budget_nov_qty"] = txtQuantityNov.Text;
                    _ht["p_budget_des_qty"] = txtQuantityDes.Text;
                    _ht["p_item_group_code"] = gvwListQty.DataKeys[row.RowIndex][1].ToString();
                    if (chbuse.Checked)
                        _ht["p_is_use"] = "1";
                    else
                        _ht["p_is_use"] = "0";


                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "dbo.xsp_master_budgeting_group_qty_update", _ht);

                }
            }
            //Shared.ShowSuccessGritter(this, string.Format("masterbudgeting.aspx?action=edit&id={0}", lblId.Text)); 
            Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggroup.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&code={4}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, Request.Params["code"]));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    public void RevisiQty()
    {
        //System.Diagnostics.Debugger.Break();
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }
        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(UpdQty.Controls, _ht);


        try
        {


            foreach (GridViewRow row in gvwListQty.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                CheckBox chbuse = (CheckBox)row.Cells[3].Controls[1];
                if (chb.Checked)
                {
                    TextBox txtQuantityJan = (row.Cells[4].Controls[1] as TextBox);
                    TextBox txtQuantityFeb = (row.Cells[4].Controls[5] as TextBox);
                    TextBox txtQuantityMar = (row.Cells[4].Controls[9] as TextBox);
                    TextBox txtQuantityApr = (row.Cells[4].Controls[13] as TextBox);
                    TextBox txtQuantityMei = (row.Cells[4].Controls[17] as TextBox);
                    TextBox txtQuantityJun = (row.Cells[4].Controls[21] as TextBox);
                    TextBox txtQuantityJul = (row.Cells[4].Controls[25] as TextBox);
                    TextBox txtQuantityAgust = (row.Cells[4].Controls[29] as TextBox);
                    TextBox txtQuantitySept = (row.Cells[4].Controls[33] as TextBox);
                    TextBox txtQuantityOkt = (row.Cells[4].Controls[37] as TextBox);
                    TextBox txtQuantityNov = (row.Cells[4].Controls[41] as TextBox);
                    TextBox txtQuantityDes = (row.Cells[4].Controls[45] as TextBox);



                    _ht["p_code"] = gvwListQty.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_budget_jan_qty"] = txtQuantityJan.Text;
                    _ht["p_budget_feb_qty"] = txtQuantityFeb.Text;
                    _ht["p_budget_mar_qty"] = txtQuantityMar.Text;
                    _ht["p_budget_apr_qty"] = txtQuantityApr.Text;
                    _ht["p_budget_mai_qty"] = txtQuantityMei.Text;
                    _ht["p_budget_jun_qty"] = txtQuantityJun.Text;
                    _ht["p_budget_jul_qty"] = txtQuantityJul.Text;
                    _ht["p_budget_agt_qty"] = txtQuantityAgust.Text;
                    _ht["p_budget_sep_qty"] = txtQuantitySept.Text;
                    _ht["p_budget_okt_qty"] = txtQuantityOkt.Text;
                    _ht["p_budget_nov_qty"] = txtQuantityNov.Text;
                    _ht["p_budget_des_qty"] = txtQuantityDes.Text;
                    _ht["p_item_group_code"] = gvwListQty.DataKeys[row.RowIndex][1].ToString();
                    if (chbuse.Checked)
                        _ht["p_is_use"] = "1";
                    else
                        _ht["p_is_use"] = "0";


                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "dbo.xsp_master_budgeting_group_qty_update_revisi", _ht);

                }
            }
            //Shared.ShowSuccessGritter(this, string.Format("masterbudgeting.aspx?action=edit&id={0}", lblId.Text)); 
            Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggroup.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&code={4}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, Request.Params["code"]));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListQty.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
    protected void btnSaveQty_Click(object sender, EventArgs e)
    {
        SaveQty();
    }

    protected void btnRevisiQty_Click(object sender, EventArgs e)
    {
        RevisiQty();
    }

    protected void gvwListQty_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            btnDeleteQty.OnClientClick = "return confirm('Delete selected data?');";

            string isUse = "";

            CheckBox chbUse = (CheckBox)e.Row.FindControl("chbUse");

            isUse = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IS_USE"));

            if (isUse == "1")
                chbUse.Checked = true;
            else
                chbUse.Checked = false;


        }
    }
    #endregion

    #region Item
    private void BindDataItem()
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchItm.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_division_code"] = ddlDivision.SelectedValue;
            _ht["p_department_code"] = ddlDepartment.SelectedValue;
            _ht["p_group_level"] = ddlGroupLevel.SelectedValue;
            _ht["p_year"] = Request.Params["year"];//txtYear.Text;

            var ifRowItem = _dal.GetRows("", "xsp_master_budgeting_group_amount_getrows", _ht);

            //if (ifRowItem.Rows.Count > 0)
            //{
                gvwListItm.DataSource = ifRowItem;
                gvwListItm.DataBind();
            //}
            //else
            //{
            //    Shared.ShowValidationError(this, "There is no Item, Please Setting First!");
            //    return;
            //}

            
            //if (gvwListItm.DataSource. > 0) 
            //{
            //    gvwListItm.DataBind();
            //}
            
        }


        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListItm_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListItm.PageIndex = e.NewPageIndex;
        BindDataItem();
    }

    protected void btnDeleteItm_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListItm.Rows)
        {
            CheckBox chbCheckedItm = (CheckBox)row.Cells[1].Controls[1];
            if (chbCheckedItm.Checked)
            {
                DeleteDataItm(gvwListItm.DataKeys[row.RowIndex][1].ToString());
            }
        }

        BindDataItem();
    }



    private void DeleteDataItm(string ITEM_GROUP_CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_item_group_code"] = ITEM_GROUP_CODE;

            _dal.ExecRawSP("xsp_master_budgeting_group_detail_amount_delete", _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggroup.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&code={4}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, Request.Params["code"]));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchItm_Click(object sender, EventArgs e)
    {
        BindDataItem();

    }

    protected void chbCheckedAllItm_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListItm.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedItm") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    

    public void SaveItm()
    {
        
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExistItem())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(updItm.Controls, _ht);

        try
        {
          

            foreach (GridViewRow row in gvwListItm.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                CheckBox chbUseAmount = (CheckBox)row.Cells[3].Controls[1];
                if (chb.Checked)
                {

                    TextBox txtAmountJan = (row.Cells[4].Controls[1] as TextBox);
                    TextBox txtAmountFeb = (row.Cells[4].Controls[5] as TextBox);
                    TextBox txtAmountMar = (row.Cells[4].Controls[9] as TextBox);
                    TextBox txtAmountApr = (row.Cells[4].Controls[13] as TextBox);
                    TextBox txtAmountMei = (row.Cells[4].Controls[17] as TextBox);
                    TextBox txtAmountJun = (row.Cells[4].Controls[21] as TextBox);
                    TextBox txtAmountJul = (row.Cells[4].Controls[25] as TextBox);
                    TextBox txtAmountAgust = (row.Cells[4].Controls[29] as TextBox);
                    TextBox txtAmountSept = (row.Cells[4].Controls[33] as TextBox);
                    TextBox txtAmountOkt = (row.Cells[4].Controls[37] as TextBox);
                    TextBox txtAmountNov = (row.Cells[4].Controls[41] as TextBox);
                    TextBox txtAmountDes = (row.Cells[4].Controls[45] as TextBox);

                    _ht["p_code"] = gvwListItm.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_budget_jan_amount"] = txtAmountJan.Text;
                    _ht["p_budget_feb_amount"] = txtAmountFeb.Text;
                    _ht["p_budget_mar_amount"] = txtAmountMar.Text;
                    _ht["p_budget_apr_amount"] = txtAmountApr.Text;
                    _ht["p_budget_mai_amount"] = txtAmountMei.Text;
                    _ht["p_budget_jun_amount"] = txtAmountJun.Text;
                    _ht["p_budget_jul_amount"] = txtAmountJul.Text;
                    _ht["p_budget_agt_amount"] = txtAmountAgust.Text;
                    _ht["p_budget_sep_amount"] = txtAmountSept.Text;
                    _ht["p_budget_okt_amount"] = txtAmountOkt.Text;
                    _ht["p_budget_nov_amount"] = txtAmountNov.Text;
                    _ht["p_budget_des_amount"] = txtAmountDes.Text;
                    _ht["p_item_group_code"] = gvwListItm.DataKeys[row.RowIndex][1].ToString();
                    if (chbUseAmount.Checked)
                        _ht["p_is_use_amount"] = "1";
                    else
                        _ht["p_is_use_amount"] = "0";

                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "xsp_master_budgeting_group_update", _ht);
                }

            }
            //Shared.ShowSuccessGritter(this, string.Format("masterbudgeting.aspx?action=edit&id={0}", lblId.Text));
            Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggroup.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&code={4}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, Request.Params["code"]));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    public void RevisiItm()
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExistItem())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(updItm.Controls, _ht);

        try
        {


            foreach (GridViewRow row in gvwListItm.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                CheckBox chbUseAmount = (CheckBox)row.Cells[3].Controls[1];
                if (chb.Checked)
                {

                    TextBox txtAmountJan = (row.Cells[4].Controls[1] as TextBox);
                    TextBox txtAmountFeb = (row.Cells[4].Controls[5] as TextBox);
                    TextBox txtAmountMar = (row.Cells[4].Controls[9] as TextBox);
                    TextBox txtAmountApr = (row.Cells[4].Controls[13] as TextBox);
                    TextBox txtAmountMei = (row.Cells[4].Controls[17] as TextBox);
                    TextBox txtAmountJun = (row.Cells[4].Controls[21] as TextBox);
                    TextBox txtAmountJul = (row.Cells[4].Controls[25] as TextBox);
                    TextBox txtAmountAgust = (row.Cells[4].Controls[29] as TextBox);
                    TextBox txtAmountSept = (row.Cells[4].Controls[33] as TextBox);
                    TextBox txtAmountOkt = (row.Cells[4].Controls[37] as TextBox);
                    TextBox txtAmountNov = (row.Cells[4].Controls[41] as TextBox);
                    TextBox txtAmountDes = (row.Cells[4].Controls[45] as TextBox);

                    _ht["p_code"] = gvwListItm.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_budget_jan_amount"] = txtAmountJan.Text;
                    _ht["p_budget_feb_amount"] = txtAmountFeb.Text;
                    _ht["p_budget_mar_amount"] = txtAmountMar.Text;
                    _ht["p_budget_apr_amount"] = txtAmountApr.Text;
                    _ht["p_budget_mai_amount"] = txtAmountMei.Text;
                    _ht["p_budget_jun_amount"] = txtAmountJun.Text;
                    _ht["p_budget_jul_amount"] = txtAmountJul.Text;
                    _ht["p_budget_agt_amount"] = txtAmountAgust.Text;
                    _ht["p_budget_sep_amount"] = txtAmountSept.Text;
                    _ht["p_budget_okt_amount"] = txtAmountOkt.Text;
                    _ht["p_budget_nov_amount"] = txtAmountNov.Text;
                    _ht["p_budget_des_amount"] = txtAmountDes.Text;
                    _ht["p_item_group_code"] = gvwListItm.DataKeys[row.RowIndex][1].ToString();
                    if (chbUseAmount.Checked)
                        _ht["p_is_use_amount"] = "1";
                    else
                        _ht["p_is_use_amount"] = "0";

                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "xsp_master_budgeting_group_amount_update_revisi", _ht);
                }

            }
            //Shared.ShowSuccessGritter(this, string.Format("masterbudgeting.aspx?action=edit&id={0}", lblId.Text));
            Shared.ShowSuccessGritter(this, string.Format("masterbudgetinggroup.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&code={4}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, Request.Params["code"]));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSaveItm_Click(object sender, EventArgs e)
    {
        SaveItm();
    }

    protected void btnRevisiItm_Click(object sender, EventArgs e)
    {
        RevisiItm();
    }

    private Boolean SelectedExistItem()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListItm.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
    protected void gvwListItm_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        btnDeleteItm.OnClientClick = "return confirm('Delete selected data?');";

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string isUseAmount = "";

            CheckBox chbUseAmount = (CheckBox)e.Row.FindControl("chbUseAmount");

            isUseAmount = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IS_USE_AMOUNT"));

            if (isUseAmount == "1")
                chbUseAmount.Checked = true;
            else
                chbUseAmount.Checked = false;

        }
    }

    #endregion
}
