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
            Shared.BindGeneralSubCode(ddlTRX, "TRX");
            var items = new System.Collections.Generic.List<System.Web.UI.WebControls.ListItem>();
            foreach (System.Web.UI.WebControls.ListItem item in ddlTRX.Items)
            {
                items.Add(item);
            }

            items.Sort(delegate(ListItem x, ListItem y)
            {
                int xNum = GetNumberFromText(x.Text);
                int yNum = GetNumberFromText(y.Text);

                return xNum.CompareTo(yNum);
            });

            ddlTRX.Items.Clear();
            foreach (ListItem sortedItem in items)
            {
                ddlTRX.Items.Add(sortedItem);
            }

            //Shared.BindUnit(ddlUnit);
            btnLookUpItem.Enabled = false;
            lblCodeBarcode.Text = Request.Params["code"];
            txtCodeBarcode.Text = Request.Params["codebarcode"];
            TotalAmount();

            string refreshID = btnRefreshAmount.UniqueID;
            string baseUrl = String.Format("../../lookup/subscription.aspx?code=POTERMIT&par_code_barcode={0}&gvw={1}&par_po_barcode={2}", txtCodeBarcode.Text, refreshID, txtCodeBarcode.Text);
            btnLookUpItem.Attributes["onclick"] = String.Format("var e = document.getElementById('{0}'); " + "var trx = e.options[e.selectedIndex].value; " + "fnShowDialog('{1}&par_trx_code=' + trx); return false;",ddlTRX.ClientID, baseUrl);
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
        //Response.Redirect("purchaseorderheader.aspx?action=edit&codebarcode=" + txtCodeBarcode.Text + "&code=" + lblBarcode.Text);

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

    //protected void txtAmount_TextChanged(object sender, EventArgs e)
    //{
    //    decimal pct = 0;
         
    //    pct = Decimal.Parse(txtAmount.Text.Replace(".00", "")) / Decimal.Parse(txtTotalAmount.Text.Replace(".00", "")) * 100;
    //    txtPercentage.Text = pct.ToString();
    //   // txtPercentage.Enabled = false;
    //}

    //protected void txtPersen_TextChanged(object sender, EventArgs e)
    //{
    //    decimal amount  = 0;
        
    //    amount = Decimal.Parse(txtPercentage.Text.Replace(".00", "")) / 100 * Decimal.Parse(txtTotalAmount.Text.Replace(".00", "")) ;
    //    txtAmount.Text = amount.ToString();
    //   // txtAmount.Enabled = false;
    //}

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
}
