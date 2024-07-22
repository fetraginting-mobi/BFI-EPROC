using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

using iProc.DataAccessLayer;

public partial class module_commonmst_faassetlist : BasePageList
{
    private static string TABLE_NAME = "FA_ASSET";

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
            Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "FA");
            Shared.BindBranchEmployeeAll(ddlBranch);
            Shared.BindFaLocationAll(ddlToLocationCode, ddlBranch.SelectedValue);
            // txtFromDate.Text = Shared.CurrentStartAccDate;
            // txtToDate.Text = Shared.CurrentEndAccDate;
            // BindData();
            //btnDelete.OnClientClick = "return confirm('Delete selected data?');";
        }
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
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDate.Text);
            _ht["p_to_location"] = ddlToLocationCode.SelectedValue;
            _ht["p_emp_code"] = Shared.CurrentUID;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void BindRefreshData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDate.Text);
            _ht["p_to_location"] = ddlToLocationCode.SelectedValue;
            _ht["p_emp_code"] = Shared.CurrentUID;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void RememberOldValues()
    {
        //System.Diagnostics.Debugger.Break();
        ArrayList categoryIDList = new ArrayList();
        foreach (GridViewRow row in gvwList.Rows)
        {
            string index = (string)gvwList.DataKeys[row.RowIndex][1].ToString();
            bool result = ((CheckBox)row.FindControl("chbSelect")).Checked;

            // Check in the Session
            if (Session["CHECKED_ITEMS"] != null)
            {
                categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];
            }
            if (result)
            {
                if (!categoryIDList.Contains(index))
                {
                    categoryIDList.Add(index);
                }
            }
            else
            {
                categoryIDList.Remove(index);
            }
        }
        if (categoryIDList != null && categoryIDList.Count > 0)
            Session["CHECKED_ITEMS"] = categoryIDList;
    }

    private void RePopulateValues()
    {
        ArrayList categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];
        if (categoryIDList != null && categoryIDList.Count > 0)
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                string index = (string)gvwList.DataKeys[row.RowIndex][1].ToString();
                if (categoryIDList.Contains(index))
                {
                    CheckBox myCheckBox = (CheckBox)row.FindControl("chbSelect");
                    myCheckBox.Checked = true;
                }
            }

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


    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        RememberOldValues();
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
        RePopulateValues();
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        // 
        if (e.Row.RowType == DataControlRowType.DataRow)
        {


            DropDownList ddlDocumentStatus = (DropDownList)e.Row.FindControl("ddlDocumentStatus");

            ddlDocumentStatus.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "EXISTENCE"));

            // ddlSwitchDepartment.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PURPOSE_DEPARTMENT"));
            //ddlBranch.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BRANCH"));
            //ddlTypeProcurment.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_PURCHASE"));



        }
    }

    private void ProcessData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataTable _dt = null;


        //
        //System.Diagnostics.Debugger.Break();
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
        gvwList.AllowPaging = false;
        BindData();
        ArrayList categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];
        if (categoryIDList != null && categoryIDList.Count > 0)
        {
            try
            {
                foreach (GridViewRow row in gvwList.Rows)
                {
                    string index = gvwList.DataKeys[row.RowIndex][1].ToString();               // string index = (string)gvwList.SelectedDataKey.Value[1];
                    //CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                    if (categoryIDList.Contains(index))
                    {
                        //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);
                        DropDownList ddlDocumentStatus = ((DropDownList)row.Cells[11].Controls[1]);



                        _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                        _ht["p_existence"] = ddlDocumentStatus.SelectedValue;


                        //if (AuthorityBranch.Checked == true)
                        //    _ht["p_is_authority_branch"] = "1";
                        //else
                        //    _ht["p_is_authority_branch"] = "0";

                        Shared.ApplyDefaultProp(_ht);

                        _dal.ExecRawSP("xsp_fa_asset_update_existence", _ht);
                    }
                }
                //gvwList.AllowPaging = true;
                Shared.ShowSuccessGritter(this, string.Format("faassetlist.aspx"));
                BindData();
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
        }
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
    }

    private Boolean SelectedExist()
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
      
        RememberOldValues();
        BindData();
        RePopulateValues();
    }

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("faasset.aspx?action=edit&id=" + gvwList.SelectedDataKey[0].ToString() + "&assetno=" + gvwList.SelectedDataKey[1].ToString() + "&assettype=" + gvwList.SelectedDataKey[2].ToString());
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        //BindData();
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindFaLocationAll(ddlToLocationCode, ddlBranch.SelectedValue);
       // BindData();
    }

    protected void ddlToLocationCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        //BindData();
    }

    private void GenBarcode()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataTable _dt = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _dt = new DataTable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDate.Text);
            _ht["p_to_location"] = ddlToLocationCode.SelectedValue;
            _ht["p_emp_code"] = Shared.CurrentUID;

            _dt = _dal.GetRows(TABLE_NAME, _ht);

            if (_dt.Rows.Count != 0)
            {
                for (int i = 0; i < _dt.Rows.Count; i++)
                {
                    string barcode = _dt.Rows[i]["barcode"].ToString();
                    if (File.Exists(Server.MapPath(@"" + barcode + "")))
                    {
                        File.Delete(Server.MapPath(@"" + barcode + ""));
                    }

                    qr_gen bg = new qr_gen();
                    bg.QRGen(barcode);

                }

                //   Shared.ShowSuccessGritter(this, null);

            }

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex); ;
        }
    }

    private void PrintAll()
    {
        GeneralDAL _dal;
        Hashtable _ht;
        IList listPDF = new ArrayList();

        string rptName = "rpt_barcode_list_qr";
        string rptPath;
        string pdfPath;
        string tamp;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            //_ht["p_ast_code"] = "ALL";
            _ht["p_user_id"] = Shared.CurrentUID;
            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDate.Text);
            _ht["p_to_location"] = ddlToLocationCode.SelectedValue;

            rptPath = Server.MapPath(@"..\..\rpt\" + rptName + ".rpt");
            tamp = Shared.ExecuteReport(this, rptName, _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            string[] spl = tamp.Split('/');
            pdfPath = Server.MapPath(@"..\..\temp\pdf\" + spl[1]);
            listPDF.Add(pdfPath);

            string sPdfName;
            sPdfName = "rpt_barcode_list_qr_combine_" + Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".pdf";
            string sPdfPath = Server.MapPath(@"..\..\temp\pdf\" + sPdfName);
            Shared.CombineReport(listPDF, sPdfPath);
            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/pdf/" + sPdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void btnPrintAll_Click(object sender, EventArgs e)
    {
        GenBarcode();
        PrintAll();
    }
    protected void btnPrintSelected_Click(object sender, EventArgs e)
    {
        //System.Diagnostics.Debugger.Break();
        RememberOldValues();
        GenBarcode();
        //GenBarcodeSelected();
       // BindRefreshData();
        PrintSelected();
        RememberOldValues();
        RePopulateValues();
        
    }

    private void PrintSelected()
    {
        string BarcodeNo = "";
        int flag = 0;
        ArrayList categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];

        if (categoryIDList != null && categoryIDList.Count > 0)
        {
            gvwList.AllowPaging = false;
            BindData();
            foreach (GridViewRow row in gvwList.Rows)
            {
                string index = gvwList.DataKeys[row.RowIndex][1].ToString();
                if (categoryIDList.Contains(index))
                {
                    CheckBox myCheckBox = (CheckBox)row.FindControl("chbSelect");
                    myCheckBox.Checked = true;
                    if (flag == 0)
                        BarcodeNo = gvwList.DataKeys[row.RowIndex][1].ToString();
                    else
                        BarcodeNo += ";" + gvwList.DataKeys[row.RowIndex][1].ToString();
                    flag = 1;
                }
            }

            if (flag == 1)
            {

                GeneralDAL _dal;
                Hashtable _ht;
                IList listPDF = new ArrayList();

                string rptName = "rpt_barcode_list_qr_selected";
                string rptPath;
                string pdfPath;
                string tamp;

                try
                {

                    //System.Diagnostics.Debugger.Break();
                    _dal = new GeneralDAL();
                    _ht = new Hashtable();

                    _ht["p_branch_code"] = ddlBranch.SelectedValue;
                    //_ht["p_ast_code"] = "ALL";
                    _ht["p_barcode"] = BarcodeNo;
                    _ht["p_user_id"] = Shared.CurrentUID;

                    rptPath = Server.MapPath(@"..\..\rpt\" + rptName + ".rpt");
                    tamp = Shared.ExecuteReport(this, "rpt_barcode_list_qr_selected", _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                    string[] spl = tamp.Split('/');
                    pdfPath = Server.MapPath(@"..\..\temp\pdf\" + spl[1]);
                    listPDF.Add(pdfPath);

                    string sPdfName;
                    sPdfName = "rpt_barcode_list_qr_selected_combine_" + Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".pdf";
                    string sPdfPath = Server.MapPath(@"..\..\temp\pdf\" + sPdfName);
                    Shared.CombineReport(listPDF, sPdfPath);
                    ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/pdf/" + sPdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
                    
                  

                }
                     
                catch (Exception ex)
                {
                    Shared.ShowErrorDialog(this, ex);
                }
            }
        }
        gvwList.AllowPaging = true;
        BindData();
    }

    private void GenBarcodeSelected()
    {
        
        ArrayList categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];
        var folderPath = Server.MapPath("~/temp/qrcodes");
        System.IO.DirectoryInfo folderInfo = new DirectoryInfo(folderPath);

        foreach (FileInfo file in folderInfo.GetFiles())
        {
            file.Delete();
        }
        foreach (DirectoryInfo dir in folderInfo.GetDirectories())
        {
            dir.Delete(true);
        }

        if (categoryIDList != null && categoryIDList.Count > 0)
        {
            //gvwList.AllowPaging = false;
            foreach (GridViewRow row in gvwList.Rows)
            {
                gvwList.AllowPaging = false;
                BindData();
                string barcode = gvwList.DataKeys[row.RowIndex][1].ToString();

                //CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                string index = gvwList.DataKeys[row.RowIndex].Values[1].ToString();
                if (categoryIDList.Contains(index))
                {
                    if (File.Exists(Server.MapPath(@"" + barcode + "")))
                    {
                        File.Delete(Server.MapPath(@"" + barcode + ""));
                    }
                   

                    qr_gen bg = new qr_gen();
                    bg.QRGen(barcode);

                    //CheckingGenerateSelected(gvwList.DataKeys[row.RowIndex][0].ToString());
                    //new qr_gen().QRGen(lblBarcode.Text);
                }

            }
        }

    }

}