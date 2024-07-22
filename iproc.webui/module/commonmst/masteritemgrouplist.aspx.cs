using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masteritemgrouplist : BasePageList
{
    private static string TABLE_NAME = "MASTER_ITEM_GROUP";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "MASTER_ITEM_GROUP";
        NEXT_PAGE = "masteritemgroup.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            BindData();
            BindDataExpanse();
            BindDataInventory();
            BindDataInventoryConsumtif();
            btnDeleteFA.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteExp.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteINV.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteInvcons.OnClientClick = "return confirm('Delete selected data?');";

            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

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

            _ht["p_keywords"] = txtSearchFA.Text;
            _ht["p_group_category_type"] = "FA";

            gvwListFA.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListFA.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string id)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_category_code"] = id;

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
        BindData();
    }

    protected void btnAddFA_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritemgroup.aspx?action=add&type=FA");
    }

    protected void btnCopyFA_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        foreach (GridViewRow row in gvwListFA.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {

                Response.Redirect("masteritemgroup.aspx?action=copy&type=FA&categorycode=" + gvwListFA.DataKeys[row.RowIndex][0].ToString());
            }
        }


    }
    //protected void btnCopyFA_Click(object sender, EventArgs e)
    //{
    //    Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

    //    foreach (GridViewRow row in gvwListFA.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //           // Response.Redirect("masteritemgroup.aspx?action=copy&type=FA&categorycode=" + gvwListFA.SelectedDataKey[0].ToString());
    //            Response.Redirect("masteritemgroup.aspx?action=edit&type=FA&categorycode=" + gvwListFA.SelectedDataKey[0].ToString());
    //        }
    //    }
    //}

    protected void btnDeleteFA_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListFA.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwListFA.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindData();
    }

    protected void btnSearchFA_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("masteritemgroup.aspx?action=edit&type=FA&categorycode=" + gvwListFA.SelectedDataKey[0].ToString());
    }

    #region Inventory
    private void BindDataInventory()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchINV.Text;
            _ht["p_group_category_type"] = "IT";

            gvwListInv.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListInv.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListInv_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritemgroup.aspx?action=edit&type=IT&categorycode=" + gvwListInv.SelectedDataKey[0].ToString());
    }

    protected void gvwListInv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListInv.PageIndex = e.NewPageIndex;
        BindDataInventory();
    }
    protected void btnAddINV_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritemgroup.aspx?action=add&type=IT");
    }
    protected void btnCopyINV_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;


        foreach (GridViewRow row in gvwListInv.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            
        
            if (chb.Checked)
            {
                Response.Redirect("masteritemgroup.aspx?action=copy&type=IT&categorycode=" + gvwListInv.DataKeys[row.RowIndex][0].ToString());//&categorycode=" + gvwListInv.SelectedDataKey[0].ToString());
            }
        }
    }

    protected void btnSearchINV_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        BindDataInventory();
    }

    protected void btnDeleteINV_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListInv.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwListInv.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataInventory();
    }

    #endregion

    #region InventoryComsumtif
    private void BindDataInventoryConsumtif()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchInvcons.Text;
            _ht["p_group_category_type"] = "IC";


            gvwListInvcons.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListInvcons.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListInvcons_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritemgroup.aspx?action=edit&type=IC&categorycode=" + gvwListInvcons.SelectedDataKey[0].ToString());
    }

    protected void gvwListInvcons_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListInvcons.PageIndex = e.NewPageIndex;
        BindDataInventoryConsumtif();
    }

    protected void btnSearchInvcons_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        BindDataInventoryConsumtif();
    }

    protected void btnAddInvcons_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritemgroup.aspx?action=add&type=IC");
    }

    protected void btnCopyInvcons_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        foreach (GridViewRow row in gvwListInvcons.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                Response.Redirect("masteritemgroup.aspx?action=copy&type=IC&categorycode=" + gvwListInvcons.DataKeys[row.RowIndex][0].ToString());
            }
        }
    }

    protected void btnDeleteInvcons_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListInvcons.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwListInvcons.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataInventoryConsumtif();
    }

    #endregion

    #region Expanse
    private void BindDataExpanse()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchExp.Text;
            _ht["p_group_category_type"] = "ET";


            gvwListExp.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListExp.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListExp_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritemgroup.aspx?action=edit&type=ET&categorycode=" + gvwListExp.SelectedDataKey[0].ToString());
    }

    protected void gvwListExp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListExp.PageIndex = e.NewPageIndex;
        BindDataExpanse();
    }

    protected void btnSearchExp_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        BindDataExpanse();
    }

    protected void btnAddExp_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("masteritemgroup.aspx?action=add&type=ET");
    }

    protected void btnCopyExp_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        foreach (GridViewRow row in gvwListExp.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                Response.Redirect("masteritemgroup.aspx?action=copy&type=ET&categorycode=" + gvwListExp.DataKeys[row.RowIndex][0].ToString());
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
                DeleteData(gvwListExp.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataExpanse();
    }

    #endregion
   
}
