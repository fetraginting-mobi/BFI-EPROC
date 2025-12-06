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

public partial class module_report_rptassetinprogresssumary : BasePage
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

        Hashtable _htParameters = new Hashtable();
        ExportFormatType eftreport = new ExportFormatType();
        //string data = "";
        string filename = "";
        //System.Diagnostics.Debugger.Break();
        try
        {
         
                    _htParameters["p_user_id"] = Shared.CurrentUID;
                    _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);
                    _htParameters["p_branch_code"] = ddlBranch.Text;
                    _htParameters["p_type"] = ddltype.Text;
                    // nama report yang dibuat di Crystal Report
                    string rptName = Server.MapPath(@"..\..\rpt\rpt_cashflow_asset_inprogress.rpt");

                    // nama pdf yang akan dicreate dan path nya
                    string xlsName = "RPT_CASHFLOW_ASSET_INPROGRESS" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                    //string xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);

                    xlsName = xlsName + ".xls";
                    //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                    eftreport = ExportFormatType.ExcelRecord;
                    filename = Shared.ExecuteReportExcel(this, "RPT_CASHFLOW_ASSET_INPROGRESS", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
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
