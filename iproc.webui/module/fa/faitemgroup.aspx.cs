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

public partial class module_fa_faitemgroup : BasePage
{
    private static string TABLE_NAME    = "fa_item_group";
    private static string TABLE_NAME_DETAIL ="fa_item_group_detail";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if(!Page.IsPostBack)
        {
            string itemGroupCode = Request.QueryString["faitemgroupcode"];

            Shared.BindBranchEmployeeSort(ddlBranch);
            BindFaLocationAll(ddlLocation, ddlBranch.SelectedValue);
            btnLookUpItem.Attributes["href"] = "#";
            btnLookUpItem.Attributes["onclick"] = String.Format("openLookupItem('{0}','{1}','{2}','{3}'); return false;",txtItemCode.ClientID,lblItemName.ClientID,ddlBranch.ClientID,ddlLocation.ClientID);
            btnAdd.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=FAITGROUP&gvw={0}&par_branch_code={1}&par_location={2}&par_fa_item_group_code={3}');", btnSearch.UniqueID, ddlBranch.SelectedValue, ddlLocation.SelectedValue, itemGroupCode);
            
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
                ddlBranch.Enabled = ddlLocation.Enabled = false;  
            }
            else
            {
                pnlEntry.Visible = false;
            }
        }
    }
    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_fa_item_group_code"] = Request.Params["faitemgroupcode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);
            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }
    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        Hashtable _htDetail = null;
        Hashtable _htLookup = null;
        string sNextItemGroupCode = "";
        int detailId = 0;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            string barcodeValue = Request.Form[txtItemCode.UniqueID];
            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_fa_location"] = ddlLocation.SelectedValue;
            _ht["p_item_barcode"] = barcodeValue;
            _ht["p_fa_item_group_code"] = lblItemGroupCode.Text;

            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextItemGroupCode);
                lblItemGroupCode.Text = sNextItemGroupCode.ToString();

                if (!string.IsNullOrEmpty(barcodeValue))
                {
                    _htLookup = new Hashtable();
                    _htLookup["p_item_barcode"] = barcodeValue;
                    DataRow drLookup = _dal.GetRow("fa_item_group_lookup", _htLookup);

                    if (drLookup != null)
                    {
                        _htDetail = new Hashtable();
                        _htDetail["p_fa_item_group_code"] = sNextItemGroupCode;
                        _htDetail["p_fa_asset_id"] = drLookup["fa_asset_id"];
                        _htDetail["p_code_asset"] = drLookup["code_asset"];
                        _htDetail["p_name_asset"] = drLookup["name_asset"];
                        _htDetail["p_barcode"] = drLookup["barcode"];
                        _htDetail["p_description"] = drLookup["description"];
                        _htDetail["p_is_parent"] = true;
                        Shared.ApplyDefaultProp(_htDetail);
                        _dal.Insert("fa_item_group_detail", _htDetail, ref detailId);
                    }
                }
            }
            else
            {
                ddlBranch.Enabled = ddlLocation.Enabled = false;
                _dal.Update(TABLE_NAME, _ht);
                sNextItemGroupCode = lblItemGroupCode.Text;

                if (!string.IsNullOrEmpty(barcodeValue))
                {
                    _htLookup = new Hashtable();
                    _htLookup["p_item_barcode"] = barcodeValue;
                    DataRow drLookup = _dal.GetRow("fa_item_group_lookup", _htLookup);

                    if (drLookup != null)
                    {
                        Hashtable _htParent = new Hashtable();
                        _htParent["p_item_barcode"] = barcodeValue;
                        _htParent["p_fa_item_group_code"] = sNextItemGroupCode;
                        _htParent["p_fa_asset_id"] = drLookup["fa_asset_id"];
                        _htParent["p_code_asset"] = drLookup["code_asset"];
                        _htParent["p_name_asset"] = drLookup["name_asset"];
                        _htParent["p_barcode"] = drLookup["barcode"];
                        _htParent["p_description"] = drLookup["description"];
                        Shared.ApplyDefaultProp(_htParent);
                        _dal.Update("fa_item_group_detail", _htParent);
                    }
                }
            }
            string redirectUrl = string.Format("faitemgroup.aspx?action=edit&faitemgroupcode={0}", sNextItemGroupCode);
            Response.Redirect(redirectUrl);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("faitemgrouplist.aspx");
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

        BindFaLocationAll(ddlLocation, ddlBranch.SelectedValue);
        //updDep.Update();
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
        string redirectUrl = string.Format("faitemgroup.aspx?action=add&faitemgroupcode={0}", lblItemGroupCode.Text);
        Response.Redirect(redirectUrl);
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
        if (txtSearch.Text != string.Empty)
            BindData();
    }
      protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
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
            _ht["p_fa_item_group_code"] = lblItemGroupCode.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
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

            _ht["p_id"] = code;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
}
