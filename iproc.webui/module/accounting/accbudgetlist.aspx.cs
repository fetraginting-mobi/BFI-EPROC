using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_accbudgetlist : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            txtYear.Text = DateTime.Today.ToString("yyyy");
            txtYearRev.Text = DateTime.Today.ToString("yyyy");
            txtYearRpt.Text = DateTime.Today.ToString("yyyy");
            BindBudget();
            BindRevision();

            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();
        }
    }

    #region Budget
    private void BindBudget()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_year"] = txtYear.Text;
            //_ht["p_month"] = ddlMonthBudget.SelectedValue;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_keywords"] = txtSearchBudget.Text;

            gvwListBudget.DataSource = _dal.GetRows("ACC_BUDGET", "xsp_acc_budget_getrows_budget", _ht);
            gvwListBudget.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //#region gridview budget

    //protected void gvwListBudget_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

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
    //                    //
    //                    _ht["p_id"] = gvwListBudget.DataKeys[rowIndex][0];
    //                    //_ht["p_month"] = ddlMonthBudget.SelectedValue;
    //                    _ht["p_budget"] = Decimal.Parse(((TextBox)row.Cells[5].Controls[1]).Text);
    //                    Shared.ApplyDefaultProp(_ht);

    //                    _dal.Update("ACC_BUDGET", "xsp_acc_budget_update_budget", _ht);

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
    //    BindBudget();
    //}

    //#endregion

    #region toolbar budget
    protected void btnSearchBudget_Click(object sender, EventArgs e)
    {
        BindBudget();
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_year"] = txtYear.Text;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            Shared.ApplyDefaultProp(_ht);
            _dal.ExecRawSP("xsp_acc_budget_generate", _ht);

            Shared.ShowSuccessGritter(this, null);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
        BindBudget();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
          
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            foreach (GridViewRow row in gvwListBudget.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_id"] = gvwListBudget.DataKeys[row.RowIndex][0].ToString();
                    //_ht["p_budget"] = Decimal.Parse(((TextBox)row.Cells[5].Controls[1]).Text);
                    //_ht["p_branch_code"] = ddlBranch.SelectedValue;

                    TextBox txtQuantityJan = (row.Cells[3].Controls[1] as TextBox);
                    TextBox txtQuantityFeb = (row.Cells[3].Controls[5] as TextBox);
                    TextBox txtQuantityMar = (row.Cells[3].Controls[9] as TextBox);
                    TextBox txtQuantityApr = (row.Cells[3].Controls[13] as TextBox);
                    TextBox txtQuantityMei = (row.Cells[3].Controls[17] as TextBox);
                    TextBox txtQuantityJun = (row.Cells[3].Controls[21] as TextBox);
                    TextBox txtQuantityJul = (row.Cells[3].Controls[25] as TextBox);
                    TextBox txtQuantityAgust = (row.Cells[3].Controls[29] as TextBox);
                    TextBox txtQuantitySept = (row.Cells[3].Controls[33] as TextBox);
                    TextBox txtQuantityOkt = (row.Cells[3].Controls[37] as TextBox);
                    TextBox txtQuantityNov = (row.Cells[3].Controls[41] as TextBox);
                    TextBox txtQuantityDes = (row.Cells[3].Controls[45] as TextBox);

                    _ht["p_budget1"] = txtQuantityJan.Text;
                    _ht["p_budget2"] = txtQuantityFeb.Text;
                    _ht["p_budget3"] = txtQuantityMar.Text;
                    _ht["p_budget4"] = txtQuantityApr.Text;
                    _ht["p_budget5"] = txtQuantityMei.Text;
                    _ht["p_budget6"] = txtQuantityJun.Text;
                    _ht["p_budget7"] = txtQuantityJul.Text;
                    _ht["p_budget8"] = txtQuantityAgust.Text;
                    _ht["p_budget9"] = txtQuantitySept.Text;
                    _ht["p_budget10"] = txtQuantityOkt.Text;
                    _ht["p_budget11"] = txtQuantityNov.Text;
                    _ht["p_budget12"] = txtQuantityDes.Text;

                    Shared.ApplyDefaultProp(_ht);
                    _dal.Update("ACC_BUDGET", "xsp_acc_budget_update_budget", _ht);
                }
            }
            Shared.ShowSuccessGritter(this, string.Format("accbudgetlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListBudget.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    #endregion

    #endregion

    #region Revision

    private void BindRevision()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_year"] = txtYearRev.Text;
            _ht["p_month"] = ddlMonthRev.SelectedValue;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_keywords"] = txtSearchRev.Text;

            gvwListRev.DataSource = _dal.GetRows("ACC_BUDGET", "xsp_acc_budget_getrows_revision", _ht);
            gvwListRev.DataBind();

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #region gridview rev

    protected void gvwListRev_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        LinkButton btn = null;
        GridViewRow row = null;
        int rowIndex = 0;

        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            //dapatkan tombol mana yang diklik
            btn = ((LinkButton)e.CommandSource);

            //dapatkan row dimana tombol tersebut terletak
            row = (GridViewRow)(btn.NamingContainer);

            _dal = new GeneralDAL();
            _ht = new Hashtable();

            if (row.RowType == DataControlRowType.DataRow)
            {
                rowIndex = row.RowIndex;

                if (e.CommandName == "save")
                {
                    try
                    {
                        //
                        _ht["p_id"] = gvwListRev.DataKeys[rowIndex][0];
                        _ht["p_month"] = ddlMonthRev.SelectedValue;
                        _ht["p_revision"] = Decimal.Parse(((TextBox)row.Cells[5].Controls[1]).Text);
                        _ht["p_budget"] = Decimal.Parse(gvwListRev.DataKeys[rowIndex][1].ToString());
                        Shared.ApplyDefaultProp(_ht);

                        _dal.Update("ACC_BUDGET", "xsp_acc_budget_update_revision", _ht);

                        Shared.ShowSuccessGritter(this, null);
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
        BindRevision();
    }

    #endregion

    #region toolbar rev
    protected void btnSearchRev_Click(object sender, EventArgs e)
    {
        BindRevision();
    }

    #endregion

    #endregion

    #region Report

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string filename = "";
        try
        {
         
            _ht = new Hashtable();
            _dal = new GeneralDAL();
            _ht.Clear();
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_user_id"] = Shared.CurrentUID;
            _ht["p_year"] = txtYearRpt.Text;

            if (rboType.SelectedValue.Equals("0"))
            {
                _ht["p_entity_judul"] = "BUDGET AND REVISION REPORT";
                filename = Shared.ExecuteReport(this, "RPT_BUDGET", "RPT_BUDGET_AND_REVISION", "xsp_rpt_budget", _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            }
            else if (rboType.SelectedValue.Equals("1"))
            {
                _ht["p_entity_judul"] = "BUDGET REPORT";
                filename = Shared.ExecuteReport(this, "RPT_BUDGET", "RPT_BUDGET", "xsp_rpt_budget", _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            }
            else
            {
                _ht["p_entity_judul"] = "REVISION REPORT";
                filename = Shared.ExecuteReport(this, "RPT_BUDGET", "RPT_REVISION", "xsp_rpt_budget", _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            }
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #endregion
}
