using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masteritem : BasePage
{
    private static string TABLE_NAME    = "MASTER_ITEM";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            
            //btnLookUpType.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ITMTP&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtType.ClientID, lblType.ClientID, lblTypeName.ClientID);
            btnLookUpMerk.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ITMMK&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&fcol_3={4}&gcol_4={5}&hcol_5={6}');", txtMerk.ClientID, lblMerk.ClientID, lblMerkName.ClientID, txtType.ClientID, lblTypeName.ClientID, txtModel.ClientID, lblModelName.ClientID);

            btnLookUpType.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LUFTM&acol_0={0}&bcol_1={1}&parc_code={2}');", txtType.ClientID, lblTypeName.ClientID, txtMerk.ClientID);

            btnLookUpModel.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MMDL&acol_0={0}&bcol_1={1}&parc_code={2}');", txtModel.ClientID, lblModelName.ClientID,txtType.ClientID);

            btnLookUpParentGroup.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LFIT&acol_0={0}&bcol_1={1}&parc_jenis_item={2}');", txtParentGroup.ClientID, lblParentGroup.ClientID, ddlJenisItem.ClientID);

            Shared.BindGeneralSubCode(ddlJenisItem, "ITMCAT");
            Shared.BindUnitsItemOwn(ddlOwner);
            Shared.BindUnitsItem(ddlProcessBy);
            ddlJenisItem.SelectedValue = Request.Params["jenis"];
           
            Shared.BindMasterUnit(ddlPOUnitCode);
            Shared.BindMasterUnit(ddlUOM2);
            Shared.BindMasterUnit(ddlUOM3);
            Shared.BindFAGroup(ddlFACategoryBookCode);
            Shared.BindFACategoryFiscal(ddlFACategoryFiscalCode);
            Shared.BindFACategory(ddlFaCategory);
           // Shared.BindUnitsItemOwn(ddlOwner);
            Shared.BindUnitsItem(ddlProcessBy);


            
            ddlJenisItem.Enabled = false;
            txtPOLatestCost.Enabled = false;
            txtPOAverageCost.Enabled = false;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                
                lblItemCode.Enabled = false;
                ddlJenisItem.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
               

            }
            else if (Request.Params["action"].Equals("copy"))
            {
                LoadData();

                lblItemCode.Text = "";
                ddlJenisItem.Enabled = true;
                txtPOAverageCost.Text = "0";
                txtPOLatestCost.Text = "0";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";


            }

            if (ddlJenisItem.SelectedValue.Equals("IT") || ddlJenisItem.SelectedValue.Equals("ET"))
            {
                ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = false;
                ddlFaCategory.Items.Clear();
                ddlFACategoryBookCode.Items.Clear();
                ddlFACategoryFiscalCode.Items.Clear();
                FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = false;
                ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = false;
                rfvFACategoryBookCode.Enabled = false;
                rfvFACategoryFiscalCode.Enabled = false;
                rfvFaCategory.Enabled = false;
                Maintc.Visible = false;
                ddlMaintenance.Visible = false;
                DatePromotion.Visible = false;
                cbxDatePromotion.Visible = false;
                Rounding.Visible = false;
                txtRounding.Visible = false;
                

            }
            else if (ddlJenisItem.SelectedValue.Equals("IC"))
            {
                ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = false;
                ddlFaCategory.Items.Clear();
                ddlFACategoryBookCode.Items.Clear();
                ddlFACategoryFiscalCode.Items.Clear();
                FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = false;
                ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = false;
                rfvFACategoryBookCode.Enabled = false;
                rfvFACategoryFiscalCode.Enabled = false;
                rfvFaCategory.Enabled = false;
               
            }
            else
            {
                Shared.BindFAGroup(ddlFACategoryBookCode);
                Shared.BindFACategoryFiscal(ddlFACategoryFiscalCode);
                Shared.BindFACategory(ddlFaCategory);
                //Shared.BindUnitsItemOwn(ddlOwner);
                //Shared.BindUnitsItem(ddlProcessBy);
                ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = true;
                FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = true;
                ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = true;
                rfvFACategoryBookCode.Enabled = true;
                rfvFACategoryFiscalCode.Enabled = true;
                rfvFaCategory.Enabled = true;
                rfvMaintenance.Enabled = false;
                Maintc.Visible = false;

                ddlMaintenance.Visible = false;
                chbGenerateBarcode.Visible = false;
                lblGenerateBarcode.Visible = false;
                DatePromotion.Visible = false;
                cbxDatePromotion.Visible = false;
                Rounding.Visible = false;
                txtRounding.Visible = false;
                
            }
        }
        LoadAfterInit();

    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            
            _ht["p_item_code"] = Request.Params["itemcode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);

            //Shared.BindItemGroupItemDDL(ddlItemGroup, ddlJenisItem.SelectedValue);

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
        string sNextItemcode = "";
        
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add") || Request.Params["action"].Equals("copy"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextItemcode);
                lblItemCode.Text = sNextItemcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

           // Shared.ShowSuccessGritter(this, string.Format("masteritem.aspx?action=edit&itemcode={0}", lblItemCode.Text));
            Shared.ShowSuccessGritter(this, string.Format("masteritemlist.aspx"));            
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
        Response.Redirect("masteritemlist.aspx");
    }

    protected void ddlJenisItem_OnSelectedIndex(object sender, EventArgs e)
    {
        
       // Shared.BindItemGroupItem(ddlItemGroup, ddlJenisItem.SelectedValue);
        if (ddlJenisItem.SelectedValue.Equals("IT") || ddlJenisItem.SelectedValue.Equals("ET"))
        {
            ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = false;
            ddlFaCategory.Items.Clear();
            ddlFACategoryBookCode.Items.Clear();
            ddlFACategoryFiscalCode.Items.Clear();
            FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = false;
            ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = false;
            rfvFACategoryBookCode.Enabled = false;
            rfvFACategoryFiscalCode.Enabled = false;
            rfvFaCategory.Enabled = false;
            Rounding.Visible = false;
            txtRounding.Visible = false;
                
        }
        else if (ddlJenisItem.SelectedValue.Equals("IC"))
        {
            ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = false;
            ddlFaCategory.Items.Clear();
            ddlFACategoryBookCode.Items.Clear();
            ddlFACategoryFiscalCode.Items.Clear();
            FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = false;
            ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = false;
            rfvFACategoryBookCode.Enabled = false;
            rfvFACategoryFiscalCode.Enabled = false;
            rfvFaCategory.Enabled = false;
        }
        else
        {
            Shared.BindFAGroup(ddlFACategoryBookCode);
            Shared.BindFACategoryFiscal(ddlFACategoryFiscalCode);
            Shared.BindFACategory(ddlFaCategory);
            ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = true;
            FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = true;
            ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = true;
            rfvFACategoryBookCode.Enabled = true;
            rfvFACategoryFiscalCode.Enabled = true;
            rfvFaCategory.Enabled = true;
            Rounding.Visible = false;
            txtRounding.Visible = false;
                
        }
 
    }
    protected void btnAddUploadDoc_Click(object sender, EventArgs e)
    {
        Response.Redirect("masteritemdocument.aspx?action=add&code=" + lblItemCode.Text + "&name=" + txtItemName.Text);
    }
    protected void btnSaveDocumentDetail_Click(object sender, EventArgs e)
    {
        
    }
    protected void gvwListDocReq_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("auditdetail.aspx?action=edit&auditno={0}&id={1}&idartarget={2}", gvwListDocReq.SelectedDataKey["BATCH_NO"].ToString(), gvwListDocReq.SelectedDataKey["GENERAL_DOC_CODE"].ToString(), Request.Params["idartarget"]));
    }
    protected void gvwListDocReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDocReq.PageIndex = e.NewPageIndex;
        BindDataDocRequest();
    }
    protected void gvwListDocReq_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
    }
    protected void gvwListDocReq_RowCommand(object sender, GridViewCommandEventArgs e)
    {}
    private void BindDataDocRequest()
    {}

}