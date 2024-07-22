using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryissueheader : BasePage
{
    private static string TABLE_NAME_HEADER = "INVENTORY_ISSUE_HEADER";
    private static string TABLE_NAME_DETAIL = "INVENTORY_ISSUE_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;

        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        if (!Page.IsPostBack)
        {

            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            //btnLookUpIrCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LUIRH&acol_0={0}&bcol_1={1}');", txtIrCode.ClientID, lblCodeInventoryRequest.ClientID);
            //btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_item_code={3}&parc_branch_code={4}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID, txtItemCode.ClientID, txtBranch.ClientID);
            //btnLookUpLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_item_code={3}');", txtLotCode.ClientID, txtLotName.ClientID, txtWarehouseCode.ClientID, txtItemCode.ClientID);
            //btnLookUpRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_lot_code={3}');", txtRakCode.ClientID, txtRakName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID);
            //btnLookUpSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_lot_code={3}&parc_rak_code={4}');", txtSlotCode.ClientID, txtSlotName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID, txtRakCode.ClientID);
            btnLookUpRequestoro.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=RQST&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtRequestorCode.ClientID, txtRequestorName.ClientID, txtBranch.ClientID);
            btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_branch_code={3}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtStorageControl.ClientID,ddlBranch.ClientID);
            btnLookUpLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}');", txtLotCode.ClientID, txtLotName.ClientID, txtWarehouseCode.ClientID);
            btnLookUpRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MRGFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_lot_code={3}');", txtRakCode.ClientID, txtRakName.ClientID, txtWarehouseCode.ClientID, txtLotCode.ClientID);
            btnLookUpSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MSGFL&acol_0={0}&bcol_1={1}&parc_warehouse_code={2}&parc_lot_code={3}&parc_rak_code={4}');", txtSlotCode.ClientID, txtSlotName.ClientID, txtWarehouseCode.ClientID, txtLotName.ClientID, txtRakCode.ClientID);
            btnAddAdDep.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=ITMSUE&parc_code_barcode={0}&gvw={1}&parc_branch_code={2}&parc_location_code={3}');", txtCodeBarcode.ClientID, btnSearch.UniqueID, ddlBranch.ClientID, txtWarehouseCode.ClientID);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

          
            
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblCodeBarcode.Enabled = false;
              
                btnPrint.Visible = false;
                ddlBranch.Enabled = false;
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                txtIssueDate.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
                btnLookUpRequestoro.Enabled = false;

               
                BindData();
                
                btnDeleteIssueDetail.OnClientClick = "return confirm('Delete selected data?');";
                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnReject.OnClientClick = "return confirm('Cancel selected data?');";
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];

                if (lblTransFlagDesc.Text == "POST" || lblTransFlagDesc.Text == "CANCEL" || lblTransFlagDesc.Text == "REJECTED")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnDeleteIssueDetail.Visible = false;
                    txtIssueDate.Enabled = false;
                    txtRemarks.Enabled = false;
                   
                    
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    btnPrint.Visible = true;
                    ddlBranch.Enabled = false;
                    //(+) Ari 22-12-2022 ket: disable jika sudah post / reject / cancel 
                    btnLookUpWarehouseCode.Enabled = false;
                    btnLookUpLotCode.Enabled = false;
                    btnLookUpRakCode.Enabled = false;
                    btnLookUpSlotCode.Enabled = false;



                }
                else if (lblTransFlagDesc.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnDeleteIssueDetail.Visible = false;
                    txtIssueDate.Enabled = false;
                    txtRemarks.Enabled = false;
                   
                    gvwList.Columns[1].Visible = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    btnPrint.Visible = false;
                    btnApprovalTiered.Visible = false;
                    ddlBranch.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlSubDepartment.Enabled = false;

                   
                }
                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;

            }
            else 
            {
                //ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlSubDepartment.SelectedValue = Shared.CurrentEmployeeDeptCode;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                btnPrint.Visible = false;

                btnReject.Visible = btnPost.Visible = false;           
                btnDeleteIssueDetail.Visible = false;
                lblBranchUID.Text = Shared.CurrentEmployeeBranchCode;
                pnlIssue.Visible = false;
                txtIssueDate.Enabled = false;
                txtRequestorCode.Text = Shared.CurrentUID;
                txtRequestorName.Text = Shared.CurrentEmpName;
                txtIssueDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

                btnApprovalTiered.Visible = false;

               
            }
         }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/inventoryissueheaderlist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000009&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000009&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000010&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID, lblCode.ClientID);
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

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();              
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);
            Shared.ShowSuccessGritter(this, string.Format("inventoryissueheader.aspx?action=edit&codebarcode={0}",lblCodeBarcode.Text));            
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
        Response.Redirect("inventoryissueheaderlist.aspx");
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
             _ht["p_code_barcode"] = lblCodeBarcode.Text;

             gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
             gvwList.DataBind();
         }
         catch (Exception ex)
         {
             Shared.ShowErrorDialog(this, ex);
         }
     }
    private void DeleteDatainventoryissueheaderdetail(string ID)
     {
         GeneralDAL _dal = null;
         Hashtable _ht = null;
         try
         {
             _dal = new GeneralDAL();
             _ht = new Hashtable();

             _ht["p_id"] = ID;

             _dal.Delete(TABLE_NAME_DETAIL, _ht);
         }
         catch (Exception ex)
         {
             Shared.ShowErrorDialog(this, ex);
         }
     }
   
  
    protected void btnDeleteIssueDetail_Click(object sender, EventArgs e)
    {
       foreach (GridViewRow row in gvwList.Rows)
       {
           CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
           if (chb.Checked)
           {
               DeleteDatainventoryissueheaderdetail(gvwList.DataKeys[row.RowIndex][0].ToString());
           }
       }

       BindData();
   }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtQuantity = (TextBox)e.Row.FindControl("txtQuantity");
            TextBox txtRemarks = (TextBox)e.Row.FindControl("txtRemarks");




            txtQuantity.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QUANTITY"));
            txtRemarks.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ITEM_DESCRIPTION"));
            if (lblTransFlagDesc.Text == "POST" || lblTransFlagDesc.Text == "CANCEL" || lblTransFlagDesc.Text == "ONPROGRESS" || lblProcess.Text == "GENERATE")
            {

                txtQuantity.Enabled = false;
                txtRemarks.Enabled = false;
                btnAddAdDep.Visible = false;
                btnSaveDetail.Visible = false;
                btnDeleteIssueDetail.Visible = false;
            }

        }
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
                    string Quantity = ((TextBox)row.Cells[7].Controls[1]).Text;
                    string Remarks = ((TextBox)row.Cells[6].Controls[1]).Text;

                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_quantity"] = Quantity;
                    _ht["p_item_description"] = Remarks;



                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_inventory_issue_detail_update", _ht);

                }
            }
            //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

            Shared.ShowSuccessGritter(this, string.Format("inventoryissueheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {
        SaveDataDetail();
    }


   protected void btnSearch_Click(object sender, EventArgs e)
   {
       if (lblCodeBarcode.Text != string.Empty)
       BindData();
   }
   protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
   {
       Response.Redirect(string.Format("inventoryissuedetail.aspx?action=edit&id={0}&codebarcode={1}&idtarget={2}", gvwList.SelectedDataKey[0].ToString(), lblCodeBarcode.Text, Request.Params["idartarget"]));
    }
   protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
   {
       gvwList.PageIndex = e.NewPageIndex;
       BindData();
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

       sFilename = Shared.ExecuteReport(this, "RPT_INVENTORY_ISSUE", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

       Shared.PreviewReport(this, sFilename);
   }
}