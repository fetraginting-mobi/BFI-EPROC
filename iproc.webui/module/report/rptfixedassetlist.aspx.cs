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


public partial class module_report_rptfixedassetlist : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchReportAll(ddlBranch);
            Shared.BindCategoryReportAll(ddlCategory);
            Shared.BindFaLocationReportAll(ddlLocation, ddlBranch.SelectedValue);
            Shared.BindOwnerReportAll(ddlOwner);
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
            htReportParams["p_branch_code"] = ddlBranch.Text;
            htReportParams["p_start_date"] = Shared.ToStartDateTime(txtStartDate.Text);
            htReportParams["p_end_date"] = Shared.ToEndDateTime(txtEndDate.Text);
            htReportParams["p_location"] = ddlLocation.SelectedValue;
            htReportParams["p_owner"] = ddlOwner.SelectedValue;
            htReportParams["p_category"] = ddlCategory.SelectedValue;
            htReportParams["p_status"] = ddlStatus.SelectedValue;
            htReportParams["p_type"] = ddltype.SelectedValue;
          
            //htReportParams["p_type"] = rblOrderType.SelectedValue;


            UIToDB.Map(this.Controls, htReportParams);

            //string filename = Shared.ExecuteReport(this, iReportID, htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            //Shared.PreviewReport(this, filename);
            string filename = Shared.ExecuteReportExcel(this, "RPT_FIXED_ASSET_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
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
    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindFaLocationReportAll(ddlLocation, ddlBranch.SelectedValue);
    }
}



