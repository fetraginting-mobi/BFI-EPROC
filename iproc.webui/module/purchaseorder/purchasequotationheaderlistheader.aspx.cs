using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_purchaseorder_purchasequotationheaderlistheader : BasePage
{
   
    private static string TABLE_NAME_DETAIL = "PURCHASE_QUOTATION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                //btnPostAuthority.Visible = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                


                BindQuotationDetail();

            }
        }
    }

   private void BindQuotationDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            _ht["p_id_list"] = Request.Params["idlist"];
            

            gvwList.DataSource = _dal.GetRows("","xsp_purchase_quotation_detail_list_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
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
            BindQuotationDetail();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindQuotationDetail();
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
           btnLookUp.Enabled = false;
       }
       
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        //Response.Redirect("purchasequotationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchasequotationheader.aspx?action=edit&codebarcode=" + Request.Params["codebarcode"]);
    }
    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {
        SaveDataDetail();
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindQuotationDetail();

    }

    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
       
        BindQuotationDetail();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("purchasequotationdetail.aspx?action=edit&id={0}&codebarcode={1}&idlist={2}", gvwList.SelectedDataKey[5].ToString(), Request.Params["codebarcode"], Request.Params["idlist"]));
    }
 
   
}      
  

