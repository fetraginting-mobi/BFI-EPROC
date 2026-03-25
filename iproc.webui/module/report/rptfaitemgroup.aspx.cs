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

public partial class module_report_rptfaitemgroup : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchReportAll(ddlBranch);
            Shared.BindFaLocationReportAll(ddlLocation, ddlBranch.SelectedValue);
            Shared.BindCategoryReportAll(ddlCategory);
        }

    }
    protected void btnPrintExcel_Click(object sender, EventArgs e)
    {
        Hashtable htReportParams = new Hashtable();
        try
        {
            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_branch_code"] = ddlBranch.Text;
            htReportParams["p_location_code"] = ddlLocation.SelectedValue;
            htReportParams["p_category"] = ddlCategory.SelectedValue;

            // Panggil fungsi download langsung
           Shared.ExportToExcelDirectDownload(
                "ITEM_GROUP_REPORT",
                "item_group_report", 
                htReportParams
            );
        }
        catch (Exception ex)
        {
            // Jika terjadi error, tampilkan dialog
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("fixedassetreportlist.aspx");
    }
    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindFaLocationReportAll(ddlLocation, ddlBranch.SelectedValue);        
    }
}
