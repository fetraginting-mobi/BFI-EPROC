using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
using System.Collections.Generic;

public partial class module_fa_fasaleheader : BasePage
{
    private static string TABLE_NAME_HEADER = "FA_SALE_HEADER";
    private static string TABLE_NAME_DETAIL = "FA_SALE_DETAIL";
    private static string GET_MULTIPLE_BRANCH = "GET_IS_AGAS"; // (+) Ari 30-12-2022 ket : enhancement 2022
    private readonly String UserNameAPI = System.Configuration.ConfigurationManager.AppSettings["UserNameAPI"];
    private readonly String PasswordAPI = System.Configuration.ConfigurationManager.AppSettings["PasswordAPI"];
    private readonly BfiApiService.WSProcurementSoapClient _BfiApiService = new BfiApiService.WSProcurementSoapClient();

    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {
            Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);
            
            Shared.BindBranchEmployee(ddlBranch);
            btnAdd.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=FASALE&parc_fa_sale_code={0}&gvw={1}&parc_location={2}&parc_branch_code={3}&parc_owner={4}');", txtBarcode.ClientID, btnSearch.UniqueID, ddlFromLocationCode.ClientID, ddlBranch.ClientID, ddlOwner.ClientID);
            Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);
            Shared.BindUnitsItemOwnSale(ddlOwner);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                ddlFromLocationCode.Enabled = false;
                BindData();
                ddlOwner.Enabled = false;
                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                btnReject.OnClientClick = "return confirm('Cancel selected data?');"; //(mod) Ami 18-06-2020 : Perubahan Pop up dari Delete menjadi Cancel selected data
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnReject.OnClientClick = "return confirm('Cancel selected data?');";
                txtSaleDate.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                ddlBranch.Enabled = false;


                if (lblTransFlagCode.Text == "POST")
                {
                    btnSave.Visible = btnPost.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    ddlFromLocationCode.Enabled = false;
                    ddlBranch.Enabled = false;
                    btnReject.Visible = true;
                    txtDescription.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtSaleTo.Enabled = false;
                    txtSaleDate.Enabled = false;
                    txtNoTelpBuyer.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    btnSaveDetail.Visible = false;
                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAdd.Visible = btnDelete.Visible = false;
                    ddlFromLocationCode.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtDescription.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtSaleTo.Enabled = false;
                    txtSaleDate.Enabled = false;
                    txtNoTelpBuyer.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    btnSaveDetail.Visible = false;
                }
                //nirmala (12-12-2019) no ticket : 1912000081
                else if (lblTransFlagCode.Text == "REJECTED")
                {
                    btnSave.Visible = false;
                    btnReject.Visible = false;
                    btnPost.Visible = false;
                    btnCancel.Visible = false;
                    txtSaleDate.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlOwner.Enabled = false;
                    ddlFromLocationCode.Enabled = false;
                    txtSaleTo.Enabled = false;
                    txtNoTelpBuyer.Enabled = false;
                    txtDescription.Enabled = false;
                    txtRemarks.Enabled = false;
                }
                //(+) Ami 18-06-2020
                else if (lblTransFlagCode.Text == "CANCEL")
                {
                    btnSave.Visible = false;
                    btnPost.Visible = false;
                    btnReject.Visible = false;
                    ddlFromLocationCode.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtDescription.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtSaleTo.Enabled = false;
                    txtSaleDate.Enabled = false;
                    txtNoTelpBuyer.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    btnSaveDetail.Visible = false;
                    btnAdd.Visible = false;
                    btnDelete.Visible = false;
                }

                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;
            }
            else
            {
                LoadDataagas(); // (+) Ari 30-12-2022 ket : enhancement 2022
                btnReject.Visible = pnlSale.Visible = btnPost.Visible = btnCancel.Visible = false;
                btnAdd.Visible = btnDelete.Visible = false;
                txtSaleDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtSaleDate.Enabled = false;
                ddlBranch.Enabled = false;
                Shared.BindBranchEmployee(ddlBranch);
                Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);

                // (+) Ari 30-06-2022 ket : enhancement 2022 (jika Role Flag Is Agas bisa edit ddlBranch)
                if (lblMultiplebranch.Text == "1")
                {
                    ddlBranch.Enabled = true;
                }
               

            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/fa/fasaleheaderlist.aspx";

        //System.Diagnostics.Debugger.Break();
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000019&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000019&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000020&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, lblbranch.ClientID);
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000020&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000020&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
        LoadAfterInit();
        Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);
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
            _ht["p_user_id"] = Shared.CurrentUID; // (+) Ari 30-12-2022 ket : enhancement 2022
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    // (+) Ari 30-12-2022 ket : enhancement 2022 cek Role IS_AGAS
    private void LoadDataagas()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();


            _ht["p_user_id"] = Shared.CurrentUID;
            Shared.ApplyDefaultProp(_ht);
            DataRow _dr = _dal.GetRow(GET_MULTIPLE_BRANCH, _ht);

            //DBToUI.Map(this.Controls, _dr);
            lblMultiplebranch.Text = _dr.ItemArray[0].ToString();


        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void RejectData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];

            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_fa_sale_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("fasaleheaderlist.aspx"));
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

            Shared.ShowSuccessGritter(this, string.Format("fasaleheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    //        _dal.ExecRawSP("xsp_fa_sale_header_post", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("fasaleheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    //        _dal.ExecRawSP("xsp_fa_sale_header_cancel", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("fasaleheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

        Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);

        //updDep.Update();
    }

    //(+)Gustian enhance 19102023
    protected void ddlBranchcost_SelectedIndexChanged(object sender, EventArgs e)
    {

        Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);
        //updDep.Update();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        if (lblTransFlagCode.Text == "POST")
        {
            RejectDataHitWebService();
        }
        else
        {
            RejectData();
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("fasaleheaderlist.aspx");
    }
    //protected void btnPost_Click(object sender, EventArgs e)
    //{
    //    PostData();
    //}
    //protected void btnReject_Click(object sender, EventArgs e)
    //{
    //    CancelData();
    //}

    #region fa sale detail

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
            //_ht["p_fa_sale_code"] = ll.Text;


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
        Response.Redirect("fasaledetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&location=" + ddlFromLocationCode.SelectedValue);
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
        Response.Redirect(string.Format("fasaledetail.aspx?action=edit&id={0}&codebarcode={1}&location={2}&idtarget={3}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, ddlFromLocationCode.SelectedValue, Request.Params["idartarget"]));
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwList.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    private void SaveDataDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExistItem())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

       // MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
       // System.Diagnostics.Debugger.Break();
        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {

                    string SaleValue = ((TextBox)row.Cells[6].Controls[1]).Text;

                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_sale_value"] = SaleValue;

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_fa_sale_update", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("fasaleheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));

            BindData();
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

            TextBox txtSaleValue = (TextBox)e.Row.FindControl("txtSaleValue");
           
            txtSaleValue.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SALE_VALUE"));

        }
    }

    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {
        SaveDataDetail();
    }


    private Boolean SelectedExistItem()
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


    #endregion

    private void RejectDataHitWebService()
    {
        string JurnalID;
        string IsUsed;
        GeneralDAL _dal = new GeneralDAL();
        Hashtable _ht = new Hashtable();
        try
        {
            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            Shared.ApplyDefaultProp(_ht);
            DataTable _dt = _dal.GetRows("", "xsp_fa_sale_detail_reconcile_direct_cancel_getrows", _ht);
            if (_dt != null)
            {
                foreach (DataRow _dr in _dt.Rows)
                {
                    JurnalID = _dr["Jurnal_ID"].ToString();
                    IsUsed = _dr["Is_Used"].ToString();
                    string responseCheckStatus = _BfiApiService.APIReconcileFASaleDisposal(UserNameAPI, PasswordAPI, JurnalID);
                    List<ResultAPI> resultsCheckStatus = JsonConvert.DeserializeObject<List<ResultAPI>>(responseCheckStatus);

                    if (resultsCheckStatus[0].StatusAPI.Equals("00"))
                    {
                        if (resultsCheckStatus[0].IsUsed.Equals("1"))
                        {
                            _ht.Clear();
                            _ht["p_JurnalID"] = JurnalID;
                            _dal.Update("", "xsp_fa_sale_detail_reconcile_update", _ht);
                        }
                        else
                        {
                            string response = _BfiApiService.CancelFASaleDisposal(UserNameAPI, PasswordAPI, JurnalID, IsUsed);
                            List<ResultAPI> results = JsonConvert.DeserializeObject<List<ResultAPI>>(response);
                            if (results[0].StatusAPI.Equals("00"))
                            {
                                _ht.Clear();
                                _ht["p_JurnalID"] = JurnalID;
                                _dal.Update("", "xsp_fa_sale_detail_direct_cancel_api_update", _ht);
                            }
                        }
                    }
                }
                Shared.ShowSuccessGritter(this, string.Format("fasaleheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
                BindData();
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    public class ResultAPI
    {
        [JsonProperty("StatusAPI")]
        public String StatusAPI { get; set; }

        [JsonProperty("NotesAPI")]
        public String NotesAPI { get; set; }

        [JsonProperty("Status")]
        public String Status { get; set; }

        [JsonProperty("AccountPayableNo")]
        public String AccountPayableNo { get; set; }

        [JsonProperty("Tr_Nomor")]
        public String Tr_Nomor { get; set; }

        [JsonProperty("IsUsed")]
        public String IsUsed { get; set; }
    }
}

