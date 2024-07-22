using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_fareconhistorylist : BasePageList
{
    private static string TABLE_NAME = "FA_RECON_HEADER";
    
    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "INVENTORY_CARD";
        NEXT_PAGE = "inventorycardheaderlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll1(ddlBranch);
            Shared.BindLocationFilterBranch1(ddlLocation, ddlBranch.SelectedValue);

            BindData(); 
            GenerateData();
            //gvwList.Columns[1].Visible = false;
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
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_to_due_date"] = Shared.ToEndDateTime(txtToDueDate.Text);
            _ht["p_from_due_date"] = Shared.ToDateTime(txtFromDueDate.Text);
            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_fa_recon_history_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    private void GenerateData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        try
        {

            _ht["p_code_barcode"] = "";
            _ht["p_farecon_date"] = DateTime.Now;
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_fa_recon_header_insert", _ht);



        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //protected override void SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationFilterBranch1(ddlLocation, ddlBranch.SelectedValue);
        BindData();
        GenerateData();
    }
    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    //protected void ddlBranchList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
    //    BindData();

    //}




}
