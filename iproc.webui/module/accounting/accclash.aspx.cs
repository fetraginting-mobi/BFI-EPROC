using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_accclash : BasePage
{
    private static string TABLE_NAME = "ACC_CLASS";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            btnLookUpAccChart.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&parc_curr_code={3}');", txtAccNo.ClientID, lblAccNo.ClientID, lblAccName.ClientID, ddlCurrency.ClientID);
            Shared.BindCurrencyCodeAcc(ddlCurrency);
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                //lblPvNo.Text = Request.Params["pvno"];
                btnCancel.Text = "Back";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
            else
            {
                //lblPvNo.Text = Request.Params["pvno"];
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

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);
            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #region toolbar

    protected void btnSave_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int NextID = 0;
        try
        {
            //
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_trans_code"] = "RTE";
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref NextID);
                lblID.Text = NextID.ToString();
            }
            else
            {
                _dal.Update(TABLE_NAME, _ht);
            }

            Shared.ShowSuccessGritter(this, string.Format("accclash.aspx?action=edit&id={0}", lblID.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("accclashlist.aspx");
    }

    #endregion
}
