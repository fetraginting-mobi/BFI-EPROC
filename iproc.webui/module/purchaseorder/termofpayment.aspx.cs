using System;
using System.IO;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_termofpayment : BasePage
{
    private static string TABLE_NAME = "TERM_OF_PAYMENT";

    protected void Page_Load(object sender, EventArgs e)
    {

        
        LoadInit();
        if (!Page.IsPostBack)
        {
            lblCodeBarcode.Text = Request.Params["code"];
            txtCodeBarcode.Text = Request.Params["codebarcode"];

            Shared.BindGeneralSubCode(ddlTRX, "TRX");
            var existingTrx = GetUsedTrxCodes(txtCodeBarcode.Text);
            var filteredItems = new System.Collections.Generic.List<ListItem>();
            foreach (ListItem item in ddlTRX.Items)
            {
                if (!existingTrx.Contains(item.Value))
                {
                    filteredItems.Add(item);
                }
            }

            filteredItems.Sort(delegate(ListItem x, ListItem y)
            {
                int xNum = GetNumberFromText(x.Text);
                int yNum = GetNumberFromText(y.Text);
                return xNum.CompareTo(yNum);
            });

            //Shared.BindUnit(ddlUnit);
            btnLookUpItem.Enabled = false;            
            string existingType = GetExistingTerminType(txtCodeBarcode.Text);
            TotalAmount();

            string refreshID = btnRefreshAmount.UniqueID;
            string baseUrl = String.Format("../../lookup/subscription.aspx?code=POTERMIT&par_code_barcode={0}&gvw={1}&par_po_barcode={2}", txtCodeBarcode.Text, refreshID, txtCodeBarcode.Text);
            //btnLookUpItem.Attributes["onclick"] = String.Format("var e = document.getElementById('{0}'); " + "var trx = e.options[e.selectedIndex].value; " + "fnShowDialog('{1}&par_trx_code=' + trx); return false;",ddlTRX.ClientID, baseUrl);
            btnLookUpItem.Attributes["onclick"] = String.Format( "var eTermin = document.getElementById('{0}'); " + "var terminVal = eTermin.options[eTermin.selectedIndex].value; " + 
                    "if(terminVal !== 'AMT') {{ " + "   alert('LookUp hanya tersedia untuk tipe Amount (AMT)'); " + "   return false; " +"}} " +
                        "var eTrx = document.getElementById('{1}'); " + "var trx = eTrx.options[eTrx.selectedIndex].value; " + "if(trx == '0') {{ alert('Pilih Trx Code terlebih dahulu!'); return false; }} " +
                        "fnShowDialog('{2}&par_trx_code=' + trx); return false;", ddlTerminType.ClientID, ddlTRX.ClientID, baseUrl);
            btnLookUpItem.Enabled = true;

            if (Request.Params["action"].Equals("add"))
            {
                ddlTRX.Items.Clear();
                ddlTRX.Items.Add(new ListItem("-=Select=-", "0"));
                foreach (ListItem item in filteredItems)
                {
                    ddlTRX.Items.Add(item);
                }
                if (!string.IsNullOrEmpty(existingType))
                {
                    ddlTerminType.SelectedValue = existingType;
                    ddlTerminType.Enabled = false; 
                    // Jalankan logika UI untuk mengaktifkan Percentage/Amount box
                    ToggleAmountPercentageFields(existingType);
                }
            }

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnSave.Enabled = false;
                lblCodeBarcode.Enabled = false;
                txtCodeBarcode.Enabled = false;
                ddlTerminType.Enabled = false;
                ddlTRX.Enabled = false;
                txtReferenceNo.Enabled = false;
                txtPercentage.Enabled = false;
                txtAmount.Enabled = false;
                txtTotalAmount.Enabled = false;
                txtRemarks.Enabled = false;
                btnSave.Visible = false; //nirmala(13-12-2019) no ticket : 1912000132
                ToggleAmountPercentageFields(existingType);
                
            }
            if (lblStatus.Text == "POST" || lblStatus.Text == "CLOSED")
            {
                btnSave.Visible = false;
                ddlTRX.Enabled = false;
                txtPercentage.Enabled = false;
                //txtReceiveDate.Enabled = false;
                txtReferenceNo.Enabled = false;
            }
            
           if (ddlTerminType.SelectedValue == "PCT")
            {
                txtAmount.Enabled = false;
                txtPercentage.Enabled = true;
            }
            if (ddlTerminType.SelectedValue == "AMT")
            {
                txtAmount.Enabled = true;
                txtPercentage.Enabled = false;
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

            _ht["p_id"] = Request.Params["id"];
            _ht["p_code_barcode"] = Request.Params["codebarcode"];


            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);


            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void TotalAmount()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];


            DataRow _dr = _dal.GetRow(TABLE_NAME, "xsp_term_of_payment_getrow_total_amount", _ht);


            txtTotalAmount.Text = _dr["Total_Amount"].ToString();
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

            //_ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}&code={1}", txtCodeBarcode.Text, lblBarcode.Text));
            Response.Redirect("purchaseorderheader.aspx?action=edit&codebarcode=" + txtCodeBarcode.Text + "&code=" + lblBarcode.Text);
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
        int idTarget = 0;
        String Type_app = "";

        Type_app = Request.Params["type"];

        if (Type_app == "approval")
        {
            idTarget = Int32.Parse(Request.Params["idtarget"]);

        }
        else
        {
            idTarget = 0;
        }

        if (Type_app == "approval")
        {

            //Shared.ShowSuccessGritter(this, string.Format("../purchaseorder/purchaseorderheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", Request.Params["codebarcode"], idTarget));
            Response.Redirect("../purchaseorder/purchaseorderheader.aspx?action=edit&type=approval&codebarcode=" + Request.Params["codebarcode"] + "&idartarget=" + idTarget);
        }
        else
        {
            Response.Redirect("purchaseorderheader.aspx?action=edit&codebarcode=" + txtCodeBarcode.Text + "&code=" + lblBarcode.Text);
        }
    }

    protected void ddlTerminType_SelectedIndex(object sender, EventArgs e)
    {

        if (ddlTerminType.SelectedValue == "PCT")
        {
            txtAmount.Enabled = false;
            txtPercentage.Enabled = true;
            btnLookUpItem.Enabled = false;
        }
        if (ddlTerminType.SelectedValue == "AMT")
        {
            txtAmount.Enabled = true;
            txtPercentage.Enabled = false;
            btnLookUpItem.Enabled = true;
        }
    }

    private int GetNumberFromText(string input)
    {
        // Menggunakan Regex untuk mencari angka pertama yang muncul
        System.Text.RegularExpressions.Match match = System.Text.RegularExpressions.Regex.Match(input, @"\d+");
        if (match.Success)
        {
            return int.Parse(match.Value);
        }
        return 0;
    }

    protected void btnLookUpItem_Click(object sender, EventArgs e)
    {

    }
    protected void btnRefreshAmount_Click(object sender, EventArgs e)
    {
        try
        {
            GeneralDAL _dal = new GeneralDAL();
            Hashtable _ht = new Hashtable();
            _ht["p_code_barcode"] = txtCodeBarcode.Text;
            _ht["p_trx_code"] = ddlTRX.SelectedValue;

            DataTable dt = _dal.GetRows("", "xsp_total_po_termin_item_getrows", _ht);

            decimal total = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    total += Convert.ToDecimal(dr["total_amount"]);
                }
            }
            txtAmount.Text = total.ToString("N2");
            TotalAmount();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void ToggleAmountPercentageFields(string type)
    {
        if (type == "PCT")
        {
            txtAmount.Enabled = false;
            txtPercentage.Enabled = true;
        }
        else if (type == "AMT")
        {
            txtAmount.Enabled = true;
            txtPercentage.Enabled = false;
        }
    }
    private string GetExistingTerminType(string codeBarcode)
    {
        GeneralDAL _dal = new GeneralDAL();
        Hashtable _ht = new Hashtable();

        _ht["p_code_barcode"] = Request.Params["codebarcode"];

        try
        {
            DataRow dr = _dal.GetRow("po_termin_check_type", _ht);
            if (dr != null && dr["termin_type"] != DBNull.Value)
            {
                return dr["termin_type"].ToString();
            }

        }
        catch (IndexOutOfRangeException)
        {
            return string.Empty;
        }
        catch (Exception ex)
        {
            return string.Empty;
        }
        return string.Empty;            
    }

    private System.Collections.Generic.List<string> GetUsedTrxCodes(string codeBarcode)
    {
        System.Collections.Generic.List<string> usedCodes = new System.Collections.Generic.List<string>();
        Hashtable _ht = new Hashtable();
        _ht["p_code_barcode"] = codeBarcode;

        try
        {
            DataTable dt = new GeneralDAL().GetRows("po_termin_check_type", _ht);
            foreach (DataRow dr in dt.Rows)
            {
                usedCodes.Add(dr["TRX_CODE"].ToString());
            }
        }
        catch (Exception ex)
        {
        }

        return usedCodes;
    }
}
