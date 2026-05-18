using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_fa_farequestmutationheaderlist : BasePageList
{
    private static string TABLE_NAME = "FA_REQUEST_MUTATION_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "FA_REQUEST_MUTATION_HEADER";
        NEXT_PAGE = "farequestmutationheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            //Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "IR");
            Shared.BindBranchEmployeeSort(ddlBranch);

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
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = code;

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
        Response.Redirect("farequestmutationheader.aspx?action=add");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
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
        Response.Redirect("farequestmutationheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    # region Upload bulk mutation
    protected void btnUploadRowFormat_Click(object sender, EventArgs e)
    {
        // Response.Redirect("farequestmutationbulkupload.aspx");
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {

    }
    protected void gvwListUpload_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        // gvwListUpload.PageIndex = e.NewPageIndex;
        BindData();
    }
    protected void SelectedUploadIndexChanged(object sender, EventArgs e)
    {
        // base.SelectedIndexChanged(sender, e);
        // Response.Redirect("inventorymutationheader.aspx?action=edit&codebarcode=" + gvwListUpload.SelectedDataKey[0].ToString());
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
    }
    protected void gvwUploadLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        // gvwUploadLog.PageIndex = e.NewPageIndex;
    }
    protected void gvwUploadLog_RowCommand(object sender, GridViewCommandEventArgs e)
    {
    }
    protected void ddlFromBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlToBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedBranch = ddltoBranch.SelectedValue;
        Shared.BindGeneralLocationByBranch(ddltoLocation, selectedBranch);
        ddltoLocation.Items.Insert(0, new ListItem("ALL", ""));
        BindData();
    }
    protected void ddlFromLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlToLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    #endregion
}

