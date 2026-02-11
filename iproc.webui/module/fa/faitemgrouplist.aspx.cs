using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_fagrouplist : BasePageList
{
    private static string TABLE_NAME = "FA_ITEM_GROUP";
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnAddFaGroup_Click(object sender, EventArgs e)
    {
        Response.Redirect("masteritemgroup.aspx?action=add&type=FA");

    }
    protected void btnDeleteFaGroup_Click(object sender, EventArgs e)
    {

    }
    protected void btnFaGroupSearch_Click(object sender, EventArgs e)
    {

    }
     protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gvwList.PageIndex = e.NewPageIndex;
        //BindData();
    }
}
