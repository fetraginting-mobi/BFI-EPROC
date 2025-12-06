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
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;


public partial class module_report_rptfaaccounting : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            if (ddlReportType2.SelectedValue == "SM")
            {
                upd3.Visible = false;
            }
            else
            {
                upd3.Visible = true;
            }
            if (ddlReportType.SelectedValue == "AP")
            {
                ddlReportType3.Items[3].Attributes.Add("class", "hidden");
            }

            if (ddlReportType.SelectedValue == "CP")
            {
                ddlReportType3.Items[2].Attributes.Add("class", "hidden");
                ddlReportType3.Items[4].Attributes.Add("class", "hidden");
                ddlReportType2.Items[1].Attributes.Add("class", "hidden");
            }
        }
    }

    protected void btnPrintPDF_Click(object sender, EventArgs e)
    {
        Hashtable _htParameters = new Hashtable();
        ExportFormatType eftreport = new ExportFormatType();
        //string data = "";
        string filename = "";
        //System.Diagnostics.Debugger.Break();
        try
        {
            if (ddlReportType.SelectedValue == "CP")
            {
                if (ddlReportType2.SelectedValue == "SM")// [+] Rifki 19/02/2018 01:28 : mas.hamzah
                {
                    _htParameters["p_user_id"] = Shared.CurrentUID;
                    _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                    // nama report yang dibuat di Crystal Report
                    string rptName = Server.MapPath(@"..\..\rpt\rpt_cashflow_perolehan_asset.rpt");

                    // nama pdf yang akan dicreate dan path nya
                    string pdfName = "rpt_cashflow_perolehan_asset" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                    string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


                    pdfName = pdfName + ".pdf";
                    pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                    eftreport = ExportFormatType.PortableDocFormat;
                    filename = Shared.ExecuteReport(this, "RPT_CASHFLOW_PEROLEHAN_ASSET", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                    Shared.PreviewReport(this, filename);

                    ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
                        

                }
                else
                {
                    if (ddlReportType3.SelectedValue == "AD")// [+] Rifki 19/02/2018 01:28 : mas.hamzah
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_detail_cash_flow_perolehan_asset_additional.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string pdfName = "rpt_detail_cash_flow_perolehan_asset_additional" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                        string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


                        pdfName = pdfName + ".pdf";
                        pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                        eftreport = ExportFormatType.PortableDocFormat;
                        filename = Shared.ExecuteReport(this, "RPT_DETAIL_CASH_FLOW_PEROLEHAN_ASSET_ADDITIONAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                        Shared.PreviewReport(this, filename);

                        ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);


                    }   
                    else if (ddlReportType3.SelectedValue == "DE")// [+] Rifki 19/02/2018 01:28 : rifki
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_perolehan_asset_deduction.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string pdfName = "rpt_cash_flow_akumulasi_perolehan_asset_deduction" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                        string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


                        pdfName = pdfName + ".pdf";
                        pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                        eftreport = ExportFormatType.PortableDocFormat;
                        filename = Shared.ExecuteReport(this, "RPT_CASH_FLOW_AKUMULASI_PEROLEHAN_ASSET_DEDUCTION", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                        Shared.PreviewReport(this, filename);

                        ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
                        
                    }
                    else
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_perolehan_asset_reklas_aip.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string pdfName = "rpt_cash_flow_akumulasi_perolehan_asset_reklas_aip" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                        string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


                        pdfName = pdfName + ".pdf";
                        pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                        eftreport = ExportFormatType.PortableDocFormat;
                        filename = Shared.ExecuteReport(this, "RPT_CASH_FLOW_AKUMULASI_PEROLEHAN_ASSET_REKLAS_AIP", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                        Shared.PreviewReport(this, filename);

                        ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);


                    }

                }
            }
            else // [+] Rifki 19/02/2018 01:28 : Rifki
            {
                if (ddlReportType2.SelectedValue == "SM")
                {

                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_penyusutan_asset_summary.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string pdfName = "rpt_cash_flow_akumulasi_penyusutan_asset_summary" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                        string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


                        pdfName = pdfName + ".pdf";
                        pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                        eftreport = ExportFormatType.PortableDocFormat;
                        filename = Shared.ExecuteReport(this, "RPT_CASH_FLOW_AKUMULASI_PENYUSUTAN_ASSET_SUMMARY", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                        Shared.PreviewReport(this, filename);

                        ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
                }
                else
                {

                    if (ddlReportType3.SelectedValue == "AD")// [+] Rifki 19/02/2018 01:28 : mas.hamzah
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_detail_cash_flow_akumulasi_penyusutan_asset_additional.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string pdfName = "rpt_detail_cash_flow_akumulasi_penyusutan_asset_additional" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                        string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);

                        pdfName = pdfName + ".pdf";
                        pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                        eftreport = ExportFormatType.PortableDocFormat;
                        filename = Shared.ExecuteReport(this, "RPT_DETAIL_CASH_FLOW_AKUMULASI_PENYUSUTAN_ASSET_ADDITIONAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                        Shared.PreviewReport(this, filename);

                        ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);


                    }
                    else if (ddlReportType3.SelectedValue == "DE")// [+] Rifki 19/02/2018 01:28 : rifki
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_penyusutan_asset_deduction.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string pdfName = "rpt_cash_flow_akumulasi_penyusutan_asset_deduction" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                        string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


                        pdfName = pdfName + ".pdf";
                        pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                        eftreport = ExportFormatType.PortableDocFormat;
                        filename = Shared.ExecuteReport(this, "RPT_CASH_FLOW_AKUMULASI_PENYUSUTAN_ASSET_DEDUCTION", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                        Shared.PreviewReport(this, filename);

                        ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);


                    }
                }

            }
        }

        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }

    protected void btnPrintExcel_Click(object sender, EventArgs e)
    {

        Hashtable _htParameters = new Hashtable();
        ExportFormatType eftreport = new ExportFormatType();
        //string data = "";
        string filename = "";
        //System.Diagnostics.Debugger.Break();
        try
        {
            if (ddlReportType.SelectedValue == "CP")
            {
                if (ddlReportType2.SelectedValue == "SM")// [+] Rifki 19/02/2018 01:28 : mas.hamzah
                {
                    _htParameters["p_user_id"] = Shared.CurrentUID;
                    _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                    // nama report yang dibuat di Crystal Report
                    string rptName = Server.MapPath(@"..\..\rpt\rpt_cashflow_perolehan_asset.rpt");

                    // nama pdf yang akan dicreate dan path nya
                    string xlsName = "rpt_cashflow_perolehan_asset" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                    //string xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);

                    xlsName = xlsName + ".xls";
                    //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                    eftreport = ExportFormatType.ExcelRecord;
                    filename = Shared.ExecuteReportExcel(this, "RPT_CASHFLOW_PEROLEHAN_ASSET", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                    Shared.PreviewReport(this, filename);

                }
                else
                {
                    if (ddlReportType3.SelectedValue == "AD")// [+] Rifki 19/02/2018 01:28 : mas.hamzah
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_detail_cash_flow_perolehan_asset_additional.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string xlsName = "rpt_detail_cash_flow_perolehan_asset_additional" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                        //string xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);

                        xlsName = xlsName + ".xls";
                        //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                        eftreport = ExportFormatType.ExcelRecord;
                        filename = Shared.ExecuteReportExcel(this, "RPT_DETAIL_CASH_FLOW_PEROLEHAN_ASSET_ADDITIONAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                        Shared.PreviewReport(this, filename);

                    }
                    else if (ddlReportType3.SelectedValue == "DE")// [+] Rifki 19/02/2018 01:28 : rifki
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_perolehan_asset_deduction.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string xlsName = "rpt_cash_flow_akumulasi_perolehan_asset_deduction" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                        //string xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);

                        xlsName = xlsName + ".xls";
                        //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                        eftreport = ExportFormatType.ExcelRecord;
                        filename = Shared.ExecuteReportExcel(this, "RPT_CASH_FLOW_AKUMULASI_PEROLEHAN_ASSET_DEDUCTION", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                        Shared.PreviewReport(this, filename);

                    }
                    else
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_perolehan_asset_reklas_aip.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string xlsName = "rpt_cash_flow_akumulasi_perolehan_asset_reklas_aip" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");

                        xlsName = xlsName + ".xls";
                        //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                        eftreport = ExportFormatType.ExcelRecord;
                        filename = Shared.ExecuteReportExcel(this, "RPT_CASH_FLOW_AKUMULASI_PEROLEHAN_ASSET_REKLAS_AIP", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                        Shared.PreviewReport(this, filename);
                    }

                }
            }
            else // [+] Rifki 19/02/2018 01:28 : Rifki
            {
                if (ddlReportType2.SelectedValue == "SM")
                {

                    _htParameters["p_user_id"] = Shared.CurrentUID;
                    _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                    // nama report yang dibuat di Crystal Report
                    string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_penyusutan_asset_summary.rpt");

                    // nama pdf yang akan dicreate dan path nya
                    string xlsName = "rpt_cash_flow_akumulasi_penyusutan_asset_summary" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");

                    xlsName = xlsName + ".xls";
                    //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                    eftreport = ExportFormatType.ExcelRecord;
                    filename = Shared.ExecuteReportExcel(this, "RPT_CASH_FLOW_AKUMULASI_PENYUSUTAN_ASSET_SUMMARY", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                    Shared.PreviewReport(this, filename);
                }

                if (ddlReportType2.SelectedValue == "SF")
                {

                    _htParameters["p_user_id"] = Shared.CurrentUID;
                    _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                    // nama report yang dibuat di Crystal Report
                    string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_penyusutan_asset_fiscal_summary.rpt");

                    // nama pdf yang akan dicreate dan path nya
                    string xlsName = "rpt_cash_flow_akumulasi_penyusutan_asset_fiscal_summary" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");

                    xlsName = xlsName + ".xls";
                    //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                    eftreport = ExportFormatType.ExcelRecord;
                    filename = Shared.ExecuteReportExcel(this, "RPT_CASH_FLOW_AKUMULASI_PENYUSUTAN_ASSET_FISCAL_SUMMARY", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                    Shared.PreviewReport(this, filename);
                }
                else
                {

                    if (ddlReportType3.SelectedValue == "AD")// [+] Rifki 19/02/2018 01:28 : mas.hamzah
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_detail_cash_flow_akumulasi_penyusutan_asset_additional.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string xlsName = "rpt_detail_cash_flow_akumulasi_penyusutan_asset_additional" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");

                        xlsName = xlsName + ".xls";
                        //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                        eftreport = ExportFormatType.ExcelRecord;
                        filename = Shared.ExecuteReportExcel(this, "RPT_DETAIL_CASH_FLOW_AKUMULASI_PENYUSUTAN_ASSET_ADDITIONAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                        Shared.PreviewReport(this, filename);

                    }
                    else if (ddlReportType3.SelectedValue == "DE")// [+] Rifki 19/02/2018 01:28 : rifki
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_penyusutan_asset_deduction.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string xlsName = "rpt_cash_flow_akumulasi_penyusutan_asset_deduction" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");

                        xlsName = xlsName + ".xls";
                        //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                        eftreport = ExportFormatType.ExcelRecord;
                        filename = Shared.ExecuteReportExcel(this, "RPT_CASH_FLOW_AKUMULASI_PENYUSUTAN_ASSET_DEDUCTION", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                        Shared.PreviewReport(this, filename);
                    }

                    else if (ddlReportType3.SelectedValue == "AF")// [+] Rifki 19/02/2018 01:28 : rifki
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\RPT_DETAIL_CASH_FLOW_AKUMULASI_PENYUSUTAN_FISCAL_ASSET_ADDITIONAL.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string xlsName = "RPT_DETAIL_CASH_FLOW_AKUMULASI_PENYUSUTAN_FISCAL_ASSET_ADDITIONAL" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");

                        xlsName = xlsName + ".xls";
                        //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                        eftreport = ExportFormatType.ExcelRecord;
                        filename = Shared.ExecuteReportExcel(this, "RPT_DETAIL_CASH_FLOW_AKUMULASI_PENYUSUTAN_FISCAL_ASSET_ADDITIONAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                        Shared.PreviewReport(this, filename);
                    }

                    else if (ddlReportType3.SelectedValue == "DF")// [+] Rifki 19/02/2018 01:28 : rifki
                    {
                        _htParameters["p_user_id"] = Shared.CurrentUID;
                        _htParameters["p_periode"] = Shared.ToDateTime(txtPeriode.Text);

                        // nama report yang dibuat di Crystal Report
                        string rptName = Server.MapPath(@"..\..\rpt\rpt_cash_flow_akumulasi_penyusutan_asset_fiscal_deduction.rpt");

                        // nama pdf yang akan dicreate dan path nya
                        string xlsName = "rpt_cash_flow_akumulasi_penyusutan_asset_fiscal_deduction" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");

                        xlsName = xlsName + ".xls";
                        //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                        eftreport = ExportFormatType.ExcelRecord;
                        filename = Shared.ExecuteReportExcel(this, "RPT_CASH_FLOW_AKUMULASI_PENYUSUTAN_ASSET_FISCAL_DEDUCTION", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                        Shared.PreviewReport(this, filename);
                    }
                }

            }
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

    protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlReportType.SelectedValue == "AP")
        {
            ddlReportType3.Items[3].Attributes.Add("class", "hidden");
        }

        if (ddlReportType.SelectedValue == "CP")
        {
            ddlReportType3.Items[2].Attributes.Add("class", "hidden");
            ddlReportType3.Items[4].Attributes.Add("class", "hidden");
            ddlReportType2.Items[1].Attributes.Add("class", "hidden");
        }


    }

    protected void ddlReportType2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlReportType2.SelectedValue == "SM" || ddlReportType2.SelectedValue == "SF")
        {
            upd3.Visible = false;
        }
        else
        {
            upd3.Visible = true;
        }

        if (ddlReportType.SelectedValue == "AP")
        {
           ddlReportType3.Items[3].Attributes.Add("class", "hidden");
        }

        if (ddlReportType.SelectedValue == "CP")
        {
            ddlReportType3.Items[2].Attributes.Add("class", "hidden");
            ddlReportType3.Items[4].Attributes.Add("class", "hidden");
        }

    }
}
