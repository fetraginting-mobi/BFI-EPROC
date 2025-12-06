using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_verifikasirequestheader : BasePage
{
    //private static string TABLE_NAME_HEADER = "PURCHASE_REQUEST_HEADER";
    private static string TABLE_NAME_DETAIL = "PURCHASE_REQUEST_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

      

        if (!Page.IsPostBack)
        {
            //Shared.BindDepartment(ddlDepartment, string.Empty);
            //Shared.BindCostCenter(ddlCostCenter);

            //btnDelete.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
               
                LoadData();
                btnViewDocument.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/documentrequest.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
                BindPRDetail();
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";

                //if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "UN-POST" || lblTransFlagCode.Text == "VERIFIED")
                //{
                //    btnPost.Visible =  btnUnPost.Visible = false;
                //    btnSaveChecklist.Visible = false;
                //    //btnAdd.Visible = btnDelete.Visible = false;
                //}        

                if (lblTransFlagCode.Text == "PROCESSED")
                {
                    //btnUnPost.Visible = false;
                }
            }
            else
            {
                lblRequestorUID.Text = Shared.CurrentUID;
                lblRequestor.Text = Shared.CurrentEmpName;

                btnPost.Visible = false;
                //btnAdd.Visible = btnDelete.Visible =  false;
                pnlPurchaseRequest.Visible = false;
            }
        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/verifikasirequestheaderlist.aspx";


       // btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000033&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "VERIFI", lblBranchCode.ClientID, lblCode.ClientID);
        //btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnUnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000034&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "UN-POST", lblBranchCode.ClientID, lblCode.ClientID);
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
            DataRow _dr = _dal.GetRow("","xsp_purchase_request_header_getrow_verifikasi", _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("verifikasirequestheaderlist.aspx");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }


    //protected void btnPrint_Click(object sender, EventArgs e)
    //{
    //    Hashtable htParams = new Hashtable();
    //    htParams["p_user_id"] = Shared.CurrentUID;
    //    htParams["p_code_barcode"] = lblCodeBarcode.Text;

    //    string sFilename = "";

    //    if (ddlType.SelectedValue == "R")
    //    {
    //        sFilename = Shared.ExecuteReport(this, "RPT_PURCHASE_REQUEST_ROUTINE", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

    //        Shared.PreviewReport(this, sFilename);
    //    }
    //    else
    //    {
    //        sFilename = Shared.ExecuteReport(this, "RPT_PURCHASE_REQUEST_NON_ROUTINE", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

    //        Shared.PreviewReport(this, sFilename);
    //    }

    //}

    #region PR Detail
    private void BindPRDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            //
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_code_barcode"] = lblCodeBarcode.Text;

            gvwList.DataSource = _dal.GetRows("", "xsp_purchase_request_detail_getrows_verifikasi", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    public void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);



            _dal.Update("","xsp_purchase_request_header_update_header_verivikasi", _ht);

            Shared.ShowSuccessGritter(this, string.Format("verifikasirequestheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    public void PostData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;


        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);


            _ht["p_code_barcode"] = lblCodeBarcode.Text;
            _dal.ExecRawSP("xsp_purchase_request_header_post_verifikasi", _ht);

            Shared.ShowSuccessGritter(this, string.Format("verifikasirequestheaderlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void DeleteData(string ID)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_id"] = ID;

    //        _dal.Delete(TABLE_NAME_DETAIL, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindPRDetail();
    }

    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("verifikasirequestdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
    //}

    //protected void btnDelete_Click(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in gvwList.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
    //        }
    //    }

    //    BindPRDetail();
    //}

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindPRDetail();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("verifikasirequestdetail.aspx?action=edit&id={0}&codebarcode={1}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
    }

    public void SaveChecklist()
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

            MPF23.Shared.Mapper.UIToDB.Map(upd.Controls, _ht);

        try
        {
            

            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    TextBox txtApproveQty = (row.Cells[6].Controls[1] as TextBox);

                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_approve_quantity"] = txtApproveQty.Text;
                    _ht["p_pr_code"] = lblCodeBarcode.Text;

                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "xsp_purchase_request_detail_update_verifikasi", _ht);
                }


            }
            Shared.ShowSuccessGritter(this, string.Format("verifikasirequestheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
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
    protected void btnSaveChecklist_Click(object sender, EventArgs e)
    {
       
        SaveChecklist();
    }
    protected void gvwList_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            GeneralDAL _dal = null;
            Hashtable _ht = null;
            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();

                TextBox txtApproveQty = (e.Row.Cells[6].Controls[1] as TextBox);


                _ht["p_id"] = gvwList.DataKeys[e.Row.RowIndex][0].ToString();
                _ht["p_approve_quantity"] = txtApproveQty.Text;

                DataRow _dr = _dal.GetRow(TABLE_NAME_DETAIL, _ht);
                //((DropDownList)e.Row.FindControl("ddlSupplier")).SelectedValue = _dr["SUPPLIER_CODE"].ToString();
                if (txtApproveQty.Text != "")
                {
                    txtApproveQty.Text = "0";

                }
                txtApproveQty.Text = _dr["APPROVE_QUANTITY"].ToString();
                //txtApproveQty.Enabled = false;
            }
            catch (Exception)
            {
            }
        }
    }
    #endregion



}
