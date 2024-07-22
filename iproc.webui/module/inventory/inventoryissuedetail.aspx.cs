using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryissuedetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "INVENTORY_ISSUE_DETAIL";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            //btnLookInventoryIssueItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=IIITM&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtItemCode.ClientID, lblItemCode.ClientID, lblItemName.ClientID);
            btnLookInventoryIssueItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ICFI&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_4={3}&ecol_3={4}');", txtItemCode.ClientID, lblItemCode.ClientID, lblItemName.ClientID, txtWarehouseCode.ClientID, txtWarehouseName.ClientID);
            lblBarcode.Text = Request.Params["codebarcode"];

            btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_item_code={3}&parc_branch_code={4}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID, txtItemCode.ClientID, txtBranch.ClientID);
            btnLookUpLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_item_code={3}');", txtLotCode.ClientID, txtLotName.ClientID, txtWarehouseCode.ClientID, txtItemCode.ClientID);
            btnLookUpRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_lot_code={3}');", txtRakCode.ClientID, txtRakName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID);
            btnLookUpSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_lot_code={3}&parc_rak_code={4}');", txtSlotCode.ClientID, txtSlotName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID, txtRakCode.ClientID);

            //Shared.BindLocation(ddlLocation);
            //btnLookUpVoucher.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LRVT&acol_0={0}&bcol_0={1}');", txtVoucherCode.ClientID, lblVoucherCode.ClientID); 

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                btnLookInventoryIssueItem.Enabled = false;

                if (!lblIIStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    btnLookInventoryIssueItem.Enabled = false;
                    txtQuantity.Enabled = false;
                    txtItemDescription.Enabled = false;
                }
                
                if (lblIIStatus.Text == "POST" || lblIIStatus.Text == "CANCEL")
                {
                    btnLookUpLotCode.Enabled = false;
                    btnLookUpRakCode.Enabled = false;
                    btnLookUpSlotCode.Enabled = false;
                    btnLookUpWarehouseCode.Enabled = false;
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
            else
              GetCode();
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
            DataRow _dr = _dal.GetRow("INVENTORY_ISSUE_HEADER", _ht);

            lblIICode.Text = _dr["code"].ToString();
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
        int inextid = 0;
        try
        {
            
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_ii_code"] = Request.Params["codebarcode"];
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref inextid);
                lblId.Text = inextid.ToString();
            }
            else
                _dal.Update(TABLE_NAME_DETAIL, _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventoryissueheader.aspx?action=edit&codebarcode={0}", lblBarcode.Text));          
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
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventoryissueheader.aspx?action=edit&codebarcode=" + lblBarcode.Text + "&idartarget=" + Request.Params["idtarget"]);
    }


    protected void txtItemCode_TextChanged(object sender, EventArgs e)
    {
       
    }
}