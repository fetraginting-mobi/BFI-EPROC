using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apadvanceanddeposit_apdepositrefundheader : BasePage
{
    private static string TABLE_NAME_HEADER = "AP_DEPOSIT_REFUND_HEADER";
    private static string TABLE_NAME_DETAIL = "AP_DEPOSIT_REFUND_DETAIL";
    

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyCode(ddlCurrencyCode);
            Shared.BindGeneralSubCode(ddlBankCode, "BANKLIST");
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;

            btnLookUpSupplier.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtSupplier.ClientID, lblSupplier.ClientID);
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DEPAL&acol_0={0}&bcol_1={1}&ccol_4={2}&dcol_4={3}&ecol_2={4}&fcol_5={5}&parc_branch_code={6}');", lblReffNo.ClientID, txtReffNo.ClientID, lblAmount.ClientID, txtAmount.ClientID,lblSupplier.ClientID,txtSupplier.ClientID ,txtBranch.ClientID);
            

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                btnCancel.Text = "Back";

                BindData();
                 
                btnPost.OnClientClick = "return confirm('Post selected data?');";
                btnReject.OnClientClick = "return confirm('Cancel selected data?');";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
               // txtAllocationDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtRefundDate.Enabled = false;
                btnLookUpSupplier.Enabled = false;
                btnReject.Visible = false;


                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "PAID")
                {
                    btnSave.Visible = btnPost.Visible = false;
                    btnReject.Visible = false;
                    btnPost.Visible = false;
                    txtRefundDate.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    txtDescription.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    ddlBankCode.Enabled = false;
                    rblPaymentMethodCode.Enabled = false;
                    btnLookUpUserRequest.Enabled = false;
                    btnApprovalTiered.Visible = false;
                }

                if (lblTransFlagCode.Text == "UNPAID")
                {
                    btnReject.Visible = true;
                    btnPost.Visible = false;
                    btnSave.Visible = false;
                    txtRefundDate.Enabled = false;
                    btnLookUpSupplier.Enabled = false;
                    txtDescription.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    ddlBankCode.Enabled = false;
                    rblPaymentMethodCode.Enabled = false;
                    btnLookUpUserRequest.Enabled = false;
                    btnApprovalTiered.Visible = false;
                   
                }

              
            }
            else
            {
                btnReject.Visible = btnPost.Visible = false;
                txtRefundDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtRefundDate.Enabled = false;
                btnLookUpSupplier.Enabled = false;
                btnApprovalTiered.Visible = false;
            }
            Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/apadvanceanddeposit/apdepositrefundheaderlist.aspx";
        }

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000054&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "PROCESSED", lblBranch.ClientID, lblAmount.ClientID, lblBranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000046&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000054&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblBranch.ClientID);
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

            Shared.ShowSuccessGritter(this, string.Format("apdepositrefundheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

            _dal.ExecRawSP("xsp_ap_deposit_refund_header_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apdepositrefundheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

            _dal.ExecRawSP("xsp_ap_deposit_refund_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("apdepositrefundheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    protected void btnReject_Click(object sender, EventArgs e)
    {
        CancelData();
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("apdepositrefundheaderlist.aspx");
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("apdepositrefunddetail.aspx?action=edit&id={0}&codebarcode={1}" , gvwList.SelectedDataKey[0].ToString(),lblCodeBarcode.Text));
    }

    

}