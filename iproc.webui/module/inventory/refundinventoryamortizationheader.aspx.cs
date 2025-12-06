using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_refundinventoryamortizationheader : BasePage
{
    private static string TABLE_NAME_DETAIL = "INVENTORY_AMORTIZATION_DETAIL";
    private static string TABLE_NAME_HEADER = "REFUND_INVENTORY_AMORTIZATION_HEADER";
    private static string TABLE_NAME_DOC_DETAIL = "REFUND_DOCUMENT";


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        LinkButton btn = btnViewHistory 
            as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../inventory/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeSort(ddlBranch);
            btnLookupInventoryAmort.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=INVRA&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_branch_code={3}');", txtReferenceCode.ClientID, txtReferenceCodeBarcode.ClientID, txtItemName.ClientID, ddlBranch.ClientID);
            
            string action = Request.Params["action"];

            if (action == "edit")
            {

                LoadData();
                BindData();
                BindDataDocRequest();
                txtAmortizationDate.Enabled = false;
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                string status = lblStatus.Text;
                bool isReadOnly = status == "ONPROGRESS" || status == "CANCEL" || status == "REJECTED" || status == "POST";
                bool isNew = status == "NEW";


                if (ddlActualCashInflow.SelectedValue == "1")
                {
                    txtRefundAmount.Enabled = true;
                }
                else
                {
                    txtRefundAmount.Enabled = false;
                }

                if (isReadOnly)
                {
                    btnSave.Visible = btnPost.Visible = btnCancel.Visible = false;
                    ddlBranch.Enabled = false;
                    btnLookupInventoryAmort.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlActualCashInflow.Enabled = false;
                    txtRefundAmount.Enabled = false;
                }
                else if (isNew)
                {
                    ddlBranch.Enabled = false;
                    btnLookupInventoryAmort.Enabled = false;
                    btnApprovalTiered.Visible = false;
                } 

                if (status == "POST" && lblPaidStatus.Text == "UNPAID" && ddlActualCashInflow.SelectedValue == "1")
                {
                    btnCancel.Visible = true;
                }
                string typeApp = Request.Params["type"];
                string idTargetRaw = Request.Params["idartarget"];
                bool isApproval = typeApp == "approval";

                if (isApproval)
                {
                    int idTarget = 0;
                    int.TryParse(idTargetRaw, out idTarget);
                    btnApprovalTiered.Visible = true;
                    btnSave.Visible = btnPost.Visible = btnCancel.Visible = false;

                    if (string.IsNullOrEmpty(idTargetRaw))
                    {
                        btnApprovalTiered.Visible = false;
                    }
                }
                else
                {
                    btnApprovalTiered.Visible = false;
                }
            }
            else
            {
                pnlAmortization.Visible = false;
                ddlBranch.Enabled = true;
                btnPost.Visible = btnCancel.Visible = btnApprovalTiered.Visible = false;
            }
        }

        btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
        btnCancel.OnClientClick = "return confirm('Cancel This Refund Transaction?');";
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/refundinventoryamortizationheaderlist.aspx";
        btnPost.Attributes["href"] = string.Format(
            "javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0072&parc_object_id={0}&nexturl={1}&status=POST&parc_object_branch={2}&parc_object_amount={3}&parc_branch_code={4}&parc_object_description={5}&parc_object_code={6}');",
            lblCodeBarcode.ClientID,
            Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY],
            lblBranch.ClientID,
            lblAmountAmort.ClientID,
            lblBranch.ClientID,
            txtRemarks.ClientID,
            lblCode.ClientID
        );

        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
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
            {
                _dal.Update(TABLE_NAME_HEADER, _ht);
            }

            Shared.ShowSuccessGritter(this, string.Format("refundinventoryamortizationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("refundinventoryamortizationheaderlist.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_refund_inventory_amortization_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("refundinventoryamortizationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
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
            _ht["p_amortization_code"] = txtReferenceCodeBarcode.Text;


            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwList.DataBind();
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

    private void GenerateData()
    {
        GeneralDAL _dal = null;

        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();


            _ht["p_code_barcode"] = Request.Params["codebarcode"];

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);


            _dal.ExecRawSP("xsp_inventory_amortization_header_process", _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventoryamortizationheaderlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtReferenceCode.Text = string.Empty;
        txtReferenceCodeBarcode.Text = string.Empty;
        txtItemCode.Text = string.Empty;
        txtItemName.Text = string.Empty;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }


    protected void btnPost_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_purchase_order_header_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnAddUploadDoc_Click(object sender, EventArgs e)
    {
        Response.Redirect("masterrefunddocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblCode.Text);
    }

    protected void btnSearchDocReq_Click(object sender, EventArgs e)
    {
        BindDataDocRequest();
    }


    protected void gvwListDocReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDocReq.PageIndex = e.NewPageIndex;
        BindDataDocRequest();
    }

    protected void gvwListDocReq_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string FileName = ((Label)e.Row.Cells[2].Controls[1]).Text;

            if (FileName.Length != 0)
            {

                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];
                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                if (lblStatus.Text != "NEW")
                {
                    btnDelete.Visible = false;
                }
                FileName = gvwListDocReq.DataKeys[e.Row.RowIndex]["PATHS"].ToString();
                btnPreview.Attributes["onclick"] = "javascript:window.open('../../" + FileName + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";
            }
            else
            {
                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[3];

                btnPreview.Visible = false;
                btnDelete.Visible = false;
            }
        }
    }

    protected void gvwListDocReq_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        LinkButton btn = null;
        GridViewRow row = null;
        int rowIndex = 0;

        try
        {
            btn = ((LinkButton)e.CommandSource);
            row = (GridViewRow)(btn.NamingContainer);

            if (row.RowType == DataControlRowType.DataRow)
            {
                rowIndex = row.RowIndex;

                if (e.CommandName == "del")
                {
                    try
                    {
                        int ID = (int)gvwListDocReq.DataKeys[rowIndex][4];
                        //delete data di database server
                        DeleteDoc(ID);
                    }
                    catch (Exception ex)
                    {
                        Shared.ShowErrorDialog(this, ex);
                    }

                    BindDataDocRequest();
                }
            }
        }
        catch (Exception)
        {
        }
    }

    protected void gvwListDocReq_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("auditdetail.aspx?action=edit&auditno={0}&id={1}", gvwListDocReq.SelectedDataKey["BATCH_NO"].ToString(), gvwListDocReq.SelectedDataKey["GENERAL_DOC_CODE"].ToString()));
    }

    private void DeleteDoc(int ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            Shared.ApplyDefaultProp(_ht);
            _ht["p_id"] = ID;
            _dal.Delete(TABLE_NAME_DOC_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void BindDataDocRequest()
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataView dvQUOTATIONDOC = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _ht["p_keywords"] = txtSearchDocReq.Text;
            _ht["p_refund_code"] = lblCodeBarcode.Text;
            dvQUOTATIONDOC = _dal.GetRows(TABLE_NAME_DOC_DETAIL, _ht).DefaultView;
            gvwListDocReq.DataSource = dvQUOTATIONDOC;
            gvwListDocReq.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void ddlActualCashInflow_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtRefundAmount.Text = txtOriginalRefundAmount.Text;
        if (ddlActualCashInflow.SelectedValue == "1")
        {
            txtRefundAmount.Enabled = true;
        }
        else
        {
            txtRefundAmount.Enabled = false;
        }
    }
}
