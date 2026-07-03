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

public partial class module_fa_fagroupingasset : BasePage
{
    private static string TABLE_NAME = "fa_grouping_asset";
    private static string TABLE_NAME_DETAIL = "fa_grouping_asset_detail";
    private static string TABLE_NAME_HISTORY = "fa_grouping_asset_history";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        txtAssetGroupDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
        txtAssetGroupDate.Enabled = false;

        if (!Page.IsPostBack)
        {
            chbIsActive.Checked = true;
            Shared.BindBranchEmployeeSort(ddlBranch);
            BindFaLocationAll(ddlLocation, ddlBranch.SelectedValue);

            if (Request.Params["action"] != null && Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
                ddlBranch.Enabled = ddlLocation.Enabled = false;
            }
            else
            {
                pnlTabsHeader.Visible = false;
                pnlAssetList.Visible = pnlMovementHistory.Visible = false;
            }
        }
        string currentGroupCode = string.IsNullOrEmpty(lblGroupAssetCode.Text) || lblGroupAssetCode.Text == "--"
                                  ? Request.QueryString["faGroupingAssetCode"]
                                  : lblGroupAssetCode.Text;

        btnAdd.Attributes["href"] = String.Format(
            "javascript:fnShowDialog('../../lookup/subscriptionCustom.aspx?code=FAGROUP&gvw={0}&par_branch_code={1}&par_location={2}&par_fa_group_asset_code={3}');",
            btnSearch.UniqueID,
            ddlBranch.SelectedValue,
            ddlLocation.SelectedValue,
            currentGroupCode
        );
    }
    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_fa_group_asset_code"] = Request.Params["faGroupingAssetCode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);
            DBToUI.Map(this.Controls, _dr);
            chbIsActive.Checked = IsCheckedValue(GetDataRowValue(_dr, "IS_ACTIVE"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData(true);
    }
    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {
        SaveDataDetail();
    }

    private void SaveDataDetail()
    {
        GeneralDAL _dal = null;

        try
        {
            GridViewRow selectedParentRow = null;
            string selectedParentID = hdnSelectedParentID.Value;

            foreach (GridViewRow row in gvwList.Rows)
            {
                HiddenField hdnDetailID = row.FindControl("hdnDetailID") as HiddenField;
                if (hdnDetailID != null && hdnDetailID.Value == selectedParentID)
                {
                    selectedParentRow = row;
                    break;
                }
            }

            if (selectedParentRow == null)
            {
                foreach (GridViewRow row in gvwList.Rows)
                {
                    CheckBox chkParent = row.FindControl("chkParent") as CheckBox;
                    if (chkParent != null && Request.Form[chkParent.UniqueID] != null)
                    {
                        selectedParentRow = row;
                        break;
                    }
                }
            }

            if (selectedParentRow == null)
                return;

            HiddenField selectedDetailID = selectedParentRow.FindControl("hdnDetailID") as HiddenField;
            HiddenField selectedIsParent = selectedParentRow.FindControl("hdnIsParent") as HiddenField;

            if (selectedDetailID == null)
                return;

            if (selectedIsParent != null && IsCheckedValue(selectedIsParent.Value))
                return;

            _dal = new GeneralDAL();
            Hashtable _ht = new Hashtable();

            _ht["p_id"] = selectedDetailID.Value;
            _ht["p_fa_ga_code"] = lblGroupAssetCode.Text;
            _ht["p_is_parent"] = 1;

            Shared.ApplyDefaultProp(_ht);
            _dal.ExecRawSP("xsp_fa_grouping_asset_detail_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("fagroupingasset.aspx?action=edit&faGroupingAssetCode={0}", lblGroupAssetCode.Text));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveData(bool redirectAfterSave)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string sNextGroupingAssetCode = "";
        try
        {
            Page.Validate();
            if (!Page.IsValid)
                return;

            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            _ht["p_fa_group_asset_code"] = lblGroupAssetCode.Text;
            _ht["p_fa_group_asset_name"] = txtAssetGroupName.Text;
            _ht["p_cost_center"] = ddlBranch.SelectedValue;
            _ht["p_fa_location"] = ddlLocation.SelectedValue;
            _ht["p_remarks"] = txtRemarks.Text;
            _ht["p_status"] = chbIsActive.Checked ? 1 : 0;

            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"] != null && Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextGroupingAssetCode);
                lblGroupAssetCode.Text = sNextGroupingAssetCode.ToString();

            }
            else
            {
                _ht["p_fa_group_asset_name"] = txtAssetGroupName.Text;
                ddlBranch.Enabled = ddlLocation.Enabled = false;
                _dal.Update(TABLE_NAME, _ht);
                sNextGroupingAssetCode = lblGroupAssetCode.Text;
            }

            if (redirectAfterSave)
            {
                string redirectUrl = string.Format("fagroupingasset.aspx?action=edit&faGroupingAssetCode={0}", sNextGroupingAssetCode);
                Shared.ShowSuccessGritter(this, redirectUrl);
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected bool IsCheckedValue(object value)
    {
        if (value == null || value == DBNull.Value)
            return false;

        string stringValue = Convert.ToString(value).Trim();

        return stringValue.Equals("1")
            || stringValue.Equals("true", StringComparison.OrdinalIgnoreCase)
            || stringValue.Equals("y", StringComparison.OrdinalIgnoreCase)
            || stringValue.Equals("yes", StringComparison.OrdinalIgnoreCase)
            || stringValue.Equals("active", StringComparison.OrdinalIgnoreCase);
    }

    private object GetDataRowValue(DataRow dr, string columnName)
    {
        if (dr == null || dr.Table == null)
            return null;

        foreach (DataColumn column in dr.Table.Columns)
        {
            if (String.Equals(column.ColumnName, columnName, StringComparison.OrdinalIgnoreCase))
                return dr[column];
        }

        return null;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("fagroupingassetlist.aspx");
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindFaLocationAll(ddlLocation, ddlBranch.SelectedValue);
    }
    public static void BindFaLocationAll(DropDownList ddl, string Branch)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Branch;


            ddl.DataSource = _dal.GetRows("", "dbo.xsp_fa_location_mut_ddl_getrows", _ht);
            ddl.DataTextField = "LOC_NAME";
            ddl.DataValueField = "LOC_CODE";
            ddl.DataBind();

        }
        catch (Exception ex)
        {
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        // string redirectUrl = string.Format("faitemgroup.aspx?action=add&faitemgroupcode={0}", lblItemGroupCode.Text);
        // Response.Redirect(redirectUrl);
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
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }
    protected void gvwMovementHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwMovementHistory.PageIndex = e.NewPageIndex;
        BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Response.Redirect(string.Format("faentrydetail.aspx?action=edit&codebarcode={0}&id={1}&idartarget={2}", lblCodeBarcode.Text, gvwList.SelectedDataKey[0].ToString(), Request.Params["idartarget"]));
    }
    protected void gvwMovementHistory_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Response.Redirect(string.Format("faentrydetail.aspx?action=edit&codebarcode={0}&id={1}&idartarget={2}", lblCodeBarcode.Text, gvwList.SelectedDataKey[0].ToString(), Request.Params["idartarget"]));
    }
    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwList.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
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
            _ht["p_fa_group_asset_code"] = lblGroupAssetCode.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwList.DataBind();

            gvwMovementHistory.DataSource = _dal.GetRows(TABLE_NAME_HISTORY, _ht);
            gvwMovementHistory.DataBind();
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

            _ht["p_id"] = code;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    // protected void btnMove_Click(object sender, EventArgs e)
    // {
    //     try
    //     {
    //         if (string.IsNullOrEmpty(ddlBranch.SelectedValue))
    //         {
    //             ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Pilih Branch!');", true);
    //             return;
    //         }

    //         string baseUrl = "../../lookup/genericwithparametercustom.aspx";
    //         string code = "FGAMV";
    //         string url = string.Format("{0}?code={1}&par_cost_center={2}&par_location={3}",
    //                      baseUrl,
    //                      code,
    //                      HttpUtility.UrlEncode(ddlBranch.SelectedValue),
    //                      HttpUtility.UrlEncode(ddlLocation.SelectedValue));

    //         string scriptUrl = url.Replace("\\", "\\\\").Replace("'", "\\'");
    //         string script = string.Format("setTimeout(function() {{ fnShowDialog('{0}'); }}, 200);", scriptUrl);

    //         ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "OpenPopupKey", script, true);
    //     }
    //     catch (Exception ex)
    //     {
    //         Shared.ShowErrorDialog(this, ex);
    //     }
    // }
    protected void btnSearchHistory_Click(object sender, EventArgs e)
    {
        //string redirectUrl = string.Format("faitemgrouphistory.aspx?faitemgroupcode={0}", lblItemGroupCode.Text);
        //Response.Redirect(redirectUrl);
    }
}
