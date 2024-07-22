using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_accjmdetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "ACC_JM_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ACCJM&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&ecol_4={4}');", txtAccNo.ClientID, lblAccNo.ClientID, txtOrigCurr.ClientID, txtBaseCurr.ClientID, txtRate.ClientID);

        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyBase(txtBaseCurr);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblJmNo.Text = Request.Params["jmno"];
                btnCancel.Text = "Back";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
            else
            {
                lblJmNo.Text = Request.Params["jmno"];
            }

            if (lblStatus.Text == "POST" || lblStatus.Text == "CANCEL")
            {
                btnSave.Visible = false;
                txtOrigAmount.Enabled = txtBbaseAmount.Enabled = txtRate.Enabled = txtDescription.Enabled = rblDebitOrCredit.Enabled = false;
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
            _ht["p_jm_no"] = Request.Params["jmno"];

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

                Shared.ShowSuccessGritter(this, string.Format("accjmdetail.aspx?action=edit&id={0}&jmno={1}", iNextID, Request.Params["jmno"]));
            }
            else
            {
                _dal.Update(TABLE_NAME_DETAIL, _ht);

                Shared.ShowSuccessGritter(this, string.Format("accjmdetail.aspx?action=edit&id={0}&jmno={1}", lblID.Text, Request.Params["jmno"]));
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("accjmheader.aspx?action=edit&jmno=" + Request.Params["jmno"]);
    }
}

