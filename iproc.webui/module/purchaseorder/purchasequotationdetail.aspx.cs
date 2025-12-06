using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_purchaseorder_purchasequotationdetail : BasePage
{

    private static string TABLE_NAME = "PURCHASE_QUOTATION_DETAIL";
    //private static string TABLE_NAME_DOC_DETAIL = "PURCHASE_QUOTATION_DOCUMENT_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        btnLookUpPRCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LUPRC&acol_0={0}&bcol_1={1}&parc_user_id={2}');", txtPRBarcode.ClientID, lblPrCode.ClientID, txtPqCode.ClientID);
        btnLookUpSupplierID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSUPL&acol_0={0}&bcol_1={1}&parc_item_group={2}');", txtSupplierID.ClientID, lblSupplierName.ClientID, txtGroupCode.ClientID);
        btnLookUpItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PRITM&acol_0={0}&bcol_1={1}&parc_code={2}&ccol_2={3}&dcol_3={4}&parc_user_id={5}');", txtItemCode.ClientID, lblItemName.ClientID, txtPRBarcode.ClientID, txtOrderQuantity.ClientID, ddlUnitID.ClientID,txtPqCode.ClientID);
      

        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyCode(ddlCurrencyCode);
            Shared.BindTaxScreme(ddlTaxID);
            Shared.BindMasterUnit(ddlUnitID);
            txtGroupCode.Text = Request.Params["groupcode"];
            txtPqCode.Text = Request.Params["codebarcode"];
            //btnDele.OnClientClick = "return confirm('Delete selected data?');";
          
            lblBarcode.Text = Request.Params["codebarcode"];
            lblBarcode.Enabled = false;
           
            if (Request.Params["action"].Equals("add"))
            {
                btnLookUpPRCode.Enabled = true;
                btnLookUpItem.Enabled = true;
            }
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                btnLookUpPRCode.Enabled = false;
                btnLookUpItem.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                ddlTaxID.Enabled = false;

                btnSave.Visible = false;
                btnLookUpPRCode.Enabled = false;
                btnLookUpSupplierID.Enabled = false;
                btnLookUpItem.Enabled = false;
                txtGuarantee.Enabled = false;
                txtApprovalQuantity.Enabled = false;
                txtGuaranteePart.Enabled = false;
                txtOrderQuantity.Enabled = false;
                txtRemarks.Enabled = false;
                ddlCurrencyCode.Enabled = false;
                ddlTaxID.Enabled = false;
                txtUnitPrice.Enabled = false;
                rblPaymentMethode.Enabled = false;
                
                //txtTampunganQuantity.Text = txtOrderQuantity.Text;
                //btnCancel.Text = "Back";
              
               

                if (!lblPQStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    btnLookUpPRCode.Enabled = false;
                    btnLookUpSupplierID.Enabled = false;
                    btnLookUpItem.Enabled = false;
                    txtGuarantee.Enabled = false;
                    txtApprovalQuantity.Enabled = false;
                    txtGuaranteePart.Enabled = false;
                    txtOrderQuantity.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    ddlTaxID.Enabled = false;
                    txtUnitPrice.Enabled = false;
                    rblPaymentMethode.Enabled = false;
                    
                   
                }

                //if (!lblPQStatus.Text.Equals("POST"))
                //{
                //    pnlDoc.Visible = false;
                //    btnAdd.Visible = false;
                //    btnSaveDocumentDetail.Visible = false;
                //    pnlSearchDocReq.Visible = false;
                //}

            }
            else
                GetDocumentNo();
        }
        btnViewDocument.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/documentrequest.aspx?action=edit&codebarcode={0}');", txtPRBarcode.Text);
        LoadAfterInit();
    }

    private void GetDocumentNo()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow("PURCHASE_QUOTATION_HEADER", _ht);

            lblPurchaseQuotationCode.Text = _dr["code"].ToString();
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
            _ht["p_id_list"] = Request.Params["idlist"];

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

            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;


            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert("","xsp_purchase_quotation_detail_insert_manual", _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
            {
                //_ht["p_tmp_qty"] = decimal.Parse(txtTampunganQuantity.Text);
                _dal.Update(TABLE_NAME, _ht);
            }

            Shared.ShowSuccessGritter(this, string.Format("purchasequotationheader.aspx?action=edit&id={0}&idlist{1}&codebarcode={2}", lblID.Text,Request.Params ["idlist"], lblBarcode.Text));
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
        Response.Redirect("purchasequotationheaderlistheader.aspx?action=edit&id=" + Request.Params["id"] + "&idlist=" + Request.Params ["idlist"] + "&codebarcode=" + lblBarcode.Text);
    }

    protected void btnLookUpPRCode_Click(object sender, EventArgs e)
    {
        
    }
    

}
