using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_commonmst_masteritemlist : BasePageList
{
    private static string TABLE_NAME = "MASTER_ITEM";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "MASTER_ITEM";
        NEXT_PAGE = "masteritem.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            

            BindDataFA();
            BindDataInv();
            BindDataInvCons();
            BindDataExp();
            btnDeleteFA.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteExp.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteInv.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteInvCons.OnClientClick = "return confirm('Delete selected data?');";

            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

        }
        LoadAfterInit();
    }

    #region FA
    private void BindDataFA()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchFA.Text;
            _ht["p_jenis_item"] = "FA";
            gvwListFA.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListFA.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void DeleteDataFA(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_item_code"] = code;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwListFA_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListFA.PageIndex = e.NewPageIndex;
        BindDataFA();
    }
    protected void btnAddFA_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritem.aspx?action=add&jenis=FA");
    }

    protected void btnCopyFA_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        foreach (GridViewRow row in gvwListFA.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                Response.Redirect("masteritem.aspx?action=copy&itemcode=" + gvwListFA.DataKeys[row.RowIndex][0].ToString() + "&jenis=FA");
            }
        }

        
    }
    protected void btnDeleteFA_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListFA.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataFA(gvwListFA.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataFA();
    }
    protected void btnSearchFA_Click(object sender, EventArgs e)
    {
        BindDataFA();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("masteritem.aspx?action=edit&itemcode=" + gvwListFA.SelectedDataKey[0].ToString()+"&jenis=FA");
    }
    #endregion

    #region Inv
    private void BindDataInv()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchInv.Text;
            _ht["p_jenis_item"] = "IT";

            gvwListInv.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListInv.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void DeleteDataInv(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_item_code"] = code;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwListInv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListInv.PageIndex = e.NewPageIndex;
        BindDataInv();
    }

    protected void btnAddInv_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritem.aspx?action=add&jenis=IT");
    }
    protected void btnCopyInv_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        foreach (GridViewRow row in gvwListInv.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                Response.Redirect("masteritem.aspx?action=copy&itemcode=" + gvwListInv.DataKeys[row.RowIndex][0].ToString() + "&jenis=IT");
            }
        }


    }
    protected void btnDeleteInv_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListInv.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataInv(gvwListInv.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataInv();
    }
    protected void btnSearchInv_Click(object sender, EventArgs e)
    {
        BindDataInv();
    }
    protected void gvwListInv_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritem.aspx?action=edit&itemcode=" + gvwListInv.SelectedDataKey[0].ToString() + "&jenis=IT");
    }
    #endregion

    #region InvCons
    private void BindDataInvCons()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchInvCons.Text;
            _ht["p_jenis_item"] = "IC";

            gvwListInvCons.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListInvCons.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void DeleteDataInvCons(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_item_code"] = code;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwListInvCons_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListInvCons.PageIndex = e.NewPageIndex;
        BindDataInvCons();
    }
    protected void btnAddInvCons_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritem.aspx?action=add&jenis=IC");
    }
    protected void btnCopyInvCons_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        foreach (GridViewRow row in gvwListInvCons.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                Response.Redirect("masteritem.aspx?action=copy&itemcode=" + gvwListInvCons.DataKeys[row.RowIndex][0].ToString() + "&jenis=IC");
            }
        }


    }
    protected void btnDeleteInvCons_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListInvCons.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataInvCons(gvwListInvCons.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataInvCons();
    }
    protected void btnSearchInvCons_Click(object sender, EventArgs e)
    {
        BindDataInvCons();
    }
    protected void gvwListInvCons_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritem.aspx?action=edit&itemcode=" + gvwListInvCons.SelectedDataKey[0].ToString() + "&jenis=IC");
    }
    #endregion

    #region Exp
    private void BindDataExp()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchExp.Text;
            _ht["p_jenis_item"] = "ET";

            gvwListExp.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListExp.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void DeleteDataExp(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_item_code"] = code;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwListExp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListExp.PageIndex = e.NewPageIndex;
        BindDataExp();
    }
    protected void btnAddExp_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritem.aspx?action=add&jenis=ET");
    }
    protected void btnCopyExp_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        foreach (GridViewRow row in gvwListExp.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                Response.Redirect("masteritem.aspx?action=copy&itemcode=" + gvwListExp.DataKeys[row.RowIndex][0].ToString() + "&jenis=ET");
            }
        }


    }
    protected void btnDeleteExp_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListExp.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataExp(gvwListExp.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataExp();
    }
    protected void btnSearchExp_Click(object sender, EventArgs e)
    {
        BindDataExp();
    }
    protected void gvwListExp_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritem.aspx?action=edit&itemcode=" + gvwListExp.SelectedDataKey[0].ToString() + "&jenis=ET");
    }
    #endregion
}
