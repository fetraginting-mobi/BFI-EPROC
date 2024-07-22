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
public partial class module_report_rpthoteltransactionlist : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        {
            LoadInit();
            if (!Page.IsPostBack)
            {
                Shared.BindBranchEmployeeAll(ddlBranch);
            }
        }
    }

    protected void btnPrintPDF_Click(object sender, EventArgs e)
    {
        int iReportID = Int32.Parse(Request.Params["rptid"]);
        Hashtable htReportParams = null;

        try
        {
            htReportParams = new Hashtable();

            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_branch_code"] = ddlBranch.SelectedValue;
            htReportParams["p_start_date"] = txtStartDate.Text;
            htReportParams["p_end_date"] = txtEndDate.Text;
            htReportParams["p_search_by"] = ddlSearchBy.SelectedValue;
            htReportParams["p_keywords"] = txtKeywords.Text;
            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReport(this, "RPT_HOTEL_TRANSACTION_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnPrintExcel_Click(object sender, EventArgs e)
    {
        int iReportID = Int32.Parse(Request.Params["rptid"]);
        Hashtable htReportParams = null;

        try
        {
            htReportParams = new Hashtable();

            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_branch_code"] = ddlBranch.SelectedValue;
            htReportParams["p_start_date"] = txtStartDate.Text;
            htReportParams["p_end_date"] = txtEndDate.Text;
            htReportParams["p_search_by"] = ddlSearchBy.SelectedValue;
            htReportParams["p_keywords"] = txtKeywords.Text;
            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReportExcel(this, "RPT_HOTEL_TRANSACTION_LIST_XLS", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            Shared.PreviewReport(this, filename);
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
