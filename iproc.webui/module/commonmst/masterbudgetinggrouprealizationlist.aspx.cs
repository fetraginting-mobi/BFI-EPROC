using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_commonmst_masterbudgetinggrouprealizationlist : BasePageList
{
    private static string TABLE_NAME = "MASTER_BUDGETING_GROUP_REALIZATION";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "MASTER_BUDGETING_GROUP_REALIZATION";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        //System.Diagnostics.Debugger.Break();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll(ddlBranch);
            Shared.BindUnitsAll(ddlUnits);
            BindData();
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_units_code"] = ddlUnits.SelectedValue;
            _ht["p_start_date"] = Shared.ToStartDateTime(txtStartDate.Text);
            _ht["p_end_date"] = Shared.ToEndDateTime(txtEndDate.Text);

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, "xsp_master_budgeting_group_realization_getrows", _ht);
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
        //System.Diagnostics.Debugger.Break();
        BindData();
       
    }

    protected void ddlUnits_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

        BindData();
    }


    
}
