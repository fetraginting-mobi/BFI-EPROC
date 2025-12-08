using System;
using System.IO;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class module_accounting_accgeneralledger : BasePage
{

    private static string TABLE_NAME_BRANCH = "MASTER_BRANCH";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCGL&acol_0={0}&bcol_1={1}&ccol_2={2}');", txtAccNo.ClientID, txtAccName.ClientID, lblCurr.ClientID);
            btnLookUpCOA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCGL&acol_0={0}&bcol_1={1}&ccol_2={2}');", txtCoaNo.ClientID, txtCoaName.ClientID, lblCoaCurr.ClientID);
            //Shared.BindBranchByEmpCode(ddlBranch, Shared.CurrentUID);
            Shared.BindAccPeriod(ddlAccPeriod, Shared.CurrentEmployeeBranchCode);
            txtDate.Text = txtFromDate.Text = txtToDate.Text = DateTime.Today.ToString("dd/MM/yyyy");

            BindData();

        }
    }

    #region Trial Balance

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            Shared.ApplyDefaultProp(_ht);

            _ht["p_keywords"] = "";

            gvwListBranch.DataSource = _dal.GetRows(TABLE_NAME_BRANCH, _ht);
            gvwListBranch.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        
        Hashtable _htParameters = new Hashtable();
        ExportFormatType eftreport = new ExportFormatType();
        string data = "";
        string filename = "";

        try
        {
            foreach (GridViewRow row in gvwListBranch.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                    if (chb.Checked)
                    {
                        data += gvwListBranch.DataKeys[row.RowIndex][0].ToString();
                        data += ",";
                    }
                }
            }

            _htParameters.Clear();

            if (data == "KVN,SYH,")
            {

                _htParameters["p_branch_code"] = "ALL";
                _htParameters["p_user_id"] = Shared.CurrentUID;
                _htParameters["p_date"] = Shared.ToDateTime(txtDate.Text);

                // nama report yang dibuat di Crystal Report
                string rptName = Server.MapPath(@"..\..\rpt\rpt_acc_trlbal.rpt");

                // nama pdf yang akan dicreate dan path nya
                string pdfName = "rpt_acc_trlbal" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


                pdfName = pdfName + ".pdf";
                pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                eftreport = ExportFormatType.PortableDocFormat;
                filename = Shared.ExecuteReport(this, "RPT_ACC_TRLBAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                Shared.PreviewReport(this, filename);

                ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);

            }

            if (data == "KVN,")
            {

                _htParameters["p_branch_code"] = "KVN";
                _htParameters["p_user_id"] = Shared.CurrentUID;
                _htParameters["p_date"] = Shared.ToDateTime(txtDate.Text);

                // nama report yang dibuat di Crystal Report
                string rptName = Server.MapPath(@"..\..\rpt\rpt_acc_trlbal.rpt");

                // nama pdf yang akan dicreate dan path nya
                string pdfName = "rpt_acc_trlbal" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


                pdfName = pdfName + ".pdf";
                pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                eftreport = ExportFormatType.PortableDocFormat;
                filename = Shared.ExecuteReport(this, "RPT_ACC_TRLBAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                Shared.PreviewReport(this, filename);

                ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);

            }

            if (data == "SYH,")
            {

                _htParameters["p_branch_code"] = "SYH";
                _htParameters["p_user_id"] = Shared.CurrentUID;
                _htParameters["p_date"] = Shared.ToDateTime(txtDate.Text);

                // nama report yang dibuat di Crystal Report
                string rptName = Server.MapPath(@"..\..\rpt\rpt_acc_trlbal.rpt");

                // nama pdf yang akan dicreate dan path nya
                string pdfName = "rpt_acc_trlbal" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);


                pdfName = pdfName + ".pdf";
                pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
                eftreport = ExportFormatType.PortableDocFormat;
                filename = Shared.ExecuteReport(this, "RPT_ACC_TRLBAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                Shared.PreviewReport(this, filename);

                ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);

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
        string data = "";
        string filename = "";

        try
        {
            foreach (GridViewRow row in gvwListBranch.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                    if (chb.Checked)
                    {
                        data += gvwListBranch.DataKeys[row.RowIndex][0].ToString();
                        data += ",";
                    }
                }
            }

            _htParameters.Clear();

            if (data == "KVN,SYH,")
            {

                _htParameters["p_branch_code"] = "ALL";
                _htParameters["p_user_id"] = Shared.CurrentUID;
                _htParameters["p_date"] = Shared.ToDateTime(txtDate.Text);

                // nama report yang dibuat di Crystal Report
                string rptName = Server.MapPath(@"..\..\rpt\rpt_acc_trlbal.rpt");

                // nama pdf yang akan dicreate dan path nya
                string xlsName = "rpt_acc_trlbal" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                //string xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);

                xlsName = xlsName + ".xls";
                //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                eftreport = ExportFormatType.ExcelRecord;
                filename = Shared.ExecuteReportExcel(this, "RPT_ACC_TRLBAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                Shared.PreviewReport(this, filename);
            }

            if (data == "KVN,")
            {

                _htParameters["p_branch_code"] = "KVN";
                _htParameters["p_user_id"] = Shared.CurrentUID;
                _htParameters["p_date"] = Shared.ToDateTime(txtDate.Text);

                // nama report yang dibuat di Crystal Report
                string rptName = Server.MapPath(@"..\..\rpt\rpt_acc_trlbal.rpt");

                // nama pdf yang akan dicreate dan path nya
                string xlsName = "rpt_acc_trlbal" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                //string xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);


                xlsName = xlsName + ".xls";
                //xlsPath = Server.MapPath(@"..\..\temp\pdf\" + xlsName);
                eftreport = ExportFormatType.ExcelRecord;
                filename = Shared.ExecuteReportExcel(this, "RPT_ACC_TRLBAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                Shared.PreviewReport(this, filename);
            }

            if (data == "SYH,")
            {

                _htParameters["p_branch_code"] = "SYH";
                _htParameters["p_user_id"] = Shared.CurrentUID;
                _htParameters["p_date"] = Shared.ToDateTime(txtDate.Text);

                // nama report yang dibuat di Crystal Report
                string rptName = Server.MapPath(@"..\..\rpt\rpt_acc_trlbal.rpt");

                // nama pdf yang akan dicreate dan path nya
                string xlsName = "rpt_acc_trlbal" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
                //string xlsPath = Server.MapPath(@"..\..\temp\xls\" + xlsName);


                xlsName = xlsName + ".xls";
                //xlsPath = Server.MapPath(@"..\..\temp\xls\" + xlsName);
                eftreport = ExportFormatType.ExcelRecord;
                filename = Shared.ExecuteReportExcel(this, "RPT_ACC_TRLBAL", _htParameters, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                Shared.PreviewReport(this, filename);


            }

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #endregion

    #region Trx By Acc

    private void BindAcc()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            //
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_acc_period"] = ddlAccPeriod.SelectedValue;
            _ht["p_acc_no"] = txtAccNo.Text;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_keywords"] = txtSearchByAcc.Text;

            DataTable _dt = _dal.GetRows("ACC_JURNAL_DETAIL", "xsp_acc_jurnal_detail_getrows_transaction_by_account", _ht);

            if (_dt.Rows.Count > 0)
            {
                lblOpening.Text = ((Decimal)_dt.Rows[0]["OPENING_BALANCE"]).ToString("N2");
                lblClosing.Text = ((Decimal)_dt.Rows[0]["CLOSING_BALANCE"]).ToString("N2");
                lblCredit.Text = ((Decimal)_dt.Rows[0]["SUM_CREDIT"]).ToString("N2");
                lblDebit.Text = ((Decimal)_dt.Rows[0]["SUM_DEBIT"]).ToString("N2");
            }
            else
            {
                lblDebit.Text = lblCredit.Text = lblOpening.Text = lblClosing.Text = "0.00";
            }

            gvwListAcc.DataSource = _dt;
            gvwListAcc.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        BindAcc();
    }

    protected void btnSearchByAcc_Click(object sender, EventArgs e)
    {
        BindAcc();
    }

    protected void btnPrintByAcc_Click(object sender, EventArgs e)
    {
      
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string filename = "";
        try
        {
          
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_user_id"] = Shared.CurrentUID;
            _ht["p_acc_no"] = txtAccNo.Text;
            _ht["p_period"] = ddlAccPeriod.SelectedValue;

            filename = Shared.ExecuteReport(this, "RPT_ACC_GLVOUCHER_LIST", "RPT_ACC_GLVOUCHER_LIST", "xsp_rpt_acc_glvoucher_list_all_for_account", _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #endregion

    #region Trx By Voucher

    private void BindVoucher()
    {
        GeneralDAL _dal;
        Hashtable _ht;

        try
        {
            //
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_acc_no"] = txtCoaNo.Text;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_voucher_no"] = txtVoucher.Text;
            _ht["p_from_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_to_date"] = Shared.ToDateTime(txtToDate.Text);
            _ht["p_type"] = ddlType.SelectedValue;

            DataTable _dt = _dal.GetRows("ACC_JURNAL_DETAIL", "xsp_acc_jurnal_detail_getrows_transaction_by_voucher", _ht);

            gvwListVoucher.DataSource = _dt;
            gvwListVoucher.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void PrintData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string filename = "";
        try
        {
          
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_user_id"] = Shared.CurrentUID;
            _ht["p_acc_no"] = txtCoaNo.Text;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDate.Text);

            filename = Shared.ExecuteReport(this, "RPT_ACC_GLVOUCHER_LIST", "RPT_ACC_GLVOUCHER_LIST", "xsp_rpt_acc_glvoucher_list_all", _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchVoucher_Click(object sender, EventArgs e)
    {
        BindVoucher();
    }

    protected void btnPrintAll_Click(object sender, EventArgs e)
    {
        PrintData();
    }

    protected void gvwListVoucher_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        LinkButton btn = null;
        GridViewRow row = null;
        int rowIndex = 0;

        try
        {
            //
            //dapatkan tombol mana yang diklik
            btn = ((LinkButton)e.CommandSource);

            //dapatkan row dimana tombol tersebut terletak
            row = (GridViewRow)(btn.NamingContainer);


            if (row.RowType == DataControlRowType.DataRow)
            {
                rowIndex = row.RowIndex;

                if (e.CommandName == "print")
                {
                    try
                    {
                        //
                        ArrayList filenames = null;
                        //string filename = null;
                        //string srcFile;
                        //string nameFile;
                        //string rsultFile;

                        {
                            filenames = new ArrayList();
                            GeneralDAL _dal = null;
                            _dal = new GeneralDAL();
                            Hashtable _htParameters = new Hashtable();
                            ExportFormatType eftreport = new ExportFormatType();
                            _htParameters.Clear();
                            _htParameters["p_user_id"] = Shared.CurrentUID.Trim();
                            _htParameters["p_voucher_no"] = row.Cells[1].Text;
                            //_htParameters["p_offering_letter_no"] = lblNo.Text;

                            {

                                try
                                {
                                    string sFilename = "";

                                    sFilename = Shared.ExecuteReport(this, "RPT_ACC_GLVOUCHER_LIST", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

                                    Shared.PreviewReport(this, sFilename);
                                }
                                catch (Exception ex)
                                {
                                    Shared.ShowErrorDialog(this, ex);
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Shared.ShowErrorDialog(this, ex);
                    }
                }
            }
        }
        catch (Exception)
        {
        }
    }

    #endregion
}
