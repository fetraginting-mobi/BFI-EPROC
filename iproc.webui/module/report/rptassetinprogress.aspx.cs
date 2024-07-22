using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using CrystalDecisions.Shared;
using MPF23.Shared.Mapper;

public partial class module_report_rptassetinprogress : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchReportAll(ddlBranch);
        }
    }


    protected void btnPrintExcel_Click(object sender, EventArgs e)
    {
        int iReportID = Int32.Parse(Request.Params["rptid"]);
        Hashtable htReportParams = null;
        htReportParams = new Hashtable();

      

        try
        {
        if (ddlReportType2.SelectedValue == "SM")
        {
            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_periode"] = Shared.ToDateTime(txtStartDate.Text);
            htReportParams["p_branch_code"] = ddlBranch.Text;
            htReportParams["p_type"] = ddltype.Text;

            UIToDB.Map(this.Controls, htReportParams);
            // nama report yang dibuat di Crystal Report
            string filename = Shared.ExecuteReportExcel(this, "RPT_CASHFLOW_ASSET_INPROGRESS", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            Shared.PreviewReport(this, filename);

        }

        if (ddlReportType2.SelectedValue == "DT")
        {

            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_branch_code"] = ddlBranch.Text;
            htReportParams["p_start_date"] = Shared.ToStartDateTime(txtStartDate.Text);
            htReportParams["p_type"] = ddltype.Text;


            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReportExcel(this, "RPT_FIXED_ASSET_INPROGRESS_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            Shared.PreviewReport(this, filename);
        }

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //protected void btnPrintExcel_Click(object sender, EventArgs e)
    //{
    //    Hashtable htReportParams = new Hashtable();
    //    ExportFormatType export = ExportFormatType.PortableDocFormat;
    //    export = ExportFormatType.Excel;

    //    try
    //    {
    //        htReportParams["p_user_id"] = Shared.CurrentUID;
    //        htReportParams["p_branch_code"] = ddlBranch.Text;
    //        htReportParams["p_start_date"] = Shared.ToStartDateTime(txtStartDate.Text);


    //        string pdfName = "RPT_FIXED_ASSET_INPROGRESS_LIST" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".xlsx";
    //        string pdfPath = Server.MapPath(@"..\..\temp\xls\" + pdfName);
    //        string filetype = "xls";

    //        Shared.ExecuteReportExportExcel(this, null, "xsp_rpt_fixed_asset_inprogress_list", htReportParams, pdfPath);
    //        ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/" + filetype + "/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("fixedassetreportlist.aspx");
    }
}