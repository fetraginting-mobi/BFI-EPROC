using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_personel_employeemainlist : BasePageList
{
    private static string TABLE_NAME = "EMPLOYEE_MAIN";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "EMPLOYEE_MAIN";
        NEXT_PAGE = "employeemain.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll(ddlBranch); // (+) Ari 04-07-2022 ket : enhancement 2022
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";

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
            _ht["p_branch_code"] = ddlBranch.SelectedValue; // (+) Ari 04-07-2022 ket : enhancement 2022
            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
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

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("employeemain.aspx?action=add");
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

    private void DeleteData(string Code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_emp_code"] = Code;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("employeemain.aspx?action=edit&empcode=" + gvwList.SelectedDataKey[0].ToString());
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e) // (+) Ari 04-07-2022 ket : enhancement 2022
    {
        BindData();
    }

}
