using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryreceiptdetail : BasePage
{
    private static string TABLE_NAME = "INVENTORY_RECEIPT_DETAIL";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            btnLookUpInventoryReceiptItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=IRCIT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtItemCode.ClientID, lblItemCode.ClientID, lblItemName.ClientID);
            lblBarcode.Text = Request.Params["codebarcode"];

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                btnCancel.Text = "Back";

                if (!lblIRCStatus.Text.Equals("NEW"))
                    btnSave.Visible = false;
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
            DataRow _dr = _dal.GetRow("INVENTORY_RECEIPT_HEADER", _ht);

            lblIRCCode.Text = _dr["code"].ToString();
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
        int iNextID = 0;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblId.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventoryreceiptdetail.aspx?action=edit&id={0}&codebarcode={1}", lblId.Text, lblBarcode.Text));
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
        Response.Redirect("inventoryreceiptheader.aspx?action=edit&codebarcode=" + lblBarcode.Text);
    }
}