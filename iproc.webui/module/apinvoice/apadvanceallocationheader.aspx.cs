using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apinvoice_apadvanceallocationheader : BasePage
{

    private static string TABLE_NAME_HEADER = "AP_ADVANCE_ALLOCATION_HEADER";
    private static string TABLE_NAME_DETAIL = "AP_ADVANCE_ALLOCATION_DETAIL";
    private static string TABLE_NAME_AP_ADVANCE_REGISTRATION_LIST = "AP_ADVANCE_ALLOCATION_ADVANCE";


    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        if (!Page.IsPostBack)
        {
            //btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=STAFF&acol_0={0}&bcol_1={1}');", txtUserRequest.ClientID, lblUserRequest.ClientID);
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtUserRequestCode.ClientID, txtUserRequest.ClientID);
            //btnLookUpALCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LADRG&acol_0={0}&bcol_1={1}&ccol_3={2}&dcol_3={3}&ecol_4={4}');", txtAdvanceCode.ClientID, lblALCode.ClientID, txtAdvanceAmount.ClientID, txtSaldoAdvance.ClientID, txtReffAdvanceNo.ClientID);

            //txtAdvanceAllocation.Enabled = false;
            //txtAdvanceEndingBalance.Enabled = false;

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranch(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
          

            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
            // ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
            ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;

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
                btnDeleteAdvance.OnClientClick = "return confirm('Delete selected data?');";
                BindDataadvance();


                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = btnAddAdvance.Visible = btnDeleteAdvance.Visible = false;
                    txtReferenceNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnGenerateAdvance.Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    btnGenerate.Visible = false;
                    btnSaveInvoice.Visible = false;
                    gvwList.Columns[1].Visible = false;
                    gvwListAdvance.Columns[1].Visible = false;

                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = btnAddAdvance.Visible = btnDeleteAdvance.Visible = false;
                    txtReferenceNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnGenerateAdvance.Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    btnGenerate.Visible = false;
                    btnSaveInvoice.Visible = false;
                    gvwList.Columns[1].Visible = false;
                    gvwListAdvance.Columns[1].Visible = false;

                    if (!lblApprovalRequestTargetID.Text.Equals(""))
                        btnApprovalTiered.Visible = true;

                } 

            }
            else
            {
                btnReject.Visible = btnPost.Visible = false;
                btnAdd.Visible = btnDelete.Visible = false;
                btnAddAdvance.Visible = btnDeleteAdvance.Visible = false;
                pnlAllocation.Visible = false;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);

                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                txtAllocationDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtAllocationDate.Enabled = false;

            }
            //btnAddAdvance.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericmultiple.aspx?code=ARA&par_ap_code_barcode={0}&par_emp_code={1}');", lblCodeBarcode.Text, txtUserRequest.Text);

           
            
        }
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000029&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000030&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
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

            Shared.ShowSuccessGritter(this, string.Format("apadvanceallocationheader.aspx?action=edit&codebarcode={0}&empcode={1}", lblCodeBarcode.Text, txtUserRequest.Text));
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

            _dal.ExecRawSP("xsp_ap_advance_allocation_header_post", _ht);


            Shared.ShowSuccessGritter(this, string.Format("apadvanceallocationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

            _dal.ExecRawSP("xsp_ap_advance_allocation_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apadvanceallocationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);

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


    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("apadvanceallocationheaderlist.aspx");
    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }
    protected void btnReject_Click(object sender, EventArgs e)
    {
        CancelData();
    }


    #region Advance Allocation detail
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
        Response.Redirect("apadvanceallocationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&empcode=" + txtUserRequestCode.Text);
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

        BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("apadvanceallocationdetail.aspx?action=edit&id={0}&codebarcode={1}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
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

            _dal.ExecRawSP("xsp_ap_advance_allocation_detail_generate", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apadvanceallocationheader.aspx?action=edit&codebarcode={0}&empcode={1}", lblCodeBarcode.Text, txtUserRequestCode.Text));
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
                    string AllocationAdvance = ((TextBox)row.Cells[6].Controls[1]).Text;

                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_allocation_advance"] = AllocationAdvance;
                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_ap_advance_allocation_detail_update_allocation_advance", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("apadvanceallocationheader.aspx?action=edit&codebarcode={0}&empcode={1}", lblCodeBarcode.Text, txtUserRequestCode.Text));
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
            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();

                TextBox txtAllocationAdvance = (TextBox)e.Row.FindControl("txtAllocationAdvance");

                _ht["p_id"] = gvwList.DataKeys[e.Row.RowIndex][0].ToString();

                DataRow _dr = _dal.GetRow("", "xsp_ap_advance_allocation_detail_getrow", _ht);
                code = _dr["CODE"].ToString();
                txtAllocationAdvance.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ALLOCATION_ADVANCE"));

            }
            catch (Exception)
            {
            }

        }
    }
    #endregion


    #region Advance List
    private void BindDataadvance()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchAdvance.Text;
            _ht["p_code_barcode"] = lblCodeBarcode.Text;

            gvwListAdvance.DataSource = _dal.GetRows(TABLE_NAME_AP_ADVANCE_REGISTRATION_LIST, _ht);
            gvwListAdvance.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataAdvanceList(string CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = CODE;

            _dal.Delete(TABLE_NAME_AP_ADVANCE_REGISTRATION_LIST, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListAdvance_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListAdvance.PageIndex = e.NewPageIndex;
        BindDataadvance();
    }

    protected void btnAddAdvance_Click(object sender, EventArgs e)
    {
        Response.Redirect("apadvanceallocationadvance.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&empcode=" + txtUserRequestCode.Text);
    }

    protected void btnDeleteAdvance_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListAdvance.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataAdvanceList(gvwListAdvance.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataadvance();
    }

    protected void btnSearchAdvance_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindDataadvance();
    }
    protected void gvwListAdvance_SelectedIndexChanged(object sender, EventArgs e)
    {

        Response.Redirect(string.Format("apadvanceallocationadvance.aspx?action=edit&id={0}&codebarcode={1}&empcode={2}", gvwListAdvance.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, txtUserRequestCode.Text));
    }

    protected void chbCheckedAllAdvance_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListAdvance.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    private void GenerateDataAdvance()
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

            _dal.ExecRawSP("xsp_ap_advance_allocation_advance_generate", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apadvanceallocationheader.aspx?action=edit&codebarcode={0}&empcode={1}", lblCodeBarcode.Text, txtUserRequestCode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnGenerateAdvance_Click(object sender, EventArgs e)
    {
        GenerateDataAdvance();
    }

   
    #endregion
}
