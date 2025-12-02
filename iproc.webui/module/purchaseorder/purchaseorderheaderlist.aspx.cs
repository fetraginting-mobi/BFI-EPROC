using System;
using System.Data;
using System.IO;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_purchaseorder_purchaseorderheaderlist : BasePageList
{
    private static string TABLE_NAME = "PURCHASE_ORDER_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "PURCHASE_ORDER_HEADER";
        NEXT_PAGE = "purchaseorderheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        btnDelete.OnClientClick = "return confirm('Delete selected data?');";
        btnProcess.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
        //txtSearchProcess.Focus();
        if (!Page.IsPostBack)

        {
            if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();

            Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "PO");
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindBranchEmployeeSort(ddlBranchPO);
            //Shared.BindCurrencyCode(ddlCurrencyShared);

            //(+) Ari 11-07-2022 ket : enhancement 2022
            ddlBranchPO.Items.Insert(0, "ALL");
            ddlBranch.Items.Insert(0, "ALL");
            if (string.IsNullOrEmpty(txtToDate.Text) & string.IsNullOrEmpty(txtToDatePO.Text))
            {
                //set tgl skrg
                txtToDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtToDatePO.Text = DateTime.Now.ToString("dd/MM/yyyy");

                //set tgl 30 hari sebelum hari ini
                DateTime date = new DateTime(DateTime.Now.Year, 1, 1).AddDays(DateTime.Now.DayOfYear - 30);
                txtFromDate.Text = date.ToString("dd/MM/yyyy");
                txtFromDatePO.Text = date.ToString("dd/MM/yyyy");

            }

            BindDataGenerate();
            BindDataManual();

           
        }

        LoadAfterInit();
    }


    #region purchase order manual
    private void BindDataManual()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;

            //(+) Ari 11-07-2022 ket : enhancement 2022
            _ht["p_from_date_po"] = Shared.ToStartDateTime(txtFromDate.Text);
            _ht["p_to_date_po"] = Shared.ToStartDateTime(txtToDate.Text);
            //_ht["p_emp_code"] = Shared.CurrentUID;


            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_purchase_order_header_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    private void DeleteData(string code)
    {
           
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = code;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindDataManual();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchaseorderheader.aspx?action=add");
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

        BindDataGenerate();
        BindDataManual();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        BindDataManual();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        base.SelectedIndexChanged(sender, e);
        Response.Redirect("purchaseorderheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        BindDataManual();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataManual();
    }
    #endregion    

    #region purchase order autogenerate
    private void BindDataGenerate()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
       
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchProcess.Text;
            _ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
           // _ht["p_branch_code"] = Shared.CurrentDefaultEmployeeBranchCode;
            _ht["p_branch_code"] = ddlBranchPO.SelectedValue;


            //(+) Ari 11-07-2022 ket : enhancement 2022
            _ht["p_from_date"] = Shared.ToStartDateTime(txtFromDatePO.Text);
            _ht["p_to_date"] = Shared.ToStartDateTime(txtToDatePO.Text);
            //_ht["p_emp_code"] = Shared.CurrentUID;

            Shared.ApplyDefaultProp(_ht);




            gvwListGenerate.DataSource = _dal.GetRows("", "xsp_purchase_order_header_getrows_generate", _ht);            
            gvwListGenerate.DataBind();

            
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListGenerate_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("purchaseorderheader.aspx?action=edit&codebarcode=" + gvwListGenerate.SelectedDataKey[0].ToString());
    }
    protected void gvwListGenerate_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            GeneralDAL _dal = null;
            Hashtable _ht = null;
            string pqhCode = "";
            string code = "";
            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();

                TextBox txtUnitPrice = (TextBox)e.Row.FindControl("txtUnitPrice");
                DropDownList ddlCurrencyCode = (DropDownList)e.Row.FindControl("ddlCurrencyCode");
                TextBox txtSupplierCode = (TextBox)e.Row.FindControl("txtSupplierCode");
                Label lblSupplierName = (Label)e.Row.FindControl("lblSupplierName");
                TextBox txtItemGroup = (TextBox)e.Row.FindControl("txtItemGroup");
                DropDownList ddlIsTermin = (DropDownList)e.Row.FindControl("ddlIsTermin");
                TextBox txtRate = (TextBox)e.Row.FindControl("txtRate"); // (+) Ari 29-07-2022 ket : enhancement 2022
               // CheckBox chkTermin = (CheckBox)e.Row.FindControl("chkTermin");
                Shared.BindCurrencyCode(ddlCurrencyCode);


                //_ht["p_supplier_code"] = gvwListGenerate.DataKeys[e.Row.RowIndex][1].ToString();
                //_ht["p_item_code"] = gvwListGenerate.DataKeys[e.Row.RowIndex][2].ToString();
                //_ht["p_pq_code"] = gvwListGenerate.DataKeys[e.Row.RowIndex][0].ToString();
                //DataRow _dr = _dal.GetRow("", "xsp_supplier_selection_for_po_getrows", _ht);
                //code = _dr["CODE"].ToString();

                pqhCode = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PQ_DESC"));
                code = pqhCode.Substring(4, 2); 

                txtUnitPrice.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "WINNER_AMOUNT"));
                ddlCurrencyCode.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CURRENCY_CODE"));

                txtSupplierCode.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SUPPLIER_CODE"));
                lblSupplierName.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SUPPLIER_NAME"));
                txtItemGroup.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "GROUP_CODE"));
                ddlIsTermin.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IS_TERMIN"));
                txtRate.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "RATE")); // (+) Ari 29-07-2022 ket : enhancement 2022

                //if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IS_TERMIN")) == "1")
                //    chkTermin.Checked = true;
                //else
                //    chkTermin.Checked = false;

                LinkButton btnLookUp = (LinkButton)e.Row.FindControl("btnLookUpSupplierID");
                btnLookUp.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSUPL&acol_0={0}&bcol_1={1}&parc_item_group={2}');", txtSupplierCode.ClientID, lblSupplierName.ClientID, txtItemGroup.ClientID);

                if (code == "PQ")
                {
                    txtUnitPrice.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    btnLookUp.Enabled = false;
                }
                else if (code == "QR")
                {
                    txtUnitPrice.Enabled = true;
                    ddlCurrencyCode.Enabled = true;
                    btnLookUp.Enabled = true;
                }

                if (string.IsNullOrEmpty(txtRate.Text))  // (+) Ari 29-07-2022 ket : enhancement 2022
                {
                    txtRate.Text = "1";
                }
            }
            catch (Exception ex)
            {
            }
            
        }
    }
    protected void gvwListGenerate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        gvwListGenerate.PageIndex = e.NewPageIndex;
        BindDataGenerate();
    }

    protected void btnSearchProcess_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        BindDataGenerate();
    }

    private void ProcessData()
    {
        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }


        GeneralDAL _dal = null;
        Hashtable _ht = null;

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwListGenerate.Rows)
            {
                //System.Diagnostics.Debugger.Break();
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    DropDownList Currency = ((DropDownList)row.FindControl("ddlCurrencyCode"));
                    string UnitPrice = ((TextBox)row.FindControl("txtUnitPrice")).Text;
                   

                    _ht["p_pq_code"] = gvwListGenerate.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_supplier_code"] = gvwListGenerate.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_item_code"] = gvwListGenerate.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_currency_code"] = Currency.SelectedValue;
                    _ht["p_unit_price"] = UnitPrice;
                    _ht["p_branch_code"] = Shared.CurrentDefaultEmployeeBranchCode;
                    _ht["p_branch_code_detail"] = gvwListGenerate.DataKeys[row.RowIndex][3].ToString();
                    _ht["p_ssdid"] = gvwListGenerate.DataKeys[row.RowIndex][4].ToString();

                    //(+) Ari 29-07-2022 ket : enhancement 2022, + parameter buat Rate
                    string Rate = ((TextBox)row.FindControl("txtRate")).Text;
                    //_ht["p_rate"] = Rate;     
                    _ht["p_rate"] = 1;     
                  
                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_purchase_order_header_generate", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheaderlist.aspx"));
            BindDataGenerate();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

        BindDataGenerate();
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        ProcessData();
    }
    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        
        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        
        try
        {
            foreach (GridViewRow row in gvwListGenerate.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    DropDownList Currency = ((DropDownList)row.FindControl("ddlCurrencyCode"));
                    string UnitPrice = ((TextBox)row.FindControl("txtUnitPrice")).Text;
                    string SupplierCode = ((TextBox)row.FindControl("txtSupplierCode")).Text;
                    CheckBox chkTermin = ((CheckBox)row.FindControl("chkTermin"));
                    DropDownList ddlIsowner = ((DropDownList)row.Cells[13].Controls[1]);

                    _ht["p_pq_code"] = gvwListGenerate.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_supplier_code"] = SupplierCode;
                    _ht["p_item_code"] = gvwListGenerate.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_currency_code"] = Currency.SelectedValue;
                    _ht["p_unit_price"] = UnitPrice;
                    _ht["p_is_termin"] = ddlIsowner.SelectedValue;

                    // (+) Ari 29-07-2022 ket : enhancement 2022, + Rate
                    string Rate = ((TextBox)row.FindControl("txtRate")).Text;
                    //_ht["p_rate"] = Rate;
                    _ht["p_rate"] = 1;

                    //if (chkTermin.Checked)
                    //    _ht["p_is_termin"] = "1";
                    //else
                    //    _ht["p_is_termin"] = "0";

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_purchase_quotation_detail_update_curr", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheaderlist.aspx"));
            BindDataGenerate();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        SaveData();
    }
    protected void btnDeleteProcess_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListGenerate.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwListGenerate.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataGenerate();
        //BindDataManual();
    }
    
    #endregion
    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListGenerate.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }

    //(+) Ari 11-07-2022 ket : enhancement 2022
    //protected void txtFromDate_TextChanged(object sender, EventArgs e)
    //{
    //    BindDataGenerate();
    //}
    protected void txtToDateChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        BindDataManual();
    }
    protected void txtToDatePOChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        BindDataGenerate();
    }

    protected void ddlBranchPO_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDataGenerate();
    }

   
}
