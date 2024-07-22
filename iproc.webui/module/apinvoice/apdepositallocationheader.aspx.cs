using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apinvoice_apdepositallocationheader : BasePage
{

    private static string TABLE_NAME_HEADER = "AP_DEPOSIT_ALLOCATION_HEADER";
    private static string TABLE_NAME_DETAIL = "AP_DEPOSIT_ALLOCATION_DETAIL";
    private static string TABLE_NAME_AP_DEPOSIT_REGISTRATION_LIST = "AP_DEPOSIT_ALLOCATION_DEPOSIT";


    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        //LinkButton btn = btnViewHistory as LinkButton;
        //btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            //btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=STAFF&acol_0={0}&bcol_1={1}');", txtUserRequest.ClientID, lblUserRequest.ClientID);
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=POADV&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtReferenceNo.ClientID, txtPoNo.ClientID, txtBranch.ClientID);
            //btnLookUpALCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LADRG&acol_0={0}&bcol_1={1}&ccol_3={2}&dcol_3={3}&ecol_4={4}');", txtdepositCode.ClientID, lblALCode.ClientID, txtdepositAmount.ClientID, txtSaldodeposit.ClientID, txtReffdepositNo.ClientID);
            btnAddDetail.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=DEALO&parc_deposit_allocation_code={0}&gvw={1}');", txtReferenceNo.ClientID, btnSearch.UniqueID);
            //txtdepositAllocation.Enabled = false;
            //txtdepositEndingBalance.Enabled = false;
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranch(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);


            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
            // ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
          
            ddlBranch.Enabled = false;

            if (Request.Params["action"].Equals("edit"))
            {

                LoadData();

                txtAllocationDate.Enabled = false;
                btnLookUpUserRequest.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                txtAllocationDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtAllocationDate.Enabled = false;
             


                BindData();
                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                btnDeletedeposit.OnClientClick = "return confirm('Delete selected data?');";
                BindDatadeposit();
                BindDataHist();


                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = btnAdddeposit.Visible = btnDeletedeposit.Visible = false;
                    txtReferenceNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnGeneratedeposit.Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    btnGenerate.Visible = false;
                    btnSaveInvoice.Visible = false;
                    gvwList.Columns[1].Visible = false;
                    gvwListdeposit.Columns[1].Visible = false;
                    txtdepositAllocationAmount.Enabled = false;
                    btnAddDetail.Visible = false;
                    
                  
                   
                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = btnAdddeposit.Visible = btnDeletedeposit.Visible = false;
                    txtReferenceNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnGeneratedeposit.Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    btnGenerate.Visible = false;
                    btnSaveInvoice.Visible = false;
                    gvwList.Columns[1].Visible = false;
                    gvwListdeposit.Columns[1].Visible = false;
                     txtdepositAllocationAmount.Enabled = false;
                    btnAddDetail.Visible = false;

                    if (!lblApprovalRequestTargetID.Text.Equals(""))
                        btnApprovalTiered.Visible = true;

                }

            }
            else
            {
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);

                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                txtAllocationDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtAllocationDate.Enabled = false;


              
                btnReject.Visible = btnPost.Visible = false;
                btnAdd.Visible = btnDelete.Visible = false;
                btnAdddeposit.Visible = btnDeletedeposit.Visible = false;
                pnlAllocation.Visible = false;
                
            }
            //btnAdddeposit.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericmultiple.aspx?code=ARA&par_ap_code_barcode={0}&par_emp_code={1}');", lblCodeBarcode.Text, txtUserRequest.Text);

            Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/apinvoice/apdepositallocationheaderlist.aspx";

        }
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000046&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "PROCESSED", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000046&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000047&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
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

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            _ht["p_supplier_code"] = Request.Params["empcode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

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
        string sNextBarcode = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("apdepositallocationheader.aspx?action=edit&codebarcode={0}&pono={1}", lblCodeBarcode.Text, txtPoNo.Text));
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

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            _dal.ExecRawSP("xsp_ap_deposit_allocation_header_post", _ht);


            Shared.ShowSuccessGritter(this, string.Format("apdepositallocationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void CancelData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_ap_deposit_allocation_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apdepositallocationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
      

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

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        BindDatadeposit();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("apdepositallocationheaderlist.aspx");
    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }
    protected void btnReject_Click(object sender, EventArgs e)
    {
        CancelData();
    }


    #region deposit Allocation detail
    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_code_barcode"] = lblCodeBarcode.Text;
            _ht["p_reff_no"] = txtReferenceNo.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
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

            _ht["p_id"] = code;

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
        BindData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("apdepositallocationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&pono=" + txtPoNo.Text);
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
        Response.Redirect("apdepositallocationheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text);

        BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("apdepositallocationdetail.aspx?action=edit&id={0}&codebarcode={1}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwList.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    private void GenerateData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_ap_deposit_allocation_detail_generate", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apdepositallocationheader.aspx?action=edit&codebarcode={0}&pono={1}", lblCodeBarcode.Text, txtPoNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GenerateData();
    }

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
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

    private void SaveDataInvoice()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        // 

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
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    string Allocationdeposit = ((TextBox)row.Cells[4].Controls[1]).Text;

                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_code_barcode"] = txtReferenceNo.Text;
                    _ht["p_allocation_deposit"] = Allocationdeposit;
                    _ht["p_code_header"] = lblCodeBarcode.Text;

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_ap_deposit_allocation_detail_update_allocation_deposit", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("apdepositallocationheader.aspx?action=edit&codebarcode={0}&pono={1}", lblCodeBarcode.Text, txtPoNo.Text));
            //GenerateData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSaveInvoice_Click(object sender, EventArgs e)
    {
        SaveDataInvoice();
    }

    protected void gvwListGenerate_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            GeneralDAL _dal = null;
            Hashtable _ht = null;
            string code = "";
            string status = "";
            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();

                TextBox txtAllocationdeposit = (TextBox)e.Row.FindControl("txtAllocationdeposit");
                TextBox txtStatus = (e.Row.FindControl("txtStatus") as TextBox);

                _ht["p_id"] = gvwList.DataKeys[e.Row.RowIndex][0].ToString();

                DataRow _dr = _dal.GetRow("", "xsp_ap_deposit_allocation_detail_getrow", _ht);
                code = _dr["CODE"].ToString();
                status = _dr["DEPOSIT_STATUS"].ToString();
                txtAllocationdeposit.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ALLOCATION_deposit"));
                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ONPROGRESS")
                {
                    txtAllocationdeposit.Enabled = false;
                }
                if (_dr["DEPOSIT_STATUS"].ToString() == "POST")
                {
                    txtAllocationdeposit.Enabled = false;
                }
                else
                {
                    txtAllocationdeposit.Enabled = true;
                }

            }
            catch (Exception ex)
            {
            }

        }
    }
    #endregion


    #region deposit List
    private void BindDatadeposit()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchdeposit.Text;
            _ht["p_code_barcode"] = lblCodeBarcode.Text;

            gvwListdeposit.DataSource = _dal.GetRows(TABLE_NAME_AP_DEPOSIT_REGISTRATION_LIST, _ht);
            gvwListdeposit.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDatadepositList(string CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = CODE;

            _dal.Delete(TABLE_NAME_AP_DEPOSIT_REGISTRATION_LIST, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListdeposit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListdeposit.PageIndex = e.NewPageIndex;
        BindDatadeposit();
    }

    protected void btnAdddeposit_Click(object sender, EventArgs e)
    {
        Response.Redirect("apdepositalocationdeposit.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&pono=" + txtPoNo.Text);
    }

    protected void btnDeletedeposit_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListdeposit.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDatadepositList(gvwListdeposit.DataKeys[row.RowIndex][0].ToString());
            }
        }
        Response.Redirect("apdepositallocationheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text);
        //BindDatadeposit();
        //ScriptManager.RegisterStartupScript(this, GetType(), "dp", "javascript:document.getElementById('"+btnRefresh.ClientID +"').click();", true);
    }

    

    protected void btnSearchdeposit_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindDatadeposit();
    }
    protected void gvwListdeposit_SelectedIndexChanged(object sender, EventArgs e)
    {

        Response.Redirect(string.Format("apdepositalocationdeposit.aspx?action=edit&id={0}&codebarcode={1}&pono={2}", gvwListdeposit.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, txtPoNo.Text));
    }

    protected void chbCheckedAlldeposit_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListdeposit.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    private void GenerateDatadeposit()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_code_barcode"] = Request.Params["codebarcode"];

            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_ap_deposit_allocation_deposit_generate", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apdepositallocationheader.aspx?action=edit&codebarcode={0}&pono={1}", lblCodeBarcode.Text, txtPoNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnGeneratedeposit_Click(object sender, EventArgs e)
    {
        GenerateDatadeposit();
    }


    #endregion

    #region history
    private void BindDataHist()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_code_barcode"] = lblCodeBarcode.Text;
            _ht["p_reff_no"] = txtReferenceNo.Text;

            gvwListHis.DataSource = _dal.GetRows("", "xsp_ap_deposit_allocation_detail_history_getrows", _ht);
            gvwListHis.DataBind();

        }

        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListhistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListHis.PageIndex = e.NewPageIndex;
        BindDataHist();
    }



    protected void btnSearchhistory_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindDataHist();
    }

 
   
   
  
    

    #endregion
}