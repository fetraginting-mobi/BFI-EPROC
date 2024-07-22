using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_accounting_accjmheaderlist : BasePageList
{
    private static string TABLE_NAME = "ACC_JM_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "ACC_JM_HEADER";
        NEXT_PAGE = "accjmheader.aspx";
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
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch"] = Shared.CurrentEmployeeBranchCode;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    private void DeleteData(string JM_NO)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_jm_no"] = JM_NO;

            _dal.Delete(TABLE_NAME, _ht);
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
        Response.Redirect("accjmheader.aspx?action=add");
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

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("accjmheader.aspx?action=edit&jmno=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Hashtable htReportParams = null;
       
        try
        {
            htReportParams = new Hashtable();

            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_status"] = ddlStatus.SelectedValue;

            //UIToDB.Map(this.Controls, htReportParams);
            //if (rblPrinterOption.SelectedValue.ToString() == "1")
            {
                string filename = Shared.ExecuteReportExcel(this, "RPT_REKAP_JURNAL_MEMORIAL_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                Shared.PreviewReport(this, filename);
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
}
