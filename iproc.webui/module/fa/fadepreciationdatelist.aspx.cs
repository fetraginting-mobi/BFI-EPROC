using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_fa_fadepreciationdatelist : BasePageList
{
    private static string TABLE_NAME = "FA_ASSET";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "FA_ASSET";
        NEXT_PAGE = "faasset.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeSort(ddlBranch);

            BindData();
            //btnDelete.OnClientClick = "return confirm('Delete selected data?');";
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

            _ht["p_keywords"]   = txtSearch.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME,"xsp_fa_asset_depreciation_date_getrows", _ht);
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

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtPeriod = (TextBox)e.Row.FindControl("txtPeriod");
            TextBox txtPeriodFiscal = (TextBox)e.Row.FindControl("txtPeriodFiscal");

            txtPeriod.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DEPRE_PERIOD"));
            txtPeriodFiscal.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DEPRE_PERIOD_FISCAL"));

        }
    }

    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        //
        //System.Diagnostics.Debugger.Break();
        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();


        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);
                    TextBox txtPeriod = ((TextBox)row.FindControl("txtPeriod"));
                    TextBox txtPeriodFiscal = ((TextBox)row.FindControl("txtPeriodFiscal"));


                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_depre_period"] = Shared.ToDateTime(txtPeriod.Text);
                    _ht["p_depre_period_fiscal"] = Shared.ToDateTime(txtPeriodFiscal.Text);

 
                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_fa_asset_update_depre_period", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("fadepreciationdatelist.aspx"));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }

     

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
 
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
