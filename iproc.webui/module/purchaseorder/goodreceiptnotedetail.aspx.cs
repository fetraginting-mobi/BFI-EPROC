using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_goodreceiptnotedetail : BasePage
{
    private static string TABLE_NAME = "GOOD_RECEIPT_NOTE_DETAIL";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            var a = txtWarehouseCode.ClientID;
            var b = txtWarehouseName.ClientID;
            var c = txtStorageControl.ClientID;
            btnLookUpShipper.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSLU&acol_0={0}&bcol_1={1}');", txtTrxCode.ClientID, txtDescription.ClientID); 
            btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID);
            btnLookUpLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}');", txtLotCode.ClientID, txtLotName.ClientID, txtWarehouseCode.ClientID);
            btnLookUpRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_lot_code={3}');", txtRakCode.ClientID, txtRakName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID);
            btnLookUpSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_lot_code={3}&parc_rak_code={4}');", txtSlotCode.ClientID, txtSlotName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID, txtRakCode.ClientID);
            btnLookupStock.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ICGI&parc_item_code={0}&parc_branch_code={1}');", txtItemCode.ClientID, txtBranch.ClientID);

            ///btnLookUpGRNItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=GRNIT&acol_0={0}&bcol_1={1}&parc_po_code={2}&ccol_2={3}&dcol_3={4}&ecol_2={5}&fcol_3={6}&gcol_4={7}&hcol_4={8}'); javascript:__doPostBack('ctl00$cpb$btnReloadLocation','')", txtItemCode.ClientID, lblItemName.ClientID, lblPO.ClientID, txtPOQuantity.ClientID, txtUnitPrice.ClientID, lblPOQuantity.ClientID, lblUnitPrice.ClientID, txtRemaining.ClientID, lblRemaining.ClientID);

            Shared.BindMasterUnit(ddlUnitID);
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;

             
                if (lblJenisItem.Text == "IT")
                {
                    btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_item_code={3}&parc_branch_code={4}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID, txtItemCode.ClientID, txtBranch.ClientID);
                    // (+) 4/13/2017 6:25:45 PM  Rifki,
                    //btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID);

                }
                if (lblJenisItem.Text == "IC")
                {
                    btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_item_code={3}&parc_branch_code={4}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID, txtItemCode.ClientID, txtBranch.ClientID);
                    // (+) 4/13/2017 6:25:45 PM  Rifki,
                    //btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID);

                }
                if (lblJenisItem.Text == "FA")
                {
                    btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FALOC&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtBranch.ClientID);
                    btnLookUpLotCode.Visible = txtLotCode.Visible = txtLotName.Visible = false;
                    btnLookUpRakCode.Visible = txtRakCode.Visible = txtRakName.Visible = false;
                    btnLookUpSlotCode.Visible = txtSlotCode.Visible = txtSlotCode.Visible = false;
                    slot.Visible = lot.Visible = rak.Visible = false;
                    btnLookupStock.Visible = false;
                    TableLot.Visible = false;
                    TableRak.Visible = false;
                    TableSlot.Visible = false;
                }

                if (lblJenisItem.Text == "ET")
                {
                    lblJenisItem.Text = "EXPENSE";
                    btnLookUpWarehouseCode.Visible = false;
                    lookupWarehouse.Visible = false;
                    btnLookUpLotCode.Visible = txtLotCode.Visible = txtLotName.Visible = false;
                    btnLookUpRakCode.Visible = txtRakCode.Visible = txtRakName.Visible = false;
                    btnLookUpSlotCode.Visible = txtSlotCode.Visible = txtSlotCode.Visible = false;
                    slot.Visible = lot.Visible = rak.Visible = false;
                    TableLot.Visible = false;
                    TableRak.Visible = false;
                    TableSlot.Visible = false;
                    rvfWarehouse.Enabled = false;
                }


                if (lblCategoryItem.Text == "SERVICES")
                {
                    if (lblJenisItem.Text == "IC" || lblJenisItem.Text == "IT")
                    {
                        btnLookUpWarehouseCode.Visible = false;
                        lookupWarehouse.Visible = false;
                        btnLookUpLotCode.Visible = txtLotCode.Visible = txtLotName.Visible = false;
                        btnLookUpRakCode.Visible = txtRakCode.Visible = txtRakName.Visible = false;
                        btnLookUpSlotCode.Visible = txtSlotCode.Visible = txtSlotCode.Visible = false;
                        slot.Visible = lot.Visible = rak.Visible = false;
                        TableLot.Visible = false;
                        TableRak.Visible = false;
                        TableSlot.Visible = false;
                        rvfWarehouse.Enabled = false;
                    }
                }

           


            txtTotalAmount.Enabled = false;
            lblBarcode.Text = Request.Params["codebarcode"];
 

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblId.Enabled = false;
               // btnCancel.Text = "Back";

                

                    if (lblJenisItem.Text == "IT")
                    {
                        btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_item_code={3}&parc_branch_code={4}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID, txtItemCode.ClientID, txtBranch.ClientID);
                        // (+) 4/13/2017 6:25:45 PM  Rifki,
                        //btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID);

                    }
                    if (lblJenisItem.Text == "IC")
                    {
                        btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_item_code={3}&parc_branch_code={4}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID, txtItemCode.ClientID, txtBranch.ClientID);
                        // (+) 4/13/2017 6:25:45 PM  Rifki,
                        //btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID);

                    }
                    if (lblJenisItem.Text == "FA")
                    {
                        btnLookUpShipper.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSLU&acol_0={0}&bcol_1={1}');", txtTrxCode.ClientID, txtDescription.ClientID);
                        btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FALOC&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtBranch.ClientID);
                        btnLookUpLotCode.Visible = txtLotCode.Visible = txtLotName.Visible = false;
                        btnLookUpRakCode.Visible = txtRakCode.Visible = txtRakName.Visible = false;
                        btnLookUpSlotCode.Visible = txtSlotCode.Visible = txtSlotCode.Visible = false;
                        slot.Visible = lot.Visible = rak.Visible = false;
                        btnLookupStock.Visible = false;
                        TableLot.Visible = false;
                        TableRak.Visible = false;
                        TableSlot.Visible = false;
                    }
                    if (lblJenisItem.Text == "ET")
                    {
                        lblJenisItem.Text = "EXPENSE";
                        lookupWarehouse.Visible = false;
                        btnLookUpWarehouseCode.Visible = false;
                        btnLookUpLotCode.Visible = txtLotCode.Visible = txtLotName.Visible = false;
                        btnLookUpRakCode.Visible = txtRakCode.Visible = txtRakName.Visible = false;
                        btnLookUpSlotCode.Visible = txtSlotCode.Visible = txtSlotCode.Visible = false;
                        slot.Visible = lot.Visible = rak.Visible = false;
                        TableLot.Visible = false;
                        TableRak.Visible = false;
                        TableSlot.Visible = false;
                    }
                 

                if (lblCategoryItem.Text == "SERVICES")
                {
                    if (lblJenisItem.Text == "IC" || lblJenisItem.Text == "IT")
                    {
                        btnLookUpWarehouseCode.Visible = false;
                        lookupWarehouse.Visible = false;
                        btnLookUpLotCode.Visible = txtLotCode.Visible = txtLotName.Visible = false;
                        btnLookUpRakCode.Visible = txtRakCode.Visible = txtRakName.Visible = false;
                        btnLookUpSlotCode.Visible = txtSlotCode.Visible = txtSlotCode.Visible = false;
                        slot.Visible = lot.Visible = rak.Visible = false;
                        TableLot.Visible = false;
                        TableRak.Visible = false;
                        TableSlot.Visible = false;
                        rvfWarehouse.Enabled = false;
                    }
                }

                if (lblStatus.Text == "POST" || lblStatus.Text == "CLOSED" || lblStatus.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = false;
                    txtReceiveQuantity.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpWarehouseCode.Enabled = false;
                    btnLookUpLotCode.Enabled = btnLookUpRakCode.Enabled = btnLookUpSlotCode.Enabled = false;
                    btnSave.Visible = false;
                    txtNoResi.Enabled = false;
                    txtShipperAmount.Enabled = false;
                }
                if (txtStorageControl.Text == "N")
                {
                    lot.Visible = false;
                    rak.Visible = false;
                    slot.Visible = false;
                    rfvLotCode.Enabled = false;
                    rfvRakCode.Enabled = false;
                    rfvSlotCode.Enabled = false;
                }
                else
                {
                    lot.Visible = true;
                    rak.Visible = true;
                    slot.Visible = true;
                    rfvLotCode.Enabled = true;
                    rfvRakCode.Enabled = true;
                    rfvSlotCode.Enabled = true;
                }
            }
            else if (Request.Params["action"].Equals("add"))
            {
                GetCode();
                lblPO.Text = Request.Params["pono"];
            }
        }
        LoadAfterInit();
    }

    //protected void btnReloadLocation_Click(object sender, EventArgs e)
    //{
    //    Shared.BindLocationOrFALocation(ddlLocationCode, txtItemCode.Text);      
    //}

    private void GetCode()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow("GOOD_RECEIPT_NOTE_HEADER", _ht);

            lblCode.Text = _dr["code"].ToString();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = Request.Params["id"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        if (txtStorageControl.Text == "N")
        {
            lot.Visible = false;
            rak.Visible = false;
            slot.Visible = false;
        }
        else
        {
            lot.Visible = true;
            rak.Visible = true;
            slot.Visible = true;
        }

    }

    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int inextid = 0;

        
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref inextid);
                lblId.Text = inextid.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("goodreceiptnotedetail.aspx?action=edit&id={0}&codebarcode={1}", lblId.Text, lblBarcode.Text));
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
        Response.Redirect("goodreceiptnoteheader.aspx?action=edit&codebarcode=" + lblBarcode.Text);
    }
}