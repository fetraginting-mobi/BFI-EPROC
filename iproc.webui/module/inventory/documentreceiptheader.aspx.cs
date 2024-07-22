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

public partial class module_inventory_documentreceiptheader : BasePage
{
    private static string TABLE_NAME_HEADER = "DOCUMENT_RECEIPT_HEADER";
    private static string TABLE_NAME_DETAIL = "DOCUMENT_RECEIPT_DETAIL";
    string sfullname = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        LoadInit(); LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../inventory/documentmutationhistory.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        

        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            
            txtSupplierID.Text = Shared.CurrentUID;
            btnLookUpShipper.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSLU&acol_0={0}&bcol_1={1}');", txtTrxCode.ClientID, txtDescription.ClientID);
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STALL&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtSupplierID.ClientID, lblSupplierName.ClientID, txtBranch.ClientID);
            btnLookUpPIC.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STALL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_branch_code={3}');", txtDocumentPIC.ClientID, lblPIC.ClientID, txtFreeRequestor.ClientID, txtBranch.ClientID);
            Shared.BindBranchEmployee(ddlBranch);
            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
            ddlBranch.Enabled = false;
            Shared.BindGeneralSubCode(ddlReceiveLocation, "DOCL");

            Shared.BindGeneralSubCode(ddlDocumentCategory, "DOCCAT");
           

           // btnDelete.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                //BindDetail();
                ddlBranch.Enabled = false;
                btnLookUpUserRequest.Enabled = false;
           
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnApprove.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";

               // btnDelete.OnClientClick = "return confirm('Delete selected data?');";

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "ON-PROCCESS" || lblTransFlagCode.Text == "CANCEL" || lblTransFlagCode.Text == "REJECTED")
                {
                    btnSave.Visible = btnApprove.Visible = false;
                   // btnAdd.Visible = btnDelete.Visible = false;
                    btnReject.Visible = false;
                    txtFreeRequestor.Enabled = false;
                    txtTrxDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtDescription.Enabled = false;
                    txtDocumentName.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtShipperName.Enabled = false;
                    txtDocumentNo.Enabled = false;
                    ddlDocumentCategory.Enabled =false;
                    ddlRating.Enabled = false;
                    ddlReceiveLocation.Enabled = false;
                    ddlType.Enabled = false;
                    btnLookUpShipper.Enabled = false;
                    btnLookUpPIC.Enabled = false; // (+) Ari 22-12-2022 ket : disable jika sudah di proses / cancel / reject 
                }
            }
            else
            {
                btnApprove.Visible = false;
               // btnAdd.Visible = btnDelete.Visible = false;
                btnReject.Visible = false;
               // gvwList.Columns[1].Visible = false;
                txtTrxDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtTrxDate.Enabled = false;
                txtSupplierID.Text = Shared.CurrentUID;
                btnLookUpUserRequest.Enabled = false;
            }
            btnPreviewDoc.Attributes["onclick"] = String.Format("javascript:window.open('../../" + lblPATH.Text + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');");
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/documentreceiptheaderlist.aspx";

        btnApprove.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0065&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "PROCESSED", lblbranch.ClientID,lblCode.ClientID);
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0064&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "REJECT", lblbranch.ClientID,lblCode.ClientID);
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
            //Shared.ApplyDefaultProp(_ht);
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
        string sFileDirectorys;
        FileUpload fupFile;
        string lblFileName;
        string sFileName;
        String sFilePath;
        sFilePath = string.Empty;
       
        try
       // System.Diagnostics.Debugger.Break();
         {
            _dal = new GeneralDAL();
            _ht = new Hashtable();


            sFileDirectorys = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/" + Request.Params["codebarcode"]));

            if (fupFilename.HasFile)
            {
                sfullname = System.IO.Path.GetFileName(fupFilename.FileName);

                sFilePath = Shared.GetUploadPath("ADD_DOCUMENT" + Request.Params["codebarcode"]) + sfullname;
            }


            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_file"] = sfullname;
            _ht["p_paths"] = sFilePath;

            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
          // _ht["p_location_code"] = ddlRating.SelectedValue;
          // _ht["p_type_sender"] = ddlType.SelectedValue;


            if (Request.Params["action"].Equals("add"))
            {

                //if (!fupFilename.HasFile)
                //{
                //    throw new Exception("Please insert file image!");
                //}

                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();

                if (!System.IO.Directory.Exists(sFileDirectorys))
                    System.IO.Directory.CreateDirectory(sFileDirectorys);

                if (fupFilename.HasFile)
                {
                    if (!System.IO.File.Exists(sFileDirectorys + sfullname))
                        fupFilename.SaveAs(sFileDirectorys + sfullname);
                }

            }
            else
            {
                if (!fupFilename.HasFile)
                {
                    _ht["p_file"] = lblFILE.Text;
                    _ht["p_paths"] = lblPATH.Text;
                }

                _dal.Update(TABLE_NAME_HEADER, _ht);
            }

          

            Shared.ShowSuccessGritter(this, string.Format("documentreceiptheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
        Response.Redirect("documentreceiptheaderlist.aspx");
    }

    //#region Ticket Detail
    //private void BindDetail()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_keywords"] = txtSearch.Text;
    //        _ht["p_trx_code"] = lblCodeBarcode.Text;

    //        gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
    //        gvwList.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

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

    //protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    gvwList.PageIndex = e.NewPageIndex;
    //    BindDetail();
    //}

    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("documentreceiptdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
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

    //    BindDetail();
    //}

    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    if (Request.Params["action"].Equals("edit"))
    //        BindDetail();
    //}

    //protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Response.Redirect(string.Format("documentreceiptdetail.aspx?action=edit&id={0}&codebarcode={1}&status={2}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, lblTransFlagCode.Text));
    //}

    //#endregion
}
