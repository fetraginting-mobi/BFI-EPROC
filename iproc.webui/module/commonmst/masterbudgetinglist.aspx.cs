using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_commonmst_masterbudgetinglist : BasePageList
{
    private static string TABLE_NAME = "MASTER_BUDGETING";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "MASTER_BUDGETING";
        NEXT_PAGE = "masterbudgeting.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployee(ddlBranch);
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    
    private void DeleteData(string branch, string subbranch,string division, string department, string units,  string year)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
           
            _ht["p_branch_code"] = branch;
            _ht["p_year"] = year;
            _ht["p_sub_deparment_code"] = subbranch;
            _ht["p_department_code"] = department;
            _ht["p_units_code"] = units;
            _ht["p_division_code"] = division;
          
         


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
        Response.Redirect("masterbudgeting.aspx?action=add");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString(),
                            gvwList.DataKeys[row.RowIndex][1].ToString(),
                            gvwList.DataKeys[row.RowIndex][2].ToString(),
                            gvwList.DataKeys[row.RowIndex][3].ToString(),
                            gvwList.DataKeys[row.RowIndex][4].ToString(),
                             gvwList.DataKeys[row.RowIndex][5].ToString());
                           
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
        Response.Redirect("masterbudgeting.aspx?action=edit&branch=" + gvwList.SelectedDataKey[0].ToString() +
                                                           "&subdepartment=" + gvwList.SelectedDataKey[1].ToString() +
                                                           "&division=" + gvwList.SelectedDataKey[2].ToString() +
                                                            "&department=" +    gvwList.SelectedDataKey[3].ToString() +
                                                            "&unitscode=" +    gvwList.SelectedDataKey[4].ToString() +
                                                           "&year=" +    gvwList.SelectedDataKey[5].ToString()   
                                                          
                                                          );

    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

}
