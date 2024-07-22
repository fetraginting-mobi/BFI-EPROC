using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
public partial class module_accounting_accallocprepaidadjustment : BasePage
{
    private static string TABLE_NAME = "PREPAID_EXPENSE_ADJUSTMENT";
    private static string TABLE_NAME_DETAIL = "PREPAID_EXPENSE_ADJUSTMENT_DETAIL";
    private static string TABLE_NAME_PENCADANGAN = "PENCADANGAN_PREPAID_EXPENSE_ADJUSTMENT_DETAIL";
    private static string TABLE_NAME_AMORTIZATION = "PREPAID_EXPENSE_AMORTIZATION";
    private static string TABLE_NAME_AMORTIZATION_ADJUSTMENT = "PREPAID_EXPENSE_ADJUSTMENT_AMORTIZATION";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../accounting/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);

        if (!Page.IsPostBack)
        {

            btnLookUpExpenseNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=EXPEN&acol_0={0}&bco1_1={1}&cco1_2={2}&dco1_3={3}&eco1_4={4}&fco1_5={5}&gco1_6={6}&hco1_7={7}&ico1_8={8}&jco1_9={9}');",txtExpenseNo.ClientID,txtBranchCode.ClientID,lblBranch.ClientID,txtInvoiceNo.ClientID,txtTransDate.ClientID,txtDescription.ClientID,txtStartDate.ClientID,txtEndDate.ClientID,txtAmount.ClientID,txtTenor.ClientID);
       
            if (Request.Params["action"].Equals("edit"))
            {
                
                LoadData();
                BindDetailAllocation();
                BindDetailPencadangan();
                BindDetailAmortization();
                BindDetailAmortizationAdjustment();
                btnCancel.Text = "Back";
                btnCancel.Text = "<i class='icon-arrow-left'></i> Back";
                btnLookUpExpenseNo.Enabled = false;
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                control_menu();
                
                if (txtInvoiceNo.Text != "")
                {
                    //tabpencadanganlist.Visible = false;
                    Tabpencadanganli.Attributes.Add("style", "display:none");

                    //TabPencadangan.Style.Add("display", "inline");
                }

            }
            else
            {
                pnlDetail.Visible = false;
                divTransDate.Visible = false;
                divBranch.Visible = false;
                divInvoiceNo.Visible = false;
                divStatus.Visible = false;
                divStartDate.Visible= false;
                divEndDate.Visible=false;
                divAmount1.Visible = false;
                divTenor1.Visible = false;
            }
        }
        LoadAfterInit();
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/accounting/accallocprepaidadjustmentlist.aspx";

        //btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0071&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblTransactionNo.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblBranchCode.ClientID, lblAmount.ClientID, lblBranchCode.ClientID, txtDescription.ClientID, lblTransactionNo.ClientID);
       // btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0070&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblTransactionNo.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblBranchCode.ClientID, lblAmount.ClientID, lblBranchCode.ClientID, txtDescription.ClientID, lblTransactionNo.ClientID);
        
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        
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
    private void control_menu()
    {
        if (lblStatus.Text == "NEW")
        {
            btnSave.Visible = btnPost.Visible = true;
        }
        else if (lblStatus.Text == "APPROVE" || lblStatus.Text == "REJECT")
        {
            btnSave.Visible = btnPost.Visible = false;   
            btngenerateAmortAdjust.Visible = false;
  
            txtStartDateNew.Enabled = false;
            txtEndDateNew.Enabled = false;
            txtAmountNew.Enabled = false;
        }
        else if (lblStatus.Text == "ONPROGRESS")
        {

            btnSave.Visible = btnPost.Visible = false;
            btngenerateAmortAdjust.Visible = false;
            txtStartDateNew.Enabled = false;
            txtEndDateNew.Enabled = false;
            txtAmountNew.Enabled = false;

            if (!lblApprovalRequestTargetID.Text.Equals(""))
            {
                btnApprovalTiered.Visible = true;
            }
        }
 
    }
    private void SaveData()
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string sNextCode = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(updMain.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            //_ht["p_code"] = lblCode.Text;
            //_ht["p_id"] = Request.Params["id"];
            _ht["p_transaction_no"] = Request.Params["codebarcode"];

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextCode);
                txtTransactionNo.Text = sNextCode;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("accallocprepaidadjustment.aspx?action=edit&codebarcode={0}", txtTransactionNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void PostData()
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(updMain.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            //_ht["p_code"] = lblCode.Text;
            _ht["p_transaction_no"] = txtTransactionNo.Text;

            _dal.ExecRawSP("xsp_prepaid_allocation_expense_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accallocprepaidadjustment.aspx?action=edit&codebarcode={0}", txtTransactionNo.Text));
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

    protected void btngenerateAmortAdjust_Click(object sender, EventArgs e)
    {
        Amortization();
    }

    private void Amortization()
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(updMain.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            //_ht["p_code"] = lblCode.Text;
            _ht["p_transaction_no"] = txtTransactionNo.Text;

            _dal.ExecRawSP("xsp_prepaid_expense_adjustment_amortization_generate", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accallocprepaidadjustment.aspx?action=edit&codebarcode={0}", txtTransactionNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("accallocprepaidadjustmentlist.aspx"));
    }

    #region DetailPencadangan
    private void BindDetailPencadangan()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchPencadangan.Text;
            _ht["p_transaction_no"] = Request.Params["codebarcode"]; //txtTransactionNo.Text;


            gvwListPencadanganDetail.DataSource = _dal.GetRows(TABLE_NAME_PENCADANGAN, _ht);
            gvwListPencadanganDetail.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListPencadanganDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListPencadanganDetail.PageIndex = e.NewPageIndex;
        BindDetailPencadangan();
    }


    protected void btnSearchPencadangan_Click(object sender, EventArgs e)
    {

        BindDetailPencadangan();
    }

    protected void gvwListPencadanganDetail_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //dOrigCr = dOrigCr + decimal.Parse(e.Row.Cells[8].Text);
            //dOrigDb = dOrigDb + decimal.Parse(e.Row.Cells[7].Text);
            //dBaseCr = dBaseCr + decimal.Parse(e.Row.Cells[11].Text);
            //dBaseDb = dBaseDb + decimal.Parse(e.Row.Cells[10].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            //e.Row.Cells[7].Text = dOrigDb.ToString("N2");
            //e.Row.Cells[8].Text = dOrigCr.ToString("N2");
            //e.Row.Cells[10].Text = dBaseDb.ToString("N2");
            //e.Row.Cells[11].Text = dBaseCr.ToString("N2");
        }
    }



    protected void btnAddPencadangan_Click(object sender, EventArgs e)
    {
        Response.Redirect("accpencadanganexpenseadjustmentdetail.aspx?action=add&codebarcode=" + Request.Params["codebarcode"]);
    }

    protected void btnDeletePencadangan_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListPencadanganDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataDetail(gvwListPencadanganDetail.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindDetailPencadangan();
    }

    private void DeleteDataDetail(string id)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = id;

            _dal.Delete(TABLE_NAME_PENCADANGAN, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }

    protected void gvwListPencadanganDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("accpencadanganexpenseadjustmentdetail.aspx?action=edit&id=" + gvwListPencadanganDetail.SelectedDataKey[0].ToString() + "&codebarcode=" + Request.Params["codebarcode"]);
    }

    #endregion

    #region DetailAllocation
    private void BindDetailAllocation()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchAlloc.Text;
            _ht["p_transaction_no"] = Request.Params["codebarcode"]; //txtTransactionNo.Text;


            gvwListAllocationDetail.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwListAllocationDetail.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListAllocationDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListAllocationDetail.PageIndex = e.NewPageIndex;
        BindDetailAllocation();
    }


    protected void btnSearchAllocation_Click(object sender, EventArgs e)
    {

        BindDetailAllocation();
    }

    protected void gvwListAllocationDetail_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //dOrigCr = dOrigCr + decimal.Parse(e.Row.Cells[8].Text);
            //dOrigDb = dOrigDb + decimal.Parse(e.Row.Cells[7].Text);
            //dBaseCr = dBaseCr + decimal.Parse(e.Row.Cells[11].Text);
            //dBaseDb = dBaseDb + decimal.Parse(e.Row.Cells[10].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            //e.Row.Cells[7].Text = dOrigDb.ToString("N2");
            //e.Row.Cells[8].Text = dOrigCr.ToString("N2");
            //e.Row.Cells[10].Text = dBaseDb.ToString("N2");
            //e.Row.Cells[11].Text = dBaseCr.ToString("N2");
        }
    }



    protected void btnAddAllocation_Click(object sender, EventArgs e)
    {
        Response.Redirect("accallocprepaidexpensedetail.aspx?action=add&codebarcode=" + Request.Params["codebarcode"]);
    }

    protected void btnDeleteAllocation_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListAllocationDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataDetailAllocation(gvwListAllocationDetail.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindDetailAllocation();
    }

    private void DeleteDataDetailAllocation(string id)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = id;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }

    protected void gvwListAllocationDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("accallocprepaidexpenseadjustmentdetail.aspx?action=edit&id=" + gvwListAllocationDetail.SelectedDataKey[0].ToString() + "&codebarcode=" + Request.Params["codebarcode"]);
    }

    #endregion

    #region DetailAmortization
    private void BindDetailAmortization()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchAmortization.Text;
            _ht["p_transaction_no"] = Request.Params["codebarcode"]; //txtTransactionNo.Text;

            gvwListAmortizationDetail.DataSource = _dal.GetRows(TABLE_NAME_AMORTIZATION, _ht);
            gvwListAmortizationDetail.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListAmortizationDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListAmortizationDetail.PageIndex = e.NewPageIndex;
        BindDetailAmortization();
    }


    protected void btnSearchAmortization_Click(object sender, EventArgs e)
    {

        BindDetailAmortization();
    }

    protected void gvwListAmortizationDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //dOrigCr = dOrigCr + decimal.Parse(e.Row.Cells[8].Text);
            //dOrigDb = dOrigDb + decimal.Parse(e.Row.Cells[7].Text);
            //dBaseCr = dBaseCr + decimal.Parse(e.Row.Cells[11].Text);
            //dBaseDb = dBaseDb + decimal.Parse(e.Row.Cells[10].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            //e.Row.Cells[7].Text = dOrigDb.ToString("N2");
            //e.Row.Cells[8].Text = dOrigCr.ToString("N2");
            //e.Row.Cells[10].Text = dBaseDb.ToString("N2");
            //e.Row.Cells[11].Text = dBaseCr.ToString("N2");
        }
    }



    protected void btnAddAmortization_Click(object sender, EventArgs e)
    {
        Response.Redirect("accallocprepaidexpensedetail.aspx?action=add&codebarcode=" + Request.Params["codebarcode"]);
    }

    protected void btnDeleteAmortization_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListAmortizationDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataDetailAmortization(gvwListAmortizationDetail.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindDetailAmortization();
    }

    private void DeleteDataDetailAmortization(string id)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = id;

            _dal.Delete(TABLE_NAME_AMORTIZATION, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }

    protected void gvwListAmortizationDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("accallocprepaidexpensedetail.aspx?action=edit&id=" + gvwListAmortizationDetail.SelectedDataKey[0].ToString() + "&codebarcode=" + Request.Params["codebarcode"]);
    }

    #endregion

    #region DetailAmortizationAdjustment
    private void BindDetailAmortizationAdjustment()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchAmortAdjust.Text;
            _ht["p_transaction_no"] = Request.Params["codebarcode"]; //txtTransactionNo.Text;

            gvwListAmortizationAdjustmentDetail.DataSource = _dal.GetRows(TABLE_NAME_AMORTIZATION_ADJUSTMENT, _ht);
            gvwListAmortizationAdjustmentDetail.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListAmortizationAdjustmentDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListAmortizationAdjustmentDetail.PageIndex = e.NewPageIndex;
        BindDetailAmortizationAdjustment();
    }


    protected void btnSearchAmortizationAdjustment_Click(object sender, EventArgs e)
    {

        BindDetailAmortizationAdjustment();
    }

    protected void gvwListAmortizationAdjustmentDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //dOrigCr = dOrigCr + decimal.Parse(e.Row.Cells[8].Text);
            //dOrigDb = dOrigDb + decimal.Parse(e.Row.Cells[7].Text);
            //dBaseCr = dBaseCr + decimal.Parse(e.Row.Cells[11].Text);
            //dBaseDb = dBaseDb + decimal.Parse(e.Row.Cells[10].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            //e.Row.Cells[7].Text = dOrigDb.ToString("N2");
            //e.Row.Cells[8].Text = dOrigCr.ToString("N2");
            //e.Row.Cells[10].Text = dBaseDb.ToString("N2");
            //e.Row.Cells[11].Text = dBaseCr.ToString("N2");
        }
    }

    protected void btnAddAmortizationAdjustment_Click(object sender, EventArgs e)
    {
        Response.Redirect("accallocprepaidexpensedetail.aspx?action=add&codebarcode=" + Request.Params["codebarcode"]);
    }

    protected void btnDeleteAmortizationAdjustment_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListAmortizationDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataDetailAmortizationAdjustment(gvwListAmortizationAdjustmentDetail.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindDetailAmortizationAdjustment();
    }

    private void DeleteDataDetailAmortizationAdjustment(string id)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = id;

            _dal.Delete(TABLE_NAME_AMORTIZATION_ADJUSTMENT, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }

    protected void gvwListAmortizationAdjustmentDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("accallocprepaidexpensedetail.aspx?action=edit&id=" + gvwListAmortizationAdjustmentDetail.SelectedDataKey[0].ToString() + "&codebarcode=" + Request.Params["codebarcode"]);
    }

    #endregion
}
