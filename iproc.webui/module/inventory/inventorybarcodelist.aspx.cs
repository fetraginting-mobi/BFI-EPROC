using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

using iProc.DataAccessLayer;

public partial class module_inventory_inventorybarcodelist : BasePageList
{
    private static string TABLE_NAME = "INVENTORY_BARCODE";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "INVENTORY_BARCODE";
        NEXT_PAGE = "inventorybarcodeheaderlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            Shared.BindBranchEmployeeAll1(ddlBranch);
            Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
           // txtFromDate.Text = Shared.CurrentStartAccDate;
            //txtToDate.Text = Shared.CurrentEndAccDate;
            //BindData();
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
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDate.Text);
            Shared.ApplyDefaultProp(_ht);

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
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDate.Text);
            Shared.ApplyDefaultProp(_ht);

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
            string index = (string)gvwList.DataKeys[row.RowIndex][0].ToString();
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
                string index = (string)gvwList.DataKeys[row.RowIndex][0].ToString();
                if (categoryIDList.Contains(index))
                {
                    CheckBox myCheckBox = (CheckBox)row.FindControl("chbSelect");
                    myCheckBox.Checked = true;
                }
            }

        }
    }

 
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

  
    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
        BindData();
    }

    private void GenBarcodeAll()
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
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

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

                    qr_gen_inv bg = new qr_gen_inv();
                    bg.QRGenInv(barcode);

                }

                Shared.ShowSuccessGritter(this, null);

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
        //GeneralDAL _daldelete = null;
        //Hashtable _htdelete = null;

        string rptName = "rpt_barcode_inv_list_qr";
        string rptPath;
        string pdfPath;
        string tamp;

        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            //_ht["p_ast_code"] = "ALL";
            _ht["p_user_id"] = Shared.CurrentUID;

            rptPath = Server.MapPath(@"..\..\rpt\" + rptName + ".rpt");
            tamp = Shared.ExecuteReport(this, rptName, _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            string[] spl = tamp.Split('/');
            pdfPath = Server.MapPath(@"..\..\temp\pdf\" + spl[1]);
            listPDF.Add(pdfPath);

            string sPdfName;
            sPdfName = "rpt_barcode_inv_list_qr_combine_" + Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".pdf";
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
        GenBarcodeAll();
        PrintAll();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        RememberOldValues();
        BindData();
        RePopulateValues();
    }

    private void PrintSelected()
    {
         
        string BarcodeNo = "";
        int flag = 0;
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)gvwList.Rows[row.RowIndex].Cells[1].Controls[1];
            if (chb.Checked)
            {
                if (flag == 0)
                    BarcodeNo = gvwList.DataKeys[row.RowIndex][0].ToString();
                else
                    BarcodeNo += ";" + gvwList.DataKeys[row.RowIndex][0].ToString();
                flag = 1;
            }
        }

        if (flag == 1)
        {

            GeneralDAL _dal;
            Hashtable _ht;
            IList listPDF = new ArrayList();

            string rptName = "rpt_barcode_inv_list_qr_selected";
            string rptPath;
            string pdfPath;
            string tamp;
            string PaperName = "barcode";

            try
            {


                _dal = new GeneralDAL();
                _ht = new Hashtable();

                _ht["p_branch_code"] = ddlBranch.SelectedValue;
                //_ht["p_ast_code"] = "ALL";
                _ht["p_barcode"] = BarcodeNo;
                _ht["p_location_code"] = ddlLocation.SelectedValue;
                _ht["p_user_id"] = Shared.CurrentUID;

                rptPath = Server.MapPath(@"..\..\rpt\" + rptName + ".rpt");
                tamp = Shared.ExecuteReportBarcode(this, "rpt_barcode_inv_list_qr_selected", _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, PaperName);
                string[] spl = tamp.Split('/');
                pdfPath = Server.MapPath(@"..\..\temp\pdf\" + spl[0]);
                listPDF.Add(pdfPath);

                string sPdfName;
                sPdfName = "rpt_barcode_inv_list_qr_selected_combine_"+ Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".pdf";
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


    private void GenBarcodeSelected()
    {
        var folderPath = Server.MapPath("~/temp/qrcodesinv");
        System.IO.DirectoryInfo folderInfo = new DirectoryInfo(folderPath);

        foreach (FileInfo file in folderInfo.GetFiles())
        {
            file.Delete();
        }
        foreach (DirectoryInfo dir in folderInfo.GetDirectories())
        {
            dir.Delete(true);
        }
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];

            if (chb.Checked)
            {
                string barcode = gvwList.DataKeys[row.RowIndex][0].ToString();

                if (File.Exists(Server.MapPath(@"" + barcode + "")))
                {
                    File.Delete(Server.MapPath(@"" + barcode + ""));
                }

                qr_gen_inv bg = new qr_gen_inv();
                bg.QRGenInv(barcode);

                //CheckingGenerateSelected(gvwList.DataKeys[row.RowIndex][0].ToString());
                //new qr_gen().QRGen(lblBarcode.Text);
            }

        }

    }


    protected void btnPrintSelected_Click(object sender, EventArgs e)
    {
        //BindRefreshData();
        RememberOldValues();
        BindRefreshData();
        RePopulateValues();
        GenBarcodeSelected();
        PrintSelected();
    }
}
