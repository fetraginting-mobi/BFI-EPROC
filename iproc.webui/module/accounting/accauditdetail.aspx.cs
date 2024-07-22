using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_accauditdetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "ACC_AUDIT_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ACCJM&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&ecol_4={4}');", txtAccNo.ClientID, lblAccNo.ClientID, txtOrigCurr.ClientID, txtBaseCurr.ClientID, txtRate.ClientID);

            txtOrigAmount.Attributes.Add("onchange", String.Format("javascript:fnCalculateBaseAmount('{0}','{1}','{2}')", txtOrigAmount.ClientID, txtRate.ClientID, txtBbaseAmount.ClientID));

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblAuditNo.Text = Request.Params["auditno"];
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
            else
            {
                lblAuditNo.Text = Request.Params["auditno"];
            }

            if (lblStatus.Text == "POST" || lblStatus.Text == "CANCEL")
            {
                btnSave.Visible = false;
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
            _ht["p_audit_no"] = Request.Params["auditno"];

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

                Shared.ShowSuccessGritter(this, string.Format("accauditdetail.aspx?action=edit&id={0}&auditno={1}", iNextID, Request.Params["auditno"]));
            }
            else
            {
                _dal.Update(TABLE_NAME_DETAIL, _ht);

                Shared.ShowSuccessGritter(this, string.Format("accauditdetail.aspx?action=edit&id={0}&auditno={1}", lblID.Text, Request.Params["auditno"]));
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

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("accauditheader.aspx?action=edit&auditno=" + Request.Params["auditno"]);
    }
}
