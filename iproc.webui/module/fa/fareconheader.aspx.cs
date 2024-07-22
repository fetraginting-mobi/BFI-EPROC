using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_fareconheader : BasePage
{
    private static string TABLE_NAME_HEADER = "FA_RECON_HEADER";
    private static string TABLE_NAME_DETAIL = "FA_RECON_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindFaLocationAll(ddlToLocationCode, ddlBranch.SelectedValue);
            Shared.BindOwnerReportAll(ddlAsetOwner);


            
            btnAdd.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=FACON&parc_fa_recon_code={0}&gvw={1}&parc_branch_code={2}');", txtCodeBarcode.ClientID, btnSearch.UniqueID, ddlBranch.ClientID);

         

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
              


                BindData();
                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                txtReconDate.Enabled = false;
                ddlBranch.Enabled = false;
                ddlToLocationCode.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                ddlAsetOwner.Enabled = false;
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnReject.OnClientClick = "return confirm('Cancel selected data?');";
                ddlBranch.Enabled = false;

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL")
                {
                    btnSave.Visible = btnSaveTermin.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    txtReconDate.Enabled = false;
                  
                    ddlBranch.Enabled = false;
                    ddlAsetOwner.Enabled = false;
                    txtDescription.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    btnViewHistory.Visible = false;
                }
                else if (lblTransFlagCode.Text == "ONPROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    txtReconDate.Enabled = false;
                  
                    txtDescription.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlBranch.Enabled = false;
                    ddlAsetOwner.Enabled = false;


                }
                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;

            }
            else
            {
                btnReject.Visible = pnlDisposal.Visible = btnPost.Visible = false;
                btnAdd.Visible = btnDelete.Visible = false;
                txtReconDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtReconDate.Enabled = false;
                ddlBranch.Enabled = false;
                Shared.BindBranchEmployee(ddlBranch);
                Shared.BindFaLocationAll(ddlToLocationCode, ddlBranch.SelectedValue);
                Shared.BindOwnerReportAll(ddlAsetOwner);
                btnViewHistory.Visible = false;
             
            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/fa/fareconlist.aspx";
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000074&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "PROCESSED", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtDescription.ClientID, lblCode.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000021&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000022&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000075&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtDescription.ClientID, lblCode.ClientID);
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
            Shared.BindBranchEmployee(ddlBranch);
            ddlToLocationCode.SelectedValue = _dr["LOCATION_CODE"].ToString();
            Shared.BindOwnerReportAll(ddlAsetOwner);
            

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
            
                
            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("fareconheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    //        _dal.ExecRawSP("xsp_fa_recon_header_post", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("fareconheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

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

            _dal.ExecRawSP("xsp_fa_disposal_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("fareconheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindFaLocationAll(ddlToLocationCode, ddlBranch.SelectedValue);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("fareconlist.aspx");
    }
   
    protected void btnReject_Click(object sender, EventArgs e)
    {
        CancelData();
    }

    #region fa mutation detail

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

            _ht["p_ast_code"] = code;

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
        Response.Redirect("fadisposaldetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&location=" );
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
        Response.Redirect(string.Format("fadisposaldetail.aspx?action=edit&id={0}&codebarcode={1}&location={2}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwList.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    private void SaveDataQty()
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
        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {

                    string Qty = ((TextBox)row.Cells[7].Controls[1]).Text;

                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();

                    //_ht["p_fa_recon_code"] = txtCodeBarcode.Text;

                    _ht["p_qty"] = Qty;


                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_fa_recon_qty_update", _ht);

                }
            }
            Shared.ShowSuccessGritter(this, string.Format("fareconheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
            
            //Shared.ShowSuccessGritter(this, string.Format("fareconheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
            //BindData();

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtQty = (TextBox)e.Row.FindControl("txtQty");




            txtQty.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QTY"));

          

        }
    }

    protected void btnSaveQty_Click(object sender, EventArgs e)
    {
        SaveDataQty();
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


    //private void SaveDataDetail()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    if (!SelectedExistItem())
    //    {
    //        Exception ex = null;
    //        ex = new Exception("No Transaction Selected !");
    //        Shared.ShowErrorDialog(this, ex);
    //        return;
    //    }

    //    _dal = new GeneralDAL();
    //    _ht = new Hashtable();

    //    // MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //    // System.Diagnostics.Debugger.Break();
    //    try
    //    {
    //        foreach (GridViewRow row in gvwList.Rows)
    //        {
    //            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //            if (chb.Checked)
    //            {

    //                string SaleValue = ((TextBox)row.Cells[5].Controls[1]).Text;

    //                _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
    //                //_ht["p_sale_value"] = SaleValue;

    //                Shared.ApplyDefaultProp(_ht);

    //                _dal.ExecRawSP("xsp_fa_disposal_update", _ht);
    //            }
    //        }

    //        Shared.ShowSuccessGritter(this, string.Format("fadisposalheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));

    //        BindData();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}


    ////protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    ////{
    ////    if (e.Row.RowType == DataControlRowType.DataRow)
    ////    {

    ////        TextBox txtSaleValue = (TextBox)e.Row.FindControl("txtSaleValue");

    ////        txtSaleValue.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SALE_VALUE"));

    ////    }
    ////}

    //protected void btnSaveDetail_Click(object sender, EventArgs e)
    //{
    //    SaveDataDetail();
    //}

    //private Boolean SelectedExistItem()
    //{
    //    int _RowCount = 0;
    //    foreach (GridViewRow row in gvwList.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            _RowCount += 1;
    //        }
    //    }

    //    if (_RowCount > 0)
    //        return true;
    //    else
    //        return false;
    //}

    #endregion


}