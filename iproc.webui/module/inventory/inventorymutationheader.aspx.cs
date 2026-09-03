using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventorymutationheader : BasePage
{
    private static string TABLE_NAME_DETAIL = "INVENTORY_MUTATION_DETAIL";
    private static string TABLE_NAME_HEADER = "INVENTORY_MUTATION_HEADER";
    private static string TABLE_NAME_EXPEDITION = "INVENTORY_MUTATION_EXPEDITION";
    private static string TABLE_NAME_POST_HISTORY = "INVENTORY_POST_MUTATION_UPLOAD_HISTORY";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {
            Shared.BindBranchMutAll(ddlToBranch);
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            btnLookUpRequestoro.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=RQST&acol_0={0}&bcol_1={1}&ccol_2={2}&ccol_3={3}&ccol_4={4}&parc_branch_code={5}');", txtRequestorCode.ClientID, txtRequestorName.ClientID, ddlBranch.ClientID, ddlDepartment.ClientID, ddlDivision.ClientID, txtBranch.ClientID);
            btnFromLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtFromLocationCode.ClientID, lblFromLocationName.ClientID, ddlBranch.ClientID);
            btnLookUpFromLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}');", txtFromLotCode.ClientID, txtFromLotName.ClientID, lblFromLotName.ClientID, txtFromLocationCode.ClientID);
            btnLookUpFromRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}');", txtFromRakCode.ClientID, txtFromRakName.ClientID, lblFromRakName.ClientID, txtFromLocationCode.ClientID, txtFromLotCode.ClientID);
            btnLookUpFromSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}&parc_rak_code={5}');", txtFromSlotCode.ClientID, txtFromSlotName.ClientID, lblFromSlotName.ClientID, txtFromLocationCode.ClientID, txtFromLotCode.ClientID, txtFromRakCode.ClientID);
            btnToLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFA&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtToLocationCode.ClientID, lblToLocationName.ClientID, ddlToBranch.ClientID);
            btnLookUpToLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}');", txtToLotCode.ClientID, txtToLotName.ClientID, lblToLotName.ClientID, txtToLocationCode.ClientID);
            btnLookUpToRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}');", txtToRakCode.ClientID, txtToRakName.ClientID, lblToRakName.ClientID, txtToLocationCode.ClientID, txtToLotCode.ClientID);
            btnLookUpToSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_warehouse_code={3}&parc_lot_code={4}&parc_rak_code={5}');", txtToSlotCode.ClientID, txtToSlotName.ClientID, lblToSlotName.ClientID, txtToLocationCode.ClientID, txtToLotCode.ClientID, txtToRakCode.ClientID);
            btnAddAdDep.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=ITMMUT&parc_code_barcode={0}&gvw={1}&parc_branch_code={2}&parc_location_code={3}&parc_to_branch_code={4}&parc_to_location_code={5}');", txtCodeBarcode.ClientID, btnSearch.UniqueID, ddlBranch.ClientID, txtFromLocationCode.ClientID, ddlToBranch.ClientID, txtToLocationCode.ClientID);

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

            if (Request.Params["action"].Equals("edit"))
            {
                // Load Data Utama dari Database
                LoadData();
                BindTOP();
                BindMutationUploadLog();


                // Setting Default untuk Mode Edit
                ddlBranch.Enabled = false;
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                txtMutationDate.Enabled = false;

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";

                // Disable Lookups agar user tidak bisa ganti referensi header
                btnLookUpRequestoro.Enabled = false;
                btnFromLocation.Enabled = false;
                btnLookUpFromLotCode.Enabled = false;
                btnLookUpFromRakCode.Enabled = false;
                btnLookUpFromSlotCode.Enabled = false;

                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";

                // lblProcess mendapatkan nilai dari kolom 'process'
                if (lblProcess.Text == "UPLOAD")
                {
                    //btnSave.Visible = false;
                    btnPost.Visible = false;
                    //btnReject.Visible = false;
                    btnApprovalTiered.Visible = false;
                    txtRemarks.Enabled = false;
                    txtExpeditionDescription.Enabled = false;
                    ddlToBranch.Enabled = false;
                    txtToLocationCode.Enabled = false;
                    btnToLocation.Visible = false;
                    btnLookUpToLotCode.Visible = false;
                    btnLookUpToRakCode.Visible = false;
                    btnLookUpToSlotCode.Visible = false;
                    //btnAddAdDep.Visible = false;
                    //btnDeleteRequestDetail.Enabled = false;
                    //btnSaveDetail.Enabled = false;

                    if (gvwList.Rows.Count > 0)
                    {
                        gvwList.Columns[1].Visible = false;
                    }
                    btnCancel.Visible = true;
                    liMutationUploadLog.Visible = true;
                }
                else
                {
                    if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "ON-PROGRESS" || lblTransFlagCode.Text == "CANCEL")
                    {
                        btnSave.Visible = btnReject.Visible = btnPost.Visible = false;
                        txtRemarks.Enabled = false;
                        txtExpeditionDescription.Enabled = false;
                        btnAddTOP.Visible = false;
                        btnDeleteTOP.Visible = false;
                        gvwList.Columns[1].Visible = false;
                    }
                    liMutationUploadLog.Visible = false;
                }
                BindData();
                btnDeleteRequestDetail.OnClientClick = "return confirm('Delete selected data?');";
                btnDeleteTOP.OnClientClick = "return confirm('Delete selected data?');";
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
            }
            else
            {
                btnReject.Visible = btnPost.Visible = false;
                btnAddTOP.Visible = btnDeleteTOP.Visible = true;
                pnlMutation.Visible = false;
                txtMutationDate.Enabled = false;
                txtMutationDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtFromBranchDesc.Text = Shared.CurrentDefaultEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlSubDepartment.SelectedValue = Shared.CurrentEmployeeSubDepartmentCode;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                txtRequestorCode.Text = Shared.CurrentUID;
                txtRequestorName.Text = Shared.CurrentEmpName;
            }
            SetUploadInfoVisibility();
            if (!lblApprovalRequestTargetID.Text.Equals(""))
                btnApprovalTiered.Visible = true;
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/inventorymutationheaderlist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000013&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000014&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
        LoadAfterInit();
    }

    private void SetUploadInfoVisibility()
    {
        bool isUploadProcess = lblProcess.Text.Equals("UPLOAD", StringComparison.OrdinalIgnoreCase);

        divUploadID.Visible = isUploadProcess;
        divFileName.Visible = isUploadProcess;
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
            BindUploadInfo(_dr);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventorymutationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventorymutationheaderlist.aspx");
    }

    #region detail

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_im_code"] = lblCodeBarcode.Text;


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

    //protected void btnAddRequestDetail_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("inventorymutationdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text); //+ "&location=" + txtFromLocationCode.Text + "&lot=" + txtFromLotCode.Text + "&rak=" + txtFromRakCode.Text + "&slot=" + txtFromSlotCode.Text);
    //}

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

    private void SaveDataDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExistDetail())
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
                    string Quantity = ((TextBox)row.Cells[5].Controls[1]).Text;
                    string Remarks = ((TextBox)row.Cells[4].Controls[1]).Text;

                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_quantity"] = Quantity;
                    _ht["p_remarks"] = Remarks;



                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_inventory_mutation_detail_update", _ht);

                }
            }
            //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

            Shared.ShowSuccessGritter(this, string.Format("inventorymutationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Response.Redirect(string.Format("inventorymutationdetail.aspx?action=edit&id={0}&codebarcode={1}&location={2}&lot={3}&rak={4}&slot={5}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, txtFromLocationCode.Text, txtFromLotCode.Text, txtFromRakCode.Text, txtFromSlotCode.Text));
        Response.Redirect(string.Format("inventorymutationdetail.aspx?action=edit&id={0}&codebarcode={1}&idtarget={2}", gvwList.SelectedDataKey[0].ToString(), Request.Params["codebarcode"], Request.Params["idartarget"]));
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtQuantity = (TextBox)e.Row.FindControl("txtQuantity");
            TextBox txtRemarks = (TextBox)e.Row.FindControl("txtRemarks");

            txtQuantity.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QUANTITY"));
            txtRemarks.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "REMARKS"));
            if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "ONPROGRESS" || lblProcess.Text == "GENERATE")
            {

                txtQuantity.Enabled = false;
                txtRemarks.Enabled = false;
                btnAddAdDep.Visible = false;
                btnDeleteRequestDetail.Visible = false;
                btnSaveDetail.Visible = false;
            }

        }
    }

    private Boolean SelectedExistDetail()
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


    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
        //updDep.Update();
    }

    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {
        SaveDataDetail();
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

    #endregion

    # region Expedition
    private void BindTOP()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchTOP.Text;
            //_ht["p_id"] = Request.Params["id"];
            _ht["p_im_code"] = lblCodeBarcode.Text;

            gvwListTOP.DataSource = _dal.GetRows(TABLE_NAME_EXPEDITION, _ht);
            gvwListTOP.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataTOP(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_EXPEDITION, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListTOP_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListTOP.PageIndex = e.NewPageIndex;
        BindTOP();
    }

    protected void btnAddTOP_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventorymutationepedition.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
    }

    protected void btnDeleteTOP_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListTOP.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataTOP(gvwListTOP.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindTOP();

    }

    protected void btnSearchTOP_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindTOP();
    }

    protected void gvwListTOP_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("inventorymutationepedition.aspx?action=edit&id={0}&codebarcode={1}", gvwListTOP.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
    }
    protected void gvwListMutationUploadlog_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListmutationuploadlog.PageIndex = e.NewPageIndex;
        BindMutationUploadLog();
    }
    private void BindUploadId()
    {
        lblUploadID.Text = "-";
        lblFileName.Text = "-";

        if (lblProcess.Text.Trim().ToUpper() != "UPLOAD" && lblProcess.Text.Trim().ToUpper() != "UPL")
            return;

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _ht["p_code_barcode"] = Request.Params["codebarcode"];

            DataTable dtUpload = _dal.GetRows("", "xsp_inv_request_mutation_upload_id_getrow", _ht);
            if (dtUpload.Rows.Count == 0)
                return;

            DataRow _dr = dtUpload.Rows[0];
            if (_dr["upload_id"] != DBNull.Value && _dr["upload_id"].ToString() != "")
            {
                lblUploadID.Text = _dr["upload_id"].ToString();
                lblFileName.Text = _dr["file_name"].ToString();
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void BindUploadInfo(DataRow dr)
    {
        lblUploadID.Text = "-";
        lblFileName.Text = "-";

        if (dr == null || lblProcess.Text.Trim().ToUpper() != "UPLOAD")
            return;

        if (dr.Table.Columns.Contains("upload_id") && dr["upload_id"] != DBNull.Value && dr["upload_id"].ToString() != "")
            lblUploadID.Text = dr["upload_id"].ToString();

        if (dr.Table.Columns.Contains("file_name") && dr["file_name"] != DBNull.Value && dr["file_name"].ToString() != "")
            lblFileName.Text = dr["file_name"].ToString();
    }

    private void BindMutationUploadLog()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_im_code"] = lblCodeBarcode.Text;

            gvwListmutationuploadlog.DataSource = _dal.GetRows(TABLE_NAME_POST_HISTORY, _ht);
            gvwListmutationuploadlog.DataBind();
            updmutationuploadlog.Update();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    #endregion


}
