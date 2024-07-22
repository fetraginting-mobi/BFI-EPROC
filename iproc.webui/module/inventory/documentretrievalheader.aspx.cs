using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_documentretrievalheader : BasePage
{
    private static string TABLE_NAME_HEADER = "DOCUMENT_RECEIPT_HEADER";
    private static string TABLE_NAME_DETAIL = "DOCUMENT_RECEIPT_DETAIL";
    string sfullname = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit(); LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../inventory/documentmutationhistory.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);

        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            btnLookUpShipper.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSLU&acol_0={0}&bcol_1={1}');", txtTrxCode.ClientID, txtDescription.ClientID);
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STALL&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_branch_code={3}');", txtSupplierID.ClientID, txtSupplierID.ClientID, txtFreeRequestor.ClientID, txtBranch.ClientID);
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindGeneralSubCode(ddlReceiveLocation, "DOCL");

            Shared.BindGeneralSubCode(ddlDocumentCategory, "DOCCAT");


            // btnDelete.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                //BindDetail();
                ddlBranch.Enabled = false;

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";

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
                    ddlDocumentCategory.Enabled = false;
                    ddlRating.Enabled = false;
                    ddlReceiveLocation.Enabled = false;
                    ddlType.Enabled = false;
                    btnLookUpShipper.Enabled = false;



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
            }
            btnPreviewDoc.Attributes["onclick"] = String.Format("javascript:window.open('../../" + lblPATH.Text + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');");
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/documentreceiptheaderlist.aspx";

        btnApprove.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0065&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "PROCESSED", lblbranch.ClientID, lblCode.ClientID);
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

        // System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            sFileDirectorys = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/" + Request.Params["codebarcode"]));

            if (fupFilename.HasFile)
            {
                sfullname = System.IO.Path.GetFileName(fupFilename.FileName);

                sFilePath = Shared.GetUploadPath("ADD_DOCUMENT/" + Request.Params["codebarcode"]) + sfullname;

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
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode;
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            if (!System.IO.Directory.Exists(sFileDirectorys))
                System.IO.Directory.CreateDirectory(sFileDirectorys);

            if (fupFilename.HasFile)
            {
                if (!System.IO.File.Exists(sFileDirectorys + sfullname))
                    fupFilename.SaveAs(sFileDirectorys + sfullname);
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
        Response.Redirect("documentretrievalheaderlist.aspx");
    }
}







//    private static string TABLE_NAME_HEADER = "DOCUMENT_RETRIEVAL_HEADER";
//    private static string TABLE_NAME_DETAIL = "DOCUMENT_RETRIEVAL_DETAIL";

//    protected void Page_Load(object sender, EventArgs e)
//    {
//        LoadInit();
//        if (!Page.IsPostBack)
//        {

//            btnLookUpIrCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=DCLR&acol_0={0}&bcol_1={1}');", txtIrCode.ClientID, lblCodeInventoryRequest.ClientID);
//            Shared.BindDivision(ddlDivision);
//            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
//            Shared.BindBranchEmployee(ddlBranch);

//            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
//            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
           

//            if (Request.Params["action"].Equals("edit"))
//            {
//                LoadData();
//                lblCodeBarcode.Enabled = false;
//                btnLookUpIrCode.Enabled = false;
        


//                BindData();
//                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
//                btnCancel.CssClass = "btn btn-custome";
//                txtIssueDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
//                txtIssueDate.Enabled = false;

//                btnDeleteIssueDetail.OnClientClick = "return confirm('Delete selected data?');";
//                //btnPost.OnClientClick = "return confirm('Post selected data?');";
//                //btnReject.OnClientClick = "return confirm('Cancel selected data?');";
//                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

//                if (lblTransFlagDesc.Text == "APPROVED" || lblTransFlagDesc.Text == "CANCEL" || lblTransFlagDesc.Text == "REJECTED")
//                {
//                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
//                    btnDeleteIssueDetail.Visible = false;
//                    txtIssueDate.Enabled = false;
//                    txtRemarks.Enabled = false;
//                    btnLookUpIrCode.Enabled = false;
//                    gvwList.Columns[1].Visible = false;
//                    ddlDepartment.Enabled = false;
//                    ddlDivision.Enabled = false;
//                    ddlUnits.Enabled = false;
//                    ddlSubDepartment.Enabled = false;
//                   // ddlSubBranch.Enabled = false;
//                    ddlBranch.Enabled = false;

//                }
//                else if (lblTransFlagDesc.Text == "ON-PROGRESS")
//                {
//                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
//                    btnDeleteIssueDetail.Visible = false;
//                    txtIssueDate.Enabled = false;
//                    txtRemarks.Enabled = false;
//                    btnLookUpIrCode.Enabled = false;
//                    gvwList.Columns[1].Visible = false;
//                    ddlDepartment.Enabled = false;
//                    ddlDivision.Enabled = false;
//                    btnApprovalTiered.Visible = false;
//                    ddlBranch.Enabled = false;
//                    ddlUnits.Enabled = false;
//                    ddlSubDepartment.Enabled = false;
//                    //ddlSubBranch.Enabled = false;
//                }
//                if (!lblApprovalRequestTargetID.Text.Equals(""))
//                    btnApprovalTiered.Visible = true;

//            }
//            else
//            {
//                //ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
//                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
//                //Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
//               // Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);
//                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
//                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
//                txtIssueDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
//                txtIssueDate.Enabled = false;

             

//                btnReject.Visible = btnPost.Visible = false;
//                btnDeleteIssueDetail.Visible = false;
//                lblBranchUID.Text = Shared.CurrentEmployeeBranchCode;
//                pnlIssue.Visible = false;

//                btnApprovalTiered.Visible = false;
//            }
//        }
//        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/documentretrievalheaderlist.aspx";

//        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000048&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "APPROVED", lblbranch.ClientID);
//        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
//        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000049&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
//        LoadAfterInit();
//    }
//    private void LoadData()
//    {

//        GeneralDAL _dal = null;
//        Hashtable _ht = null;
//        try
//        {
//            _dal = new GeneralDAL();
//            _ht = new Hashtable();

//            _ht["p_code_barcode"] = Request.Params["codebarcode"];
//            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

//            DBToUI.Map(this.Controls, _dr);
//            Shared.BindDivision(ddlDivision);
//            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
//            Shared.BindBranchEmployee(ddlBranch);
//            //Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);
//            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
//            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
           

//        }
//        catch (Exception ex)
//        {
//            Shared.ShowErrorDialog(this, ex);
//        }
//    }
//    private void SaveData()
//    {
//        GeneralDAL _dal = null;
//        Hashtable _ht = null;
//        string sNextBarcode = "";

//        try
//        {
//            _dal = new GeneralDAL();
//            _ht = new Hashtable();

//            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
//            Shared.ApplyDefaultProp(_ht);
//            _ht["p_branch_code"] = ddlBranch.SelectedValue;

//            if (Request.Params["action"].Equals("add"))
//            {
//                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
//                lblCodeBarcode.Text = sNextBarcode.ToString();
//            }
//            else
//                _dal.Update(TABLE_NAME_HEADER, _ht);
//            Shared.ShowSuccessGritter(this, string.Format("documentretrievalheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
//        }
//        catch (Exception ex)
//        {
//            Shared.ShowErrorDialog(this, ex);
//        }
//    }


//    protected void btnSave_Click(object sender, EventArgs e)
//    {
//        SaveData();
//    }
//    protected void btnCancel_Click(object sender, EventArgs e)
//    {
//        Response.Redirect("documentretrievalheaderlist.aspx");
//    }

//    private void BindData()
//    {
//        GeneralDAL _dal = null;
//        Hashtable _ht = null;

//        try
//        {
//            _dal = new GeneralDAL();
//            _ht = new Hashtable();

//            _ht["p_keywords"] = txtSearch.Text;
//            _ht["p_code_barcode"] = lblDrCode.Text;

//            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
//            gvwList.DataBind();
//        }
//        catch (Exception ex)
//        {
//            Shared.ShowErrorDialog(this, ex);
//        }
//    }
//    private void DeleteDatainventoryissueheaderdetail(string ID)
//    {
//        GeneralDAL _dal = null;
//        Hashtable _ht = null;
//        try
//        {
//            _dal = new GeneralDAL();
//            _ht = new Hashtable();

//            _ht["p_id"] = ID;

//            _dal.Delete(TABLE_NAME_DETAIL, _ht);
//        }
//        catch (Exception ex)
//        {
//            Shared.ShowErrorDialog(this, ex);
//        }
//    }
//    private void SaveDataDetail(string ItemCode, DateTime Date)
//    {
//        GeneralDAL _dal = null;
//        Hashtable _ht = null;

//        try
//        {
//            _dal = new GeneralDAL();
//            _ht = new Hashtable();
//            _ht["p_item_code"] = ItemCode;
//            _ht["p_confirm_date"] = Date;

          
            
//            Shared.ApplyDefaultProp(_ht);

//            _dal.Update("", "dbo.xsp_document_retrieval_detail_update_confirm", _ht);

//            Shared.ShowSuccessGritter(this, string.Format("documentretrievalheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
//        }
//        catch (Exception ex)
//        {
//            Shared.ShowErrorDialog(this, ex);
//        }
//    }

//     protected void btnSaveDetail_Click(object sender, EventArgs e)
//     {
//         Int16 iRowSelected = 0;

//         foreach (GridViewRow row in gvwList.Rows)
//         {
//             CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
//             if (chb.Checked)
//             {
//                 iRowSelected++;

//                 DateTime Date = Shared.ToDateTime(((TextBox)row.Cells[4].Controls[1]).Text);

//                 SaveDataDetail(gvwList.DataKeys[row.RowIndex][1].ToString(), Date);
//             }
//         }
//     }

 


//    protected void btnDeleteIssueDetail_Click(object sender, EventArgs e)
//    {
//        foreach (GridViewRow row in gvwList.Rows)
//        {
//            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
//            if (chb.Checked)
//            {
//                DeleteDatainventoryissueheaderdetail(gvwList.DataKeys[row.RowIndex][0].ToString());
//            }
//        }

//        BindData();
//    }
//    protected void btnSearch_Click(object sender, EventArgs e)
//    {
//        if (lblCodeBarcode.Text != string.Empty)
//            BindData();
//    }
//    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        Response.Redirect(string.Format("documentretrievaldetail.aspx?action=edit&id={0}&codebarcode={1}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
//    }
//    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
//    {
//        gvwList.PageIndex = e.NewPageIndex;
//        BindData();
//    }

//    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
//        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
//        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);



//        //updDep.Update();
//    }

//    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
//        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
//    }

//    protected void ddlSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
//    {

//        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
//    }

//    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
//    {

//       // Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);

//        //updDep.Update();
//    }


//    //protected void btnPrint_Click(object sender, EventArgs e)
//    //{
//    //    Hashtable htParams = new Hashtable();
//    //    htParams["p_user_id"] = Shared.CurrentUID;
//    //    htParams["p_code_barcode"] = lblCodeBarcode.Text;

//    //    string sFilename = "";

//    //    sFilename = Shared.ExecuteReport(this, "RPT_INVENTORY_ISSUE", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

//    //    Shared.PreviewReport(this, sFilename);
//    //}
//}