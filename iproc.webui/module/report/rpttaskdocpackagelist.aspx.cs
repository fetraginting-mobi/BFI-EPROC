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

public partial class module_report_rpttaskdocpackagelist : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        {
            LoadInit();
            if (!Page.IsPostBack)
            {
                Shared.BindBranchReportAll(ddlBranch);
               
            }
        }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
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
            htReportParams["p_type_code"] = ddlTypeReceipt.SelectedValue;
            htReportParams["p_status"] = ddlStatus.SelectedValue;
            htReportParams["p_search_by"] = ddlSearchBy.SelectedValue;
            htReportParams["p_keywords"] = txtKeywords.Text;
            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReportExcel(this, "RPT_TASK_DOC_PACKAGE_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventoryreportlist.aspx");
    }
}
