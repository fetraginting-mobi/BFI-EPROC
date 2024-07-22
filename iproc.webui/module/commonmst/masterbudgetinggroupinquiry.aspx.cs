using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using Excel;
//using System.IO;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterbudgetinggroupinquiry : BasePage
{
    private static string TABLE_NAME = "MASTER_BUDGETING_GROUP";
    // string sfullname = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

         
        if (!Page.IsPostBack)
        {
            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranch(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindGroupLevel(ddlGroupLevel);

            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataItem();
                BindDataQty();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                ddlDepartment.Enabled = false;
                ddlDivision.Enabled = false;
                ddlBranch.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                txtYear.Enabled = false;
                ddlGroupLevel.Enabled = false;
            }
            else
            {
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;

                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                Shared.BindGroupLevel(ddlGroupLevel);

                pnlAllBudget.Visible = false;
            }
        }
        LoadAfterInit();
    }

    private void LoadData()
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = Request.Params["code"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("masterbudgetinggroupinquirylist.aspx");
    }
    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
    }

    protected void ddlSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {

        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
    }

    #region Qty
    private void BindDataQty()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchQty.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_division_code"] = ddlDivision.SelectedValue;
            _ht["p_department_code"] = ddlDepartment.SelectedValue;
            _ht["p_year"] = txtYear.Text;
            _ht["p_group_level"] = ddlGroupLevel.SelectedValue;

            gvwListQty.DataSource = _dal.GetRows("", "xsp_master_budgeting_group_qty_inquiry_getrows", _ht);
            gvwListQty.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListQty_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListQty.PageIndex = e.NewPageIndex;
        BindDataQty();
    }

    protected void btnSearchQty_Click(object sender, EventArgs e)
    {
        BindDataQty();

    }


    protected void chbCheckedAllQty_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListQty.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedQty") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    #endregion

    #region Item
    private void BindDataItem()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchItm.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_division_code"] = ddlDivision.SelectedValue;
            _ht["p_department_code"] = ddlDepartment.SelectedValue;
            _ht["p_group_level"] = ddlGroupLevel.SelectedValue;
            _ht["p_year"] = txtYear.Text;

            gvwListItm.DataSource = _dal.GetRows("", "xsp_master_budgeting_group_amount_inquiry_getrows", _ht);
            gvwListItm.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListItm_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListItm.PageIndex = e.NewPageIndex;
        BindDataItem();
    }


    protected void btnSearchItm_Click(object sender, EventArgs e)
    {
        BindDataItem();

    }

    protected void chbCheckedAllItm_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListItm.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedItm") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
     
     

    #endregion
}
