using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_accounting_accallocprepaidadjustmentdetail : BasePage
{
    private static string TABLE_NAME = "ACC_ALLOC_PREPAID_ADJUSTMENT_DETAIL";


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        btnLookupCOA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ACCHT&acol_1={0}&bcol_0={1}');", txtACCName.ClientID, txtACCNo.ClientID);

        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                btnCancelDetail.Text = "Back";
                btnCancelDetail.Text = "<i class='icon-arrow-left'></i> Back";

            }
            else
            {
                //detail.Visible = false;
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

            _ht["p_transaction_no"] = Request.Params["codebarcode"];
            //_ht["p_code"] = Request.Params["code"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(updMain.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveDataDetail()
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int sNextCode = 0;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(updMain.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            //_ht["p_code"] = lblCode.Text;
            _ht["p_id"] = Request.Params["id"];
            _ht["p_transaction_no"] = Request.Params["codebarcode"];

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextCode);
                lblID.Text = sNextCode.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("accallocprepaidadjustmentdetail.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, Request.Params["codebarcode"]));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {
        SaveDataDetail();
    }

    protected void btnCancelDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("accallocprepaidadjustment.aspx?action=edit&codebarcode=" + Request.Params["codebarcode"]));
    }
}
