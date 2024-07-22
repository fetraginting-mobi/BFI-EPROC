using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_supplierselectiondetaillist : BasePage
{

    private static string TABLE_NAME_DETAIL = "SUPPLIER_SELECTION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
          
            if (Request.Params["action"].Equals("edit"))
            {
                //btnPostAuthority.Visible = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                gvwList.Columns[9].Visible = false;
                gvwList.Columns[10].Visible = false;
                gvwList.Columns[1].Visible = false;


                BindSSDetail();

            }
        }
    }

    private void BindSSDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            _ht["p_item_code"] = Request.Params["itemcode"];


            gvwList.DataSource = _dal.GetRows("","xsp_supplier_selection_list_detail_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void BindSupplierAmount(GridViewRow grdrDropDownRow)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataRow _dr = null;
        try
        {


            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //DropDownList ddlSupplier = (grdrDropDownRow.FindControl("ddlSupplier") as DropDownList);

            _ht["p_item_code"] = gvwList.DataKeys[grdrDropDownRow.RowIndex][1].ToString();
            _ht["p_code_barcode"] = gvwList.DataKeys[grdrDropDownRow.RowIndex][3].ToString();
            _ht["p_supplier_code"] = ((DropDownList)grdrDropDownRow.FindControl("ddlSupplier")).SelectedValue;
            _ht["p_branch_code"] = gvwList.DataKeys[grdrDropDownRow.RowIndex][4].ToString();

            _dr = _dal.GetRow("", "xsp_supplier_selection_detail_list_getrow", _ht);

            TextBox txtAmount = (TextBox)grdrDropDownRow.FindControl("txtAmount");
            TextBox txtTotalAmount = (TextBox)grdrDropDownRow.FindControl("txtTotalAmount");
            TextBox txtRating = (TextBox)grdrDropDownRow.FindControl("txtRating");
            if (txtAmount != null)
            {
                txtAmount.Text = _dr["amount"].ToString();
                txtTotalAmount.Text = _dr["total_amount"].ToString();
                txtRating.Text = _dr["rating"].ToString();
            }
         




        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void SaveDataDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    string txtSupplierCode = ((TextBox)row.Cells[1].Controls[1]).Text;
                    string txtQuantity = ((TextBox)row.Cells[4].Controls[1]).Text;
                    DropDownList ddlCurrencyCode = ((DropDownList)row.Cells[5].Controls[1]);
                    string txtUnitPrice = ((TextBox)row.Cells[6].Controls[1]).Text;


                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_pq_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_pr_code"] = gvwList.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_currency_code"] = ddlCurrencyCode.SelectedValue;
                    _ht["p_payment_methode_code"] = "DEBIT";
                    _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][3].ToString();
                    _ht["p_supplier_code"] = txtSupplierCode;
                    _ht["p_warranty_month"] = 0;
                    _ht["p_tax_code"] = "TS00001";
                    _ht["p_warranty_part_month"] = 0;
                    _ht["p_quantity"] = txtQuantity;
                    _ht["p_approval_po_quantity"] = 0;
                    _ht["p_unit_code"] = gvwList.DataKeys[row.RowIndex][4].ToString();
                    _ht["p_unit_price"] = txtUnitPrice;
                    _ht["p_remarks"] = "-";

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_purchase_quotation_detail_update", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("purchasequotationheader.aspx?action=edit&codebarcode={0}", Request.Params["codebarcode"]));
            BindSSDetail();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindSSDetail();
    }

    protected void gvwList_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            GeneralDAL _dal = null;
            Hashtable _ht = null;
            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();

                DropDownList ddlSupplier = (e.Row.FindControl("ddlSupplier") as DropDownList);
                TextBox txtAmount = (e.Row.FindControl("txtAmount") as TextBox);
                TextBox txtTotalAmount = (e.Row.FindControl("txtTotalAmount") as TextBox);
                TextBox txtRating = (e.Row.FindControl("txtRating") as TextBox);

                GridViewRow grdrDropDownRow = ((GridViewRow)ddlSupplier.Parent.Parent);

                _ht["p_selection_code"] = Request.Params["codebarcode"];
                _ht["p_item_code"] = gvwList.DataKeys[e.Row.RowIndex][1].ToString();
                _ht["p_pq_code"] =  gvwList.DataKeys[e.Row.RowIndex][3].ToString();


                Shared.BindSupplierSelection(ddlSupplier, Request.Params["codebarcode"], gvwList.DataKeys[e.Row.RowIndex][3].ToString(), gvwList.DataKeys[e.Row.RowIndex][1].ToString());
                BindSupplierAmount(grdrDropDownRow);



                DataRow _dr = _dal.GetRow("", "xsp_supplier_selection_detail_getrow_for_supplier", _ht);
               
                ddlSupplier.SelectedValue = _dr["SUPPLIER_CODE"].ToString();
                BindSupplierAmount(grdrDropDownRow);
                //LinkButton btn2 = e.Row.FindControl("btnItemHistory") as LinkButton;
                //btn2.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/itemhistory.aspx?action=edit&suppliercode={0}&itemcode={1}&branch={2}');", Request.Params["suppliercode"], gvwList.DataKeys[e.Row.RowIndex][1].ToString(), Request.Params["branchcode"]);
                //LinkButton btn = e.Row.FindControl("btnSupplierHistory") as LinkButton;
                //btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/supplierhistory.aspx?action=edit&suppliercode={0}&codebarcode={1}&branch={2}');", gvwList.DataKeys[e.Row.RowIndex][2].ToString(), Request.Params["codebarcode"], Request.Params["branchcode"]);
                LinkButton btn1 = e.Row.FindControl("btnViewDocument") as LinkButton;
                btn1.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/documentreviewss.aspx?action=edit&codebarcode={0}&itemcode={1}');", gvwList.DataKeys[e.Row.RowIndex][0].ToString(), gvwList.DataKeys[e.Row.RowIndex][1].ToString());




            }
            catch (Exception ex)
            {

            }
        }
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtSupplierCode = (TextBox)e.Row.FindControl("txtSupplierCode");
            Label lblSupplierName = (Label)e.Row.FindControl("lblSupplierName");
            TextBox txtQuantity = (TextBox)e.Row.FindControl("txtQuantity");
            DropDownList ddlCurrencyCode = (DropDownList)e.Row.FindControl("ddlCurrencyCode");
            TextBox txtUnitPrice = (TextBox)e.Row.FindControl("txtUnitPrice");

            Shared.BindCurrencyCode(ddlCurrencyCode);
            ddlCurrencyCode.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CURRENCY_CODE"));
            txtSupplierCode.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SUPPLIER_CODE"));
            lblSupplierName.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SUPPLIER_NAME"));
            txtQuantity.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QUANTITY"));
            txtUnitPrice.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UNIT_PRICE"));

            LinkButton btnLookUp = (LinkButton)e.Row.FindControl("btnLookUpSupplierID");
            btnLookUp.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtSupplierCode.ClientID, lblSupplierName.ClientID);
            //    if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ON-PROGRESS")
            //    {
            //        //btnLookUp.Enabled = false;
            //        txtQuantity.Enabled = false;
            //        ddlCurrencyCode.Enabled = false;
            //        txtUnitPrice.Enabled = false;
            //    }
        }

    }

    protected void ddlSupplier_SelectedIndexChanged(object sender, EventArgs e)
    {
        //
        DropDownList ddlSupplier = (DropDownList)sender;
        GridViewRow grdrDropDownRow = ((GridViewRow)ddlSupplier.Parent.Parent);

        BindSupplierAmount(grdrDropDownRow);
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        //Response.Redirect("purchasequotationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("supplierselectionheader.aspx?action=edit&codebarcode=" + Request.Params["codebarcode"] + "&idartarget=" + Request.Params["idartarget"]);
    }
    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {
        SaveDataDetail();
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {

        BindSSDetail();

    }

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
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


    protected void btnSearch_Click(object sender, EventArgs e)
    {

        BindSSDetail();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("purchasequotationdetail.aspx?action=edit&id={0}&codebarcode={1}&idlist={2}", gvwList.SelectedDataKey[5].ToString(), Request.Params["codebarcode"], Request.Params["idlist"]));
    }


}
