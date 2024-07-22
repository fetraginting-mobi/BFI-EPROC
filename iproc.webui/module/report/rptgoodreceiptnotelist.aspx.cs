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
public partial class module_report_rptgoodreceiptnotelist : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        {
            LoadInit();
            if (!Page.IsPostBack)
            {
                Shared.BindBranchReportAll(ddlBranch);
                //Shared.BindLocationReportAll(ddlLocationName, ddlBranch.SelectedValue);
                Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "GN");
                //Shared.BindSupplier(ddlSupplier);
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
            htReportParams["p_start_date"] = Shared.ToStartDateTime(txtStartDate.Text);
            htReportParams["p_end_date"] = Shared.ToEndDateTime(txtEndDate.Text);
            htReportParams["p_category"] = ddlCategory.SelectedValue;
            htReportParams["p_supplier_location"] = ddlJenisItem.SelectedValue;
            htReportParams["p_supplier_code"] = txtSearch.Text;
            htReportParams["p_location_name"] = "ALL";
            htReportParams["p_status"] = ddlStatus.SelectedValue;
            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReport(this, "RPT_GOOD_RECEIPT_NOTE_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
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
            htReportParams["p_start_date"] = Shared.ToStartDateTime(txtStartDate.Text);
            htReportParams["p_end_date"] = Shared.ToEndDateTime(txtEndDate.Text);
            htReportParams["p_category"] = ddlCategory.SelectedValue;
            htReportParams["p_jenis_item"] = ddlJenisItem.SelectedValue;
            htReportParams["p_keywords"] = txtSearch.Text;
            //htReportParams["p_location_name"] = ddlLocationName.SelectedValue;
            htReportParams["p_status"] = ddlStatus.SelectedValue;
            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReportExcel(this, "RPT_GOOD_RECEIPT_NOTE_LIST_XLS", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("goodreceiptnotereportlist.aspx");
    }

    //protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Shared.BindLocationReportAll(ddlLocationName, ddlBranch.SelectedValue);
    //}

}
