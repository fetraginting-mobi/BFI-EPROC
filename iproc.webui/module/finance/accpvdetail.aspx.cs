using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_finance_accpvdetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "ACC_PV_DETAIL";

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
                lblPvNo.Text = Request.Params["pvno"];
                btnCancel.Text = "Back";
                //iconCancel.Attributes.Add("class", "icon-arrow-left btn btn-danger");
            }
            else
            {
                lblPvNo.Text = Request.Params["pvno"];
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
        LoadInit();
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
            _ht["p_pv_no"] = Request.Params["pvno"];

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

                Shared.ShowSuccessGritter(this, string.Format("accpvdetail.aspx?action=edit&id={0}&pvno={1}", iNextID, Request.Params["pvno"]));
            }
            else
            {
                _dal.Update(TABLE_NAME_DETAIL, _ht);

                Shared.ShowSuccessGritter(this, string.Format("accpvdetail.aspx?action=edit&id={0}&pvno={1}", lblID.Text, Request.Params["pvno"]));
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
        Response.Redirect("accpvheader.aspx?action=edit&pvno=" + Request.Params["pvno"]);
    }
}

