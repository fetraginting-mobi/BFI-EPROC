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
            string itemGroupCode = Request.QueryString["faitemgroupcode"] ?? "";

            Shared.BindBranchEmployeeSort(ddlBranch);
            BindFaLocationAllMut(ddlLocation, ddlBranch.SelectedValue);
            btnAdd.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=FAITGROUP&gvw={0}&par_branch_code={1}&par_location={2}&par_fa_item_group_code={3}');", btnSearch.UniqueID, ddlBranch.SelectedValue, ddlLocation.SelectedValue, itemGroupCode);
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
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
        string sNextItemGroupCode = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

             MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
             _ht["p_branch_code"] = ddlBranch.SelectedValue;
             _ht["p_fa_location"] = ddlLocation.SelectedValue;
             Shared.ApplyDefaultProp(_ht);


            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextItemGroupCode);
                lblItemGroupCode.Text = sNextItemGroupCode.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("faitemgroup.aspx?action=edit&itemgroupcode={0}", lblItemGroupCode.Text));
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

        BindFaLocationAllMut(ddlLocation, ddlBranch.SelectedValue);
        //updDep.Update();
    }
    public static void BindFaLocationAllMut(DropDownList ddl, string Branch)
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
        // Response.Redirect("faentrydetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        // foreach (GridViewRow row in gvwList.Rows)
        // {
        //     CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
        //     if (chb.Checked)
        //     {
        //         DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
        //     }
        // }

        // BindData();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        // if (lblCodeBarcode.Text != string.Empty)
        //     BindData();
    }
      protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        // gvwList.PageIndex = e.NewPageIndex;
        // BindData();
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
            //_ht["p_fa_sale_code"] = ll.Text;


            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
}
