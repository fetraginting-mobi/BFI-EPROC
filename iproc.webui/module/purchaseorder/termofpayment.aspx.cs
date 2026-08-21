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
    private static string TABLE_NAME_DETAIL = "TERM_OF_PAYMENT_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {


        LoadInit();
        if (!Page.IsPostBack)
        {
            lblCodeBarcode.Text = Request.Params["code"];
            txtCodeBarcode.Text = Request.Params["codebarcode"];

            string action = Request.Params["action"] != null ? Request.Params["action"].ToLower() : "";

            Shared.BindGeneralSubCode(ddlTRX, "TRX");
            var existingTrx = GetUsedTrxCodes(txtCodeBarcode.Text);
            string existingType = GetExistingTerminType(txtCodeBarcode.Text);

            if (action == "add")
            {
                var filteredItems = new System.Collections.Generic.List<ListItem>();
                foreach (ListItem item in ddlTRX.Items)
                {
                    if (!existingTrx.Contains(item.Value) && item.Value != "0")
                    {
                        filteredItems.Add(new ListItem(item.Text, item.Value));
                    }
                }

                filteredItems.Sort(delegate (ListItem x, ListItem y)
                {
                    return GetNumberFromText(x.Text).CompareTo(GetNumberFromText(y.Text));
                });

                ddlTRX.Items.Clear();
                foreach (var item in filteredItems)
                {
                    ddlTRX.Items.Add(item);
                }
                if (filteredItems.Count > 0)
                {
                    ddlTRX.SelectedIndex = 0;
                }
                if (!string.IsNullOrEmpty(existingType))
                {
                    ddlTerminType.SelectedValue = existingType;
                    ddlTerminType.Enabled = false;
                    ApplyTerminTypeUI();
                }
            }
            if (action == "edit")
            {
                LoadData();
                lblID.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnSave.Visible = true;
                btnSaveItemList.Enabled = true;
                btnLookUpItem.Enabled = true;
                txtCodeBarcode.Enabled = false;
                ddlTerminType.Enabled = false;
                ddlTRX.Enabled = false;
                txtReferenceNo.Enabled = false;
                txtPercentage.Enabled = false;
                txtAmount.Enabled = false;
                txtTotalAmount.Enabled = false;
                txtRemarks.Enabled = false;

                ApplyTerminTypeUI();
                if (IsAmountTermin())
                {
                    LoadItemList();
                }
            }

            if (action != "edit")
            {
                string refreshID = btnRefreshAmount.UniqueID;
                string baseUrl = String.Format("../../lookup/subscription.aspx?code=POTERMIT&par_code_barcode={0}&gvw={1}&par_po_barcode={2}",
                                 txtCodeBarcode.Text, refreshID, txtCodeBarcode.Text);

                btnLookUpItem.Attributes["onclick"] = String.Format(
                    "var eTermin = document.getElementById('{0}'); " +
                    "var terminVal = eTermin.options[eTermin.selectedIndex].value; " +
                    "if(terminVal !== 'AMT') {{ alert('LookUp hanya tersedia untuk tipe Amount (AMT)'); return false; }} " +
                    "var eTrx = document.getElementById('{1}'); " +
                    "var trx = eTrx.options[eTrx.selectedIndex].value; " +
                    "if(trx == '0') {{ alert('Pilih Trx Code terlebih dahulu!'); return false; }} " +
                    "fnShowDialog('{2}&par_trx_code=' + trx); return false;",
                    ddlTerminType.ClientID, ddlTRX.ClientID, baseUrl);

                btnLookUpItem.Enabled = true;
            }

            TotalAmount();
            if (lblStatus.Text == "POST" || lblStatus.Text == "CLOSED")
            {
                btnSave.Visible = false;
                ddlTRX.Enabled = false;
                txtPercentage.Enabled = false;
                txtReferenceNo.Enabled = false;
            }

            ApplyTerminTypeUI();
        }
        LoadAfterInit();


        //    Shared.BindGeneralSubCode(ddlTRX, "TRX");
        //    var existingTrx = GetUsedTrxCodes(txtCodeBarcode.Text);
        //    var filteredItems = new System.Collections.Generic.List<ListItem>();
        //    foreach (ListItem item in ddlTRX.Items)
        //    {
        //        if (!existingTrx.Contains(item.Value) && item.Value != "0")
        //        {
        //            filteredItems.Add(new ListItem(item.Text, item.Value));
        //        }
        //    }

        //    filteredItems.Sort(delegate(ListItem x, ListItem y)
        //    {
        //        int xNum = GetNumberFromText(x.Text);
        //        int yNum = GetNumberFromText(y.Text);
        //        return xNum.CompareTo(yNum);
        //    });

        //    ddlTRX.Items.Clear();
        //    foreach (var item in filteredItems)
        //    {
        //        ddlTRX.Items.Add(item);
        //    }

        //    if (filteredItems.Count > 0)
        //    {
        //        // Karena sudah di-sort, filteredItems[0] adalah termin urutan berikutnya
        //        ddlTRX.SelectedValue = filteredItems[0].Value;
        //    }




        //    //Shared.BindUnit(ddlUnit);
        //    btnLookUpItem.Enabled = false;            
        //    string existingType = GetExistingTerminType(txtCodeBarcode.Text);
        //    TotalAmount();

        //    string refreshID = btnRefreshAmount.UniqueID;
        //    string baseUrl = String.Format("../../lookup/subscription.aspx?code=POTERMIT&par_code_barcode={0}&gvw={1}&par_po_barcode={2}", txtCodeBarcode.Text, refreshID, txtCodeBarcode.Text);
        //    //btnLookUpItem.Attributes["onclick"] = String.Format("var e = document.getElementById('{0}'); " + "var trx = e.options[e.selectedIndex].value; " + "fnShowDialog('{1}&par_trx_code=' + trx); return false;",ddlTRX.ClientID, baseUrl);
        //    btnLookUpItem.Attributes["onclick"] = String.Format( "var eTermin = document.getElementById('{0}'); " + "var terminVal = eTermin.options[eTermin.selectedIndex].value; " + 
        //            "if(terminVal !== 'AMT') {{ " + "   alert('LookUp hanya tersedia untuk tipe Amount (AMT)'); " + "   return false; " +"}} " +
        //                "var eTrx = document.getElementById('{1}'); " + "var trx = eTrx.options[eTrx.selectedIndex].value; " + "if(trx == '0') {{ alert('Pilih Trx Code terlebih dahulu!'); return false; }} " +
        //                "fnShowDialog('{2}&par_trx_code=' + trx); return false;", ddlTerminType.ClientID, ddlTRX.ClientID, baseUrl);
        //    btnLookUpItem.Enabled = true;

        //    if (Request.Params["action"].Equals("add"))
        //    {
        //        ddlTRX.Items.Clear();
        //        foreach (ListItem item in filteredItems)
        //        {
        //            ddlTRX.Items.Add(item);
        //        }
        //        if (!string.IsNullOrEmpty(existingType))
        //        {
        //            ddlTerminType.SelectedValue = existingType;
        //            ddlTerminType.Enabled = false; 
        //            // Jalankan logika UI untuk mengaktifkan Percentage/Amount box
        //            ToggleAmountPercentageFields(existingType);
        //        }
        //    }

        //    if (Request.Params["action"].Equals("edit"))
        //    {
        //        LoadData();
        //        lblID.Enabled = false;
        //        btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
        //        btnCancel.CssClass = "btn btn-custome";
        //        btnSave.Enabled = false;
        //        lblCodeBarcode.Enabled = false;
        //        txtCodeBarcode.Enabled = false;
        //        ddlTerminType.Enabled = false;
        //        ddlTRX.Enabled = false;
        //        txtReferenceNo.Enabled = false;
        //        txtPercentage.Enabled = false;
        //        txtAmount.Enabled = false;
        //        txtTotalAmount.Enabled = false;
        //        txtRemarks.Enabled = false;
        //        btnSave.Visible = false; //nirmala(13-12-2019) no ticket : 1912000132
        //        btnLookUpItem.Enabled = false;

        //        btnSaveItemList.Enabled = false;
        //        ToggleAmountPercentageFields(existingType);
        //        LoadItemList();

        //    }
        //    if (lblStatus.Text == "POST" || lblStatus.Text == "CLOSED")
        //    {
        //        btnSave.Visible = false;
        //        ddlTRX.Enabled = false;
        //        txtPercentage.Enabled = false;
        //        //txtReceiveDate.Enabled = false;
        //        txtReferenceNo.Enabled = false;
        //    }

        //   if (ddlTerminType.SelectedValue == "PCT")
        //    {
        //        txtAmount.Enabled = false;
        //        txtPercentage.Enabled = true;
        //    }
        //    if (ddlTerminType.SelectedValue == "AMT")
        //    {
        //        txtAmount.Enabled = true;
        //        txtPercentage.Enabled = false;
        //    }

        //}
        //LoadAfterInit();
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
        ApplyTerminTypeUI();
        if (IsAmountTermin())
        {
            LoadItemList();
        }
        upd.Update();
        updItemListContainer.Update();
    }

    private int GetNumberFromText(string input)
    {
        if (string.IsNullOrEmpty(input)) return 0;
        System.Text.RegularExpressions.Match match = System.Text.RegularExpressions.Regex.Match(input, @"\d+");

        if (match.Success)
        {
            int result;
            if (int.TryParse(match.Value, out result))
            {
                return result;
            }
        }
        return 0;
    }
    protected void btnRefreshAmount_Click(object sender, EventArgs e)
    {
        try
        {
            txtAmount.Text = "0.00";
            LoadItemList();
            upd.Update();
            updItemList.Update();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private bool IsAmountTermin()
    {
        return ddlTerminType.SelectedValue == "AMT";
    }

    private void ApplyTerminTypeUI()
    {
        string action = Request.Params["action"] != null ? Request.Params["action"].ToLower() : "";
        bool isEdit = action == "edit";
        bool isAmount = IsAmountTermin();
        bool isPercentage = ddlTerminType.SelectedValue == "PCT";

        txtAmount.Enabled = isAmount && !isEdit;
        txtPercentage.Enabled = isPercentage && !isEdit;
        pnlItemLookup.Visible = isAmount;
        btnLookUpItem.Enabled = isAmount && !isEdit;
        pnlItemList.Visible = isAmount;
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

    private void LoadItemList()
    {
        GeneralDAL _dal = new GeneralDAL();
        Hashtable _ht = new Hashtable();
        _ht["p_code_barcode"] = txtCodeBarcode.Text;
        _ht["p_trx_code"] = ddlTRX.SelectedValue;

        try
        {
            DataTable dt = _dal.GetRows("term_of_payment_item", _ht);
            gvwList.DataSource = dt;
            gvwList.DataBind();
            pnlItemList.Visible = IsAmountTermin();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }
    protected void btnSaveItemList_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = new GeneralDAL();
        decimal totalKeseluruhan = 0;

        if (Request.QueryString["action"] == "edit")
        {
            return;
        }
        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    string idItem = gvwList.DataKeys[row.RowIndex].Value.ToString();
                    TextBox txtAmountItem = (TextBox)row.FindControl("txtTerminAmount");

                    if (txtAmountItem != null)
                    {
                        decimal nilaiInput = 0;
                        if (!string.IsNullOrEmpty(txtAmountItem.Text))
                        {
                            nilaiInput = decimal.Parse(txtAmountItem.Text);
                        }
                        totalKeseluruhan += nilaiInput;

                        Hashtable _ht = new Hashtable();
                        _ht["p_id"] = idItem;
                        _ht["p_total_amount_termin"] = nilaiInput;
                        _dal.Update("TERM_OF_PAYMENT_DETAIL", "xsp_term_of_payment_detail_update", _ht);
                    }
                }
            }
            txtAmount.Text = totalKeseluruhan.ToString("N2");
            LoadItemList();
            upd.Update();
            updItemList.Update();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }
    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkAll = (CheckBox)sender;
        foreach (GridViewRow row in gvwList.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (CheckBox)row.FindControl("chbChecked");
                if (chkRow != null)
                {
                    chkRow.Checked = chkAll.Checked;
                }
            }
        }
        updItemList.Update();
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string action = Request.QueryString["action"];

            if (action == "edit")
            {
                TextBox txtTermin = (TextBox)e.Row.FindControl("txtTerminAmount");
                if (txtTermin != null)
                {
                    txtTermin.ReadOnly = true;

                }
                CheckBox chk = (CheckBox)e.Row.FindControl("chbChecked");
                if (chk != null) chk.Enabled = false;
            }
        }
    }
    protected void btnDeleteItemList_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataItemList(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }
        LoadItemList();
    }
    private void DeleteDataItemList(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;
            _ht["p_po_barcode"] = Request.Params["codebarcode"];

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
}
