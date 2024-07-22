using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_commonmst_masterstampdutylist : BasePageList
{
    private static string TABLE_NAME = "MASTER_STAMP_DUTY";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "MASTER_STAMP_DUTY";
        NEXT_PAGE = "masterstampdutylist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            BindData();
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
        }
        LoadAfterInit();
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

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string TransactionFrom, string TransactionTo, string Currency)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

       // 
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_transaction_from"] = TransactionFrom;
            _ht["p_transaction_to"] = TransactionTo;
            _ht["p_currency_code"] = Currency;

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
        Response.Redirect("masterstampduty.aspx?action=add");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString(), gvwList.DataKeys[row.RowIndex][1].ToString(), gvwList.DataKeys[row.RowIndex][2].ToString());
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
        Response.Redirect("masterstampduty.aspx?action=edit&transactionfrom=" + gvwList.SelectedDataKey[0].ToString() + "&transactionto=" + gvwList.SelectedDataKey[1].ToString() + "&currency=" + gvwList.SelectedDataKey[2].ToString());
    }
}
