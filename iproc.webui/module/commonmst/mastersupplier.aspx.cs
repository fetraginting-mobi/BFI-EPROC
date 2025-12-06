using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
using System.Web.Services;

public partial class module_commonmst_mastersupplier : BasePage
{
    private static string TABLE_NAME = "MASTER_SUPPLIER";
    private static string TABLE_NAME_BANK = "MASTER_SUPPLIER_BANK";
    private static string TABLE_NAME_ITEM_GROUP = "MASTER_SUPPLIER_ITEM_GROUP";
    private static string TABLE_NAME_DOC_DETAIL = "SUPPLIER_DOCUMENT";
    private static string TABLE_NAME_HISTORY = "SUPPLIER_HISTORY";
    private static string GET_MULTIPLE_BRANCH = "GET_IS_AGAS"; // (+) Ari 04-07-2022 ket : enhancement 2022


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {


            //btnLookUpEmployee.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=STAFF&acol_0={0}&bcol_1={1}');", txtUserRequest.ClientID, lblUserRequest.ClientID);
            btnLookUpEmployee.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=EMP&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtSupplierCode.ClientID, lblSupplierCode.ClientID, txtSupplierName.ClientID);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindTaxScreme(ddlTaxType);
            Shared.BindWilayah(ddlWilayah);
            Shared.BindCreditorTypeSelect(ddlCreditorTypeCode);
           
            //Shared.BindGeneralSubCode(ddlBankDestination, "BANKLIST");
            btnDeleteBank.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteGroup.OnClientClick = "return confirm('Delete selected data?');";
            btnInValid.OnClientClick = "return confirm('Invalid selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataBank();
                BindDataItemGroup();
                BindDataDocRequest();
                BindDataa();
                gvwListHist.DataBind();
                txtSupplierName.Enabled = false;
                btnLookUpEmployee.Enabled = false;

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                ddlCreditorTypeCode.Enabled = false;

                if (lblStatus.Text == "VALID")
                {
                    btnPost.Visible = false;
                    btnInValid.Visible = true;
                    btnSave.Visible = btnAddBank.Visible = btnDeleteBank.Visible = btnAddGroup.Visible = btnDeleteGroup.Visible = false;
                    btnAddUploadDoc.Visible = false;
                    btnSaveDocumentDetail.Visible = false;
                    gvwListBank.Columns[1].Visible = false;
                    gvwListGroup.Columns[1].Visible = false;
                  

                }
                if (lblStatus.Text == "IN-VALID")
                {
                    btnPost.Visible = true;
                    btnInValid.Visible = false;
                    btnSave.Visible = btnAddBank.Visible = btnDeleteBank.Visible = btnAddGroup.Visible = btnDeleteGroup.Visible = true;
                    btnAddUploadDoc.Visible = true;
                    btnSaveDocumentDetail.Visible = true;
                    gvwListBank.Columns[1].Visible = true;
                    gvwListGroup.Columns[1].Visible = true;
                }

            }
                
            else
            {
                LoadDataagas(); // (+) Ari 30-12-2022 ket : enhancement 2022
                btnAddBank.Visible = btnDeleteBank.Visible = false;
                pnlBank.Visible = false;
                btnAddGroup.Visible = btnDeleteGroup.Visible = false;
                btnInValid.Visible = btnPost.Visible = false;

                // (+) Ari 30-06-2022 ket : enhancement 2022 (jika Role Flag Is Agas bisa edit ddlBranch)
                if (lblMultiplebranch.Text == "1")
                {
                    ddlBranch.Enabled = true;
                }
            }

            GeneralDAL _dal = null;
            Hashtable _ht = null;

            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();

                _ht["p_creditortype_code"] = ddlCreditorTypeCode.SelectedValue;
                DataRow _dr = _dal.GetRow("master_creditor_type", _ht);

               
                if (_dr["creditor_type"].ToString() == "SOF")
                {
                    btnLookUpEmployee.Visible = true;
                    txtSupplierName.Enabled = false;
                }

                else if(_dr["creditor_type"].ToString() == "SPL")
                {
                    btnLookUpEmployee.Visible = false;
                    txtSupplierName.Enabled = true;
                }
                
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }

            
            
           
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/commonmst/mastersupplierlist.aspx";

        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0061&parc_object_id={0}&parc_object_branch={1}');", lblSupplierCode.ClientID, lblbranch.ClientID);
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0061&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblSupplierCode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "VALID", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblSupplierCode.ClientID);
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

            _ht["p_supplier_code"] = Request.Params["suppliercode"];
            DataRow _dr = _dal.GetRow("MASTER_SUPPLIER", _ht);

            lblSupplierCode.Text = _dr["suppliercode"].ToString();
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

            _ht["p_supplier_code"] = Request.Params["suppliercode"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
            gvwListHist.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    // (+) Ari 01-07-2022 ket : enhancement 2022 cek Role IS_AGAS
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

    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string NextCode = "";
            
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_supplier_code"] = txtSupplierCode.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            if (Request.Params["action"].Equals("edit"))
            {
                _dal.Update(TABLE_NAME, _ht);
            }
            else
            {
                _dal.Insert(TABLE_NAME, _ht, ref NextCode);
                txtSupplierCode.Text = NextCode.ToString();
               
            }
            Shared.ShowSuccessGritter(this, string.Format("mastersupplier.aspx?action=edit&suppliercode={0}", txtSupplierCode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void InvalidData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_supplier_code"] = txtSupplierCode.Text;

            _dal.ExecRawSP("xsp_master_supplier_invalid", _ht);

            Shared.ShowSuccessGritter(this, string.Format("mastersupplier.aspx?action=edit&suppliercode={0}", txtSupplierCode.Text));
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

    protected void btnInValid_Click(object sender, EventArgs e)
    {
        InvalidData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("mastersupplierlist.aspx");
    }

    protected void ddlCreditorTypeCode_SelectedIndex(object sender, EventArgs e)
    {
        btnLookUpEmployee.Visible = false;
    }

    protected void ddlCreditorTypeCode_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_creditortype_code"] = ddlCreditorTypeCode.SelectedValue;
            DataRow _dr = _dal.GetRow("master_creditor_type", _ht);


            if (_dr["creditor_type"].ToString() == "SOF")
            {
                btnLookUpEmployee.Visible = true;
                txtSupplierName.Enabled = false;
            }

            else if (_dr["creditor_type"].ToString() == "SPL")
            {
                btnLookUpEmployee.Visible = false;
                txtSupplierName.Enabled = true;
            }

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

    }


    #region Branch Bank
    private void BindDataBank()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchBank.Text;
            _ht["p_supplier_code"] = txtSupplierCode.Text;

            gvwListBank.DataSource = _dal.GetRows(TABLE_NAME_BANK, _ht);
            gvwListBank.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListBank_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListBank.PageIndex = e.NewPageIndex;
        BindDataBank();
    }

    protected void btnAddBank_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("mastersupplierbank.aspx?action=add&suppliercode={0}&suppliername={1}", txtSupplierCode.Text, txtSupplierName.Text));
    }

    protected void btnDeleteBank_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListBank.Rows)
        {
            CheckBox chbBank = (CheckBox)row.Cells[1].Controls[1];
            if (chbBank.Checked)
            {
                DeleteDataBank(gvwListBank.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataBank();
    }

    private void DeleteDataBank(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_BANK, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchBank_Click(object sender, EventArgs e)
    {
        BindDataBank();
    }

    protected void gvwListBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("mastersupplierbank.aspx?action=edit&suppliercode={0}&id={1}&id_dt={2}&status={3}", Request.Params["suppliercode"], Request.Params["id"], gvwListBank.SelectedDataKey[0].ToString(), lblStatus.Text));
    }

    #endregion

    #region History

    private void BindDataa()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_supplier_code"] = txtSupplierCode.Text;
            _ht["p_id"] = Request.Params["id"];

            gvwListHist.DataSource = _dal.GetRows(TABLE_NAME_HISTORY, _ht);
            gvwListHist.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListHist_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListHist.PageIndex = e.NewPageIndex;
        BindDataa();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataa();
    }
    #endregion

    #region Item Group
    private void BindDataItemGroup()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchGroup.Text;
            _ht["p_supplier_code"] = txtSupplierCode.Text;

            gvwListGroup.DataSource = _dal.GetRows(TABLE_NAME_ITEM_GROUP, _ht);
            gvwListGroup.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListGroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListGroup.PageIndex = e.NewPageIndex;
        BindDataItemGroup();
    }

    protected void btnAddGroup_Click(object sender, EventArgs e)    
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("mastersuppliergroup.aspx?action=add&suppliercode={0}", txtSupplierCode.Text));
    }

    protected void btnDeleteGroup_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListGroup.Rows)
        {
            CheckBox chbBank = (CheckBox)row.Cells[1].Controls[1];
            if (chbBank.Checked)
            {
                DeleteDataGroup(gvwListGroup.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataItemGroup();
    }

    private void DeleteDataGroup(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_ITEM_GROUP, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchGroup_Click(object sender, EventArgs e)
    {
        BindDataItemGroup();
    }

    protected void gvwListGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        Response.Redirect(string.Format("mastersuppliergroup.aspx?action=edit&suppliercode={0}&id={1}&id_dt={2}&status={3}", Request.Params["suppliercode"], Request.Params["id"], gvwListGroup.SelectedDataKey[0].ToString(), lblStatus.Text));
    }

    #endregion

    #region doc detail
    private void BindDataDocRequest()
    {
        //System.Diagnostics.Debugger.Break();
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataView dvQUOTATIONDOC = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDocReq.Text;
            _ht["p_supplier_code"] = lblSupplierCode.Text;
            _ht["p_id"] = Request.Params["id"];

            dvQUOTATIONDOC = _dal.GetRows(TABLE_NAME_DOC_DETAIL, _ht).DefaultView;

            if (dirQUOTATIONDOC == SortDirection.Ascending)
                dvQUOTATIONDOC.Sort = expressionQUOTATIONDOC + " ASC";
            else
                dvQUOTATIONDOC.Sort = expressionQUOTATIONDOC + " DESC";

            gvwListDocReq.DataSource = dvQUOTATIONDOC;

            //DataTable _dt = _dal.GetRows(TABLE_NAME_DOC_DETAIL, _ht);

            //gvwListDocReq.DataSource = _dt;
            gvwListDocReq.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void UpdateDataDetail(string SUPPLIER_CODE, string GENERAL_DOC_CODE, string FILE_NAME, string PATHS, string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_supplier_code"] = SUPPLIER_CODE;
            _ht["p_general_doc_code"] = GENERAL_DOC_CODE;
            _ht["p_file"] = FILE_NAME;
            _ht["p_paths"] = PATHS;
            _ht["p_id"] = ID;

            Shared.ApplyDefaultProp(_ht);

            _dal.Update(TABLE_NAME_DOC_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListDocReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDocReq.PageIndex = e.NewPageIndex;
        BindDataDocRequest();
    }

    protected void btnAddUploadDoc_Click(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("mastersupplierdocument.aspx?action=add&suppliercode=" + lblSupplierCode.Text + "&flagprocess=" + lblStatus.Text);
    }

    protected void btnSaveDocumentDetail_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        FileUpload fupFile;
        string lblFileName;
        string sFileName;
        String filePath;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            foreach (GridViewRow gvr in gvwListDocReq.Rows)
            {
                fupFile = (FileUpload)gvr.FindControl("fupFilename");
                lblFileName = ((Label)gvr.FindControl("lblFileName")).Text;
                sFileName = System.IO.Path.GetFileName(fupFile.FileName);

                filePath = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/" + lblSupplierCode.Text));

                if (fupFile.HasFile)
                {
                    string sFullPath = filePath + '/' + sFileName;

                    string sFileType = System.IO.Path.GetExtension(fupFile.FileName);  // (+) Ari 13-09-2022 ket : validasi extension
                    if (
                                  sFileType == ".xls" || sFileType == ".xlsx"     // EXCEL
                                   || sFileType == ".doc" || sFileType == ".docx"     // WORD
                                   || sFileType == ".jpeg" || sFileType == ".jpg"      // Image
                                   || sFileType == ".png" //|| sFileType == ".gif"
                                   || sFileType == ".pdf" //|| sFileType == ".csv"      // PDF
                                   || sFileType == ".zip" || sFileType == ".rar"      // File
                                   || sFileType == ".7z"

                        )
                    {

                            if (!System.IO.Directory.Exists(filePath))
                                System.IO.Directory.CreateDirectory(filePath);

                            if (!System.IO.File.Exists(sFullPath))
                                fupFile.SaveAs(sFullPath);

                            sFullPath = Shared.GetUploadPath("ADD_DOCUMENT/" + lblSupplierCode.Text) + sFileName;
                            UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["SUPPLIER_CODE"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());
                    }
                    else
                    {
                        Shared.ShowValidationError(this, "Please upload file with format type (.pdf .zip .doc .xlx .png .jpg .jpeg). Max file size allowed is 3 mb.");
                        return;
                    }
                }

                MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

                int fileSize = fupFile.PostedFile.ContentLength;

                if (fupFile.PostedFile.ContentLength > 3000000) // (+) Ari 13-09-2022 ket : cek size file Max 3MB.
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "fx", "fnShowErrorNotif('Maximum file size allowed is 3 mb.', '');", true);
                    return;
                }

            }

            Shared.ShowSuccessGritter(this, null);
            BindDataDocRequest();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListDocReq_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        LinkButton btn = null;
        GridViewRow row = null;
        int rowIndex = 0;

        try
        {
            //dapatkan tombol mana yang diklik
            btn = ((LinkButton)e.CommandSource);

            //dapatkan row dimana tombol tersebut terletak
            row = (GridViewRow)(btn.NamingContainer);

            if (row.RowType == DataControlRowType.DataRow)
            {
                rowIndex = row.RowIndex;

                if (e.CommandName == "del")
                {
                    try
                    {
                        //string ApplicationNo = lblApplicationNo.Text;
                        string PQ_CODE = (string)gvwListDocReq.DataKeys[rowIndex][1];
                        //string GENERAL_DOC_CODE = (string)gvwListDocReq.DataKeys[rowIndex][0];
                        string FileName = ((Label)row.Cells[2].Controls[1]).Text;
                        int ID = (int)gvwListDocReq.DataKeys[rowIndex][4];


                        //delete data di database server
                        DeleteDoc(ID);

                        //delete file di app server 
                        //DeleteDocFile(ApplicationNo, FileName);
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

    protected void gvwListDocReq_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string FileName = ((Label)e.Row.Cells[2].Controls[1]).Text;

            if (FileName.Length != 0)
            {
                //System.Diagnostics.Debugger.Break();
                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[1];

                btnDelete.OnClientClick = "return confirm('Delete selected data?');";




                FileName = gvwListDocReq.DataKeys[e.Row.RowIndex]["PATHS"].ToString();
                btnPreview.Attributes["onclick"] = "javascript:window.open('../../" + FileName + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');";
            }
            else
            {
                LinkButton btnPreview = (LinkButton)e.Row.Cells[3].Controls[1];
                LinkButton btnDelete = (LinkButton)e.Row.Cells[4].Controls[3];
                btnDelete.OnClientClick = "return confirm('Delete selected data?');";

                btnPreview.Visible = false;
                btnDelete.Visible = false;
            }
        }
    }

    protected void btnSearchDocReq_Click(object sender, EventArgs e)
    {
        BindDataDocRequest();
    }


    protected void gvwListDocReq_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("auditdetail.aspx?action=edit&auditno={0}&id={1}", gvwListDocReq.SelectedDataKey["BATCH_NO"].ToString(), gvwListDocReq.SelectedDataKey["GENERAL_DOC_CODE"].ToString()));
    }

    protected void chbCheckedAllDocRew_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListDocReq.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedDocReq") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    protected void gvwListDocReq_Sorting(object sender, GridViewSortEventArgs e)
    {
        {
            if (dirQUOTATIONDOC == SortDirection.Ascending)
                dirQUOTATIONDOC = SortDirection.Descending;
            else
                dirQUOTATIONDOC = SortDirection.Ascending;

            expressionQUOTATIONDOC = e.SortExpression;
        }

        BindDataDocRequest();
    }

    public SortDirection dirQUOTATIONDOC
    {

        get
        {
            if (ViewState["dirStateQUOTATIONDOC"] == null)
            {
                ViewState["dirStateQUOTATIONDOC"] = SortDirection.Descending;
            }

            return (SortDirection)ViewState["dirStateQUOTATIONDOC"];
        }

        set { ViewState["dirStateQUOTATIONDOC"] = value; }
    }

    public string expressionQUOTATIONDOC
    {

        get
        {
            if (ViewState["expressionStateQUOTATIONDOC"] == null)
            {
                ViewState["expressionStateQUOTATIONDOC"] = "MOD_DATE";
            }

            return (string)ViewState["expressionStateQUOTATIONDOC"];
        }

        set { ViewState["expressionStateQUOTATIONDOC"] = value; }
    }
    #endregion

   

}
