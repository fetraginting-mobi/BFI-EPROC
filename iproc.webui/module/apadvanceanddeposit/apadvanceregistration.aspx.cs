using System;
using System.Data;
using System.Collections;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_apadvanceanddeposit_apadvanceregistration : BasePage
{
    private static string TABLE_NAME = "AP_ADVANCE_REGISTRATION";

    private static string TABLE_NAME_DETAIL = "AP_ADVANCE_REGISTRATION_DETAIL";
    private static string TABLE_NAME_PO = "AP_ADVANCE_REGISTRATION_PO";


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();


        if (!Page.IsPostBack)
        {
            ////Shared.BindCurrency(ddlCurrencyCode);
            Shared.BindGeneralSubCode(ddlCurrencyCode, "CUR");
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);



            ddlBranch.Enabled = false;
            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
            ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtUserRequestCode.ClientID, txtUserRequest.ClientID);
            ScriptManager.RegisterStartupScript(this, GetType(), "fx1", "tab();", true);
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                BindData();
                BindDataPO();
                btnDeleteDetail.OnClientClick = "return confirm('Delete selected data?');";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                txtAdvanceDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtAdvanceDate.Enabled = false;
                // btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnBack.OnClientClick = "return confirm('Cancel selected data?');";

                chbFlagPo.Enabled = false;
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (chbFlagPo.Checked)
                {
                    liDetail.Visible = false;
                    liPo.Visible = true;


                }

                else
                {
                    ////btnBack.Visible = btnPost.Visible = 
                    //btnPrint.Visible = false;
                    //btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                    //pnlAdvanceRegis.Visible = false;
                    liDetail.Visible = true;
                    liPo.Visible = false;
                }

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnBack.Visible = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                    txtAdvanceDate.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    btnLookUpUserRequest.Enabled = false;
                    txtDescription.Enabled = false;
                    txtReferenceNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    btnPrint.Visible = true;
                    btnAddDetail.Visible = false;
                    btnDeleteDetail.Visible = false;
                    btnAddPo.Visible = false;
                    btnDeletePo.Visible = false;

                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnBack.Visible = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                    txtAdvanceDate.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    btnLookUpUserRequest.Enabled = false;
                    txtDescription.Enabled = false;
                    txtReferenceNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    btnPrint.Visible = false;
                    ddlUnits.Enabled = false;
                    btnAddDetail.Visible = false;
                    btnDeleteDetail.Visible = false;
                    btnAddPo.Visible = false;
                    btnDeletePo.Visible = false;

                    if (!lblApprovalRequestTargetID.Text.Equals(""))
                        btnApprovalTiered.Visible = true;

                }
               





            }
            else
            {
                btnPost.Visible = btnBack.Visible = false;
                btnPrint.Visible = false;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                //ddlUnits.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                Shared.BindDivision(ddlDivision);
                txtAdvanceDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtAdvanceDate.Enabled = false;

          
            }
            btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000025&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
            btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");

            btnBack.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000026&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);

            LoadAfterInit();
        }
    }

    #region  Header
    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];

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
        String sNextBarcode = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("apadvanceregistration.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void PostData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //        Shared.ApplyDefaultProp(_ht);

    //        _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
    //        //_ht["p_barcode_advance"] = lblCodeBarcode.Text;

    //        _dal.ExecRawSP("xsp_ap_advance_registration_post", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("apadvanceregistration.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //private void CancelData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //        Shared.ApplyDefaultProp(_ht);

    //        _dal.ExecRawSP("xsp_ap_advance_registration_cancel", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("apadvanceregistration.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("apadvanceregistrationlist.aspx");
    }

    //protected void btnPost_Click(object sender, EventArgs e)
    //{
    //    PostData();
    //}

    //protected void btnBack_Click(object sender, EventArgs e)
    //{
    //    CancelData();
    //}

    #endregion

    #region  Detail
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
    private void DeleteDataapadvanceregistrationdetail(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;
            _ht["p_ar_code"] = lblCodeBarcode.Text;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnAddDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect("apadvanceregistrationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&departmentcode=" + ddlDepartment.SelectedItem + "&divisioncode=" + ddlDivision.SelectedItem );
    }

    protected void btnDeleteDetail_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataapadvanceregistrationdetail(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindData();
        Response.Redirect(string.Format("apadvanceregistration.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("apadvanceregistrationdetail.aspx?action=edit&id={0}&codebarcode={1}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));

    }
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }
 

    #endregion

    #region  PO
    private void BindDataPO()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchPo.Text;
            _ht["p_ar_no"] = lblCodeBarcode.Text;

            gvwListPo.DataSource = _dal.GetRows(TABLE_NAME_PO, _ht);
            gvwListPo.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void DeleteDataPO(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;
             

            _dal.Delete(TABLE_NAME_PO, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnAddPo_Click(object sender, EventArgs e)
    {
        Response.Redirect("apadvanceregistrationpo.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&departmentcode=" + ddlDepartment.SelectedItem + "&divisioncode=" + ddlDivision.SelectedItem + "&suppliercode=" + txtUserRequestCode.Text);
    }

    protected void btnDeletePo_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListPo.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataPO(gvwListPo.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataPO();
        Response.Redirect(string.Format("apadvanceregistration.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    }

    protected void btnSearchPo_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindDataPO();
    }
    protected void gvwListPo_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("apadvanceregistrationpo.aspx?action=edit&id={0}&codebarcode={1}", gvwListPo.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));

    }
    protected void gvwListPo_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListPo.PageIndex = e.NewPageIndex;
        BindDataPO();
    }

    #endregion

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_code_barcode"] = lblCodeBarcode.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_AP_ADVANCE_REGISTRATION", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
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

        //Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);

        //updDep.Update();
    }


}