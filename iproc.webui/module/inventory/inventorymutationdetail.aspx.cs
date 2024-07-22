using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventorymutationdetail : BasePage
{
    private static string TABLE_NAME = "INVENTORY_MUTATION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        txtLocation.Text = Request.Params["location"];
        txtLot.Text = Request.Params["lot"];
        txtRak.Text = Request.Params["rak"];
        txtSlot.Text = Request.Params["slot"];

        btnLookUpInventoryMutationItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=IAITM&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&parc_location={4}&parc_lot={5}&parc_rak={6}&parc_slot={7}');", txtItemCode.ClientID, lblItemCode.ClientID, lblItemName.ClientID, txtOnhandQty.ClientID, txtLocation.ClientID, txtLot.ClientID, txtRak.ClientID, txtSlot.ClientID);
        LoadInit();
        if (!Page.IsPostBack)
        {
            //btnLookUpInventoryMutationItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MITEM&acol_0={0}&bcol_1={1}');", txtItemCode.ClientID, lblItemName.ClientID);
            //btnLookUpInventoryMutationItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=IRITM&acol_0={0}&bcol_1={1}');", txtItemCode.ClientID, lblItemName.ClientID);
           
            Shared.BindBranchAll(ddlToBranch);
            btnFromLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&parc_item_code={2}&parc_branch_code={3}');", txtFromLocationCode.ClientID, lblFromLocationName.ClientID, txtItemCode.ClientID, txtFromBranchCode.ClientID);
            btnLookUpFromLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_item_code={4}');", txtFromLotCode.ClientID, txtFromLotName.ClientID, lblFromLotName.ClientID, txtFromLocationCode.ClientID, txtItemCode.ClientID);
            btnLookUpFromRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}');", txtFromRakCode.ClientID, txtFromRakName.ClientID, lblFromRakName.ClientID, txtFromLocationCode.ClientID, txtFromLotCode.ClientID);
            btnLookUpFromSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}&parc_rak_code={5}');", txtFromSlotCode.ClientID, txtFromSlotName.ClientID, lblFromSlotName.ClientID, txtFromLocationCode.ClientID, txtFromLotCode.ClientID, txtFromRakCode.ClientID);


            btnToLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFA&acol_0={0}&bcol_1={1}&parc_item_code={2}&parc_branch_code={3}');", txtToLocationCode.ClientID, lblToLocationName.ClientID, txtItemCode.ClientID, ddlToBranch.ClientID);
            btnLookUpToLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_item_code={4}');", txtToLotCode.ClientID, txtToLotName.ClientID, lblToLotName.ClientID, txtToLocationCode.ClientID, txtItemCode.ClientID);
            btnLookUpToRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}');", txtToRakCode.ClientID, txtToRakName.ClientID, lblToRakName.ClientID, txtToLocationCode.ClientID, txtToLotCode.ClientID);
            btnLookUpToSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}&parc_rak_code={5}');", txtToSlotCode.ClientID, txtToSlotName.ClientID, lblToSlotName.ClientID, txtToLocationCode.ClientID, txtToLotCode.ClientID, txtToRakCode.ClientID);
            lblCodeBarcode.Text = Request.Params["codebarcode"];


            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                if (lblIMStatus.Text == "POST")
                {
                    btnSave.Visible = false;
                    btnLookUpInventoryMutationItem.Enabled = false;
                    txtQuantity.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtFromBranchCode.Enabled = false;
                    ddlToBranch.Enabled = false;
                    btnFromLocation.Enabled = false;
                    btnToLocation.Enabled = false;
                    btnLookUpFromLotCode.Enabled = false;
                    btnLookUpToLotCode.Enabled = false;
                    btnLookUpFromRakCode.Enabled = false;
                    btnLookUpToRakCode.Enabled = false;
                    btnLookUpToSlotCode.Enabled = false;
                    btnLookUpFromSlotCode.Enabled = false;


                }

                else
                {
                    lblID.Enabled = false;
                    txtRemarks.Enabled = true;
                    txtQuantity.Enabled = false;
                    txtFromBranchCode.Enabled = true;
                    ddlToBranch.Enabled = true;
                    btnFromLocation.Enabled = true;
                    btnToLocation.Enabled = true;
                    btnLookUpFromLotCode.Enabled = true;
                    btnLookUpToLotCode.Enabled = true;
                    btnLookUpFromRakCode.Enabled = true;
                    btnLookUpToRakCode.Enabled = true;
                    btnLookUpToSlotCode.Enabled = true;
                    btnLookUpFromSlotCode.Enabled = true;
                    txtFromBranchCode.Enabled = true;
                    ddlToBranch.Enabled = true;
                    btnFromLocation.Enabled = true;
                    btnToLocation.Enabled = true;
                    btnLookUpFromLotCode.Enabled = true;
                    btnLookUpToLotCode.Enabled = true;
                    btnLookUpFromRakCode.Enabled = true;
                    btnLookUpToRakCode.Enabled = true;
                    btnLookUpToSlotCode.Enabled = true;
                    btnLookUpFromSlotCode.Enabled = true;
                    btnSave.Visible = true;


                }

            }
            else
            {
                GetCode();
            }
        }
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
            DataRow _dr = _dal.GetRow("INVENTORY_MUTATION_HEADER", _ht);

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
                lblID.Text = inextid.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventorymutationheader.aspx?action=edit&codebarcode={0}",lblCodeBarcode.Text));
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
        Response.Redirect("inventorymutationheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text + "&idartarget=" + Request.Params["idtarget"]);
    }
}