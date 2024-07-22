using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_confirmation : BasePage
{
    private static string TABLE_NAME_HEADER = "PURCHASE_ORDER_HEADER";
    private static string TABLE_NAME_DETAIL = "PURCHASE_ORDER_DETAIL";
    private static string TABLE_NAME_DETAIL_2 = "TERM_OF_PAYMENT";
    private static string TABLE_NAME_DETAIL_FEE = "PURCHASE_ORDER_FEE";

    private decimal dSubTotal = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();


        if (!Page.IsPostBack)
        {
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);

            Shared.BindCurrencyCode(ddlCurrency);
            Shared.BindTaxScreme(ddlTaxType);
            btnLookUpSupplier.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtSupplierCode.ClientID, txtSupplier.ClientID);
            txtPPN.Enabled = false;
            txtPPH.Enabled = false;
            txtTotalAmount.Enabled = false;

            if (Request.Params["action"].Equals("edit"))
            {

                LoadData();

                lblCodeBarcode.Enabled = false;
                //txtConfirmationDate.Enabled = false;
                BindOrderDetail();
                BindTOP();
                BindFee();
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (txtSupplierCode.Text == "SP9999")
                {
                    btnLookUpSupplier.Enabled = true;
                }
                else
                {
                    btnLookUpSupplier.Enabled = false;
                }
                if (lblTransFlagDesc.Text == "POST" || lblTransFlagDesc.Text == "CANCEL" || lblTransFlagDesc.Text == "CLOSED" || lblTransFlagDesc.Text == "REJECTED")
                {
                    //btnSave.Visible = false;                   
                    txtDiscount.Enabled = false;
                    txtOrderDate.Enabled = false;
                    txtPPH.Enabled = false;
                    txtPPN.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    ddlTaxType.Enabled = false;
                    rblOrderType.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlCurrency.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlBranch.Enabled = false;
                    gvwListFee.Columns[1].Visible = false;

                    //List TOP
                    gvwListTOP.Columns[1].Visible = false;

                    //List Fee
                    gvwListFee.Columns[1].Visible = false;
                }
                else if (lblTransFlagDesc.Text == "ON-PROGRESS")
                {
                   // btnSave.Visible = false;
                    txtDiscount.Enabled = false;
                    txtOrderDate.Enabled = false;
                    txtPPH.Enabled = false;
                    txtPPN.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    ddlTaxType.Enabled = false;
                    rblOrderType.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlCurrency.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlBranch.Enabled = false;

                    gvwListFee.Columns[1].Visible = false;

                    //List TOP
                    gvwListTOP.Columns[1].Visible = false;

                    //List Fee
                    gvwListFee.Columns[1].Visible = false;
                }

                else
                {
                    if (lblFlagProcess.Text == "GNR")
                    {
                        gvwList.Columns[1].Visible = false;
                    }
                }

                if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                    txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

            }
            else
            {
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;

                pnlDetail.Visible = false;
                gvwList.Columns[1].Visible = true;
            }
        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/purchaseorderheaderlist.aspx";
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

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            DBToUI.Map(this.Controls, _dr);

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            _dal.Update("","xsp_purchase_order_header_update_for_confirmation", _ht);

            Shared.ShowSuccessGritter(this, string.Format("confirmation.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("confirmationlist.aspx");
    }

    #region purchase order detail

    private void BindOrderDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_code_barcode"] = lblCodeBarcode.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindOrderDetail();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindOrderDetail();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect(string.Format("purchaseorderdetail.aspx?action=edit&id={0}&codebarcode={1}&currency_code={2}&currency_desc={3}&status={4}&flagprocess={5}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, ddlCurrency.SelectedValue, ddlCurrency.SelectedItem, lblTransFlagDesc.Text, lblFlagProcess.Text));
    }

    protected void gvwList_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //dUnitPrice = dUnitPrice + decimal.Parse(e.Row.Cells[5].Text);
            dSubTotal = dSubTotal + decimal.Parse(e.Row.Cells[6].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            //e.Row.Cells[5].Text = dUnitPrice.ToString("N2");
            e.Row.Cells[6].Text = dSubTotal.ToString("N2");
        }
    }
    #endregion

    # region term of payment
    private void BindTOP()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchTOP.Text;
            //_ht["p_id"] = Request.Params["id"];
            _ht["p_code_barcode"] = lblCodeBarcode.Text;


            gvwListTOP.DataSource = _dal.GetRows(TABLE_NAME_DETAIL_2, _ht);
            gvwListTOP.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListTOP_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListTOP.PageIndex = e.NewPageIndex;
        BindTOP();
    }

    protected void btnSearchTOP_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindTOP();
    }

    protected void gvwListTOP_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect(string.Format("termofpayment.aspx?action=edit&id={0}&codebarcode={1}", gvwListTOP.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
    }

    # endregion

    #region Fee
    private void BindFee()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchFee.Text;
            _ht["p_po_code"] = lblCodeBarcode.Text;


            gvwListFee.DataSource = _dal.GetRows(TABLE_NAME_DETAIL_FEE, _ht);
            gvwListFee.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListFee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListFee.PageIndex = e.NewPageIndex;
        BindFee();
    }

    protected void gvwListFee_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtAmountFee = (TextBox)e.Row.FindControl("txtAmountFee");
            DropDownList ddlCurrencyCode = (DropDownList)e.Row.FindControl("ddlCurrencyCode");
            DropDownList ddlChargedTo = (DropDownList)e.Row.FindControl("ddlChargedTo");

            Shared.BindCurrency(ddlCurrencyCode);
            Shared.BindGeneralSubCode(ddlChargedTo, "CHGTO");
            txtAmountFee.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "AMOUNT_FEE"));
            ddlCurrencyCode.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CURRENCY_CODE"));
            ddlChargedTo.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CHARGED_TO"));
            ddlCurrencyCode.Enabled = false;
            if (lblTransFlagDesc.Text == "ON-PROGRESS" || lblTransFlagDesc.Text == "POST" || lblTransFlagDesc.Text == "CANCEL" || lblTransFlagDesc.Text == "CLOSED" || lblTransFlagDesc.Text == "REJECTED")
            {
                txtAmountFee.Enabled = false;
                ddlChargedTo.Enabled = false;
            }
        }
    }

    protected void btnSearchFee_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindFee();
    }

    private Boolean SelectedExistItem()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListFee.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
    #endregion

}