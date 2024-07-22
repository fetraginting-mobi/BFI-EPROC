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

public partial class module_report_rptapadvancepaymentlist : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MBG&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_1={3}');", txtBankCode.ClientID, lblBankCode.ClientID, txtBankName.ClientID, lblBankName.ClientID);

        if (!Page.IsPostBack)
        {
            Shared.BindBranch(ddlBranch);
        }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        //
        int iReportID = Int32.Parse(Request.Params["rptid"]);
        Hashtable htReportParams = null;

        try
        {
            htReportParams = new Hashtable();

            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_branch_code"] = ddlBranch.SelectedValue;
            UIToDB.Map(this.Controls, htReportParams);

            string filename = Shared.ExecuteReport(this, iReportID, htReportParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("reportlist.aspx");
    }
}
