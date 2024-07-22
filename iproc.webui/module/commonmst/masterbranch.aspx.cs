using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterbranch : BasePage
{
    private static string TABLE_NAME = "MASTER_BRANCH";
    private static string TABLE_NAME_BANK = "SYS_BRANCH_BANK";
    private static string TABLE_NAME_ACC = "SYS_BRANCH_ACC_FIRST_PERIOD";
    private static string TABLE_NAME_SUB_BRANCH = "SUB_BRANCH";


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindGeneralSubCode(ddlMonth, "MNH");
            btnLookUpACCRAK.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtACCRAK.ClientID, lblNoACCRAK.ClientID, lblNameACCRAK.ClientID);
            
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataBank();
                BindDataAccPeriod();
               // BindDataSubBranch();

                txtCode.Enabled = false;
                txtInisialCode.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnDeleteBank.OnClientClick = "return confirm('Delete selected data?');";
               
                //btnCancel.Text = "Back";
            }
            else
            {
                btnAddBank.Visible = btnDeleteBank.Visible = false;
                pnlBank.Visible = false;
            }

            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

        }
        LoadAfterInit();
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = Request.Params["code"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(UpdatePanel1.Controls, _dr);
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
                _dal.Insert(TABLE_NAME, _ht);
            
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterbranchlist.aspx"));
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
        Response.Redirect("masterbranchlist.aspx");
    }

    #region Branch Bank
    private void BindDataBank()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //System.Diagnostics.Debugger.Break();

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchBank.Text;
            _ht["p_branch_code"] = txtCode.Text;

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
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("branchbank.aspx?action=add&companycode={0}&branchcode={1}&branchname={2}", Request.Params["companycode"], txtCode.Text, txtDescription.Text));
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
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("branchbank.aspx?action=edit&branchcode={0}&code={1}", Request.Params["code"], gvwListBank.SelectedDataKey[0].ToString()));
    }

    #endregion

    #region accounting period

    private void BindDataAccPeriod()
    {
        
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_branch_code"] = txtCode.Text;
            DataRow _dr = _dal.GetRow(TABLE_NAME_ACC, _ht);

            
            DBToUI.Map(updAcc.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    private void SaveDataAccPeriod()
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
                _dal.Insert(TABLE_NAME_ACC, _ht);

            else
                _dal.Update(TABLE_NAME_ACC, _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterbranch.aspx?action=edit&code={0}", txtCode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSaveAccPeriod_Click(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        SaveDataAccPeriod();
    }

    #endregion

    //#region Sub Branch
    //private void BindDataSubBranch()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_keywords"] = txtSearchSubBranch.Text;
    //        _ht["p_branch_code"] = txtCode.Text;

    //        gvwListSubBranch.DataSource = _dal.GetRows(TABLE_NAME_SUB_BRANCH, _ht);
    //        gvwListSubBranch.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //private void DeleteData(string ID)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_code"] = ID;

    //        _dal.Delete(TABLE_NAME_SUB_BRANCH, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //protected void gvwListSubBranch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    gvwListSubBranch.PageIndex = e.NewPageIndex;
    //    BindDataSubBranch();
    //}

    //protected void btnAddSubBranch_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("subbranch.aspx?action=add&branchcode=" + txtCode.Text);
    //}

    //protected void btnDeleteSubBranch_Click(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in gvwListSubBranch.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            DeleteData(gvwListSubBranch.DataKeys[row.RowIndex][0].ToString());
    //        }
    //    }

    //    BindDataSubBranch();

    //}

    //protected void btnSearchSubBranch_Click(object sender, EventArgs e)
    //{
    //    BindDataSubBranch();
    //}

    //protected void gvwListSubBranch_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Response.Redirect("subbranch.aspx?action=edit&code=" + gvwListSubBranch.SelectedDataKey[0].ToString() + "&branchcode=" + Request.Params["code"]);
    //}
    //#endregion

}