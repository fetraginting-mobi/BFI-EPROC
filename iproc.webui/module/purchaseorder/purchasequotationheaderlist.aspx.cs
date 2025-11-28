using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_purchaseorder_purchasequotationheaderlist : BasePageList
{
    private static string TABLE_NAME = "PURCHASE_QUOTATION_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "PURCHASE_QUOTATION_HEADER";
        NEXT_PAGE = "purchasequotationheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "QR");
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindOwnerAll(ddlOwner);

            //(+) Ari 11-07-2022 ket : enhancement 2022
            ddlStatus.Items.Insert(0, "ALL");
            ddlBranch.Items.Insert(0, "ALL");
            if (string.IsNullOrEmpty(txtToDate.Text))
            {
                //set tgl skrg
                txtToDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

                //set tgl 30 hari sebelum hari ini
                DateTime date = new DateTime(DateTime.Now.Year, 1, 1).AddDays(DateTime.Now.DayOfYear - 30);
                txtFromDate.Text = date.ToString("dd/MM/yyyy");

            }

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
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;

            _ht["p_owner"] = ddlOwner.SelectedValue;
            //(+) Ari 11-07-2022 ket : enhancement 2022
            _ht["p_from_date"] = Shared.ToStartDateTime(txtFromDate.Text);
            _ht["p_to_date"] = Shared.ToStartDateTime(txtToDate.Text);
            _ht["p_emp_code"] = Shared.CurrentUID;


            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
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

            _ht["p_code_barcode"] = ID;

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
        Response.Redirect("purchasequotationheader.aspx?action=add");
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
        BindData();
    }

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
       
        Response.Redirect("purchasequotationheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlOwner_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    //(+) Ari 11-07-2022 ket : enhancement 2022
    //protected void txtFromDate_TextChanged(object sender, EventArgs e)
    //{
    //    BindData();
    //}
    protected void txtToDateChanged(object sender, EventArgs e)
    {

        BindData();
    }
}
