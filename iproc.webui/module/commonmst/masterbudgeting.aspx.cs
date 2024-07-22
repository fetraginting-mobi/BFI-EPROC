using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
public partial class module_commonmst_masterbudgeting : BasePage
{
    private static string TABLE_NAME = "MASTER_BUDGETING";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        btnDeleteQty.OnClientClick = "return confirm('Delete selected data?');";
        btnDeleteItm.OnClientClick = "return confirm('Delete selected data?');";
        if (!Page.IsPostBack)
        {
            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            
           

            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataItem();
                BindDataQty(); 
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                ddlDepartment.Enabled = false;
                ddlDivision.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                ddlBranch.Enabled = false;
                btnSave.Visible = false;
                txtYear.Enabled = false;
            }
            else
            {
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
               
              
                pnlAllBudget.Visible = false;
            }
        }
        LoadAfterInit();
    }

    private void LoadData()
    {
        //System.Diagnostics.Debugger.Break();
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_branch_code"] = Request.Params["branch"];
            _ht["p_division_code"] = Request.Params["division"];
            _ht["p_department_code"] = Request.Params["department"];
            _ht["p_units_code"] = Request.Params["unitscode"];
            _ht["p_sub_department_code"] = Request.Params["subdepartment"];

            _ht["p_year"] = Request.Params["year"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue); 
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
           
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;


            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblId.Text = iNextID.ToString();
            }
            else

                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterbudgeting.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&unitscode={4}&subdepartment={5}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, ddlUnits.SelectedValue, ddlSubDepartment.SelectedValue));   
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
        Response.Redirect("masterbudgetinglist.aspx");
    }


    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);



        //updDep.Update();
    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
    }

    protected void ddlSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {

        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

      

        //updDep.Update();
    }

  

    #region Qty
    private void BindDataQty()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchQty.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_division_code"] = ddlDivision.SelectedValue;
            _ht["p_department_code"] = ddlDepartment.SelectedValue;
            _ht["p_year"] = txtYear.Text;

            gvwListQty.DataSource = _dal.GetRows("", "xsp_master_budgeting_quantity_getrows", _ht);
            gvwListQty.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListQty_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListQty.PageIndex = e.NewPageIndex;
        BindDataQty();
    }

    protected void btnDeleteQty_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListQty.Rows)
        {
            CheckBox chbCheckedLot = (CheckBox)row.Cells[1].Controls[1];
            if (chbCheckedLot.Checked)
            {
                DeleteDataQty(gvwListQty.DataKeys[row.RowIndex][1].ToString());
            }
        }

        BindDataQty();
    }



    private void DeleteDataQty(string ITEM_CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_item_code"] = ITEM_CODE;

            _dal.ExecRawSP("xsp_master_budgeting_detail_delete", _ht);


        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchQty_Click(object sender, EventArgs e)
    {
        BindDataQty();

    }


    protected void chbCheckedAllQty_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListQty.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedQty") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    public void SaveQty()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(UpdQty.Controls, _ht);

            foreach (GridViewRow row in gvwListQty.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    TextBox txtQuantityJan = (row.Cells[3].Controls[1] as TextBox);
                    TextBox txtQuantityFeb = (row.Cells[3].Controls[5] as TextBox);
                    TextBox txtQuantityMar = (row.Cells[3].Controls[9] as TextBox);
                    TextBox txtQuantityApr = (row.Cells[3].Controls[13] as TextBox);
                    TextBox txtQuantityMei = (row.Cells[3].Controls[17] as TextBox);
                    TextBox txtQuantityJun = (row.Cells[3].Controls[21] as TextBox);
                    TextBox txtQuantityJul = (row.Cells[3].Controls[25] as TextBox);
                    TextBox txtQuantityAgust = (row.Cells[3].Controls[29] as TextBox);
                    TextBox txtQuantitySept = (row.Cells[3].Controls[33] as TextBox);
                    TextBox txtQuantityOkt = (row.Cells[3].Controls[37] as TextBox);
                    TextBox txtQuantityNov = (row.Cells[3].Controls[41] as TextBox);
                    TextBox txtQuantityDes = (row.Cells[3].Controls[45] as TextBox);

                    _ht["p_id"] = gvwListQty.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_budget_jan_qty"] = txtQuantityJan.Text;
                    _ht["p_budget_feb_qty"] = txtQuantityFeb.Text;
                    _ht["p_budget_mar_qty"] = txtQuantityMar.Text;
                    _ht["p_budget_apr_qty"] = txtQuantityApr.Text;
                    _ht["p_budget_mai_qty"] = txtQuantityMei.Text;
                    _ht["p_budget_jun_qty"] = txtQuantityJun.Text;
                    _ht["p_budget_jul_qty"] = txtQuantityJul.Text;
                    _ht["p_budget_agt_qty"] = txtQuantityAgust.Text;
                    _ht["p_budget_sep_qty"] = txtQuantitySept.Text;
                    _ht["p_budget_okt_qty"] = txtQuantityOkt.Text;
                    _ht["p_budget_nov_qty"] = txtQuantityNov.Text;
                    _ht["p_budget_des_qty"] = txtQuantityDes.Text;
                    //_ht["p_item_code"] = gvwListQty.DataKeys[row.RowIndex][1].ToString();

                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "xsp_master_budgeting_quantity_update", _ht);

                }
            }
            //Shared.ShowSuccessGritter(this, string.Format("masterbudgeting.aspx?action=edit&id={0}", lblId.Text)); 
            Shared.ShowSuccessGritter(this, string.Format("masterbudgeting.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&unitscode={4}&subdepartment={5}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, ddlUnits.SelectedValue, ddlSubDepartment.SelectedValue)); 
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnSaveQty_Click(object sender, EventArgs e)
    {
        SaveQty();
    }
    protected void gvwListQty_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            btnDeleteQty.OnClientClick = "return confirm('Delete selected data?');";

            //GeneralDAL _dal = null;
            //Hashtable _ht = null;
            //try
            //{
            //    _dal = new GeneralDAL();
            //    _ht = new Hashtable();

            //    TextBox txtQuantityJan = (e.Row.Cells[3].Controls[1] as TextBox);
            //    TextBox txtQuantityFeb = (e.Row.Cells[4].Controls[1] as TextBox);
            //    TextBox txtQuantityMar = (e.Row.Cells[5].Controls[1] as TextBox);
            //    TextBox txtQuantityApr = (e.Row.Cells[6].Controls[1] as TextBox);
            //    TextBox txtQuantityMei = (e.Row.Cells[7].Controls[1] as TextBox);
            //    TextBox txtQuantityJun = (e.Row.Cells[8].Controls[1] as TextBox);
            //    TextBox txtQuantityJul = (e.Row.Cells[9].Controls[1] as TextBox);
            //    TextBox txtQuantityAgust = (e.Row.Cells[10].Controls[1] as TextBox);
            //    TextBox txtQuantitySept = (e.Row.Cells[11].Controls[1] as TextBox);
            //    TextBox txtQuantityOkt = (e.Row.Cells[12].Controls[1] as TextBox);
            //    TextBox txtQuantityNov = (e.Row.Cells[13].Controls[1] as TextBox);
            //    TextBox txtQuantityDes = (e.Row.Cells[14].Controls[1] as TextBox);

            //    if (txtQuantityJan.Text != "" || txtQuantityFeb.Text != "" || txtQuantityMar.Text != "")
            //    {
            //        txtQuantityJan.Text = "0";
            //        txtQuantityFeb.Text = "0";
            //        txtQuantityFeb.Text = "0";
            //        txtQuantityFeb.Text = "0";
            //        txtQuantityFeb.Text = "0";
            //    }
            //    txtQuantityJan.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_JAN_QTY")); //_dr["BUDGET_JAN_QTY"].ToString();
            //    txtQuantityFeb.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_FEB_QTY")); //_dr["BUDGET_FEB_QTY"].ToString();
            //    txtQuantityMar.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_MAR_QTY")); //_dr["BUDGET_MAR_QTY"].ToString();
            //    txtQuantityApr.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_APR_QTY")); //_dr["BUDGET_APR_QTY"].ToString();
            //    txtQuantityMei.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_MAI_QTY")); //_dr["BUDGET_MAI_QTY"].ToString();
            //    txtQuantityJun.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_JUN_QTY")); //_dr["BUDGET_JUN_QTY"].ToString();
            //    txtQuantityJul.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_JUL_QTY")); //_dr["BUDGET_JUL_QTY"].ToString();
            //    txtQuantityAgust.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_AGT_QTY")); //_dr["BUDGET_AGT_QTY"].ToString();
            //    txtQuantitySept.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_SEP_QTY")); //_dr["BUDGET_SEP_QTY"].ToString();
            //    txtQuantityOkt.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_OKT_QTY")); //_dr["BUDGET_OKT_QTY"].ToString();
            //    txtQuantityNov.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_NOV_QTY")); //_dr["BUDGET_NOV_QTY"].ToString();
            //    txtQuantityDes.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BUDGET_DES_QTY")); //_dr["BUDGET_DES_QTY"].ToString();
            //}
            //catch (Exception ex)
            //{
            //}
        }
    }
    #endregion

    #region Item
    private void BindDataItem()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchItm.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_division_code"] = ddlDivision.SelectedValue;
            _ht["p_department_code"] = ddlDepartment.SelectedValue;
            _ht["p_year"] = txtYear.Text;

            gvwListItm.DataSource = _dal.GetRows("", "xsp_master_budgeting_amount_getrows", _ht);
            gvwListItm.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListItm_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListItm.PageIndex = e.NewPageIndex;
        BindDataItem();
    }

    protected void btnDeleteItm_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListItm.Rows)
        {
            CheckBox chbCheckedItm = (CheckBox)row.Cells[1].Controls[1];
            if (chbCheckedItm.Checked)
            {
                DeleteDataItm(gvwListItm.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataItem();
    }



    private void DeleteDataItm(string ITEM_CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_item_code"] = ITEM_CODE;

        _dal.ExecRawSP("xsp_master_budgeting_detail_amount_delete", _ht);

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchItm_Click(object sender, EventArgs e)
    {
        BindDataItem();

    }

    protected void chbCheckedAllItm_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListItm.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedItm") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    public void SaveItm()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(updItm.Controls, _ht);
             
            foreach (GridViewRow row in gvwListItm.Rows)
            {
                 CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                 if (chb.Checked)
                 {

                     TextBox txtAmountJan = (row.Cells[3].Controls[1] as TextBox);
                     TextBox txtAmountFeb = (row.Cells[3].Controls[5] as TextBox);
                     TextBox txtAmountMar = (row.Cells[3].Controls[9] as TextBox);
                     TextBox txtAmountApr = (row.Cells[3].Controls[13] as TextBox);
                     TextBox txtAmountMei = (row.Cells[3].Controls[17] as TextBox);
                     TextBox txtAmountJun = (row.Cells[3].Controls[21] as TextBox);
                     TextBox txtAmountJul = (row.Cells[3].Controls[25] as TextBox);
                     TextBox txtAmountAgust = (row.Cells[3].Controls[29] as TextBox);
                     TextBox txtAmountSept = (row.Cells[3].Controls[33] as TextBox);
                     TextBox txtAmountOkt = (row.Cells[3].Controls[37] as TextBox);
                     TextBox txtAmountNov = (row.Cells[3].Controls[41] as TextBox);
                     TextBox txtAmountDes = (row.Cells[3].Controls[45] as TextBox);

                     _ht["p_id"] = gvwListQty.DataKeys[row.RowIndex][0].ToString();
                     _ht["p_budget_jan_amount"] = txtAmountJan.Text;
                     _ht["p_budget_feb_amount"] = txtAmountFeb.Text;
                     _ht["p_budget_mar_amount"] = txtAmountMar.Text;
                     _ht["p_budget_apr_amount"] = txtAmountApr.Text;
                     _ht["p_budget_mai_amount"] = txtAmountMei.Text;
                     _ht["p_budget_jun_amount"] = txtAmountJun.Text;
                     _ht["p_budget_jul_amount"] = txtAmountJul.Text;
                     _ht["p_budget_agt_amount"] = txtAmountAgust.Text;
                     _ht["p_budget_sep_amount"] = txtAmountSept.Text;
                     _ht["p_budget_okt_amount"] = txtAmountOkt.Text;
                     _ht["p_budget_nov_amount"] = txtAmountNov.Text;
                     _ht["p_budget_des_amount"] = txtAmountDes.Text;
                     //_ht["p_item_code"] = gvwListQty.DataKeys[row.RowIndex][1].ToString();

                     Shared.ApplyDefaultProp(_ht);

                     _dal.Update("", "xsp_master_budgeting_amount_update", _ht);
                 }

            }
            //Shared.ShowSuccessGritter(this, string.Format("masterbudgeting.aspx?action=edit&id={0}", lblId.Text));
            Shared.ShowSuccessGritter(this, string.Format("masterbudgeting.aspx?action=edit&year={0}&branch={1}&division={2}&department={3}&unitscode={4}&subdepartment={5}", txtYear.Text, ddlBranch.SelectedValue, ddlDivision.SelectedValue, ddlDepartment.SelectedValue, ddlUnits.SelectedValue, ddlSubDepartment.SelectedValue)); 
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnSaveItm_Click(object sender, EventArgs e)
    {
        SaveItm();
    }
    protected void gvwListItm_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        btnDeleteItm.OnClientClick = "return confirm('Delete selected data?');";
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{

        //    GeneralDAL _dal = null;
        //    Hashtable _ht = null;
        //    try
        //    {
        //        _dal = new GeneralDAL();
        //        _ht = new Hashtable();

        //        TextBox txtAmountJan = (e.Row.Cells[3].Controls[1] as TextBox);
        //        TextBox txtAmountFeb = (e.Row.Cells[4].Controls[1] as TextBox);
        //        TextBox txtAmountMar = (e.Row.Cells[5].Controls[1] as TextBox);
        //        TextBox txtAmountApr = (e.Row.Cells[6].Controls[1] as TextBox);
        //        TextBox txtAmountMei = (e.Row.Cells[7].Controls[1] as TextBox);
        //        TextBox txtAmountJun = (e.Row.Cells[8].Controls[1] as TextBox);
        //        TextBox txtAmountJul = (e.Row.Cells[9].Controls[1] as TextBox);
        //        TextBox txtAmountAgust = (e.Row.Cells[10].Controls[1] as TextBox);
        //        TextBox txtAmountSept = (e.Row.Cells[11].Controls[1] as TextBox);
        //        TextBox txtAmountOkt = (e.Row.Cells[12].Controls[1] as TextBox);
        //        TextBox txtAmountNov = (e.Row.Cells[13].Controls[1] as TextBox);
        //        TextBox txtAmountDes = (e.Row.Cells[14].Controls[1] as TextBox);

        //        _ht["p_id"] = gvwListQty.DataKeys[e.Row.RowIndex][0].ToString();
        //        _ht["p_budget_jan_amount"] = txtAmountJan.Text;
        //        _ht["p_budget_feb_amount"] = txtAmountFeb.Text;
        //        _ht["p_budget_mar_amount"] = txtAmountMar.Text;
        //        _ht["p_budget_apr_amount"] = txtAmountApr.Text;
        //        _ht["p_budget_mai_amount"] = txtAmountMei.Text;
        //        _ht["p_budget_jun_amount"] = txtAmountJun.Text;
        //        _ht["p_budget_jul_amount"] = txtAmountJul.Text;
        //        _ht["p_budget_agt_amount"] = txtAmountAgust.Text;
        //        _ht["p_budget_sep_amount"] = txtAmountSept.Text;
        //        _ht["p_budget_okt_amount"] = txtAmountOkt.Text;
        //        _ht["p_budget_nov_amount"] = txtAmountNov.Text;
        //        _ht["p_budget_des_amount"] = txtAmountDes.Text;

        //        DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

        //        //if (txtAmountJan.Text != "" || txtAmountFeb.Text != "" || txtAmountMar.Text != "")
        //        //{
        //        //    txtAmountJan.Text = "0";
        //        //    txtQuantityFeb.Text = "0";
        //        //    txtQuantityFeb.Text = "0";
        //        //    txtQuantityFeb.Text = "0";
        //        //    txtQuantityFeb.Text = "0";
        //        //}
        //        txtAmountJan.Text = _dr["BUDGET_JAN_AMOUNT"].ToString();
        //        txtAmountFeb.Text = _dr["BUDGET_FEB_AMOUNT"].ToString();
        //        txtAmountMar.Text = _dr["BUDGET_MAR_AMOUNT"].ToString();
        //        txtAmountApr.Text = _dr["BUDGET_APR_AMOUNT"].ToString();
        //        txtAmountMei.Text = _dr["BUDGET_MAI_AMOUNT"].ToString();
        //        txtAmountJun.Text = _dr["BUDGET_JUN_AMOUNT"].ToString();
        //        txtAmountJul.Text = _dr["BUDGET_JUL_AMOUNT"].ToString();
        //        txtAmountAgust.Text = _dr["BUDGET_AGT_AMOUNT"].ToString();
        //        txtAmountSept.Text = _dr["BUDGET_SEP_AMOUNT"].ToString();
        //        txtAmountOkt.Text = _dr["BUDGET_OKT_AMOUNT"].ToString();
        //        txtAmountNov.Text = _dr["BUDGET_NOV_AMOUNT"].ToString();
        //        txtAmountDes.Text = _dr["BUDGET_DES_AMOUNT"].ToString();
        //    }
        //    catch (Exception ex)
        //    {
        //    }
        //}
    }

    #endregion
   
}
