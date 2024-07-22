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

public partial class module_report_rptsewarukolist : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            yr2.Visible = false;
            txtYear2.Text = "";
            yr3.Visible = false;
            //if (ddltype.SelectedValue == "BT")
            //{
            //    yr2.Visible = true;
            //}
            //else
            //{
            //    yr2.Visible = true;
            //}
            Shared.BindBranchReportAll(ddlBranch);
        }
    }

    protected void ddltype_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddltype.SelectedValue == "CO")
        {
            yr2.Visible = false;
            yr3.Visible = false;
        }
        else
        {
            yr2.Visible = true;
            yr3.Visible = true;
        }

        //if (ddlReportType.SelectedValue == "AP")
        //{
        //    ddlReportType3.Items[3].Attributes.Add("class", "hidden");
        //}

        //if (ddlReportType.SelectedValue == "CP")
        //{
        //    ddlReportType3.Items[2].Attributes.Add("class", "hidden");
        //    ddlReportType3.Items[4].Attributes.Add("class", "hidden");
        //}

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
            htReportParams["p_year"] = txtYear.Text;
            htReportParams["p_year2"] = txtYear2.Text;
            htReportParams["p_cut_off_month"] = ddlMonth.SelectedValue;
            htReportParams["p_cut_off_month2"] = ddlMonth2.SelectedValue;
            htReportParams["p_type"] = ddltype.SelectedValue;
            htReportParams["p_search_by"] = ddlSearchBy.SelectedValue;
            htReportParams["p_keywords"] = txtKeywords.Text;

            //string filename = Shared.ExecuteReport(this, iReportID, htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
            //Shared.PreviewReport(this, filename);
            string filename = Shared.ExecuteReportExcel(this, "RPT_SEWA_RUKO_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
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