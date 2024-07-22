using System;
using System.IO;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class module_report_rptprepaidexpenselist : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            yr2.Visible = false;
            txtYear2.Text = "";
            yr3.Visible = false;
            //if (ddltype.SelectedValue == "BT")
            //{
            //    yr2.Visible = true;
            //}
            //else
            //{
            //    yr2.Visible = true;
            //}
            Shared.BindBranchReportAll(ddlBranch);
        }
    }

    protected void ddltype_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddltype.SelectedValue == "CO")
        {
            yr2.Visible = false;
            yr3.Visible = false;
        }
        else
        {
            yr2.Visible = true;
            yr3.Visible = true;
        }

        //if (ddlReportType.SelectedValue == "AP")
        //{
        //    ddlReportType3.Items[3].Attributes.Add("class", "hidden");
        //}

        //if (ddlReportType.SelectedValue == "CP")
        //{
        //    ddlReportType3.Items[2].Attributes.Add("class", "hidden");
        //    ddlReportType3.Items[4].Attributes.Add("class", "hidden");
        //}

    }

    protected void btnPrintExcel1_Click(object sender, EventArgs e)
    {

        int iReportID = Int32.Parse(Request.Params["rptid"]);
        Hashtable htReportParams = null;

       
        try
        {
            htReportParams = new Hashtable();

            htReportParams.Clear();

            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_branch_code"] = ddlBranch.Text;
            htReportParams["p_year"] = txtYear.Text;
            htReportParams["p_year2"] = txtYear2.Text;
            htReportParams["p_cut_off_month"] = ddlMonth.SelectedValue;
            htReportParams["p_cut_off_month2"] = ddlMonth2.SelectedValue;
            htReportParams["p_type"] = ddltype.SelectedValue;
            //htReportParams["p_search_by"] = ddlSearchBy.SelectedValue;
            //htReportParams["p_keywords"] = txtKeywords.Text;

            //UIToDB.Map(this.Controls, htReportParams);

            //string filename = Shared.ExecuteReport(this, iReportID, htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            //Shared.PreviewReport(this, filename);
            //string filename = Shared.ExecuteReportExcel(this, "RPT_PREPAID_EXPENSE_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            //Shared.PreviewReport(this, filename);
            
            string pdfName = "RPT_PREPAID_EXPENSE" + Shared.CurrentUID + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx"; ;
            // string pdfPath = Server.MapPath(@"..\..\template\" + pdfName);
            string pdfPath = Server.MapPath(@"..\..\temp\" + pdfName);

            string filetype = "xls";


            // menampilkan pdf yang sudah dibuat
            Shared.ExecuteReportExportExcel(this, null, "xsp_rpt_prepaid_expense_list", htReportParams, pdfPath);
            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
       


        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnPrintExcel_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable htReportParams = null;
        string filename = "";
        try
        {

            _dal = new GeneralDAL();
            htReportParams = new Hashtable();


            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_branch_code"] = ddlBranch.Text;
            htReportParams["p_year"] = txtYear.Text;
            htReportParams["p_year2"] = txtYear2.Text;
            htReportParams["p_cut_off_month"] = ddlMonth.SelectedValue;
            htReportParams["p_cut_off_month2"] = ddlMonth2.SelectedValue;
            htReportParams["p_type"] = ddltype.SelectedValue;

            string pdfName = "RPT_PREPAID_EXPENSE" + Shared.CurrentUID + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx"; ;
            // string pdfPath = Server.MapPath(@"..\..\template\" + pdfName);
            string pdfPath = Server.MapPath(@"..\..\temp\" + pdfName);

            string filetype = "xls";


            // menampilkan pdf yang sudah dibuat
            Shared.ExecuteReportExportExcel(this, null, "xsp_rpt_prepaid_expense_list", htReportParams, pdfPath);
            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
       
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchaseorderreportlist.aspx");
    }
}
