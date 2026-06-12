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
    private static string TABLE_NAME_HEADER = "FA_ENTRY_HEADER";


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

                if (!IsHeaderStatusNew(lblFEStatus.Text))
                {
                    SetReadOnlyMode();
                }
            }
            else
            {
                LoadHeaderData();
                ddlCategory.Enabled = false;
                ddlDepreCategoryFiscal.Enabled = false;
                ddlDepreCategoryBook.Enabled = false;
                txtPurchaseDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtPurchaseDate.Enabled = false;

                if (!IsHeaderStatusNew(lblFEStatus.Text))
                    SetReadOnlyMode();
            }
        }
        LoadAfterInit();
    }

    private DataRow GetHeaderRow(GeneralDAL dal)
    {
        Hashtable ht = new Hashtable();
        ht["p_code_barcode"] = Request.Params["codebarcode"];

        return dal.GetRow(TABLE_NAME_HEADER, ht);
    }

    private string GetHeaderStatus(DataRow dr)
    {
        string status = string.Empty;

        if (dr == null)
            return string.Empty;

        if (dr.Table.Columns.Contains("FE_STATUS"))
        {
            status = dr["FE_STATUS"].ToString();
            if (!string.IsNullOrEmpty(status.Trim()))
                return status;
        }

        if (dr.Table.Columns.Contains("TRANS_FLAG_CODE"))
        {
            status = dr["TRANS_FLAG_CODE"].ToString();
            if (!string.IsNullOrEmpty(status.Trim()))
                return status;
        }

        if (dr.Table.Columns.Contains("TRANS_FLAG_DESC"))
            return dr["TRANS_FLAG_DESC"].ToString();

        return string.Empty;
    }

    private bool IsHeaderStatusNew(string status)
    {
        if (string.IsNullOrEmpty(status))
            return false;

        return status.Trim().Equals("NEW", StringComparison.OrdinalIgnoreCase);
    }

    private void LoadHeaderData()
    {
        GeneralDAL _dal = null;

        try
        {
            _dal = new GeneralDAL();

            DataRow _dr = GetHeaderRow(_dal);

            lblFECode.Text = _dr["code"].ToString();
            lblFEStatus.Text = GetHeaderStatus(_dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private bool IsCurrentHeaderNew(GeneralDAL dal)
    {
        DataRow dr = GetHeaderRow(dal);
        lblFEStatus.Text = GetHeaderStatus(dr);

        return IsHeaderStatusNew(lblFEStatus.Text);
    }

    private void SetReadOnlyMode()
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
        ddlCategory.Enabled = false;
        btnLookUpInventoryEntryItem.Enabled = false;
        txtItemName.Enabled = false;
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

            if (!IsCurrentHeaderNew(_dal))
            {
                Shared.ShowValidationError(this, "FA Entry status must be NEW to add or update detail.");
                return;
            }

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
        Page.Validate();
        if (!Page.IsValid)
            return;

        SaveData();
    }

    protected void cvItemName_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = !string.IsNullOrEmpty(txtItemCode.Text.Trim())
            && !string.IsNullOrEmpty(txtItemName.Text.Trim())
            && !txtItemName.Text.Trim().Equals("--");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("faentryheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text + "&idartarget=" + Request.Params["idartarget"]);
    }  
}
