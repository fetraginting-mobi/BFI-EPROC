using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterwarehousetrx : BasePage
{
    private static string TABLE_NAME = "MASTER_LOCATION_QTY";
    private static string TABLE_NAME_LOT = "MASTER_LOCATION_LOT";
    private static string TABLE_NAME_RAK = "MASTER_LOCATION_RAK";
    private static string TABLE_NAME_SLOT = "MASTER_LOCATION_SLOT";
    private static string TABLE_NAME_ITEM = "MASTER_LOCATION_ITEM";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFL&acol_0={0}&bcol_1={1}');", txtWarehouseCode.ClientID, lblWarehouseCode.ClientID);
            btnAddLot.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=LOCLOT&parc_warehouse_code={0}&gvw={1}');", txtWarehouseCode.ClientID, btnSearchLot.UniqueID);
            btnAddRak.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=LOCRAK&parc_warehouse_code={0}&gvw={1}&parc_lot_code={2}');", txtWarehouseCode.ClientID, btnSearchRak.UniqueID, ddlLot.ClientID);
            BtnAddSlot.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=LOCSLOT&parc_warehouse_code={0}&gvw={1}&parc_lot_code={2}&parc_rak_code={3}');", txtWarehouseCode.ClientID, btnSearchSlot.UniqueID, ddlLotSlot.ClientID, ddlRak.ClientID);
            Shared.BindLocationLot(ddlLot, Request.Params["warehousecode"].ToString());
            Shared.BindLocationLot(ddlLotSlot, Request.Params["warehousecode"].ToString());
            Shared.BindLocationRak(ddlRak, Request.Params["warehousecode"].ToString(), ddlLotSlot.SelectedValue);
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataLot();
                BindDataRak();
                BindDataSlot();
                BindDataItem();
                lblId.Enabled = true;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
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

            _ht["p_warehouse_code"] = Request.Params["warehousecode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int iNextID = 0;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_warehouse_code"] = txtWarehouseCode.Text;
            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblId.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterwarehousetrx.aspx?action=edit&warehousecode={0}", txtWarehouseCode.Text));
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
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("masterwarehousetrxlist.aspx");
    }

    #region Lot
    private void BindDataLot()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchLot.Text;
            _ht["p_warehouse_code"] = Request.Params["warehousecode"];

            gvwListLot.DataSource = _dal.GetRows(TABLE_NAME_LOT, _ht);
            gvwListLot.DataBind();

            //Shared.BindLocationLot(ddlLot, Request.Params["warehousecode"].ToString());
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwListLot_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListLot.PageIndex = e.NewPageIndex;
        BindDataLot();
    }
    protected void gvwListLot_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtMinQty = (TextBox)e.Row.FindControl("txtMinQty");
            TextBox txtMaxQty = (TextBox)e.Row.FindControl("txtMaxQty");

            txtMinQty.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MINIMUM_QTY"));
            txtMaxQty.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MAXIMUM_QTY"));
        }
    }
    private void SaveDataLot()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

        if (!SelectedExistLot())
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
            foreach (GridViewRow row in gvwListLot.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    string MinimalQtyLot = ((TextBox)row.Cells[4].Controls[1]).Text;
                    string MaximalQtyLot = ((TextBox)row.Cells[5].Controls[1]).Text;


                    _ht["p_warehouse_code"] = Request.Params["warehousecode"].ToString();
                    _ht["p_lot_code"] = gvwListLot.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_minimum_qty"] = MinimalQtyLot;
                    _ht["p_maximum_qty"] = MaximalQtyLot;
                    _ht["p_id"] = gvwListLot.DataKeys[row.RowIndex][0].ToString(); 

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_master_location_lot_update", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("masterwarehousetrx.aspx?action=edit&warehousecode={0}", txtWarehouseCode.Text));
            BindDataLot();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnSaveLot_Click(object sender, EventArgs e)
    {
        SaveDataLot();
    }
    protected void btnAddLot_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("masterlocationlot.aspx?action=add&warehousecode={0}&warehousedesc={1}", txtWarehouseCode.Text, lblWarehouseCode.Text));
    }
    protected void btnDeleteLot_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListLot.Rows)
        {
            CheckBox chbCheckedLot = (CheckBox)row.Cells[1].Controls[1];
            if (chbCheckedLot.Checked)
            {
                DeleteDataLot(gvwListLot.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataLot();
    }
    private Boolean SelectedExistLot()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListLot.Rows)
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
    private void DeleteDataLot(string WAREHOUSE_CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = WAREHOUSE_CODE;

            _dal.Delete(TABLE_NAME_LOT, _ht);

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnSearchLot_Click(object sender, EventArgs e)
    {
        BindDataLot();
        
    }
    protected void gvwListLot_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("masterlocationlot.aspx?action=edit&warehousecode={0}&warehousedesc={1}&id={2}", txtWarehouseCode.Text,lblWarehouseCode.Text, gvwListLot.SelectedDataKey[0].ToString()));
    }
    protected void chbCheckedAllLot_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListLot.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedLot") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    #endregion

    #region Rak
    private void BindDataRak()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchLot.Text;
            _ht["p_warehouse_code"] = Request.Params["warehousecode"];
            _ht["p_lot_code"] = ddlLot.SelectedValue;

            gvwListRak.DataSource = _dal.GetRows(TABLE_NAME_RAK, _ht);
            gvwListRak.DataBind();

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListRak_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListRak.PageIndex = e.NewPageIndex;
        BindDataRak();
    }

    protected void btnAddRak_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("masterlocationrak.aspx?action=add&warehousecode={0}&warehousedesc={1}", txtWarehouseCode.Text, lblWarehouseCode.Text));
    }
    protected void btnSaveRak_Click(object sender, EventArgs e)
    {
        SaveDataRak();
    }
    protected void btnDeleteRak_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListRak.Rows)
        {
            CheckBox chbCheckedRak = (CheckBox)row.Cells[1].Controls[1];
            if (chbCheckedRak.Checked)
            {
                DeleteDataRak(gvwListRak.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataRak();
    }

    protected void ddlLot_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataRak();
    }

    protected void gvwListRak_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtMinQtyRak = (TextBox)e.Row.FindControl("txtMinQtyRak");
            TextBox txtMaxQtyRak = (TextBox)e.Row.FindControl("txtMaxQtyRak");

            txtMinQtyRak.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MINIMUM_QTY"));
            txtMaxQtyRak.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MAXIMUM_QTY"));
        }
    }

    private void SaveDataRak()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

        if (!SelectedExistRak())
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
            foreach (GridViewRow row in gvwListRak.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    string MinimalQtyRak = ((TextBox)row.Cells[4].Controls[1]).Text;
                    string MaximalQtyRak = ((TextBox)row.Cells[5].Controls[1]).Text;


                    _ht["p_warehouse_code"] = Request.Params["warehousecode"].ToString();
                    _ht["p_lot_code"] = gvwListRak.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_rak_code"] = gvwListRak.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_minimum_qty"] = MinimalQtyRak;
                    _ht["p_maximum_qty"] = MaximalQtyRak;
                    _ht["p_id"] = gvwListRak.DataKeys[row.RowIndex][0].ToString();

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_master_location_rak_update", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("masterwarehousetrx.aspx?action=edit&warehousecode={0}", txtWarehouseCode.Text));
            BindDataRak();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
            
    private void DeleteDataRak(string WAREHOUSE_CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = WAREHOUSE_CODE;

            _dal.Delete(TABLE_NAME_RAK, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchRak_Click(object sender, EventArgs e)
    {
        BindDataRak();
        Shared.BindLocationLot(ddlLot, txtWarehouseCode.Text.ToString());
    }
    protected void gvwListRak_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("masterlocationrak.aspx?action=edit&warehousecode={0}&warehousedesc={1}&id={2}", txtWarehouseCode.Text, lblWarehouseCode.Text, gvwListRak.SelectedDataKey[0].ToString()));
    }

    protected void chbCheckedAllRak_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListRak.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedRak") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    private Boolean SelectedExistRak()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListRak.Rows)
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
    #endregion

    #region Slot
    private void BindDataSlot()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchSlot.Text;
            _ht["p_warehouse_code"] = Request.Params["warehousecode"];
            _ht["p_lot_code"] = ddlLotSlot.SelectedValue;
            _ht["p_rak_code"] = ddlRak.SelectedValue;

            gvwListSlot.DataSource = _dal.GetRows(TABLE_NAME_SLOT, _ht);
            gvwListSlot.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListSlot_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListSlot.PageIndex = e.NewPageIndex;
        BindDataSlot();
    }
    protected void ddlLotSlot_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationRak(ddlRak, Request.Params["warehousecode"].ToString(), ddlLotSlot.SelectedValue);
        BindDataSlot();
    }

    protected void ddlRak_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataSlot();
    }

    protected void btnAddSlot_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("masterlocationslot.aspx?action=add&warehousecode={0}&warehousedesc={1}", txtWarehouseCode.Text, lblWarehouseCode.Text));
    }
    protected void btnSaveSlot_Click(object sender, EventArgs e)
    {
        SaveDataSlot();
    }
    protected void btnDeleteSlot_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListSlot.Rows)
        {
            CheckBox chbCheckedSlot = (CheckBox)row.Cells[1].Controls[1];
            if (chbCheckedSlot.Checked)
            {
                DeleteDataSlot(gvwListSlot.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataSlot();
    }

    private void DeleteDataSlot(string WAREHOUSE_CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = WAREHOUSE_CODE;

            _dal.Delete(TABLE_NAME_SLOT, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchSlot_Click(object sender, EventArgs e)
    {
        BindDataSlot();
    }
    protected void gvwListSlot_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("masterlocationslot.aspx?action=edit&warehousecode={0}&warehousedesc={1}&id={2}", txtWarehouseCode.Text, lblWarehouseCode.Text, gvwListSlot.SelectedDataKey[0].ToString()));
    }
    protected void gvwListSlot_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtMinQtySlot = (TextBox)e.Row.FindControl("txtMinQtySlot");
            TextBox txtMaxQtySlot = (TextBox)e.Row.FindControl("txtMaxQtySlot");

            txtMinQtySlot.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MINIMUM_QTY"));
            txtMaxQtySlot.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MAXIMUM_QTY"));
        }
    }
    private void SaveDataSlot()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

        if (!SelectedExistSlot())
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
            foreach (GridViewRow row in gvwListSlot.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    string MinimalQtySlot = ((TextBox)row.Cells[4].Controls[1]).Text;
                    string MaximalQtySlot = ((TextBox)row.Cells[5].Controls[1]).Text;


                    _ht["p_warehouse_code"] = Request.Params["warehousecode"].ToString();
                    _ht["p_lot_code"] = gvwListSlot.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_rak_code"] = gvwListSlot.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_slot_code"] = gvwListSlot.DataKeys[row.RowIndex][3].ToString();
                    _ht["p_minimum_qty"] = MinimalQtySlot;
                    _ht["p_maximum_qty"] = MaximalQtySlot;
                    _ht["p_id"] = gvwListSlot.DataKeys[row.RowIndex][0].ToString();

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_master_location_slot_update", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("masterwarehousetrx.aspx?action=edit&warehousecode={0}", txtWarehouseCode.Text));
            BindDataRak();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void chbCheckedAllSlot_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListSlot.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedSlot") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    private Boolean SelectedExistSlot()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListSlot.Rows)
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

            _ht["p_keywords"] = txtSearchSlot.Text;
            _ht["p_warehouse_code"] = Request.Params["warehousecode"];

            gvwListItem.DataSource = _dal.GetRows(TABLE_NAME_ITEM, _ht);
            gvwListItem.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListItem_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListItem.PageIndex = e.NewPageIndex;
        BindDataItem();
    }

    protected void btnAddItem_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("masterlocationitem.aspx?action=add&warehousecode={0}&warehousedesc={1}", txtWarehouseCode.Text, lblWarehouseCode.Text));
    }

    protected void btnDeleteItem_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListItem.Rows)
        {
            CheckBox chbCheckedItem = (CheckBox)row.Cells[1].Controls[1];
            if (chbCheckedItem.Checked)
            {
                DeleteDataItem(gvwListItem.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataItem();
    }



    private void DeleteDataItem(string WAREHOUSE_CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = WAREHOUSE_CODE;

            _dal.Delete(TABLE_NAME_ITEM, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchItem_Click(object sender, EventArgs e)
    {
        BindDataItem();
    }
    protected void gvwListItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("masterlocationitem.aspx?action=edit&warehousecode={0}&warehousedesc={1}", txtWarehouseCode.Text, lblWarehouseCode.Text));
    }

    protected void chbCheckedAllItem_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListItem.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedItem") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    #endregion
}
