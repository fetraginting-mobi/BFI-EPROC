using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_accounting_accauditheaderlist : BasePageList
{
    private static string TABLE_NAME = "ACC_AUDIT_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "ACC_AUDIT_HEADER";
        NEXT_PAGE = "accauditheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            BindData();
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
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

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string AUDIT_NO)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_audit_no"] = AUDIT_NO;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void Post(string Audit_no)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_audit_no"] = Audit_no;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_acc_audit_header_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accauditheaderlist.aspx"));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void PostClose()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_acc_period"] = accperiod();
            _ht["p_date"] = GetDate();
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_acc_audit_header_post_close", _ht);
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

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("accauditheader.aspx?action=add");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                if (gvwList.DataKeys[row.RowIndex][1].ToString() == "HOLD")
                    DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                if (gvwList.DataKeys[row.RowIndex][1].ToString() == "HOLD")
                {
                    Post(gvwList.DataKeys[row.RowIndex][0].ToString());
                }
            }
        }

        PostClose();
        BindData();
    }

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("accauditheader.aspx?action=edit&auditno=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected DateTime GetDate()
    {
        // tanggal audit jurnal dipaksakan pada tanggal 31 Des tahun lalu
        // audit jurnal digunakan untuk adjustment acc period jika sudah closing year
        DateTime currentDate = DateTime.Today;

        int lastYear = (currentDate.Year) - 1;

        DateTime auditDate = new DateTime(lastYear, 12, 31);

        return auditDate;
    }

    protected string accperiod()
    {
        string acc_period = "";

        DateTime currentDate = DateTime.Today;

        int lastYear = (currentDate.Year) - 1;

        acc_period = lastYear.ToString() + "12";

        return acc_period;
    }
}