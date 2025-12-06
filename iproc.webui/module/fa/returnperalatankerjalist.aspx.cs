using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_returnperalatankerjalist : BasePageList
{
    //private static string TABLE_NAME = "RETURN_PERALATAN_KERJA_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "RETURN_PERALATAN_KERJA_HEADER";
        NEXT_PAGE = "returnperalatankerja.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            //Shared.BindBranchEmployeeAll(ddlBranch);
            //txtempcode.Text = Shared.CurrentUID;
            Shared.BindGeneralSubCode(ddlStatus, "TRNSFLAG");
            ddlStatus.Items.RemoveAt(0);
            ddlStatus.Items.RemoveAt(4);
            ddlStatus.Items.RemoveAt(4);
            ddlStatus.Items.RemoveAt(6);
            ddlStatus.Items.RemoveAt(7);
            ddlStatus.Items.RemoveAt(7);
            ddlStatus.Items.RemoveAt(7);
            ddlStatus.Items.RemoveAt(7);
            ddlStatus.Items.RemoveAt(1);
            ddlStatus.Items.RemoveAt(2);
            ddlStatus.Items.RemoveAt(3);

            //Shared.BindBranchAll(ddlBranch);
            //Shared.BindBranchEmployeeSort(ddlBranch); // (+) Ari 17-02-2023 ket : enhancement 2022, branch coverage
            Shared.BindBranchEmployeeAll(ddlBranch);
            //ddlBranch.Items.Insert(0, "ALL");

            BindData();
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
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch"] = ddlBranch.SelectedValue;
            _ht["p_user_id"] = Shared.CurrentUID;

            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_return_peralatan_kerja_header_getrows", _ht);
            gvwList.DataBind();
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


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("returnperalatankerja.aspx?action=edit&return_no=" + gvwList.SelectedDataKey[0].ToString());
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("returnperalatankerja.aspx?action=add");
    }
    protected void ddlStatus_TextChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_TextChanged(object sender, EventArgs e)
    {
        BindData();
    }
}

