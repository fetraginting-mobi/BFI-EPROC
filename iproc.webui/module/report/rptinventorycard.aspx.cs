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

using iProc.DataAccessLayer;

public partial class module_report_rptinventorycard : BasePage
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchReportAll(ddlBranch);
            Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
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
            htReportParams["p_location_code"] = ddlLocation.SelectedValue;
   
            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReportExcel(this, "RPT_INVENTORY_CARD", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
         
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventoryreportlist.aspx");
    }
}
