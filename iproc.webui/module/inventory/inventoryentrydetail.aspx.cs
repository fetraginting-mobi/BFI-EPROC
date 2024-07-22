using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryentrydetail : BasePage
{

    private static string TABLE_NAME_DETAIL = "INVENTORY_ENTRY_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {

        btnLookUpInventoryEntryItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=IEITM&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}');", txtItemCode.ClientID, lblItemCode.ClientID, lblItemName.ClientID, ddlUnitID.ClientID);
      
        LoadInit();
        if (!Page.IsPostBack)
        {
            lblCodeBarcode.Text = Request.Params["codebarcode"];

            //Shared.BindLocation(ddlLastLocation);
            Shared.BindMasterUnit(ddlUnitID);
            //Shared.BindLot(ddlLastLot);
            //Shared.BindRak(ddlLastRak);
            //Shared.BindSlot(ddlLastSlot);
            btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFL&acol_0={0}&bcol_1={1}');", txtWarehouseCode.ClientID, lblWarehouseCode.ClientID);
            btnLookUpLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}');", txtLotCode.ClientID, txtLotName.ClientID, lblLotName.ClientID, txtWarehouseCode.ClientID);
            btnLookUpRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}');", txtRakCode.ClientID, txtRakName.ClientID, lblRakName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID);
            btnLookUpSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}&parc_rak_code={5}');", txtSlotCode.ClientID, txtSlotName.ClientID, lblSlotName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID, txtRakCode.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;

                if (!lblIEStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    btnLookUpInventoryEntryItem.Enabled = false;
                    txtQuantity.Enabled = false;
                    ddlUnitID.Enabled = false;
                    //ddlLastLocation.Enabled = false;
                    txtDescription.Enabled = false;
                    txtUnitPrice.Enabled = false;
                }

            }
            else 
            {
                GetCode();
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
            DataRow _dr = _dal.GetRow("INVENTORY_ENTRY_HEADER", _ht);

            lblIECode.Text = _dr["code"].ToString();
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
            DataRow _dr = _dal.GetRow(TABLE_NAME_DETAIL, _ht);

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

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME_DETAIL, _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventoryentrydetail.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, lblCodeBarcode.Text));
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
        Response.Redirect("inventoryentryheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text);
    }  
}
