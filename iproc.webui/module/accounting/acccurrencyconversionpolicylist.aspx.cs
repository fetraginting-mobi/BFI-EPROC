using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_acccurrencyconversionpolicylist : BasePageList
{
    private static string TABLE_NAME = "ACC_CHART";
    private static string TABLE_NAME_REVAL = "ACC_REVAL";
    private static string TABLE_NAME_CLASS = "ACC_CLASS";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            BindForexAcc();
            BindAccReval();
            BindGainLoss();
        }
    }

    #region Reval

    #region bind
    private void BindForexAcc()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            gvwListAcc.DataSource = _dal.GetRows(TABLE_NAME, "xsp_acc_chart_getrows_for_reval", _ht);
            gvwListAcc.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void BindAccReval()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            gvwListReval.DataSource = _dal.GetRows(TABLE_NAME_REVAL, _ht);
            gvwListReval.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    #endregion

    #region toolbar

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int count = 0;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode.ToString();
            foreach (GridViewRow row in gvwListAcc.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_acc_no"] = gvwListAcc.DataKeys[row.RowIndex][0].ToString(); ;
                    Shared.ApplyDefaultProp(_ht);
                    _dal.Insert(TABLE_NAME_REVAL, _ht);

                    count++;
                }
            }
            if (count > 0)
            {
                Shared.ShowSuccessGritter(this, "acccurrencyconversionpolicylist.aspx");
            }
            BindForexAcc();
            BindAccReval();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int ctr = 0;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            foreach (GridViewRow row in gvwListReval.Rows)
            {
                //
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_acc_no"] = gvwListReval.DataKeys[row.RowIndex][0].ToString();

                    _dal.Delete(TABLE_NAME_REVAL, _ht);

                    ctr++;
                }
            }

            if (ctr > 0)
            {
                Shared.ShowSuccessGritter(this, "acccurrencyconversionpolicylist.aspx");
            }
            BindForexAcc();
            BindAccReval();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #endregion

    #endregion

    #region gain loss

    #region bind

    private void BindGainLoss()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchClass.Text;
            gvwGainLoss.DataSource = _dal.GetRows(TABLE_NAME_CLASS, _ht);
            gvwGainLoss.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #endregion

    #region toolbar

    protected void btnAddClass_Click(object sender, EventArgs e)
    {
        Response.Redirect("acccurrencyconversionpolicy.aspx?action=add");
    }

    protected void btnDeleteClass_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            foreach (GridViewRow row in gvwGainLoss.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_id"] = Int32.Parse(gvwGainLoss.DataKeys[row.RowIndex][0].ToString());
                    _dal.Delete("ACC_CLASS", _ht);
                }

                BindGainLoss();
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchClass_Click(object sender, EventArgs e)
    {
        BindGainLoss();
    }

    #endregion

    #region gridview

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("acccurrencyconversionpolicy.aspx?action=edit&id=" + gvwGainLoss.SelectedDataKey[0].ToString());
    }

    protected void gvwListAcc_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListAcc.PageIndex = e.NewPageIndex;
        BindForexAcc();
    }
    protected void gvwListReval_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListReval.PageIndex = e.NewPageIndex;
        BindAccReval();
    }

    #endregion

    #endregion

}