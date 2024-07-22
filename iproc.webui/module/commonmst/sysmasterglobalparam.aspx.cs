using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
public partial class module_commonmst_sysmasterglobalparam : BasePage
{
    private static string TABLE_NAME = "SYS_GLOBAL_PARAM";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindGeneralSubCode(ddlInventoryMetod, "INVMD");
            Shared.BindGeneralSubCode(ddlCogsMethod, "COGMD");
            btnLookUpAccStockVariance.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAccStockVariance.ClientID, lblAccStockVariance.ClientID, lblNameAccStockVariance.ClientID);
            btnLookUpAccAPVariance.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAccAPVariance.ClientID, lblAccAPVariance.ClientID, lblNameAccAPVariance.ClientID);
            btnLookUpAccAdvance.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAccAdvance.ClientID, lblAccAdvance.ClientID, lblNameAccAdvance.ClientID);
            btnLookTrxType.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=TRXTY&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtTrxType.ClientID, lblTrxTypeCode.ClientID, lblTrxType.ClientID);
            btnLookTrxTypeDiscount.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=TRXTY&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtTrxTypeDiscount.ClientID, lblTrxTypeCodeDiscount.ClientID, lblTrxTypeDiscount.ClientID);


            LoadData();
            lblId.Enabled = false;
            txtRequestDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtRequestDate.Enabled = false;
            ddlInventoryMetod.Enabled = false;
            btnLookTrxType.Enabled = false;
            btnLookTrxTypeDiscount.Enabled = true;
            txtFileUploadPath.Enabled = false;
            ddlCogsMethod.Enabled = false;

            btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            btnCancel.CssClass = "btn btn-custome";

        }
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

            _ht["p_id"] = Request.Params["id"];
            
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

        //

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);


            //if (Request.Params["action"].Equals("add"))
            //{
            //    _dal.Insert(TABLE_NAME, _ht, ref iNextID);
            //}
            //else
            _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("sysmasterglobalparam.aspx"));
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
        Response.Redirect("sysmasterglobalparamlist.aspx");
    }
   
  
}