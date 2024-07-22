using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_commonsec_mastergroupseclist : BasePageList
{
    private static string TABLE_NAME = "MASTER_GROUP_SEC";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "MASTER_GROUP_SEC";
        NEXT_PAGE = "mastergroupsec.aspx";
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            BindDataGroup();
            btnDeleteGroup.OnClientClick = "return confirm('Delete selected data?');";
        }
        LoadAfterInit();
    }

    private void BindDataGroup()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;

            gvwListGroup.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwListGroup.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataGroup (string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = code;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListGroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListGroup.PageIndex = e.NewPageIndex;
        BindDataGroup();
    }

    protected void btnAddGroup_Click(object sender, EventArgs e)
    {
        Response.Redirect("mastergroupsec.aspx?action=add");
    }

    protected void btnDeleteGroup_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListGroup.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataGroup(gvwListGroup.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataGroup();
    }

    protected void btnSearchGroup_Click(object sender, EventArgs e)
    {
        BindDataGroup();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("mastergroupsec.aspx?action=edit&code=" + gvwListGroup.SelectedDataKey[0].ToString());
    }

}
