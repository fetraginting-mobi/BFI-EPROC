using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_purchaseorder_purchasequotationreviewheaderlistheader : BasePage
{

    //private static string TABLE_NAME_DETAIL = "PURCHASE_QUOTATION_REVIEW_DETAIL";

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

    #region detail
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
            _ht["p_item_code"] = Request.Params["itemcode"];


            gvwList.DataSource = _dal.GetRows("","xsp_purchase_quotation_review_detail_list_getrows" ,_ht);
            gvwList.DataBind();
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



    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindQuotationDetail();
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        TextBox txtSupplierCode = (TextBox)e.Row.FindControl("txtSupplierCode");
        //       // Label lblSupplierName = (Label)e.Row.FindControl("lblSupplierName");
        //        TextBox txtQuantity = (TextBox)e.Row.FindControl("txtQuantity");
        //        DropDownList ddlCurrencyCode = (DropDownList)e.Row.FindControl("ddlCurrencyCode");
        //        TextBox txtUnitPrice = (TextBox)e.Row.FindControl("txtUnitPrice");

        //        Shared.BindCurrencyCode(ddlCurrencyCode);
        //        ddlCurrencyCode.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CURRENCY_CODE"));
        //        //txtSupplierCode.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SUPPLIER_CODE"));
        //       //lblSupplierName.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SUPPLIER_NAME"));
        //        txtQuantity.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QUANTITY"));
        //        txtUnitPrice.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UNIT_PRICE"));

        //        //LinkButton btnLookUp = (LinkButton)e.Row.FindControl("btnLookUpSupplierID");
        //        //btnLookUp.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtSupplierCode.ClientID, lblSupplierName.ClientID);
        //        if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ON-PROGRESS")
        //        {
        //            //btnLookUp.Enabled = false;
        //            txtQuantity.Enabled = false;
        //            ddlCurrencyCode.Enabled = false;
        //            txtUnitPrice.Enabled = false;
        //        }
        //    }

    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchasequotationreviewdetail.aspx?action=add&codebarcode=" + Request.Params["codebarcode"]);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchasequotationreviewheader.aspx?action=edit&codebarcode=" + Request.Params["codebarcode"]);
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["codebarcode"] != string.Empty)
            BindQuotationDetail();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("purchasequotationreviewdetail.aspx?action=edit&id={0}&codebarcode={1}&itemcode={2}", gvwList.SelectedDataKey[5].ToString(), Request.Params["codebarcode"], Request.Params["itemcode"]));
    }
    #endregion
}
