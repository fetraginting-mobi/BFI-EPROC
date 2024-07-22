using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_finance_accrvdetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "ACC_RV_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            btnLookupDivision.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MD&acol_0={0}&bcol_1={1}&ccol_1={2}&dcol_2={3}');", txtDivisionCode.ClientID, txtDivisionDesc.ClientID, txtDepartementCode.ClientID, txtDepartementDesc.ClientID);
            btnLookupDepartement.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DPTF&acol_0={0}&bcol_1={1}&parc_divisi={2}');", txtDepartementCode.ClientID, txtDepartementDesc.ClientID, txtDivisionCode.ClientID);
            btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCPV&acol_0={0}&bcol_1={1}&ccol_2={2}');", txtAccNo.ClientID, lblAccNo.ClientID, txtCurrencyCode.ClientID);
            Shared.BindCurrencyBase(txtBaseCurr);
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblRvNo.Text = Request.Params["rvno"];
                btnCancel.Text = "Back";
                //iconCancel.Attributes.Add("class", "icon-arrow-left btn btn-danger");
            }
            else
            {
                lblRvNo.Text = Request.Params["rvno"];
                //txtCurrencyCode.Text = Request.Params["currency"];
                txtOrigAmount.Text = txtExchRate.Text = txtBaseAmount.Text = "0.00";
            }

            if (lblStatus.Text == "POST" || lblStatus.Text == "CANCEL" || lblTrxCode.Text != "")
            {
                btnSave.Visible = false;
                txtOrigAmount.Enabled = false;
                txtExchRate.Enabled = false;
                txtRemarks.Enabled = false;
                btnLookUpAccChart.Enabled = false;
                btnLookupDepartement.Enabled = false;
                btnLookupDivision.Enabled = false;
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
                lblID.Text = iNextID.ToString();

                Shared.ShowSuccessGritter(this, string.Format("accrvdetail.aspx?action=edit&id={0}&rvno={1}", iNextID, Request.Params["rvno"]));
            }
            else
            {
                _dal.Update(TABLE_NAME_DETAIL, _ht);

                Shared.ShowSuccessGritter(this, string.Format("accrvdetail.aspx?action=edit&id={0}&rvno={1}", lblID.Text, Request.Params["rvno"]));
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
        Response.Redirect("accrvheader.aspx?action=edit&rvno=" + Request.Params["rvno"]);
    }
}

