using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_purchasequotationreviewdetail : BasePage
{

    private static string TABLE_NAME = "PURCHASE_QUOTATION_REVIEW_DETAIL";
    //private static string TABLE_NAME_DOC_DETAIL = "PURCHASE_QUOTATION_DOCUMENT_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        btnLookUpPRCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LUPRC&acol_0={0}&bcol_1={1}');", txtPRBarcode.ClientID, lblPrCode.ClientID);
        btnLookUpSupplierID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSUPL&acol_0={0}&bcol_1={1}');", txtSupplierID.ClientID, lblSupplierName.ClientID);
        btnLookUpItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PRITM&acol_0={0}&bcol_1={1}&parc_code={2}&ccol_2={3}&dcol_3={4}');", txtItemCode.ClientID, lblItemName.ClientID, txtPRBarcode.ClientID, txtOrderQuantity.ClientID, ddlUnitID.ClientID);


        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyCode(ddlCurrencyCode);
            Shared.BindTaxScreme(ddlTaxID);
            Shared.BindMasterUnit(ddlUnitID);
            //btnDele.OnClientClick = "return confirm('Delete selected data?');";

            lblBarcode.Text = Request.Params["codebarcode"];
            lblBarcode.Enabled = false;

            if (Request.Params["action"].Equals("add"))
            {
                btnLookUpPRCode.Enabled = true;
                btnLookUpItem.Enabled = true;
            }
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                btnLookUpPRCode.Enabled = false;
                btnLookUpItem.Enabled = false;
                //txtTampunganQuantity.Text = txtOrderQuantity.Text;
                //btnCancel.Text = "Back";
                //BindDataDocRequest();
                btnSave.Visible = false;
                btnLookUpPRCode.Enabled = false;
                btnLookUpSupplierID.Enabled = false;
                btnLookUpItem.Enabled = false;
                txtGuarantee.Enabled = false;
                txtApprovalQuantity.Enabled = false;
                txtGuaranteePart.Enabled = false;
                txtOrderQuantity.Enabled = false;
                txtRemarks.Enabled = false;
                ddlCurrencyCode.Enabled = false;
                ddlTaxID.Enabled = false;
                txtUnitPrice.Enabled = false;
                rblPaymentMethode.Enabled = false;
                txtTotal.Enabled = false;


                if (!lblPQStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    btnLookUpPRCode.Enabled = false;
                    btnLookUpSupplierID.Enabled = false;
                    btnLookUpItem.Enabled = false;
                    txtGuarantee.Enabled = false;
                    txtApprovalQuantity.Enabled = false;
                    txtGuaranteePart.Enabled = false;
                    txtOrderQuantity.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlCurrencyCode.Enabled = false;
                    ddlTaxID.Enabled = false;
                    txtUnitPrice.Enabled = false;
                    rblPaymentMethode.Enabled = false;
                    //btnAdd.Visible = false;
                    //btnSaveDocumentDetail.Visible = false;
                }

                //if (!lblPQStatus.Text.Equals("POST"))
                //{
                //    pnlDoc.Visible = false;
                //    btnAdd.Visible = false;
                //    btnSaveDocumentDetail.Visible = false;
                //    pnlSearchDocReq.Visible = false;
                //}

            }
                
            else
                GetDocumentNo();
        }
        btnViewDocument.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/documentrequest.aspx?action=edit&codebarcode={0}');", txtPRBarcode.Text);
        LoadAfterInit();
    }

    private void GetDocumentNo()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow("PURCHASE_QUOTATION_HEADER", _ht);

            lblPurchaseQuotationCode.Text = _dr["code"].ToString();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = Request.Params["id"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

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
        int iNextID = 0;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;


            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert("", "xsp_purchase_quotation_detail_review_insert", _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
            {
                //_ht["p_tmp_qty"] = decimal.Parse(txtTampunganQuantity.Text);
                _dal.Update(TABLE_NAME, _ht);
            }

            Shared.ShowSuccessGritter(this, string.Format("purchasequotationdetail.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, lblBarcode.Text));
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
        Response.Redirect("purchasequotationreviewheaderlistheader.aspx?action=edit&id=" + Request.Params["id"] + "&itemcode=" + Request.Params["itemcode"] + "&codebarcode=" + lblBarcode.Text);
    }

    protected void btnLookUpPRCode_Click(object sender, EventArgs e)
    {

    }
    //#region purchase quotation doc detail
    //private void BindDataDocRequest()
    //{
    //     
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    DataView dvQUOTATIONDOC = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_keywords"] = txtSearchDocReq.Text;
    //        _ht["p_pqr_code"] = lblBarcode.Text;
    //        _ht["p_id_detail"] = Request.Params["id"];

    //        dvQUOTATIONDOC = _dal.GetRows(TABLE_NAME_DOC_DETAIL, _ht).DefaultView;

    //        if (dirQUOTATIONDOC == SortDirection.Ascending)
    //            dvQUOTATIONDOC.Sort = expressionQUOTATIONDOC + " ASC";
    //        else
    //            dvQUOTATIONDOC.Sort = expressionQUOTATIONDOC + " DESC";

    //        gvwListDocReq.DataSource = dvQUOTATIONDOC;

    //        //DataTable _dt = _dal.GetRows(TABLE_NAME_DOC_DETAIL, _ht);

    //        //gvwListDocReq.DataSource = _dt;
    //        gvwListDocReq.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //private void UpdateDataDetail(string pqr_code, string GENERAL_DOC_CODE, string FILE_NAME, string PATHS, string ID)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_pqr_code"] = pqr_code;
    //        _ht["p_general_doc_code"] = GENERAL_DOC_CODE;
    //        _ht["p_file"] = FILE_NAME;
    //        _ht["p_paths"] = PATHS;
    //        _ht["p_id"] = ID;

    //        Shared.ApplyDefaultProp(_ht);

    //        _dal.Update(TABLE_NAME_DOC_DETAIL, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    ////private void DeleteData(string ID)
    ////{
    ////    GeneralDAL _dal = null;
    ////    Hashtable _ht = null;

    ////    try
    ////    {
    ////        _dal = new GeneralDAL();
    ////        _ht = new Hashtable();

    ////        _ht["p_id"] = ID;

    ////        _dal.Delete(TABLE_NAME_DOC_DETAIL, _ht);
    ////    }
    ////    catch (Exception ex)
    ////    {
    ////        Shared.ShowErrorDialog(this, ex);
    ////    }
    ////}


    //protected void gvwListDocReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    gvwListDocReq.PageIndex = e.NewPageIndex;
    //    BindDataDocRequest();
    //}

    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
    //    Response.Redirect("purchasequotationdocumentdetail.aspx?action=add&codebarcode=" + lblBarcode.Text + "&flagprocess=" + lblPQStatus.Text + "&iddetail=" + lblID.Text + "&code=" + lblPurchaseQuotationCode.Text);
    //}

    //protected void btnSaveDocumentDetail_Click(object sender, EventArgs e)
    //{
    //    Hashtable _ht;
    //    FileUpload fupFile;
    //    string lblFileName;
    //    string sFileName;
    //    String filePath;

    //    foreach (GridViewRow gvr in gvwListDocReq.Rows)
    //    {
    //        fupFile = (FileUpload)gvr.FindControl("fupFilename");
    //        lblFileName = ((Label)gvr.FindControl("lblFileName")).Text;
    //        sFileName = System.IO.Path.GetFileName(fupFile.FileName);


    //        filePath = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/" + lblBarcode.Text));

    //        if (fupFile.HasFile)
    //        {
    //            string sFullPath = filePath + '/' + sFileName;

    //            if (!System.IO.Directory.Exists(filePath))
    //                System.IO.Directory.CreateDirectory(filePath);

    //            if (!System.IO.File.Exists(sFullPath))
    //                fupFile.SaveAs(sFullPath);

    //            sFullPath = Shared.GetUploadPath("ADD_DOCUMENT/" + lblBarcode.Text) + sFileName;
    //            UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["pqr_code"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());
    //        }

    //    }

    //    Shared.ShowSuccessGritter(this, null);
    //    BindDataDocRequest();
    //}

    //protected void gvwListDocReq_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    LinkButton btn = null;
    //    GridViewRow row = null;
    //    int rowIndex = 0;

    //    try
    //    {
    //        //dapatkan tombol mana yang diklik
    //        btn = ((LinkButton)e.CommandSource);

    //        //dapatkan row dimana tombol tersebut terletak
    //        row = (GridViewRow)(btn.NamingContainer);

    //        if (row.RowType == DataControlRowType.DataRow)
    //        {
    //            rowIndex = row.RowIndex;

    //            if (e.CommandName == "del")
    //            {
    //                try
    //                {
    //                    //string ApplicationNo = lblApplicationNo.Text;
    //                    string pqr_code = (string)gvwListDocReq.DataKeys[rowIndex][1];
    //                    //string GENERAL_DOC_CODE = (string)gvwListDocReq.DataKeys[rowIndex][0];
    //                    string FileName = ((Label)row.Cells[2].Controls[1]).Text;
    //                    int ID = (int)gvwListDocReq.DataKeys[rowIndex][4];


    //                    //delete data di database server
    //                    DeleteDoc(ID);

    //                    //delete file di app server 
    //                    //DeleteDocFile(ApplicationNo, FileName);
    //                }
    //                catch (Exception ex)
    //                {
    //                    Shared.ShowErrorDialog(this, ex);
    //                }

    //                BindDataDocRequest();
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    //private void DeleteDoc(int ID)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        Shared.ApplyDefaultProp(_ht);
    //        _ht["p_id"] = ID;
    //        _dal.Delete(TABLE_NAME_DOC_DETAIL, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //    BindDataDocRequest();
    //}

    //protected void gvwListDocReq_OnRowDataBound(object sender, GridViewRowEventArgs e)
    //{

    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        string FileName = ((Label)e.Row.Cells[2].Controls[1]).Text;

    //        if (FileName.Length != 0)
    //        {

    //            LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
    //            LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];
    //            btnDelete.OnClientClick = "return confirm('Delete selected data?');";


    //            FileName = gvwListDocReq.DataKeys[e.Row.RowIndex]["PATHS"].ToString();
    //            btnPreview.Attributes["onclick"] = "javascript:window.open('../../" + FileName + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";
    //        }
    //        else
    //        {
    //            LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
    //            LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];
    //            //btnDelete.OnClientClick = "return confirm('Delete selected data?');";
    //            btnPreview.Visible = false;
    //            btnDelete.Visible = false;
    //        }
    //    }
    //}

    //protected void btnSearchDocReq_Click(object sender, EventArgs e)
    //{
    //    BindDataDocRequest();
    //}


    //protected void gvwListDocReq_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Response.Redirect(string.Format("auditdetail.aspx?action=edit&auditno={0}&id={1}", gvwListDocReq.SelectedDataKey["BATCH_NO"].ToString(), gvwListDocReq.SelectedDataKey["GENERAL_DOC_CODE"].ToString()));
    //}

    //protected void chbCheckedAllDocRew_CheckedChanged(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow gvr in gvwListDocReq.Rows)
    //    {
    //        CheckBox cbSelect = gvr.FindControl("chbCheckedDocReq") as CheckBox;
    //        cbSelect.Checked = ((CheckBox)sender).Checked;
    //    }
    //}

    //protected void gvwListDocReq_Sorting(object sender, GridViewSortEventArgs e)
    //{
    //    {
    //        if (dirQUOTATIONDOC == SortDirection.Ascending)
    //            dirQUOTATIONDOC = SortDirection.Descending;
    //        else
    //            dirQUOTATIONDOC = SortDirection.Ascending;

    //        expressionQUOTATIONDOC = e.SortExpression;
    //    }

    //    BindDataDocRequest();
    //}

    //public SortDirection dirQUOTATIONDOC
    //{

    //    get
    //    {
    //        if (ViewState["dirStateQUOTATIONDOC"] == null)
    //        {
    //            ViewState["dirStateQUOTATIONDOC"] = SortDirection.Descending;
    //        }

    //        return (SortDirection)ViewState["dirStateQUOTATIONDOC"];
    //    }

    //    set { ViewState["dirStateQUOTATIONDOC"] = value; }
    //}

    //public string expressionQUOTATIONDOC
    //{

    //    get
    //    {
    //        if (ViewState["expressionStateQUOTATIONDOC"] == null)
    //        {
    //            ViewState["expressionStateQUOTATIONDOC"] = "MOD_DATE";
    //        }

    //        return (string)ViewState["expressionStateQUOTATIONDOC"];
    //    }

    //    set { ViewState["expressionStateQUOTATIONDOC"] = value; }
    //}
    //#endregion

}

