using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_transactioninquiry : BasePageList
{
    private static string TABLE_NAME = "APPROVAL_REQUEST";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "APPROVAL_REQUEST";
        //NEXT_PAGE = "approvelreviewapplication.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();


        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll(ddlBranch);
            txtempcode.Text = Shared.CurrentUID;
            Shared.BindGeneralSubCode(ddlTrxMenu,"TRXIQ");
            ddlTrxMenu.Items.RemoveAt(0); // hilangkan select item

            //(+) Ari 11-07-2022 ket : enhancement 2022
            if (string.IsNullOrEmpty(txtToDate.Text))
            {
                //set tgl skrg
                txtToDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

                //set tgl 30 hari sebelum hari ini
                DateTime date = new DateTime(DateTime.Now.Year, 1, 1).AddDays(DateTime.Now.DayOfYear - 30);
                txtFromDate.Text = date.ToString("dd/MM/yyyy");

            }

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
            _ht["p_menu"] = ddlTrxMenu.SelectedValue;
            _ht["p_from_date"] = Shared.ToStartDateTime(txtFromDate.Text);
            _ht["p_to_date"] = Shared.ToStartDateTime(txtToDate.Text);
            //_ht["p_searchby"] = ddlTransaction.SelectedValue;
            _ht["p_emp_code"] = Shared.CurrentUID; // (+) Ari 30-12-2022 ket : enhancement 2022, for employe branch coverage


            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_transaction_inquiry_approval_getrows", _ht);
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
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        //base.SelectedIndexChanged(sender, e);
        //Response.Redirect("approvelreviewapplication.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString() + "&btncancel=" + "true");
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void txtToDateChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlTrxMenu_TextChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void gvwList_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string transaction;//= ((Label)e.Row.Cells[3].Controls[1]).Text;
 

            //LinkButton btnPreview = (LinkButton)e.Row.Cells[11].Controls[1];
 
            //transaction = gvwList.DataKeys[e.Row.RowIndex]["CODE_BARCODE"].ToString();
            //btnPreview.Attributes["onclick"] = "javascript:window.open('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode=" + transaction + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";

            LinkButton btn = (LinkButton)e.Row.Cells[11].Controls[1];
            btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", gvwList.DataKeys[e.Row.RowIndex]["CODE_BARCODE"].ToString());
        }
    }
    protected void gvwList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
         
    }

}

