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

public partial class module_report_rptfaassetdisposallist : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll(ddlBranch);
            //Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "QR");
            Shared.BindFaLocationReportAll(ddlLocation, ddlBranch.SelectedValue);
            Shared.BindOwnerReportAll(ddlOwner);
            Shared.BindCategoryReportAll(ddlCategory);
            Shared.BindReasonReportAll(ddlReason, "RSN");
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
            htReportParams["p_category"] = ddlCategory.SelectedValue;
            htReportParams["p_location"] = ddlLocation.SelectedValue;
            htReportParams["p_owner"] = ddlOwner.SelectedValue;
            htReportParams["p_reason"] = ddlReason.SelectedValue;
            htReportParams["p_status"] = ddlStatus.SelectedValue;
            htReportParams["p_search_by"] = ddlSearchBy.SelectedValue;
            htReportParams["p_keywords"] = txtKeywords.Text;
            UIToDB.Map(this.Controls, htReportParams);

            //string filename = Shared.ExecuteReport(this, iReportID, htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            //Shared.PreviewReport(this, filename);
            string filename = Shared.ExecuteReportExcel(this, "RPT_FA_ASSET_DISPOSAL_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
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


