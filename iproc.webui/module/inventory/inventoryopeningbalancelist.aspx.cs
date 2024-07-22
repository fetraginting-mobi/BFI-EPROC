using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryopeningbalancelist : BasePageList
{
    private static string TABLE_NAME = "INVENTORY_OPENING_BALANCE";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "INVENTORY_OPENING_BALANCE";
        NEXT_PAGE = "inventoryopeningbalancelist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll1(ddlBranch);
            Shared.BindLocationFilterBranch1(ddlLocation, ddlBranch.SelectedValue);
            Shared.BindLocationLot(ddlLot, ddlLocation.SelectedValue);
            Shared.BindLocationRak(ddlRak, ddlLocation.SelectedValue, ddlLot.SelectedValue);
            Shared.BindLocationSlot(ddlSlot, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue);

            btnProcess.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
            GenerateData();
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
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_lot_code"] = ddlLot.SelectedValue;
            _ht["p_rak_code"] = ddlRak.SelectedValue;
            _ht["p_slot_code"] = ddlSlot.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_inventory_opening_balance_getrows", _ht);
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

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtQty = (TextBox)e.Row.FindControl("txtQty");
            TextBox txtUnitPrice = (TextBox)e.Row.FindControl("txtUnitPrice");

            txtQty.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QUANTITY"));
            txtUnitPrice.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UNIT_PRICE"));
        }
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

            _ht["p_code_barcode"] = "" ;
            _ht["p_entry_date"] = DateTime.Now;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_inventory_opening_balance_insert", _ht);


          
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //protected void btnGenerate_Click(object sender, EventArgs e)
    //{
    //    GenerateData();
    //}

    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    string Qty = ((TextBox)row.Cells[9].Controls[1]).Text;
                    string UnitPrice = ((TextBox)row.Cells[10].Controls[1]).Text;

                    _ht["p_code_barcode"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_last_location"] = gvwList.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_last_lot"] = gvwList.DataKeys[row.RowIndex][3].ToString();
                    _ht["p_last_rak"] = gvwList.DataKeys[row.RowIndex][4].ToString();
                    _ht["p_last_slot"] = gvwList.DataKeys[row.RowIndex][5].ToString();
                    _ht["p_quantity"] = Qty;
                    _ht["p_unit_price"] = UnitPrice;
                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_inventory_opening_balance_update", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("inventoryopeningbalancelist.aspx"));
            BindData();
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

    private void ProcessData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_code_barcode"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_last_location"] = gvwList.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_last_lot"] = gvwList.DataKeys[row.RowIndex][3].ToString();
                    _ht["p_last_rak"] = gvwList.DataKeys[row.RowIndex][4].ToString();
                    _ht["p_last_slot"] = gvwList.DataKeys[row.RowIndex][5].ToString();
                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_inventory_opening_balance_process", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("inventoryopeningbalancelist.aspx"));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
    }
    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationFilterBranch1(ddlLocation, ddlBranch.SelectedValue);
        Shared.BindLocationLot(ddlLot, ddlLocation.SelectedValue);
        Shared.BindLocationRak(ddlRak, ddlLocation.SelectedValue, ddlLot.SelectedValue);
        Shared.BindLocationSlot(ddlSlot, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue);
        BindData();
        GenerateData();
    }
    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationLot(ddlLot, ddlLocation.SelectedValue);
        Shared.BindLocationRak(ddlRak, ddlLocation.SelectedValue, ddlLot.SelectedValue);
        Shared.BindLocationSlot(ddlSlot, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue);
        BindData();
    }
    protected void ddlLot_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationRak(ddlRak, ddlLocation.SelectedValue, ddlLot.SelectedValue);
        BindData();
    }
    protected void ddlRak_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationSlot(ddlSlot, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue);
        BindData();
    }
    protected void ddlSlot_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
