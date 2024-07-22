using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_mastercreditortype : BasePage
{
    private static string TABLE_NAME = "MASTER_CREDITOR_TYPE";
    private static string TABLE_NAME_DETAIL = "MASTER_CREDITOR_TYPE_LINK_ACC";
    protected void Page_Load(object sender, EventArgs e)
    {
        //btnLookUpCapyCOA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtCapyAcc.ClientID, lblCapyAcc.ClientID, lblNameCapyAcc.ClientID);
        //btnLookUpAdvanceAcc.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAdvanceAcc.ClientID, lblAdvanceAcc.ClientID, lblNameAdvanceAcc.ClientID);
        //btnLookUpAccruedAcc.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAccruedAcc.ClientID, lblAccruedAcc.ClientID, lblNameAccruedAcc.ClientID);
        //btnLookUpDepositAcc.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtDepositAcc.ClientID, lblDepositAcc.ClientID, lblNameDepositAcc.ClientID);
        
        LoadInit();
        if (!Page.IsPostBack)
        {   
            Shared.BindGeneralSubCode(ddlCreditorType, "CRETYP");
            
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                ddlCreditorType.Enabled = false;
                txtCreditorTypeCode.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                BindCreditorTypeLinkAcc();
            }
            else
            {
                btnAdd.Visible = btnDelete.Visible = false;
                pnlEditorTypeAcc.Visible = false;
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

            _ht["p_creditortype_code"] = Request.Params["code"];
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

            Shared.ShowSuccessGritter(this, string.Format("mastercreditortype.aspx?action=edit&code={0}", txtCreditorTypeCode.Text));            
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
        Response.Redirect("mastercreditortypelist.aspx");
    }

    #region Creditor Type Link Acc

    private void BindCreditorTypeLinkAcc()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_creditortype_code"] = txtCreditorTypeCode.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindCreditorTypeLinkAcc();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("mastercreditortypelinkacc.aspx?action=add&creditortypecode=" + txtCreditorTypeCode.Text);
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindCreditorTypeLinkAcc();

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (txtCreditorTypeCode.Text != string.Empty)
            BindCreditorTypeLinkAcc();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("mastercreditortypelinkacc.aspx?action=edit&id={0}&creditortypecode={1}", gvwList.SelectedDataKey[0].ToString(), txtCreditorTypeCode.Text));
    }
    #endregion
}