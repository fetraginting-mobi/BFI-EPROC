using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterlocation : BasePage
{
    private static string TABLE_NAME = "MASTER_LOCATION";
    private static string TABLE_NAME_LOT = "MASTER_LOCATION_LOT";
    private static string TABLE_NAME_RAK = "MASTER_LOCATION_RAK";
    private static string TABLE_NAME_SLOT = "MASTER_LOCATION_SLOT";
    private static string TABLE_NAME_ITEM = "MASTER_LOCATION_ITEM";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        btnDeleteLot.OnClientClick = "return confirm('Delete selected data?');";
        btnDeleteRak.OnClientClick = "return confirm('Delete selected data?');";
        btnDeleteSlot.OnClientClick = "return confirm('Delete selected data?');";
        btnDeleteItem.OnClientClick = "return confirm('Delete selected data?');";
        if (!Page.IsPostBack)
        {
            btnAddLot.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=LOCLOT&parc_warehouse_code={0}&gvw={1}');", txtCode.ClientID, btnSearchLot.UniqueID);
            btnAddRak.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=LOCRAK&parc_warehouse_code={0}&gvw={1}&parc_lot_code={2}');", txtCode.ClientID, btnSearchRak.UniqueID, ddlLot.ClientID);
            BtnAddSlot.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=LOCSLOT&parc_warehouse_code={0}&gvw={1}&parc_lot_code={2}&parc_rak_code={3}');", txtCode.ClientID, btnSearchSlot.UniqueID, ddlLotSlot.ClientID, ddlRak.ClientID);
            BtnAddItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=LOCITM&parc_warehouse_code={0}&gvw={1}&parc_lot_code={2}&parc_rak_code={3}&parc_slot_code={4}');", txtCode.ClientID, btnSearchItem.UniqueID, ddlLotItem.ClientID, ddlRakItem.ClientID, ddlSlotItem.ClientID);
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "tab();", true);
            
            Shared.BindLocationLot(ddlLot, txtCode.Text);
            
            Shared.BindLocationLot(ddlLotSlot, txtCode.Text);
            Shared.BindLocationRak(ddlRak, txtCode.Text, ddlLotSlot.SelectedValue);

            Shared.BindLocationLot(ddlLotItem, txtCode.Text);
            Shared.BindLocationRak(ddlRakItem, txtCode.Text, ddlLotItem.SelectedValue);
            Shared.BindLocationSlot(ddlSlotItem, txtCode.Text, ddlLotItem.SelectedValue, ddlRakItem.SelectedValue);

            Shared.BindBranchEmployee(ddlBranch);
            ddlBranch.Enabled = true;
            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

            btnAddLot.Visible = false;
            btnDeleteLot.Visible = false;
            BtnSaveLot.Visible = false;

            btnAddRak.Visible = false;
            btnDeleteRak.Visible = false;
            btnSaveRak.Visible = false;

            BtnAddSlot.Visible = false;
            btnDeleteSlot.Visible = false;
            btnSaveSlot.Visible = false;

            BtnAddItem.Visible = false;
            btnDeleteItem.Visible = false;
            btnSaveItem.Visible = false;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataLot();
                BindDataRak();
                BindDataSlot();
                BindDataItem();

                txtCode.Enabled = false;
                chbStorageControl.Enabled = false;

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";

                btnAddLot.Visible = true;
                btnDeleteLot.Visible = true;
                BtnSaveLot.Visible = true;

                btnAddRak.Visible = true;
                btnDeleteRak.Visible = true;
                btnSaveRak.Visible = true;

                BtnAddSlot.Visible = true;
                btnDeleteSlot.Visible = true;
                btnSaveSlot.Visible = true;

                BtnAddItem.Visible = true;
                btnDeleteItem.Visible = true;
                btnSaveItem.Visible = true;

            }
            else
            {
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
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

            _ht["p_code"] = Request.Params["code"];
            DataRow dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, dr);
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
    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
                _dal.Insert(TABLE_NAME, _ht);
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterlocation.aspx?action=edit&code={0}", txtCode.Text));            
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("masterlocationlist.aspx");
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
            _ht["p_warehouse_code"] = Request.Params["code"];

            gvwListLot.DataSource = _dal.GetRows(TABLE_NAME_LOT, _ht);
            gvwListLot.DataBind();

            Shared.BindLocationLot(ddlLot, Request.Params["code"].ToString());
            updLotDDL.Update();

            Shared.BindLocationLot(ddlLotSlot, Request.Params["code"].ToString());
            updRakDDL.Update();

            Shared.BindLocationLot(ddlLotItem, Request.Params["code"].ToString());
            updItemDDL.Update();
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


                    _ht["p_warehouse_code"] = Request.Params["code"].ToString();
                    _ht["p_lot_code"] = gvwListLot.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_minimum_qty"] = MinimalQtyLot;
                    _ht["p_maximum_qty"] = MaximalQtyLot;
                    _ht["p_id"] = gvwListLot.DataKeys[row.RowIndex][0].ToString();

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_master_location_lot_update", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("masterlocation.aspx?action=edit&code={0}", txtCode.Text));
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
        BindDataRak();
        BindDataSlot();
        BindDataItem();
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

            _ht["p_keywords"] = txtSearchRak.Text;
            _ht["p_warehouse_code"] = Request.Params["code"];
            _ht["p_lot_code"] = ddlLot.SelectedValue;

            gvwListRak.DataSource = _dal.GetRows(TABLE_NAME_RAK, _ht);
            gvwListRak.DataBind();

            Shared.BindLocationLot(ddlLotSlot, Request.Params["code"].ToString());
            updRakDDL.Update();

            Shared.BindLocationRak(ddlRak, Request.Params["code"].ToString(), ddlLotSlot.SelectedValue);
            updRakDDL.Update();

            Shared.BindLocationLot(ddlLotItem, Request.Params["code"].ToString());
            updItemDDL.Update();

            Shared.BindLocationRak(ddlRakItem, Request.Params["code"].ToString(), ddlLotItem.SelectedValue);
            updItemDDL.Update();

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

   
    protected void btnSaveRak_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
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
        BindDataSlot();
        BindDataItem();
    }

    protected void ddlLot_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
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


                    _ht["p_warehouse_code"] = Request.Params["code"].ToString();
                    _ht["p_lot_code"] = gvwListRak.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_rak_code"] = gvwListRak.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_minimum_qty"] = MinimalQtyRak;
                    _ht["p_maximum_qty"] = MaximalQtyRak;
                    _ht["p_id"] = gvwListRak.DataKeys[row.RowIndex][0].ToString();

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_master_location_rak_update", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("masterlocation.aspx?action=edit&code={0}", txtCode.Text));
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
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        BindDataRak();
        Shared.BindLocationLot(ddlLot, txtCode.Text.ToString());
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
            _ht["p_warehouse_code"] = Request.Params["code"];
            _ht["p_lot_code"] = ddlLotSlot.SelectedValue;
            _ht["p_rak_code"] = ddlRak.SelectedValue;

            gvwListSlot.DataSource = _dal.GetRows(TABLE_NAME_SLOT, _ht);
            gvwListSlot.DataBind();

            Shared.BindLocationLot(ddlLotItem, Request.Params["code"].ToString());
            updItemDDL.Update();

            Shared.BindLocationRak(ddlRakItem, Request.Params["code"].ToString(), ddlLotItem.SelectedValue);
            updItemDDL.Update();

            Shared.BindLocationSlot(ddlSlotItem, Request.Params["code"].ToString(), ddlLotItem.SelectedValue, ddlRakItem.SelectedValue);
            updItemDDL.Update();
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
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Shared.BindLocationRak(ddlRak, Request.Params["code"].ToString(), ddlLotSlot.SelectedValue);
        BindDataSlot();
    }
    protected void ddlRak_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        BindDataSlot();
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
        BindDataItem();
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


                    _ht["p_warehouse_code"] = Request.Params["code"].ToString();
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

            Shared.ShowSuccessGritter(this, string.Format("masterlocation.aspx?action=edit&code={0}", txtCode.Text));
            BindDataSlot();
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

            _ht["p_keywords"] = txtSearchItem.Text;
            _ht["p_warehouse_code"] = Request.Params["code"];
            _ht["p_lot_code"] = ddlLotItem.SelectedValue;
            _ht["p_rak_code"] = ddlRakItem.SelectedValue;
            _ht["p_slot_code"] = ddlSlotItem.SelectedValue;

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
    protected void gvwListItem_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtMinQtyItem = (TextBox)e.Row.FindControl("txtMinQtyItem");
            TextBox txtMaxQtyItem = (TextBox)e.Row.FindControl("txtMaxQtyItem");
            TextBox txtReorderQtyItem = (TextBox)e.Row.FindControl("txtReorderQtyItem");

            txtMinQtyItem.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MINIMUM_QTY"));
            txtMaxQtyItem.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MAXIMUM_QTY"));
            txtReorderQtyItem.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "REORDER_QTY"));
        }
    }
    private void SaveDataItem()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        GeneralDAL dal = null;
        Hashtable ht = null;

        if (!SelectedExistItem())
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
            foreach (GridViewRow row in gvwListItem.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    string MinimalQtySlot = ((TextBox)row.Cells[4].Controls[1]).Text;
                    string MaximalQtySlot = ((TextBox)row.Cells[5].Controls[1]).Text;
                    string ReorderQtySlot = ((TextBox)row.Cells[6].Controls[1]).Text;


                    _ht["p_warehouse_code"] = Request.Params["code"].ToString();
                    _ht["p_lot_code"] = gvwListItem.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_rak_code"] = gvwListItem.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_slot_code"] = gvwListItem.DataKeys[row.RowIndex][3].ToString();
                    _ht["p_item_code"] = gvwListItem.DataKeys[row.RowIndex][4].ToString();
                    _ht["p_minimum_qty"] = MinimalQtySlot;
                    _ht["p_maximum_qty"] = MaximalQtySlot;
                    _ht["p_reorder_qty"] = ReorderQtySlot;
                    _ht["p_id"] = gvwListItem.DataKeys[row.RowIndex][0].ToString();

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_master_location_item_update", _ht);
                }
            }
            dal = new GeneralDAL();
            ht = new Hashtable();

            ht["p_warehouse_code"] = Request.Params["code"].ToString();
            ht["p_lot_code"] = ddlLotItem.SelectedValue;
            ht["p_rak_code"] = ddlRakItem.SelectedValue;
            ht["p_slot_code"] = ddlSlotItem.SelectedValue;

            dal.ExecRawSP("xsp_master_location_item_update_validate", ht);

            Shared.ShowSuccessGritter(this, string.Format("masterlocation.aspx?action=edit&code={0}", txtCode.Text));
            BindDataItem();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
   
    protected void ddlLotItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Shared.BindLocationRak(ddlRakItem, Request.Params["code"].ToString(), ddlLotItem.SelectedValue);
        Shared.BindLocationSlot(ddlSlotItem, Request.Params["code"].ToString(), ddlLotItem.SelectedValue, ddlRakItem.SelectedValue);
        BindDataItem();
    }
    protected void ddlRakItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        
        Shared.BindLocationSlot(ddlSlotItem, Request.Params["code"].ToString(), ddlLotItem.SelectedValue, ddlRakItem.SelectedValue);
        BindDataItem();
    }
    protected void ddlSlotItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        BindDataItem();
    }
    protected void btnSaveItem_Click(object sender, EventArgs e)
    {
        SaveDataItem();
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
        Response.Redirect(string.Format("masterlocationitem.aspx?action=edit&warehousecode={0}&warehousedesc={1}", txtCode.Text, txtDescription.Text));
    }

    protected void chbCheckedAllItem_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListItem.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedItem") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    private Boolean SelectedExistItem()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListItem.Rows)
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
}
