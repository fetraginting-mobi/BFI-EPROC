using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterstampduty : BasePage
{
    private static string TABLE_NAME = "MASTER_STAMP_DUTY";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyCode(ddlCurrency);
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                txtTransactionFrom.Enabled = false;
                txtTransactionTo.Enabled = false;
                ddlCurrency.Enabled = false;
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
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_transaction_from"] = decimal.Parse(Request.Params["transactionfrom"].ToString());
            _ht["p_transaction_to"] = decimal.Parse(Request.Params["transactionto"].ToString());
            _ht["p_currency_code"] = Request.Params["currency"];
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

            Shared.ShowSuccessGritter(this, string.Format("masterstampdutylist.aspx"));
            //Shared.ShowSuccessGritter(this, string.Format("masterstampdutylist.aspx?action=edit&transactionfrom=" + txtTransactionFrom.Text + "&transactionto=" + txtTransactionTo.Text + "&currency=" + ddlCurrency.SelectedValue));
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
        Response.Redirect("masterstampdutylist.aspx");
    }

}