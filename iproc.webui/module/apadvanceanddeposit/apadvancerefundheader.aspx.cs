using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apadvanceanddeposit_apadvancerefundheader : BasePage
{
    private static string TABLE_NAME_DETAIL = "AP_ADVANCE_REFUND_DETAIL";
    private static string TABLE_NAME_HEADER = "AP_ADVANCE_REFUND_HEADER";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtUserRequest.ClientID, lblUserRequest.ClientID);
            btnLookUpAdvance.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LADRE&acol_0={0}&bcol_1={1}&dcol_3={2}&parc_supplier_code={3}');", txtAdvanceCode.ClientID, lblAdvanceCode.ClientID, txtAmount.ClientID, txtUserRequest.ClientID);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);

            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
               // btnDeleteRequestDetail.OnClientClick = "return confirm('Delete selected data?');";
                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnReject.OnClientClick = "return confirm('Cancel selected data?');";

                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    ddlBranch.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    btnLookUpAdvance.Enabled = false;
                    btnLookUpUserRequest.Enabled = false;
                    txtAmount.Enabled = false;
                    txtRemarks.Enabled = false;
                   // btnAddRequestDetail.Visible = btnDeleteRequestDetail.Visible = false;

                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    ddlBranch.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    btnLookUpAdvance.Enabled = false;
                    btnLookUpUserRequest.Enabled = false;
                    txtAmount.Enabled = false;
                    txtRemarks.Enabled = false;
                    // btnAddRequestDetail.Visible = btnDeleteRequestDetail.Visible = false;

                    if (!lblApprovalRequestTargetID.Text.Equals(""))
                        btnApprovalTiered.Visible = true;

                } 
                if (lblProcess.Text == "GNR")
                {

                    btnLookUpAdvance.Enabled = true;
                }
                else
                {
                    btnLookUpAdvance.Enabled = false;
                }
            }
            else
               
            {
                btnReject.Visible = btnPost.Visible = false;

               
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
               // btnAddRequestDetail.Visible = btnDeleteRequestDetail.Visible = false;
            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/apadvanceanddeposit/apadvancerefundheaderlist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000041&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000042&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID, lblCode.ClientID);
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
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            DBToUI.Map(this.Controls, _dr);

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
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
            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("apadvancerefundheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    //        _dal.ExecRawSP("xsp_ap_advance_refund_header_post", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("apadvancerefundheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    //        _dal.ExecRawSP("xsp_ap_advance_refund_header_cancel", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("apadvancerefundheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //protected void btnPost_Click(object sender, EventArgs e)
    //{
    //    PostData();
    //}

    //protected void btnReject_Click(object sender, EventArgs e)
    //{
    //    CancelData();
    //}


    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("apadvancerefundheaderlist.aspx");
    }
    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        //updDep.Update();
    }



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

    protected void btnAddRequestDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect("apadvancerefunddetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
    }

    protected void btnDeleteRequestDetail_Click(object sender, EventArgs e)
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
       Response.Redirect(string.Format("apadvancerefunddetail.aspx?action=edit&id={0}&codebarcode={1}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
    }

   
}