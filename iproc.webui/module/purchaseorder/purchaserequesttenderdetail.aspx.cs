using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_purchaserequesttenderdetail : BasePage
{
    private static string TABLE_NAME_HEADER = "PURCHASE_TENDER";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
           
            Shared.BindUnit(ddlUnitId);
            Shared.BindTaxScreme(ddlTaxId);
            Shared.BindCurrencyCode(ddlCurrencyCode);

            lblSupplierCode.Text = Shared.CurrentUID;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

            }

        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/purchaserequesttender.aspx";

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

            _ht["p_code_barcode"] = Request.Params["requesttenderno"];
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            Shared.BindItemUOM(ddlUnitId, _dr["ITEM_CODE"].ToString());
            DBToUI.Map(this.Controls, _dr);


        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void Winner()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string sNextBarcode = "";
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_code_barcode"] = Request.Params["codebarcode"];


            _dal.ExecRawSP("xsp_purchase_tender_update_winner", _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaserequesttender.aspx?action=edit&codebarcode={0}", Request.Params["codebarcode"]));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnWinner_Click(object sender, EventArgs e)
    {
        Winner();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchaserequesttender.aspx?action=edit&codebarcode=" + Request.Params["codebarcode"]);
    }
}
