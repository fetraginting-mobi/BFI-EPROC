using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apadvanceanddeposit_purchaseorderdepositlist : BasePageList
{
    //private static string TABLE_NAME = "PURCHASE_ORDER_DEPOSIT";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "PURCHASE_ORDER_DEPOSIT";
        NEXT_PAGE = "purchaseorderdepositlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployee(ddlBranch);
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_purchase_order_deposit_getrows", _ht);
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
        BindData();
    }

    private void ProcessData()
    {
        //GeneralDAL _dal = null;
        //Hashtable _ht = null;
        //String _pqcode = "";

        //if (!SelectedExist())
        //{
        //    Exception ex = null;
        //    ex = new Exception("No Transaction Selected !");
        //    Shared.ShowErrorDialog(this, ex);
        //    return;
        //}

        //_dal = new GeneralDAL();
        //_ht = new Hashtable();


        //try
        //{
        //    Shared.ApplyDefaultProp(_ht);
        //    _ht["p_quotation_date"] = _ht["p_cre_date"];
        //    _ht["p_exp_date"] = _ht["p_cre_date"];
        //    _ht["p_branch_code"] = ddlBranch.SelectedValue;
        //    _ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
        //    _ht["p_departement_code"] = Shared.CurrentEmployeeDeptCodeDefault;
        //    _ht["p_units_code"] = "";
        //    _ht["p_sub_branch_code"] = "";
        //    _ht["p_remarks"] = "";
        //    _ht["p_flag_document"] = "PQ";

        //    _dal.Insert("purchase_quotation_header", _ht, ref _pqcode);

        //    _ht.Clear();

        //    foreach (GridViewRow row in gvwList.Rows)
        //    {

        //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
        //        if (chb.Checked)
        //        {
        //            _ht["p_pr_code"] = gvwList.DataKeys[row.RowIndex][0].ToString();
        //            _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
        //            _ht["p_pq_code"] = _pqcode;

        //            Shared.ApplyDefaultProp(_ht);

        //            _dal.ExecRawSP("xsp_item_quotation_selection_generate", _ht);
        //        }
        //    }

        //    Shared.ShowSuccessGritter(this, string.Format("itemquotationselectionlist.aspx"));
        //    BindData();
        //}
        //catch (Exception ex)
        //{
        //    Shared.ShowErrorDialog(this, ex);
        //}
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
    }
   

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}

