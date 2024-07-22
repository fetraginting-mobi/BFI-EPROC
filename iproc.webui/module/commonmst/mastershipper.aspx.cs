using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_mastershipper : BasePage
{
    private static string TABLE_NAME = "MASTER_SHIPPER";
    private static string TABLE_NAME_BANK = "MASTER_SHIPPER_BANK";

    protected void Page_Load(object sender, EventArgs e)
    {

        btnCOANo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHC&acol_0={0}&bcol_0={1}&ccol_1={2}&parc_curr_code={3}');", txtCOA.ClientID, lblCOA.ClientID, lblCOAName.ClientID, ddlCurrency.ClientID);
        
        LoadInit();
        if (!Page.IsPostBack)
        {

            Shared.BindCurrencyCode(ddlCurrency);
            
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataBank();
                txtCode.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnDeleteBank.OnClientClick = "return confirm('Delete selected data?');";

            }
            else
            {
                btnAddBank.Visible = btnDeleteBank.Visible = false;
                pnlBank.Visible = false;
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

            _ht["p_trx_code"] = Request.Params["trxcode"];
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

            Shared.ShowSuccessGritter(this, string.Format("mastershipper.aspx?action=edit&trxcode={0}", txtCode.Text));
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
        Response.Redirect("mastershipperlist.aspx");
    }

    #region Branch Bank
    private void BindDataBank()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchBank.Text;
            _ht["p_trx_code"] = txtCode.Text;

            gvwListBank.DataSource = _dal.GetRows(TABLE_NAME_BANK, _ht);
            gvwListBank.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListBank_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListBank.PageIndex = e.NewPageIndex;
        BindDataBank();
    }

    protected void btnAddBank_Click(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("mastershipperbank.aspx?action=add&trxcode={0}&shippername={1}", txtCode.Text, txtDescription.Text));
    }

    protected void btnDeleteBank_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListBank.Rows)
        {
            CheckBox chbBank = (CheckBox)row.Cells[1].Controls[1];
            if (chbBank.Checked)
            {
                DeleteDataBank(gvwListBank.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataBank();
    }

    private void DeleteDataBank(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_BANK, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchBank_Click(object sender, EventArgs e)
    {
        BindDataBank();
    }

    protected void gvwListBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("mastershipperbank.aspx?action=edit&trxcode={0}&id={1}", Request.Params["trxcode"], gvwListBank.SelectedDataKey[0].ToString()));
    }

    #endregion

}


