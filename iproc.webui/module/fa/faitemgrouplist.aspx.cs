using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MPF23.Shared.Mapper;
using iProc.DataAccessLayer;

public partial class module_fa_fagrouplist : BasePageList
{
    private static string TABLE_NAME_HEADER = "fa_item_group";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            BindDataFaItemGroup();
            btnDeleteFaGroup.OnClientClick = "return confirm('Delete selected data?');";
        }
        LoadAfterInit();  

    }

    protected void btnAddFaGroup_Click(object sender, EventArgs e)
    {
        Response.Redirect("faitemgroup.aspx?action=add");

    }
    protected void btnDeleteFaGroup_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListFaItemGroup.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwListFaItemGroup.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataFaItemGroup();

    }
    protected void btnFaGroupSearch_Click(object sender, EventArgs e)
    {

    }
     protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListFaItemGroup.PageIndex = e.NewPageIndex;
        BindDataFaItemGroup();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
         Response.Redirect("faitemgroup.aspx?action=edit&faitemgroupcode=" +gvwListFaItemGroup.SelectedValue.ToString());
    }

    private void DeleteData(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_fa_item_group_code"] = code;

            _dal.Delete(TABLE_NAME_HEADER, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #region FaItemGroup
    private void BindDataFaItemGroup()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
        
         _ht["p_keywords"] = txtFaGroupSearch.Text;
         gvwListFaItemGroup.DataSource = _dal.GetRows(TABLE_NAME_HEADER, _ht);
         gvwListFaItemGroup.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    #endregion
}
