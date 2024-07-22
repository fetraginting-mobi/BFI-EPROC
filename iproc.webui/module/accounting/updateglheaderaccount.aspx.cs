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

public partial class module_accounting_updateglheaderaccount : BasePageList
{
    private static String TABLE_NAME = "MASTER_BRANCH";

    protected void Page_Init(object sender, EventArgs e)
    {
        //PAGE_LIST = "FUNDING_BATCH_ASSET_AMORTIZATION";
        //NEXT_PAGE = "fundingbatchamortization.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            //Shared.BindFundingBank(ddlBank);
            //txtPeriod.Text = DateTime.Today.ToString("dd/MM/yyyy");

            btnProcess.OnClientClick = "return confirm('Process data selected ?');";
            //btnGenerate.OnClientClick = "return confirm('Generate the process ?');";

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

            _ht["p_keywords"] = txtSearch.Text;
            //_ht["p_period"] = txtPeriod.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, "xsp_sys_branch_getrows_for_update_gl", _ht);
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

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("fundingbatchamortization.aspx?action=edit&id=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    //_ht["p_bank_code"] = ddlBank.SelectedValue;
                    _ht["p_branch_code"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_acc_period"] = gvwList.DataKeys[row.RowIndex][1].ToString();

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_acc_sumtoheader", _ht);

                    string _dt = "01/" + gvwList.DataKeys[row.RowIndex][1].ToString().Substring(4, 2) + "/" + gvwList.DataKeys[row.RowIndex][1].ToString().Substring(0, 4);
                    DateTime dt = Shared.ToDateTime(_dt);

                    _ht.Clear();
                    _ht["p_date"] = dt;
                    _ht["p_user_id"] = Shared.CurrentUID;
                    _dal.ExecRawSP("xsp_rpt_acc_rptfinancial_formula", _ht);

                    Shared.ShowSuccessGritter(this, "updateglheaderaccount.aspx");
                }
            }

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

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    //_ht["p_bank_code"] = ddlBank.SelectedValue;
                    _ht["p_period"] = gvwList.DataKeys[row.RowIndex][0].ToString();

                    Shared.ApplyDefaultProp(_ht);

                    //_dal.ExecRawSP("xsp_funding_batch_amortization_process", _ht);
                }
            }

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

        BindData();
    }
}

