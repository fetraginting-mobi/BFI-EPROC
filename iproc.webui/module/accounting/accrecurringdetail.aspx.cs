using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
public partial class module_accounting_accrecurringdetail : BasePage
{
    private static string TABLE_NAME = "ACC_RECURRING_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        btnLookupCOA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ACCHT&acol_1={0}&bcol_0={1}');", txtACCName.ClientID, txtACCNo.ClientID);

        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                btnCancel.Text = "Back";
                btnCancel.Text = "<i class='icon-arrow-left'></i> Back";
                 
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

            _ht["p_header_code"] = Request.Params["recurringno"];
            _ht["p_code"] = Request.Params["code"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(updMain.Controls, _dr);
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
        string sNextCode = string.Empty;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(updMain.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_code"] = lblCode.Text;
            _ht["p_header_code"] = Request.Params["recurringno"];

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextCode);
                lblCode.Text = sNextCode;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("accrecurringdetail.aspx?action=edit&recurringno={0}&code={1}", Request.Params["recurringno"], lblCode.Text));
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
        Response.Redirect(String.Format("accrecurringheader.aspx?action=edit&recurringno=" + Request.Params["recurringno"]));
    }

}
