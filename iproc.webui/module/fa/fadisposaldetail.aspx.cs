using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_fadisposaldetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "FA_DISPOSAL_DETAIL";
    private static string TABLE_NAME_DOC_DETAIL = "FA_DISPOSAL_DOCUMENT";

    protected void Page_Load(object sender, EventArgs e)
    {
        txtLocation.Text = Request.Params["location"];
        btnLookUpFaAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FAASD&acol_0={0}&bcol_2={1}&ccol_2={2}&dcol_3={3}&ecol_3={4}&fcol_1={5}&gcol_1={6}&hcol_4={7}&icol_5={8}&jcol_6={9}&parc_location={10}');", txtFaID.ClientID, txtAssetCode.ClientID, lblAssetCode.ClientID, lblAssetName.ClientID, txtNameAsset.ClientID, lblBarcode.ClientID, txtBarcode.ClientID, txtOriginalValue.ClientID, txtNetBookValue.ClientID, txtTotalDepresiasi.ClientID, txtLocation.ClientID);
        btnLookUpFaAsset.Visible = false;
        BindDataDocRequest();
        LoadInit();
        if (!Page.IsPostBack)
        {
            lblCodeBarcode.Text = Request.Params["codebarcode"];


            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;

                if (lblFDStatus.Text.Equals("NEW")||lblFDStatus.Text.Equals("ONPROGRESS"))
                {
                    btnSave.Visible = true;
                    btnLookUpFaAsset.Enabled = true;
                    txtDescription.Enabled = true;
                    btnAdd.Visible = true;
                    btnSaveDocumentDetail.Visible = true;
                }


                else
                {
                    btnAdd.Visible = false;
                    btnSaveDocumentDetail.Visible = false;
                }
            }
            else
            {
                GetCode();
            }
        }
        LoadAfterInit();
    }

    private void GetCode()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow("FA_DISPOSAL_DETAIL", _ht);

            lblFaDisposalCode.Text = _dr["code"].ToString();
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
            DataRow _dr = _dal.GetRow(TABLE_NAME_DETAIL, _ht);

            DBToUI.Map(this.Controls, _dr);
            BindDataDocRequest();
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

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME_DETAIL, _ht);

            Shared.ShowSuccessGritter(this, string.Format("fadisposaldetail.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, lblCodeBarcode.Text));
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
        Response.Redirect("fadisposalheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text + "&idartarget=" + Request.Params["idartarget"]);
    }

    #region FA DISPOSAL DOC
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
            _ht["p_fa_code"] = Request.Params["codebarcode"];

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

    private void UpdateDataDetail(string FA_DISPOSAL_CODE, string GENERAL_DOC_CODE, string FILE_NAME, string PATHS, string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_fa_code"] = FA_DISPOSAL_CODE;
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

    //private void DeleteData(string ID)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_id"] = ID;

    //        _dal.Delete(TABLE_NAME_DOC_DETAIL, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}


    protected void gvwListDocReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDocReq.PageIndex = e.NewPageIndex;
        BindDataDocRequest();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect("fadisposaldocument.aspx?action=add&codebarcode=" + lblCodeBarcode.Text + "&code=" + lblFaDisposalCode.Text + "&iddetail=" + lblID.Text + "&idartarget=" + Request.Params["idartarget"]);
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

                    filePath = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/" + lblBarcode.Text));

                    if (fupFile.HasFile)
                    {
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

                            string sFullPath = filePath + '/' + sFileName;

                            if (!System.IO.Directory.Exists(filePath))
                                System.IO.Directory.CreateDirectory(filePath);

                            if (!System.IO.File.Exists(sFullPath))
                                fupFile.SaveAs(sFullPath);

                            sFullPath = Shared.GetUploadPath("ADD_DOCUMENT/" + lblBarcode.Text) + sFileName;
                            UpdateDataDetail(gvwListDocReq.DataKeys[gvr.RowIndex]["FA_CODE"].ToString(), gvwListDocReq.DataKeys[gvr.RowIndex]["GENERAL_DOC_CODE"].ToString(), fupFile.FileName, sFullPath, gvwListDocReq.DataKeys[gvr.RowIndex]["ID"].ToString());

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

                if (lblFDStatus.Text == "POST" || lblFDStatus.Text == "PROCESSED" || lblFDStatus.Text == "CANCEL" || lblFDStatus.Text == "VERIFIED" || lblFDStatus.Text == "REJECTED")
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

