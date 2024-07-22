using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_finance_firvdetail : BasePage
{
    private static string TABLE_NAME = "FI_RV_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyCode(ddlOrigCurrCode);
            Shared.BindCurrencyCode(ddlBaseCurrCode);
            Shared.BindGeneralSubCode(ddlFromBank, "BANK");

            ddlBaseCurrCode.Text = "IDR";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                ddlBaseCurrCode.Enabled = false;
                ddlOrigCurrCode.Enabled = false;
                txtExchRate.Enabled = false;
                txtOrigAmount.Enabled = false;
                txtRvType.Enabled = false;
                txtReffNo.Enabled = false;

                btnCancel.Text = "Back";
                iconCancel.Attributes.Add("class", "icon-arrow-left btn btn-danger");
            }
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
            _ht["p_rv_no"] = Request.Params["rvno"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);
            DBToUI.Map(this.Controls, _dr);
            //
            if (Request.Params["status"].ToString() == "POST" || Request.Params["status"].ToString() == "REJECT" || Request.Params["status"].ToString() == "CANCEL")
            {
                btnSave.Visible = false;
                ddlFromBank.Enabled = false;
                txtFromBankAccountName.Enabled = false;
                txtFromBankAccountNo.Enabled = false;
                ddlOrigCurrCode.Enabled = false;
            }
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
                //_ht["p_rv_no"] = txtPrNo.Text;

                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();

                Shared.ShowSuccessGritter(this, string.Format("firvdetail.aspx?action=edit&id={0}&rvno={1}&status={2}", iNextID, Request.Params["rvno"], Request.Params["status"]));
            }
            else
            {
                // _ht["p_rr_no"] = txtPrNo.Text;

                _dal.Update(TABLE_NAME, _ht);

                Shared.ShowSuccessGritter(this, string.Format("firvdetail.aspx?action=edit&id={0}&rvno={1}&status={2}", lblID.Text, Request.Params["rvno"], Request.Params["status"]));
            }
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
        Response.Redirect("firvheader.aspx?action=edit&rvno=" + Request.Params["rvno"]);
    }
}
