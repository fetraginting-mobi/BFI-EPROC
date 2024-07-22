using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_supplierselectiondetail : BasePage
{
    private static string TABLE_NAME = "SUPPLIER_SELECTION_DETAIL";
    private static string TABLE_NAME_HEADER = "SUPPLIER_SELECTION_HEADER";


    protected void Page_Load(object sender, EventArgs e)
    {
        btnLookUpItemCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PQITM&acol_0={0}&bcol_1={1}&parc_code={2}');", txtItemCode.ClientID, lblItemName.ClientID, txtPQCode.ClientID);
        btnLookUpSupplierID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PQSUP&acol_0={0}&bcol_1={1}&parc_code={2}&parc_item_code={3}&ccol_3={4}&dcol_3={5}&ecol_4={6}&fcol_4={7}&gcol_5={8}&hcol_6={9}&icol_6={10}');", txtSupplierID.ClientID, lblSupplierName.ClientID, txtPQCode.ClientID, txtItemCode.ClientID, lblQuantity.ClientID, txtQuantity.ClientID, lblAmount.ClientID, txtAmount.ClientID, txtID.ClientID, lblRemainingQuantity.ClientID, txtRemainingQuantity.ClientID);
        LoadInit();

        if (!Page.IsPostBack)
        {
            txtPQCode.Text = Request.Params["pqcode"];
            lblBarcode.Text = Request.Params["codebarcode"];
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
             //   gwwlis.Columns[1].Visible = false;

                if (!lblPQStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    txtAmount.Enabled = false;
                    txtItemCode.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpItemCode.Enabled = false;
                    btnLookUpSupplierID.Enabled = false;
                    txtQuantityOri.Enabled = false;
                    txtAmountOri.Enabled = false;
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

            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            lblSSCode.Text = _dr["code"].ToString();
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

            _ht["p_selection_code"] = Request.Params["codebarcode"];
            _ht["p_item_code"] = Request.Params["itemcode"];
            _ht["p_supplier_code"] = Request.Params["suppliercode"];

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
        string sNextBarcode = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_selection_code"] = Request.Params["codebarcode"];
            _ht["p_item_code"] = txtItemCode.Text;
            _ht["p_supplier_code"] = txtSupplierID.Text;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextBarcode);
                lblBarcode.Text = sNextBarcode;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("supplierselectiondetail.aspx?action=edit&codebarcode={0}&pqcode={1}&itemcode={2}&suppliercode={3}", lblBarcode.Text, lblPQCode.Text, txtItemCode.Text, txtSupplierID.Text));
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
        Response.Redirect("supplierselectionheader.aspx?action=edit&codebarcode=" + lblBarcode.Text);
    }
}

