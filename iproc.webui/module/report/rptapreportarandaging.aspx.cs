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

public partial class module_report_rptapreportarandaging : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            //Shared.BindBranch(ddlBranch);
        }
    }

    protected void btnPrintAR_Click(object sender, EventArgs e)
    {
        //
        int iReportID = Int32.Parse(Request.Params["rptid"]);
        //Hashtable htReportParams = null;

        try
        {
            string pdfName = "ap_laporan_hutang.pdf";


            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/pdf/" + pdfName + "' , 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnPrintAging_Click(object sender, EventArgs e)
    {
        //
        int iReportID = Int32.Parse(Request.Params["rptid"]);
        //Hashtable htReportParams = null;

        try
        {
            string pdfName = "ap_overdue_pay.pdf";

            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
}