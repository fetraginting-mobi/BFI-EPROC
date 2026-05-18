using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
using System.Collections.Generic;
public partial class module_fa_fagroupingassetlist : BasePageList
{
    private static string TABLE_NAME_HEADER = "fa_grouping_asset";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeSort(ddlCostCenter);
            BindDataFaItemGroup();
            btnDeleteFaGroup.OnClientClick = "return confirm('Delete selected data?');";
        }
        LoadAfterInit();

    }

    protected void btnAddFaGroup_Click(object sender, EventArgs e)
    {
        Response.Redirect("fagroupingasset.aspx?action=add");

    }
    protected void btnDeleteFaGroup_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListFaGroupingAsset.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwListFaGroupingAsset.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataFaItemGroup();

    }
    protected void btnFaGroupSearch_Click(object sender, EventArgs e)
    {

    }
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListFaGroupingAsset.PageIndex = e.NewPageIndex;
        BindDataFaItemGroup();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("fagroupingasset.aspx?action=edit&faGroupingAssetCode=" + gvwListFaGroupingAsset.SelectedValue.ToString());
    }

    private void DeleteData(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_fa_group_asset_code"] = code;

            _dal.Delete(TABLE_NAME_HEADER, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataFaItemGroup();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
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
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_cost_center"] = ddlCostCenter.SelectedValue;
            //_ht["p_fa_group_asset_code"] = ASSET_GROUP_CODE.Text;
            gvwListFaGroupingAsset.DataSource = _dal.GetRows(TABLE_NAME_HEADER, _ht);
            gvwListFaGroupingAsset.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    #endregion
}
