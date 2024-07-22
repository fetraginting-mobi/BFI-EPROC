using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryadjustmentdetail : BasePage
{
    private static string TABLE_NAME = "INVENTORY_ADJUSTMENT_DETAIL";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            //Shared.BindLocation(ddlLocationCode);

            //if (txtWarehouseCode.Text == "LO1")
            //{
            //    tableLot.Visible = true;
            //    tableRack.Visible = true;
            //    tableSlot.Visible = true;
            //}
            //else
            //{
            //    tableLot.Visible = false;
            //    tableRack.Visible = false;
            //    tableSlot.Visible = false;
            //}

            btnLookUpInventoryAdjustmentItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ICFI&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_4={3}&ecol_3={4}&fcol_5={5}&gcol_6={6}&hcol_7={7}&icol_8={8}&jcol_9={9}&kcol_10={10}&parc_branch_code={11}');", txtItemCode.ClientID, lblItemCode.ClientID, txtItemName.ClientID, txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtLotCode.ClientID, txtLotName.ClientID, txtRakCode.ClientID, txtRakName.ClientID, txtSlotCode.ClientID, txtSlotName.ClientID, txtBranch.ClientID);
            btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFL&acol_0={0}&bcol_1={1}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID);
            btnLookUpLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}');", txtLotCode.ClientID, txtLotName.ClientID, txtLotName.ClientID, txtWarehouseCode.ClientID);
            btnLookUpRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}');", txtRakCode.ClientID, txtRakName.ClientID, txtRakName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID);
            btnLookUpSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}&parc_rak_code={5}');", txtSlotCode.ClientID, txtSlotName.ClientID, txtSlotName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID, txtRakCode.ClientID);
            
            lblBarcode.Text = Request.Params["codebarcode"];

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                if (!lblIAStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    btnLookUpInventoryAdjustmentItem.Enabled = false;
                    rbDebetOrKredet.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtTotalAdjustment.Enabled = false;
                    btnLookUpWarehouseCode.Enabled = false;
                    btnLookUpLotCode.Enabled = false;
                    btnLookUpRakCode.Enabled = false;
                    btnLookUpSlotCode.Enabled = false;

                }

                //    if (txtWarehouseCode.Text == "LO1")
                //    {
                //        tableLot.Visible = true;
                //        tableRack.Visible = true;
                //        tableSlot.Visible = true;
                //    }
                //    else
                //    {
                //        tableLot.Visible = false;
                //        tableRack.Visible = false;
                //        tableSlot.Visible = false;
                //    }
                //}
                //else
                //{ 
                //    GetCode();

                //    if (txtWarehouseCode.Text == "LO1")
                //    {
                //        tableLot.Visible = true;
                //        tableRack.Visible = true;
                //        tableSlot.Visible = true;
                //    }
                //    else
                //    {
                //        tableLot.Visible = false;
                //        tableRack.Visible = false;
                //        tableSlot.Visible = false;
                //    }

                //}
            }
        }
        LoadAfterInit();
    }

    private void GetCode()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow("INVENTORY_ADJUSTMENT_HEADER", _ht);

            lblIACode.Text = _dr["code"].ToString();
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
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref inextid);
                lblId.Text = inextid.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventoryadjustmentheader.aspx?action=edit&codebarcode={0}", lblBarcode.Text));
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
        Response.Redirect("inventoryadjustmentheader.aspx?action=edit&codebarcode=" + lblBarcode.Text + "&idartarget=" + Request.Params["idartarget"]);
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        //if (txtWarehouseCode.Text == "LO1")
        //{
        //    tableLot.Visible = true;
        //    tableRack.Visible = true;
        //    tableSlot.Visible = true;
        //}
        //else
        //{
        //    tableLot.Visible = false;
        //    tableRack.Visible = false;
        //    tableSlot.Visible = false;
        //    txtLotCode.Text = "";
        //    txtLotName.Text = "";
        //    txtRakCode.Text = "";
        //    txtRakName.Text = "";
        //    txtSlotCode.Text = "";
        //    txtSlotName.Text = "";
        //}

    }

}