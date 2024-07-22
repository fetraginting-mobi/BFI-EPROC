using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MPF23.Shared.Mapper;
using iProc.DataAccessLayer;
using System.Data;

public partial class module_accounting_accrecurringheaderlist : BasePageList
{
    private static string TABLE_NAME = "ACC_RECURRING_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "ACC_RECURRING_HEADER";
        NEXT_PAGE = "accrecurringheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            BindData();
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
        }
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //sorting gridview
        DataView dv = null;

        try
        {
          
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_search"] = ddlSearch.SelectedValue; 	 /* (+) START 06/14/2016 08:37 am Adi --*/

            //Add sorting griedview - 5/27/2016 9:06:30 AM - Lian  
            dv = _dal.GetRows(TABLE_NAME, _ht).DefaultView;

            if (dir == SortDirection.Ascending)
                dv.Sort = expression + " ASC";
            else
                dv.Sort = expression + " DESC";

            gvwList.DataSource = dv;

            //gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    private void DeleteData(string RECURRING_NO)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_recurring_no"] = RECURRING_NO;

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
        Response.Redirect("accrecurringheader.aspx?action=add");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                //if (gvwList.DataKeys[row.RowIndex][1].ToString() == "HOLD")
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
        Response.Redirect("accrecurringheader.aspx?action=edit&recurringno=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void gvwList_Sorting(object sender, GridViewSortEventArgs e)
    {
        {
            if (dir == SortDirection.Ascending)
                dir = SortDirection.Descending;
            else
                dir = SortDirection.Ascending;

            expression = e.SortExpression;
        }

        BindData();
    }

    public SortDirection dir
    {

        get
        {
            if (ViewState["dirState"] == null)
            {
                ViewState["dirState"] = SortDirection.Ascending;
            }

            return (SortDirection)ViewState["dirState"];
        }

        set { ViewState["dirState"] = value; }
    }

    public string expression
    {

        get
        {
            if (ViewState["expressionState"] == null)
            {
                ViewState["expressionState"] = "IS_ACTIVE";
            }

            return (string)ViewState["expressionState"];
        }

        set { ViewState["expressionState"] = value; }
    }
}
