using System;
using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_faentrydetail : BasePage
{

    private static string TABLE_NAME_DETAIL = "FA_ENTRY_DETAIL";
    private static string TABLE_NAME_FA = "FA_ASSET";


    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        
        if (!Page.IsPostBack)
        {
           //Shared.BindFaLocation(ddlfaLocationCode);
            Shared.BindFAGroup(ddlDepreCategoryBook);
            Shared.BindFACategoryFiscal(ddlDepreCategoryFiscal);
            Shared.BindFACategory(ddlCategory);
            btnLookUpInventoryEntryItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LUFAI&acol_0={0}&ccol_1={1}&dcol_3={2}&ecol_4={3}&fcol_5={4}');", txtItemCode.ClientID, txtItemName.ClientID, ddlCategory.ClientID, ddlDepreCategoryBook.ClientID, ddlDepreCategoryFiscal.ClientID);
            lblCodeBarcode.Text = Request.Params["codebarcode"];
       

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                ddlCategory.Enabled = false;
                ddlDepreCategoryFiscal.Enabled = false;
                ddlDepreCategoryBook.Enabled = false;
                txtPurchaseDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtPurchaseDate.Enabled = false;

                if (!lblFEStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    txtPurchaseDate.Enabled = false;
                    txtCostPrice.Enabled = false;
                    ddlDepreCategoryBook.Enabled = false;
                    ddlDepreCategoryFiscal.Enabled = false;
                    txtTotalDepreKormesil.Enabled = false;
                    txtTotalDepreFiscal.Enabled = false;
                    txtNetBookValueKormesil.Enabled = false;
                    txtNetBookValueFiscal.Enabled = false;
                    txtObjectInfo.Enabled = false;
                    txtRemarks.Enabled = false;
                   // ddlfaLocationCode.Enabled = false;
                    ddlCategory.Enabled = false;
                    btnLookUpInventoryEntryItem.Enabled = false;
                    txtItemName.Enabled = false;
                    
                }
            }
            else
            {
                GetCode();
                ddlCategory.Enabled = false;
                ddlDepreCategoryFiscal.Enabled = false;
                ddlDepreCategoryBook.Enabled = false;
                txtPurchaseDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtPurchaseDate.Enabled = false;

               
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
            DataRow _dr = _dal.GetRow("FA_ENTRY_HEADER", _ht);

            lblFECode.Text = _dr["code"].ToString();
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
            DataRow _dr = _dal.GetRow(TABLE_NAME_DETAIL, _ht);

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

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref iNextID);
                //_dal.Insert(TABLE_NAME_FA, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME_DETAIL, _ht);

            Shared.ShowSuccessGritter(this, string.Format("faentryheader.aspx?action=edit&codebarcode={0}",lblCodeBarcode.Text));
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
        Response.Redirect("faentryheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text + "&idartarget=" + Request.Params["idartarget"]);
    }  
}
