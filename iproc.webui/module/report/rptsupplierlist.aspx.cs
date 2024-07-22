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
public partial class module_report_rptsupplierlist : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        {
            LoadInit();
            if (!Page.IsPostBack)
            {
                Shared.BindBranchEmployeeAll(ddlBranch);
                Shared.BindCreditorTypeReportAll(ddlCreditorTypeCode);
                Shared.BindSupplier(ddlSupplier);
            }
        }
    }

    protected void btnPrintPDF_Click(object sender, EventArgs e)
    {
        int iReportID = Int32.Parse(Request.Params["rptid"]);
        Hashtable htReportParams = null;

        //System.Diagnostics.Debugger.Break();

        try
        {
            htReportParams = new Hashtable();

            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_branch_code"] = ddlBranch.SelectedValue;
            htReportParams["p_supplier_type"] = ddlSupplierType.SelectedValue;
            htReportParams["p_creditor_type"] = ddlCreditorTypeCode.SelectedValue;
            htReportParams["p_supplier_code"] = ddlSupplier.SelectedValue;
            htReportParams["p_status"] = ddlStatus.SelectedValue;
            htReportParams["p_raiting"] = ddlRating.SelectedValue; //Kenny 08/03/2018 'Parameter Rating'

            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReport(this, "RPT_SUPPLIER_EXC_XLS", htReportParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
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
            htReportParams["p_supplier_type"] = ddlSupplierType.SelectedValue;
            htReportParams["p_creditor_type"] = ddlCreditorTypeCode.SelectedValue;
            htReportParams["p_supplier_code"] = ddlSupplier.SelectedValue;
            htReportParams["p_status"] = ddlStatus.SelectedValue;
            htReportParams["p_raiting"] = ddlRating.SelectedValue; //Kenny 08/03/2018 'Parameter Rating'

            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReportExcel(this, "RPT_SUPPLIER_EXC_XLS", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
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
