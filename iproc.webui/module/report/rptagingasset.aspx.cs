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

using MPF23.Shared.Mapper;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class module_report_rptagingasset : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll(ddlBranch);
        }
    }

    protected void btnPrintPDF_Click(object sender, EventArgs e)
    {
        Hashtable _htParameters = new Hashtable();
        ExportFormatType eftreport = new ExportFormatType();
        //string data = "";
        string filename = "";

       // System.Diagnostics.Debugger.Break();

        try
        {

            _htParameters["p_user_id"] = Shared.CurrentUID;
            _htParameters["p_period"] = Shared.ToDateTime(txtPeriode.Text);
            _htParameters["p_branch_id"] = ddlBranch.SelectedValue;

            // nama report yang dibuat di Crystal Report
            string rptName = Server.MapPath(@"..\..\rpt\rpt_aging_asset.rpt");

            // nama pdf yang akan dicreate dan path nya
            string pdfName = "rpt_aging_asset" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
            string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


            pdfName = pdfName + ".pdf";
            //pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
            eftreport = ExportFormatType.PortableDocFormat;
            filename = Shared.ExecuteReport(this, "RPT_AGING_ASSET", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

            Shared.PreviewReport(this, filename);

            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }        

    }

    protected void btnPrintExcel_Click(object sender, EventArgs e)
    { 
        Hashtable _htParameters = new Hashtable();
        ExportFormatType eftreport = new ExportFormatType();
        //string data = "";
        string filename = "";

        //System.Diagnostics.Debugger.Break();
        try
        {
            _htParameters["p_user_id"] = Shared.CurrentUID;
            _htParameters["p_branch_id"] = ddlBranch.SelectedValue;
            _htParameters["p_period"] = Shared.ToDateTime(txtPeriode.Text);
            

            // nama report yang dibuat di Crystal Report
            string rptName = Server.MapPath(@"..\..\rpt\rpt_aging_asset_xls.rpt");

            // nama pdf yang akan dicreate dan path nya
            string xlsName = "rpt_aging_asset_xls" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");

            xlsName = xlsName + ".xls";
            //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
            eftreport = ExportFormatType.ExcelRecord;
            filename = Shared.ExecuteReportExcel(this, "RPT_AGING_ASSET_XLS", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("fixedassetreportlist.aspx");
    }
}
