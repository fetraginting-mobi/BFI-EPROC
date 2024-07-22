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

public partial class module_fa_fainsurancelist : BasePageList
{

    private static string TABLE_NAME = "FA_ASSET_INSURANCE";
  

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "FA_ASSET";
        NEXT_PAGE = "faasset.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            //Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "FA");
            Shared.BindBranchEmployeeAll(ddlBranch);
            Shared.BindBranchEmployeeAll(ddlCostCenterIns);
            Shared.BindBranchEmployeeAll(ddlcostcenternotin);
            Shared.BindOwnerReportAll(ddlOwnerNonIns);
            Shared.BindOwnerReportAll(ddlOwnerIns);
            Shared.BindOwnerReportAll(ddlOwnerList);
            //txtFromDueDate.Text = Shared.CurrentStartAccDate;
            //txtToDueDate.Text = Shared.CurrentStartAccDate;
            btnProcessInsurance.OnClientClick = "return confirm('Regist Insurance Selected Asset?');";
            btnProcess.OnClientClick = "return confirm('Update Insurance Selected Asset?');";

            BindData();
            BindDataNotin();
            BindDataIns();
            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();
            //btnDelete.OnClientClick = "return confirm('Delete selected data?');";
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
            _htParameters["p_code"] = Request.Params["code"];


            string pdfName = "upload_row_format" + Shared.CurrentUID + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx"; ;
           // string pdfPath = Server.MapPath(@"..\..\template\" + pdfName);
            string pdfPath = Server.MapPath(@"..\..\temp\" + pdfName);
         
            string filetype = "xls";


            // menampilkan pdf yang sudah dibuat
            Shared.ExecuteReportExportExcel(this, null, "xsp_fa_not_insurance_getrows_upload", _htParameters, pdfPath);
            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
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
                    FileUploadControlAmort.SaveAs(Server.MapPath(@"../../temp/") + saveAsFileName);
                    log += "Upload file " + filename + " success.\t" + DateTime.Now.ToString() + "\n\r";
                    FileStream stream = null;
                    stream = File.Open(Server.MapPath(@"../../temp/") + saveAsFileName, FileMode.Open, FileAccess.Read);
                    IExcelDataReader excelReader = null;


                    int fileSize = FileUploadControlAmort.PostedFile.ContentLength;

                    if (FileUploadControlAmort.PostedFile.ContentLength > 3000000) // (+) Ari 13-09-2022 ket : cek size file Max 3MB.
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "fx", "fnShowErrorNotif('Maximum file size allowed is 3 mb.', '');", true);
                        return;
                    }


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

                                _htParameters["p_code_barcode"] = excelReader.GetString(0);
                                _htParameters["p_policy_insurance_no"] = excelReader.GetString(1);
                                _htParameters["p_policy_insurance_company"] = excelReader.GetString(2);
                                _htParameters["p_policy_start_date"] = excelReader.GetDateTime(3);
                                _htParameters["p_policy_due_date"] = excelReader.GetDateTime(4);
                                _htParameters["p_policy_premium"] = excelReader.GetDecimal(5);

                                Shared.ApplyDefaultProp(_htParameters);
                                _dal.Insert("", "xsp_fa_asset_insurance_upload_insert", _htParameters, ref iNextID);
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
                        Shared.ShowSuccessGritter(this, string.Format("fainsurancelist.aspx"));
                    else
                        Shared.ShowSuccessGritter(this, string.Format("fainsurancelist.aspx"));
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

    #region insurance
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
            _ht["p_owner"] = ddlOwnerNonIns.SelectedValue;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDueDate.Text);
            _ht["p_end_date"] = Shared.ToEndDateTime(txtToDueDate.Text);

            gvwList.DataSource = _dal.GetRows("", "xsp_fa_not_insurance_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void ProcessDataInsurance()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int iNextID = 0;


       
        if (!SelectedExistInsurance())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);

                    // _ht["p_id"] = gvwListnotin.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_fa_a_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_code_barcode"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_ast_code"] = gvwList.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_policy_insurance_no"] = "-";
                    _ht["p_policy_insurance_company"] = "-";
                    _ht["p_policy_premium"] = 0;
                    _ht["p_policy_start_date"] = "-";
                    _ht["p_policy_due_date"] = "-";






                    //if (AuthorityBranch.Checked == true)
                    //    _ht["p_is_authority_branch"] = "1";
                    //else
                    //    _ht["p_is_authority_branch"] = "0";

                    Shared.ApplyDefaultProp(_ht);

                    _dal.Insert("", "xsp_fa_asset_insurance_insert", _ht, ref iNextID);

                }
            }

            Shared.ShowSuccessGritter(this, string.Format("fainsurancelist.aspx"));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private Boolean SelectedExistInsurance()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
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


    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }
   

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected void btnProcessInsurance_Click(object sender, EventArgs e)
    {
        ProcessDataInsurance();
    }

    //protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    //{

         
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //       //TextBox txtBarcodeInsurance = (TextBox)e.Row.FindControl("txtBarcodeInsurance");

    //       //txtBarcodeInsurance.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BARCODE"));
    //        LinkButton btn4 = e.Row.FindControl("btnViewDocument") as LinkButton;
    //        btn4.Attributes["href"] = string.Format("faassetinfo.aspx?action=edit&id={0}&assetno={1}&assettype={2}');", gvwList.SelectedDataKey[0].ToString(), gvwList.SelectedDataKey[2].ToString());
    //       // Response.Redirect(string.Format("purchaseorderdetail.aspx?action=edit&id={0}&codebarcode={1}&currency_code={2}&currency_desc={3}&status={4}&flagprocess={5}&flagrent={6}&idtarget={7}&suppliercode={8}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, ddlCurrency.SelectedValue, ddlCurrency.SelectedItem, lblTransFlagDesc.Text, lblFlagProcess.Text, txtRentFlag.Text, Request.Params["idartarget"], txtSupplierCode.Text));


    //    }
    //}


    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("faassetinfo.aspx?action=view&id=" + gvwList.SelectedDataKey[0].ToString() + "&assetno=" + gvwList.SelectedDataKey[1].ToString() + "&assettype=" + gvwList.SelectedDataKey[2].ToString());
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlOwnerNonIns_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    #endregion

    #region noninsurance

    private void BindDataNotin()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtsearchnotin.Text;
            _ht["p_branch_code"] = ddlcostcenternotin.SelectedValue;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDueDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDueDate.Text);
            _ht["p_owner"] = ddlOwnerIns.SelectedValue;
            gvwListnotin.DataSource = _dal.GetRows("", "xsp_fa_insurance_getrows", _ht);
            gvwListnotin.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void DeleteData(string ID)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_id"] = ID;

    //        _dal.Delete(TABLE_NAME, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}


    protected void gvwListnotin_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListnotin.PageIndex = e.NewPageIndex;
        BindDataNotin();
    }

    // protected void btnAdd_Click(object sender, EventArgs e)
    // {
    //     Response.Redirect("faasset.aspx?action=add");
    // }

    //protected void btnDelete_Click(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in gvwList.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
    //        }
    //    }

    //    BindData();

    //}

    protected void btnSearchnotin_Click(object sender, EventArgs e)
    {
        BindDataNotin();
    }

    private void ProcessData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int iNextID = 0;
       
        //
       
        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwListnotin.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);

                    string PolicyNo = ((TextBox)row.Cells[6].Controls[1]).Text;
                    string InsuranceCompany = ((TextBox)row.Cells[7].Controls[1]).Text;
                   
                    DateTime StartDate = Shared.ToDateTime(((TextBox)row.Cells[8].Controls[1]).Text);
                    DateTime EndDate = Shared.ToDateTime(((TextBox)row.Cells[9].Controls[1]).Text);
                    string PolicyPremium = ((TextBox)row.Cells[10].Controls[1]).Text;

                   // _ht["p_id"] = gvwListnotin.DataKeys[row.RowIndex][0].ToString();
                  //  _ht["p_fa_a_id"] = gvwListnotin.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_code_barcode"] = gvwListnotin.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_ast_code"] = gvwListnotin.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_policy_insurance_no"] = PolicyNo;
                    _ht["p_policy_insurance_company"] = InsuranceCompany;
                    _ht["p_policy_premium"] = PolicyPremium;
                    _ht["p_policy_start_date"] = StartDate;
                    _ht["p_policy_due_date"] = EndDate;



                  
                  

                    //if (AuthorityBranch.Checked == true)
                    //    _ht["p_is_authority_branch"] = "1";
                    //else
                    //    _ht["p_is_authority_branch"] = "0";

                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "xsp_fa_asset_insurance_update_list", _ht);
                   
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("fainsurancelist.aspx"));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListnotin_SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("fainsurance.aspx?action=edit&id=" + gvwListnotin.SelectedDataKey[0].ToString() + "&codebarcode=" + gvwListnotin.SelectedDataKey[1].ToString());
    }

    protected void gvwListnotin_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        // 
        if (e.Row.RowType == DataControlRowType.DataRow)
        {




        }
    }

    protected void ddlStatusnotin_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataNotin();
    }

    protected void ddlOwnerIns_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataNotin();
    }

    protected void ddlBranchnotin_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataNotin();
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
    }


    private void DeleteData(string id)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = id;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListnotin.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwListnotin.DataKeys[row.RowIndex][3].ToString());
            }
        }

        BindData();
    }

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListnotin.Rows)
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
#endregion

    #region insurancelist
    private void BindDataIns()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtsearchins.Text;
            _ht["p_branch_code"] = ddlCostCenterIns.SelectedValue;
            _ht["p_owner"] = ddlOwnerList.SelectedValue;
          

            //_ht["p_start_date"] = txtStartDatein.Text;
            //_ht["p_end_date"] = txtEndDatein.Text;

            gvwListIns.DataSource = _dal.GetRows("", "xsp_fa_insurance_list_getrows", _ht);
            gvwListIns.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void ProcessDataInsuranceAsset()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
       


       
        if (!SelectedExistInsuranceAsset())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwListIns.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);

                    // _ht["p_id"] = gvwListnotin.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_fa_a_id"] = gvwListIns.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_code_barcode"] = gvwListIns.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_ast_code"] = gvwListIns.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_policy_insurance_no"] = "-";
                    _ht["p_policy_insurance_company"] = "-";
                    _ht["p_policy_premium"] = 0;
                    _ht["p_policy_start_date"] = "-";
                    _ht["p_policy_due_date"] = "-";






                    //if (AuthorityBranch.Checked == true)
                    //    _ht["p_is_authority_branch"] = "1";
                    //else
                    //    _ht["p_is_authority_branch"] = "0";

                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "xsp_fa_asset_insurance_update_policy", _ht);

                }
            }

            Shared.ShowSuccessGritter(this, string.Format("fainsurancelist.aspx"));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private Boolean SelectedExistInsuranceAsset()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListIns.Rows)
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


    protected void gvwListIns_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListIns.PageIndex = e.NewPageIndex;
        BindDataIns();
    }

    // protected void btnAdd_Click(object sender, EventArgs e)
    // {
    //     Response.Redirect("faasset.aspx?action=add");
    // }

    //protected void btnDelete_Click(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in gvwList.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
    //        }
    //    }

    //    BindData();

    //}

    protected void btnSearchIns_Click(object sender, EventArgs e)
    {
        BindDataIns();
    }
    protected void btnProcessInsuranceAsset_Click(object sender, EventArgs e)
    {
        ProcessDataInsuranceAsset();
    }

    protected void gvwListIns_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        //// 
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{


        //    LinkButton btn4 = e.Row.FindControl("btnViewDocument") as LinkButton;
        //    btn4.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../fa/faassetinfo.aspx?action=edit&id={0}&assetno={1}&assettype={2}');", txtFromDueDate.Text);


        //}
    }


    protected void gvwListIns_SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("faassetinfo.aspx?action=view&id=" + gvwListIns.SelectedDataKey[0].ToString() + "&assetno=" + gvwListIns.SelectedDataKey[1].ToString() + "&assettype=" + gvwListIns.SelectedDataKey[2].ToString());
    }
    protected void ddlCostCenterIns_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataIns();
    }
    protected void ddlOwnerList_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataIns();
    }

    #endregion


}      
