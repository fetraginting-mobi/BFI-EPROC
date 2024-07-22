using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;

using System.Linq;
using System.Web;

using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_report_financialstatementreport : BasePage
{
    private static string TABLE_NAME_FINANCIAL = "SYS_MASTER_REPORT_FINANCIAL";

    private static string TABLE_NAME_BRANCH = "MASTER_BRANCH";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "SYS_MASTER_REPORT_FINANCIAL";
        NEXT_PAGE = "financialstatementreport.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            txtDate.Text = DateTime.Today.ToString("dd/MM/yyyy");
            txtPeriod.Text = DateTime.Today.ToString("yyyyMM");
            BindData();

        }
    }

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

            gvwListReport.DataSource = _dal.GetRows(TABLE_NAME_FINANCIAL, _ht);
            gvwListReport.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    BindData();
    //}

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        string branch_code = "";
        Hashtable _ht = new Hashtable();
        string filename = "";

        int ctr, maxGridView1Checked;
        int count = 0; //for checking cari header yang isi/kosong
        maxGridView1Checked = 0;

        foreach (GridViewRow row in gvwListBranch.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    maxGridView1Checked++;
                }
            }
        }

        //buat yang kiri
        foreach (GridViewRow row in gvwListReport.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_rpt_code"] = gvwListReport.Rows[row.RowIndex].Cells[2].Text;
                    DataKey key = gvwListReport.DataKeys[row.RowIndex];

                    for (int i = 1; i <= 14; i++)
                    {
                        if (key[i].ToString().Length > 0)
                            count++;
                    }
                    break;
                }
            }
        }

        ctr = 0;
        //kanan
        foreach (GridViewRow row in gvwListBranch.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    ctr++;
                    branch_code = branch_code + "'" + gvwListBranch.Rows[row.RowIndex].Cells[2].Text + "'";
                    if (ctr != maxGridView1Checked)
                        branch_code = branch_code + ',';
                }
            }
        }
        //System.Diagnostics.Debugger.Break();
        if (ctr > 0)
        {
            _ht["p_branch_code"] = branch_code;
            _ht["p_user_id"] = Shared.CurrentUID;
            _ht["p_notes"] = txtReportNotes.Text;
            _ht["p_c_codesession"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_date"] = Shared.ToDateTime(txtDate.Text);
            try
            {
                string rptName;
                if (count <= 6)
                    rptName = "RPT_ACC_STATEMENT";
                else
                    rptName = "RPT_ACC_STATEMENT2";

                if (rblPrinter.SelectedValue == "Excel")
                {
                    //filename = Shared.ExecuteReportExcelFinancial(this, "RPT_ACC_STATEMENT", rptName, "xsp_rpt_acc_rptfinancial", _ht, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                    filename = Shared.ExecuteReportExcel(this, "RPT_ACC_STATEMENT", rptName, "xsp_rpt_acc_rptfinancial", _ht, CrystalDecisions.Shared.ExportFormatType.Excel);
                }
                else
                {
                    filename = Shared.ExecuteReport(this, "RPT_ACC_STATEMENT", rptName, "xsp_rpt_acc_rptfinancial", _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                }

                Shared.PreviewReport(this, filename);

            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
        }
        else
        {
            //Utility.ShowMessageBox(this, "Silahkan pilih cabang terlebih dahulu", null, null);
        }

    }

}
