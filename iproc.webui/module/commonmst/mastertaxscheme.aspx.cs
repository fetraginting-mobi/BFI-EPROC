using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_mastertaxscheme : BasePage
{
    private static string TABLE_NAME = "MASTER_TAX_SCHEME";

    protected void Page_Load(object sender, EventArgs e)
    {

        btnLookUpPPNCOA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtPPNCOA.ClientID, lblPPNCOA.ClientID, lblNamePPNCOA.ClientID);
        btnLookUpPPHCOA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtPPHCOA.ClientID, lblPPHCOA.ClientID, lblNamePPHCOA.ClientID);
        LoadInit();
        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                txtTaxCode.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
            }
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

            _ht["p_tax_code"] = Request.Params["code"];
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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht);
            }
            else
                _dal.Update(TABLE_NAME, _ht);
            Shared.ShowSuccessGritter(this, string.Format("mastertaxschemelist.aspx"));
           // Shared.ShowSuccessGritter(this, string.Format("mastertaxscheme.aspx?action=edit&code={0}", txtTaxCode.Text));
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
        Response.Redirect("mastertaxschemelist.aspx");
    }
}
