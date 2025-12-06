using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_accounting_accrevaluation : BasePageList
{
    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "ACC_REVAL_PROCESS";
        NEXT_PAGE = "accrevaluation.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            
            DateTime reval = DateTime.Today.AddMonths(1);
            Shared.BindGeneralSubCodeByCode(ddlMonthPeriod, "MNH");
            ddlMonthPeriod.Text = reval.Month.ToString();
            txtYearPeriod.Text = reval.Year.ToString();
            BindDataReval();

            btnApproved.OnClientClick = "return confirm('Post selected data?');";
        }
        LoadAfterInit();
    }

    private void BindDataReval()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_year"] = txtYearPeriod.Text;
            _ht["p_month"] = ddlMonthPeriod.Text;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            gvwList.DataSource = _dal.GetRows("", "xsp_acc_reval_process_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void ProsesReval()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_acc_year"] = txtYearPeriod.Text;
            _ht["p_acc_month"] = ddlMonthPeriod.Text;
            _ht["p_reval_rate"] = txtRevalRate.Text;
            _ht["p_reval_date"] = Shared.ToDateTime(txtRevalDate.Text);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_acc_reval_process", _ht);

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void PostData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            _ht["p_year"] = txtYearPeriod.Text;
            _ht["p_month"] = ddlMonthPeriod.Text;
            _ht["p_reval_date"] = Shared.ToDateTime(txtRevalDate.Text);
            Shared.ApplyDefaultProp(_ht);
            _dal.ExecRawSP("xsp_jurnal_acc_reval", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accrevaluation.aspx"));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
        BindDataReval();
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindDataReval();
    }

    
    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProsesReval();
        BindDataReval();
    }
    protected void btnApproved_Click(object sender, EventArgs e)
    {
        PostData();
    }
}
