using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_finance_paymententrylist : BasePageList
{
    private static string TABLE_NAME = "AP_PAYMENT_ENTRY";
    private static string TABLE_NAME_FI_PV_HEADER = "FI_PV_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "AP_PAYMENT_ENTRY";
        NEXT_PAGE = "paymententry.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            btnProcess.OnClientClick = "return confirm('Pocess selected data ?');";
            GetDate();
            BindData();
        }
    }

    private void GetDate()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            DataRow _dr = _dal.GetRow("", "xsp_get_period_branch", _ht);

            //mapping manual
            txtFromDueDate.Text = ((DateTime)_dr["FIRST_DATE"]).ToString("dd/MM/yyyy");
            txtToDueDate.Text = ((DateTime)_dr["LAST_DATE"]).ToString("dd/MM/yyyy");
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

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_branch"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDueDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDueDate.Text);

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
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

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("paymententry.aspx?action=edit&prno=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        //
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        foreach (GridViewRow row in gvwList.Rows)
        {
            try
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_pr_no"] = gvwList.DataKeys[row.RowIndex][0].ToString();

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_ap_payment_entry_proces", _ht);
                }

            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
        }

        BindData();
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            //
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_user_id"] = Shared.CurrentUID;
            _ht["p_start_date"] = txtFromDueDate.Text;
            _ht["p_end_date"] = txtToDueDate.Text;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            string filename = Shared.ExecuteReport(this, "RPT_PAYMENT_REQUEST_LIST", _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            Shared.PreviewReport(this, filename);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
}
