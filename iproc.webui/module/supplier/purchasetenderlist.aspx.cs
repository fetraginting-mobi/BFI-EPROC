using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_supplier_purchasetenderlist : BasePageList
{
    private static string TABLE_NAME_REQUEST = "PURCHASE_REQUEST_TENDER";
    private static string TABLE_NAME_TENDER = "PURCHASE_TENDER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "PURCHASE_TENDER";
        NEXT_PAGE = "purchasetender.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {


            BindDataRequest();
            BindDataTender();
            BindDataWinner();
            BindDataHistory();
            btnDeleteTender.OnClientClick = "return confirm('Delete selected data?');";
            

            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

        }
        LoadAfterInit();
    }

    #region Request
    private void BindDataRequest()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchRequest.Text;
            _ht["p_supplier_code"] = Shared.CurrentUID;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            _ht["p_status"] = "PUBLISH";

            gvwListRequest.DataSource = _dal.GetRows(TABLE_NAME_REQUEST, _ht);
            gvwListRequest.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwListRequest_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListRequest.PageIndex = e.NewPageIndex;
        BindDataRequest();
    }
    protected void btnSearchRequest_Click(object sender, EventArgs e)
    {
        BindDataRequest();
    }
    #endregion

    #region Tender
    private void BindDataTender()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchTender.Text;
            _ht["p_supplier_code"] = Shared.CurrentUID;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;


            gvwListTender.DataSource = _dal.GetRows(TABLE_NAME_TENDER, _ht);
            gvwListTender.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void DeleteDataTender(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = code;

            _dal.Delete(TABLE_NAME_TENDER, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwListTender_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListTender.PageIndex = e.NewPageIndex;
        BindDataTender();
    }

    protected void btnAddTender_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("purchasetender.aspx?action=add");
    }

    protected void btnDeleteTender_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListTender.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataTender(gvwListTender.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataTender();
    }
    protected void btnSearchTender_Click(object sender, EventArgs e)
    {
        BindDataTender();
    }
    protected void gvwListTender_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("purchasetender.aspx?action=edit&codebarcode=" + gvwListTender.SelectedDataKey[0].ToString() );
    }
    #endregion

    #region Winner
    private void BindDataWinner()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchWinner.Text;
            _ht["p_supplier_code"] = Shared.CurrentUID;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;


            gvwListWinner.DataSource = _dal.GetRows(TABLE_NAME_TENDER, "xsp_purchase_tender_getrows_winner", _ht);
            gvwListWinner.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListWinner_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListWinner.PageIndex = e.NewPageIndex;
        BindDataWinner();
    }
    
    protected void btnSearchWinner_Click(object sender, EventArgs e)
    {
        BindDataWinner();
    }
    protected void gvwListWinner_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("purchasetender.aspx?action=edit&codebarcode=" + gvwListWinner.SelectedDataKey[0].ToString());
    }
    #endregion

    #region History
    private void BindDataHistory()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchHistory.Text;
            _ht["p_supplier_code"] = Shared.CurrentUID;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;


            gvwListHistory.DataSource = _dal.GetRows(TABLE_NAME_TENDER, "xsp_purchase_tender_getrows_history", _ht);
            gvwListHistory.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListHistory.PageIndex = e.NewPageIndex;
        BindDataHistory();
    }
    protected void btnSearchHistory_Click(object sender, EventArgs e)
    {
        BindDataHistory();
    }
    protected void gvwListHistory_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("purchasetender.aspx?action=edit&codebarcode=" + gvwListHistory.SelectedDataKey[0].ToString());
    }
    #endregion
}
