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
    private static string TABLE_NAME = "FA_ITEM_GROUP";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            BindDataFaItemGroup();
        }
        LoadAfterInit();  

    }

    protected void btnAddFaGroup_Click(object sender, EventArgs e)
    {
        Response.Redirect("faitemgroup.aspx?action=add");

    }
    protected void btnDeleteFaGroup_Click(object sender, EventArgs e)
    {

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
         Response.Redirect(
        "faitemgroup.aspx?action=edit&faitemgroupcode=" +
        gvwListFaItemGroup.SelectedValue.ToString()
    );
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
         gvwListFaItemGroup.DataSource = _dal.GetRows(TABLE_NAME, _ht);
         gvwListFaItemGroup.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    #endregion
}
