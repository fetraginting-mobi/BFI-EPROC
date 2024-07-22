using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

using iProc.DataAccessLayer;

public partial class module_fa_fareconmigrasilist : BasePageList
{
    private static string TABLE_NAME = "FA_ASSET";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "FA_ASSET";
        NEXT_PAGE = "fareconmigrasi.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "FA");
            Shared.BindBranchEmployeeAll(ddlBranch);
           
        }
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
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDate.Text);

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, "xsp_fa_asset_recon_migrasi_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void BindRefreshData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_start_date"] = Shared.ToDateTime(txtFromDate.Text);
            _ht["p_end_date"] = Shared.ToDateTime(txtToDate.Text);

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, "xsp_fa_asset_recon_migrasi_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void RememberOldValues()
    {
        ArrayList categoryIDList = new ArrayList();
        foreach (GridViewRow row in gvwList.Rows)
        {
            string index = (string)gvwList.DataKeys[row.RowIndex][1].ToString();
            bool result = ((CheckBox)row.FindControl("chbSelect")).Checked;

            if (Session["CHECKED_ITEMS"] != null)
            {
                categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];
            }
            if (result)
            {
                if (!categoryIDList.Contains(index))
                {
                    categoryIDList.Add(index);
                }
            }
            else
            {
                categoryIDList.Remove(index);
            }
        }
        if (categoryIDList != null && categoryIDList.Count > 0)
            Session["CHECKED_ITEMS"] = categoryIDList;
    }

    private void RePopulateValues()
    {
        ArrayList categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];
        if (categoryIDList != null && categoryIDList.Count > 0)
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                string index = (string)gvwList.DataKeys[row.RowIndex][1].ToString();
                if (categoryIDList.Contains(index))
                {
                    CheckBox myCheckBox = (CheckBox)row.FindControl("chbSelect");
                    myCheckBox.Checked = true;
                }
            }

        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        RememberOldValues();
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
        RePopulateValues();
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
 
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            DropDownList ddlDocumentStatus = (DropDownList)e.Row.FindControl("ddlDocumentStatus");
            ddlDocumentStatus.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "EXISTENCE"));

        }
    }
 

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
 

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        RememberOldValues();
        BindData();
        RePopulateValues();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("fareconmigrasi.aspx?action=edit&id=" + gvwList.SelectedDataKey[0].ToString() + "&assetno=" + gvwList.SelectedDataKey[1].ToString() + "&assettype=" + gvwList.SelectedDataKey[2].ToString());
    }
}
