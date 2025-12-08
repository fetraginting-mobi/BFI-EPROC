using System;
using System.IO;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class module_accounting_glopeningbalance : BasePageList
{
    protected void Page_Init(object sender, EventArgs e)
    {

    }

    private decimal dTotalBase = 0;
    private decimal dTotalForex = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            //Shared.BindFundingBank(ddlBank);
            //txtperiod.Text = DateTime.Today.ToString("yyyyMM");
            BindAccPeriod();
            btnProcess.OnClientClick = "return confirm('Process data selected ?');";
            btnGenerate.OnClientClick = "return confirm('Generate the process ?');";

            BindData();
        }
    }

    private void BindAccPeriod()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            DataRow _dr = _dal.GetRow("SYS_BRANCH_ACC_FIRST_PERIOD", "xsp_sys_branch_acc_first_period_getrow_first", _ht);
            txtperiod.Text = _dr["ACC_PERIOD"].ToString();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
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

            //Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_acc_period"] = txtperiod.Text;
            _ht["p_keywords"] = txtSearch.Text;

            gvwList.DataSource = _dal.GetRows("acc_trlbal", _ht);
            gvwList.DataBind();

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_acc_period"] = txtperiod.Text;

            _dal.ExecRawSP("xsp_acc_sumtoheader", _ht);

            //string _dt = "01/" + gvwList.DataKeys[row.RowIndex][1].ToString().Substring(4, 2) + "/" + gvwList.DataKeys[row.RowIndex][1].ToString().Substring(4, 2);
            //DateTime dt = Utility.ToDateTime(_dt);

            //_ht["p_date"] = txtperiod.Text;
            _ht["p_date"] = DateTime.Today;
            _ht["p_user_id"] = Shared.CurrentUID;
            _dal.ExecRawSP("xsp_rpt_acc_rptfinancial_formula", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

        BindData();
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_acc_period"] = txtperiod.Text;

            _dal.ExecRawSP("xsp_acc_trlbal_generate", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

        BindData();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            foreach (GridViewRow row in gvwList.Rows)
            {
                if (gvwList.DataKeys[row.RowIndex][3].ToString().Equals("2"))
                {
                    _ht["p_acc_no"] = (string)gvwList.DataKeys[row.RowIndex][0];
                    _ht["p_acc_period"] = (string)gvwList.DataKeys[row.RowIndex][1];
                    _ht["p_balance_base"] = Decimal.Parse(((TextBox)row.FindControl("txtBalanceBase")).Text);
                    _ht["p_forex_base"] = Decimal.Parse(((TextBox)row.FindControl("txtBalanceForex")).Text);
                    //_ht["p_branch_code"] = ddlBranch.SelectedValue;

                    Shared.ApplyDefaultProp(_ht);
                    _dal.Update("acc_trlbal", _ht);
                }
            }
            Shared.ShowSuccessGritter(this, string.Format("glopeningbalance.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string Type = e.Row.Cells[4].Text;
            string BaseCurr = gvwList.DataKeys[e.Row.RowIndex].Values[2].ToString();

            //LinkButton btnSaveBalance = (LinkButton)e.Row.Cells[7].Controls[1];
            TextBox txtBalanceBase = (TextBox)e.Row.Cells[5].Controls[1];
            TextBox txtBalanceForex = (TextBox)e.Row.Cells[6].Controls[1];

            if (Type == "Header")
            {
                //btnSaveBalance.Visible = false;
                txtBalanceBase.Enabled = false;
                txtBalanceForex.Enabled = false;
            }
            else
            {
                if (BaseCurr == "1")
                {
                    txtBalanceForex.Enabled = false;
                }
                dTotalBase += Decimal.Parse(txtBalanceBase.Text);
                dTotalForex += Decimal.Parse(txtBalanceForex.Text);

            }
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[5].Text = dTotalBase.ToString("N2");
            e.Row.Cells[6].Text = dTotalForex.ToString("N2");
        }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
   
        Hashtable _htParameters = new Hashtable();
        ExportFormatType eftreport = new ExportFormatType();
        //string data = "";
        string filename = "";

        try
        {
            _htParameters["p_user_id"] = Shared.CurrentUID;
            _htParameters["p_period"] = txtperiod.Text;
            _htParameters["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            //_htParameters["p_date"] = Shared.ToDateTime(txtDate.Text);

            // nama report yang dibuat di Crystal Report
            string rptName = Server.MapPath(@"..\..\rpt\rpt_acc_opening_balance.rpt");

            // nama pdf yang akan dicreate dan path nya
            string pdfName = "rpt_acc_opening_balance" + Shared.CurrentUID + DateTime.Now.ToString("ddMMyyyyHHmmss");
            string pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);

            pdfName = pdfName + ".pdf";
            pdfPath = Server.MapPath(@"..\..\temp\pdf\" + pdfName);
            eftreport = ExportFormatType.PortableDocFormat;
            filename = Shared.ExecuteReport(this, "RPT_ACC_OPENING_BALANCE", _htParameters, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

            Shared.PreviewReport(this, filename);

            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../../temp/pdf/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //protected void gvwList_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    LinkButton btn = null;
    //    GridViewRow row = null;
    //    int rowIndex = 0;

    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        //dapatkan tombol mana yang diklik
    //        btn = ((LinkButton)e.CommandSource);

    //        //dapatkan row dimana tombol tersebut terletak
    //        row = (GridViewRow)(btn.NamingContainer);

    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        if (row.RowType == DataControlRowType.DataRow)
    //        {
    //            rowIndex = row.RowIndex;

    //            if (e.CommandName == "save")
    //            {
    //                try
    //                {

    //                    _ht["p_acc_no"] = gvwList.DataKeys[rowIndex][0];
    //                    _ht["p_acc_period"] = gvwList.DataKeys[rowIndex][1];
    //                    _ht["p_branch"] = Shared.CurrentEmployeeBranchCode;
    //                    _ht["p_balance_base"] = Decimal.Parse(((TextBox)row.Cells[5].Controls[1]).Text);
    //                    _ht["p_forex_base"] = Decimal.Parse(((TextBox)row.Cells[6].Controls[1]).Text);
    //                    Shared.ApplyDefaultProp(_ht);

    //                    _dal.Update("acc_trlbal", _ht);

    //                    Shared.ShowSuccessGritter(this, null);
    //                }
    //                catch (Exception ex)
    //                {
    //                    Shared.ShowErrorDialog(this, ex);
    //                }
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //    BindData();
    //}
}

