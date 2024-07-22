using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryrequestheader : BasePage
{
    private static string TABLE_NAME_DETAIL = "INVENTORY_REQUEST_DETAIL";
    private static string TABLE_NAME_HEADER = "INVENTORY_REQUEST_HEADER";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
           
            btnPrint.Visible = false;

            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
              
                
                BindData();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnDeleteRequestDetail.OnClientClick = "return confirm('Delete selected data?');";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
               
                txtRequestDate.Enabled = false;
                
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

               // btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnReject.OnClientClick = "return confirm('Cancel selected data?');";


                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddRequestDetail.Visible = btnDeleteRequestDetail.Visible = false;
                    txtRemarks.Enabled = false;
                    txtRequestDate.Enabled = false;
                    //ddlDepartment.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlBranch.Enabled = false;
                    ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = ddlUnits.Enabled = false;
                    btnPrint.Visible = true;
                    btnApprovalTiered.Visible = false;
                    ddlFlagAction.Enabled = false;
                    
                }
                if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddRequestDetail.Visible = btnDeleteRequestDetail.Visible = false;
                    txtRemarks.Enabled = false;
                    txtRequestDate.Enabled = false;
                    //ddlDepartment.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlBranch.Enabled = false;
                    ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = ddlUnits.Enabled = false;
                    btnPrint.Visible = true;
                    btnPost.Visible = false;
                    ddlFlagAction.Enabled = false;
                }

            }
            else
            {
                lblRequestorUID.Text = Shared.CurrentUID;
                lblRequestor.Text = Shared.CurrentEmpName;
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                txtRequestDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtRequestDate.Enabled = false;
                btnApprovalTiered.Visible = false;
           

                btnReject.Visible = btnPost.Visible = false;
                btnAddRequestDetail.Visible = btnDeleteRequestDetail.Visible = false;
                pnlInventoryRequest.Visible = false;
            }
            if (!lblApprovalRequestTargetID.Text.Equals(""))
                btnApprovalTiered.Visible = true;

        }

       
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/inventoryrequestheaderlist.aspx";
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000007&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
       // btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000007&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", txtBranch.ClientID);
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000008&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
        //btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericwithcomment.aspx?code=AP000008&parc_object_id={0}&nexturl={1}&spname={2}&status={3}');", lblNo.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert", "REJECT");
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
            Shared.ApplyDefaultProp(_ht);
            
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            //_ht["p_department_code"] = Shared.CurrentEmployeeDeptCode;
            
            if (Request.Params["action"].Equals("add"))
            {   
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);
                
            Shared.ShowSuccessGritter(this, string.Format("inventoryrequestheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
        Response.Redirect("inventoryrequestheaderlist.aspx");
    }

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlDepartment.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);

        //updDep.Update();
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


    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_code_barcode"] = lblCodeBarcode.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_INVENTORY_REQUEST_ISSUE", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }

    #region IR detail
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

    protected void btnAddRequestDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventoryrequestdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text );
    }
    
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("inventoryrequestdetail.aspx?action=edit&id={0}&codebarcode={1}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text));
    }
    #endregion
    
}