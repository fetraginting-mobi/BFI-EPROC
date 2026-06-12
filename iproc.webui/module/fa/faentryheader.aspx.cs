using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_faentryheader : BasePage
{


    private static string TABLE_NAME_HEADER = "FA_ENTRY_HEADER";
    private static string TABLE_NAME_DETAIL = "FA_ENTRY_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {
            //btnLookUpRequestoro.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=RQEN&acol_0={0}&bcol_1={1}&ccol_2={2}');", txtRequestorCode.ClientID, lblRequestorName.ClientID, ddlBranch.ClientID);
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);
            Shared.BindFaLocationAllMut(ddlLocation, ddlBranch.SelectedValue);
          
           

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
                Shared.BindFaLocationAll(ddlLocation, ddlBranch.SelectedValue);
                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
                txtEntryDate.Enabled = false;
                ddlBranch.Enabled = false;
                ddlLocation.Enabled = false;
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
               
               

                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnReject.OnClientClick = "return confirm('Cancel selected data?');";

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ONPROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    txtEntryDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlBranch.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlLocation.Enabled = false;
                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    txtEntryDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlBranch.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlLocation.Enabled = false;
                }
                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;

            }
            else
            {
                btnReject.Visible = pnlEntry.Visible = btnPost.Visible = false;
                btnAdd.Visible = btnDelete.Visible = false;
                txtEntryDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtEntryDate.Enabled = false;
            }
        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/fa/faentryheaderlist.aspx";
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000031&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "PROCESSED", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000031&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
       // btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000032&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000032&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("faentryheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_fa_entry_header_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("faentryheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

            _dal.ExecRawSP("xsp_fa_entry_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("faentryheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

        Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);
        Shared.BindFaLocationAllMut(ddlLocation, ddlBranch.SelectedValue);
        //updDep.Update();
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("faentryheaderlist.aspx");
    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }
    protected void btnReject_Click(object sender, EventArgs e)
    {
        CancelData();
    }

    #region fa entry detail

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

    private string GetHeaderStatus(DataRow dr)
    {
        string status = string.Empty;

        if (dr == null)
            return string.Empty;

        if (dr.Table.Columns.Contains("FE_STATUS"))
        {
            status = dr["FE_STATUS"].ToString();
            if (!string.IsNullOrEmpty(status.Trim()))
                return status;
        }

        if (dr.Table.Columns.Contains("TRANS_FLAG_CODE"))
        {
            status = dr["TRANS_FLAG_CODE"].ToString();
            if (!string.IsNullOrEmpty(status.Trim()))
                return status;
        }

        if (dr.Table.Columns.Contains("TRANS_FLAG_DESC"))
            return dr["TRANS_FLAG_DESC"].ToString();

        return string.Empty;
    }

    private bool IsCurrentHeaderNew()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        _ht["p_code_barcode"] = lblCodeBarcode.Text;
        DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

        return GetHeaderStatus(_dr).Trim().Equals("NEW", StringComparison.OrdinalIgnoreCase);
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (!IsCurrentHeaderNew())
            {
                Shared.ShowValidationError(this, "FA Entry status must be NEW to add detail.");
                return;
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        Response.Redirect("faentrydetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
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
        Response.Redirect(string.Format("faentrydetail.aspx?action=edit&codebarcode={0}&id={1}&idartarget={2}", lblCodeBarcode.Text, gvwList.SelectedDataKey[0].ToString(), Request.Params["idartarget"]));
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwList.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    #endregion


}
