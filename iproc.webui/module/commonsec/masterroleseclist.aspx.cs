using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_commonsec_masterroleseclist : BasePageList
{
    private static string TABLE_NAME = "MASTER_ROLE_SEC";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "MASTER_ROLE_SEC";
        NEXT_PAGE = "masterrolesec.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            BindDataRole();
            btnDeleteRole.OnClientClick = "return confirm('Delete selected data?');";
        }
        LoadAfterInit();
    }

    private void BindDataRole()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;

            gvwListRole.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListRole.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataRole(string rolecode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = rolecode;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListRole_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListRole.PageIndex = e.NewPageIndex;
        BindDataRole();
    }

    protected void btnAddRole_Click(object sender, EventArgs e)
    {
        Response.Redirect("masterrolesec.aspx?action=add");
    }

    protected void btnDeleteRole_Click(object sender, EventArgs e)
    {
       foreach (GridViewRow row in gvwListRole.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataRole(gvwListRole.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataRole();
    }

    protected void btnSearchRole_Click(object sender, EventArgs e)
    {
        BindDataRole();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("masterrolesec.aspx?action=edit&code=" + gvwListRole.SelectedDataKey[0].ToString());
    }
}
