using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryadjustmentheader : BasePage
{
    private static string TABLE_NAME_DETAIL = "INVENTORY_ADJUSTMENT_DETAIL";
    private static string TABLE_NAME_HEADER = "INVENTORY_ADJUSTMENT_HEADER";
   
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

            Shared.BindBranchEmployee(ddlBranch);
           
            Shared.BindGeneralSubCode(ddlReason, "RINADJ");
          
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
 
                BindData();
                btnDeleteAdjustmentDetail.OnClientClick = "return confirm('Delete selected data?');";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                txtAdjustmentDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtAdjustmentDate.Enabled = false;
               

                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                // btnReject.OnClientClick = "return confirm('Cancel selected data?');";
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (lblTransFlagCode.Text == "POST" || lblTransFlagCode.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddAdjustmentDetail.Visible = btnDeleteAdjustmentDetail.Visible = false;
                    txtAdjustmentDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlReason.Enabled = false; // (+) Ari 22-12-2022 ket : disable


                }
                else if (lblTransFlagCode.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddAdjustmentDetail.Visible = btnDeleteAdjustmentDetail.Visible = false;
                    txtAdjustmentDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlBranch.Enabled = false; // (+) Ari 22-12-2022 ket : disable
                    ddlReason.Enabled = false; // (+) Ari 22-12-2022 ket : disable

                }
                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;
            }
            else
            {
                btnReject.Visible = btnPost.Visible = false;
                btnAddAdjustmentDetail.Visible = btnDeleteAdjustmentDetail.Visible = false;
                pnlInventoryAdjustment.Visible = false;
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDivision(ddlDivision);
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                
                txtAdjustmentDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtAdjustmentDate.Enabled = false;
                btnViewHistory.Visible = false;
                
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/inventoryadjustmentheaderlist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000011&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
       // btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000011&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000012&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
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
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventoryadjustmentheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));            
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

    //        _dal.ExecRawSP("xsp_inventory_adjustment_header_post", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("inventoryadjustmentheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    //        _dal.ExecRawSP("xsp_inventory_adjustment_header_cancel", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("inventoryadjustmentheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventoryadjustmentheaderlist.aspx");
    }
    //protected void btnReject_Click(object sender, EventArgs e)
    //{
    //    CancelData();
    //}
    //protected void btnPost_Click(object sender, EventArgs e)
    //{
    //    PostData();
    //}

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);



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

#region adjustment detail 

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

    protected void btnAddAdjustmentDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventoryadjustmentdetail.aspx?action=add&codebarcode=" + lblCodeBarcode.Text);
    }

    protected void btnDeleteAdjustmentDetail_Click(object sender, EventArgs e)
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
        if (lblCodeBarcode.Text != string.Empty )
            BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("inventoryadjustmentdetail.aspx?action=edit&id={0}&codebarcode={1}&idartarget={2}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, Request.Params["idartarget"]));
    }
#endregion


   
}