using System;
using System.Data;
using System.IO;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_supplierselectionheader : BasePage
{

    private static string TABLE_NAME_HEADER = "SUPPLIER_SELECTION_HEADER";
    private static string TABLE_NAME_DETAIL = "SUPPLIER_SELECTION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        //btnLookUpPQCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LUPQC&acol_0={0}&bcol_1={1}');", txtPQCode.ClientID, lblPQCode.ClientID);
        //btnLookUpItemCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PQITM&acol_0={0}&bcol_1={1}&parc_code={2}');", txtItemCode.ClientID, lblItemName.ClientID, txtPQCode.ClientID);
        //btnLookUpSupplierID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PQSUP&acol_0={0}&bcol_1={1}&parc_code={2}&parc_item_code={3}&ccol_3={4}&dcol_4={5}&ecol_5={6}');", txtSupplierID.ClientID, lblSupplierName.ClientID, txtPQCode.ClientID, txtItemCode.ClientID, txtQuantity.ClientID, txtAmount.ClientID, txtID.ClientID);
      
        LoadInit();

        lblCodeBarcode.Text = Request.Params["codebarcode"];
        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", lblCodeBarcode.Text);
      
        if (!Page.IsPostBack)
        {
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;






            if (Request.Params["action"].Equals("edit"))
            {
                //btnCancel.Text = "Back";

                LoadData();
                BindSSDetail();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
               
                txtSelectionDate.Enabled = false;
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                LinkButton btn1 = btnViewQouDoc as LinkButton;
                btn1.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/quotationdocument.aspx?action=edit&pq_code={0}');", txtPQCode.Text);


                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnDelete.OnClientClick = "return confirm('Delete selected data?');";
            
           

                if (lblStatus.Text == "POST" || lblStatus.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnCancelReq.Visible = false;
                    ddlBranch.Enabled = false;
                    btnSaveChecklist.Visible = false;
                    txtRemarks.Enabled = false;
                    txtSelectionDate.Enabled = false;
                    ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = ddlUnits.Enabled = false;
                    //ddlBranch.Enabled = ddlSubBranch.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    btnUnPost.Visible = false;
                    btnApprovalTiered.Visible = false;
                    //btnAdd.Visible = btnDelete.Visible = false;
                }
                else if (lblStatus.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = btnCancelReq.Visible = false;
                    //btnAdd.Visible = btnDelete.Visible = false;
                    txtRemarks.Enabled = false;
                    btnSaveChecklist.Visible = false;
                    //txtRequestDate.Enabled = false;
                    //txtTermsOfPayment.Enabled = false;
                    //btnPrint.Visible = true;
                    gvwList.Columns[1].Visible = false;
                    
                    ddlDivision.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlBranch.Enabled = false;
                    
                    
                    //ddlSubBranch.Enabled = false;
                    //ddlRequirementType.Enabled = false;
                   // btnLookUpRequestoro.Enabled = false;
                    btnPost.Visible = false;
                    btnUnPost.Visible = false;
                    btnApprovalTiered.Visible = false;
                    
                    //ddlSubBranch.Enabled = false;
                    //ddlRequirementType.Enabled = false;
                    //ddlReq.Enabled = false;
                   // btnAddUploadDoc.Visible = false;
                   // btnSaveDocumentDetail.Visible = false;

                   
                }
                else if (lblStatus.Text == "NEW") // (+) Ari 16-01-2023 ket : enhancement 2022
                {
                    ddlBranch.Enabled = false;
                }

                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;
        }
           


            else
            {

                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                btnPost.Visible = false;
                btnApprovalTiered.Visible = false;
                txtSelectionDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtSelectionDate.Enabled = false;
                btnUnPost.Visible = true;
                gvwList.Columns[1].Visible = true;
                ddlBranch.Enabled = false; // (+) Ari 06-01-2023 ket : enhancement 2022, disable
            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/supplierselectionheaderlist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000035&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
        btnCancelReq.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000037&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblbranch.ClientID);
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
                lblCodeBarcode.Text = sNextBarcode;
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("supplierselectionheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void UnpostData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;


        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];

            

            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_purchase_quotation_detail_update_unpost ", _ht);

            Shared.ShowSuccessGritter(this, string.Format("supplierselectionheaderlist.aspx"));
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

    protected void btnUnPost_Click(object sender, EventArgs e)
    {
        UnpostData();
    }



    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("supplierselectionheaderlist.aspx?action=edit");
    }

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




    #region Supplier Selection Detail
    private void BindSSDetail()
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
    private void BindSupplierAmount(GridViewRow grdrDropDownRow)
{
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataRow _dr = null;
        try
        {

           
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            
            //DropDownList ddlSupplier = (grdrDropDownRow.FindControl("ddlSupplier") as DropDownList);

            _ht["p_item_code"] = gvwList.DataKeys[grdrDropDownRow.RowIndex][1].ToString();
            _ht["p_code_barcode"] = txtPQCode.Text;
            _ht["p_supplier_code"] = ((DropDownList)grdrDropDownRow.FindControl("ddlSupplier")).SelectedValue;
            
            _dr = _dal.GetRow(TABLE_NAME_DETAIL, _ht);

            TextBox txtAmount = (TextBox)grdrDropDownRow.FindControl("txtAmount");
            TextBox txtTotalAmount = (TextBox)grdrDropDownRow.FindControl("txtTotalAmount");
            TextBox txtRating = (TextBox)grdrDropDownRow.FindControl("txtRating");
            if (txtAmount != null)
            {
                txtAmount.Text = _dr["amount"].ToString();
                txtTotalAmount.Text = _dr["total_amount"].ToString();
                txtRating.Text = _dr["rating"].ToString();
            }
            if (lblStatus.Text == "POST")
            {
                txtAmount.Enabled = false;
                txtTotalAmount.Enabled = false;
                txtRating.Enabled = false;
            }


            
          
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
   
    private void DeleteData(string SELECTION_CODE,string ITEM_CODE,string SUPPLIER_CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_selection_code"] = SELECTION_CODE;
            _ht["p_item_code"] = ITEM_CODE;
            _ht["p_supplier_code"] = SUPPLIER_CODE;

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
        BindSSDetail();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("supplierselectiondetail.aspx?action=add&codebarcode={0}&pqcode={1}" , lblCodeBarcode.Text , txtPQCode.Text));
    }

   
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString(), gvwList.DataKeys[row.RowIndex][1].ToString(), gvwList.DataKeys[row.RowIndex][2].ToString());

            }
        }

        BindSSDetail();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindSSDetail();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("supplierselectiondetaillist.aspx?action=edit&codebarcode={0}&itemcode={1}&suppliercode={2}&branchcode={3}&idartarget={4}", gvwList.SelectedDataKey[0].ToString(), gvwList.SelectedDataKey[1].ToString(), gvwList.SelectedDataKey[2].ToString(), txtBranch.Text, Request.Params["idartarget"]));
    }
    #endregion

    protected void gvwList_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            GeneralDAL _dal = null;
            Hashtable _ht = null;
            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();
               
                DropDownList ddlSupplier = (e.Row.FindControl("ddlSupplier") as DropDownList);
                TextBox txtAmount = (e.Row.FindControl("txtAmount") as TextBox);
                TextBox txtTotalAmount = (e.Row.FindControl("txtTotalAmount") as TextBox);
                TextBox txtRating = (e.Row.FindControl("txtRating") as TextBox);

                GridViewRow grdrDropDownRow = ((GridViewRow)ddlSupplier.Parent.Parent);

                _ht["p_selection_code"] = txtBarcode.Text;
                _ht["p_item_code"] = gvwList.DataKeys[e.Row.RowIndex][1].ToString();
                _ht["p_pq_code"] = txtPQCode.Text;


                Shared.BindSupplierSelection(ddlSupplier, txtBarcode.Text, txtPQCode.Text, gvwList.DataKeys[e.Row.RowIndex][1].ToString());
                BindSupplierAmount(grdrDropDownRow); 
               


                DataRow _dr = _dal.GetRow("","xsp_supplier_selection_detail_getrow_for_supplier", _ht);
                if (ddlSupplier.SelectedValue != "")
                {
                    ddlSupplier.ClearSelection(); 
                    
                }
                if (lblStatus.Text == "POST")
                {
                    ddlSupplier.Enabled = false;

                }
                if (lblStatus.Text == "ON-PROGRESS")
                {
                    ddlSupplier.Enabled = false;

                }
                ddlSupplier.SelectedValue = _dr["SUPPLIER_CODE"].ToString();
                BindSupplierAmount(grdrDropDownRow);
                BindSupplierAmount(grdrDropDownRow);
                LinkButton btn2 = e.Row.FindControl("btnItemHistory") as LinkButton;
                btn2.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/itemhistory.aspx?action=edit&suppliercode={0}&itemcode={1}&branch={2}');", txtSupplierID.Text, gvwList.DataKeys[e.Row.RowIndex][1].ToString(), txtBranch.Text);
                LinkButton btn = e.Row.FindControl("btnSupplierHistory") as LinkButton;
                btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/supplierhistory.aspx?action=edit&suppliercode={0}&codebarcode={1}&branch={2}');", gvwList.DataKeys[e.Row.RowIndex][2].ToString(), Request.Params["codebarcode"], txtBranch.Text);
                LinkButton btn1 = e.Row.FindControl("btnViewDocument") as LinkButton;
                btn1.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/documentreviewss.aspx?action=edit&codebarcode={0}&itemcode={1}');", gvwList.DataKeys[e.Row.RowIndex][0].ToString(), gvwList.DataKeys[e.Row.RowIndex][1].ToString());
               


              
            }
            catch (Exception ex){
            
            }
        }
    }

    protected void ddlSupplier_SelectedIndexChanged(object sender, EventArgs e)
    {
        //
        DropDownList ddlSupplier = (DropDownList)sender;
        GridViewRow grdrDropDownRow = ((GridViewRow)ddlSupplier.Parent.Parent);

        BindSupplierAmount(grdrDropDownRow);
    }
    public void SaveChecklist()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //
        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(upd.Controls, _ht);
       try
       {

            foreach (GridViewRow row in gvwList.Rows)
            {
                 CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                 if (chb.Checked)
                 {
                     DropDownList ddlSupplier = (row.FindControl("ddlSupplier") as DropDownList);
                     TextBox txtAmount = (row.FindControl("txtAmount") as TextBox);

                     _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                     //_ht["p_quantity"] = (row.Cells[2].Text.ToString());
                     _ht["p_supplier_code"] = ddlSupplier.SelectedValue;
                     _ht["p_amount"] = txtAmount.Text;
                     _ht["p_selection_code"] = txtBarcode.Text;
                    // _ht["p_id_list"] = gvwList.DataKeys[row.RowIndex][3].ToString();

                     Shared.ApplyDefaultProp(_ht);

                     _dal.Update(TABLE_NAME_DETAIL, _ht);
                 }

               
            }
            Shared.ShowSuccessGritter(this, string.Format("supplierselectionheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
       catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnSaveChecklist_Click(object sender, EventArgs e)
    {
        //foreach (GridViewRow row in gvwList.Rows)
        //{
        //    //
        //    DropDownList ddlSupplier = (row.Cells[3].Controls[1] as DropDownList);
        //    TextBox txtAmount = (row.Cells[4].Controls[1] as TextBox);
        //    SaveChecklist(ddlSupplier.SelectedValue.ToString(),decimal.Parse( txtAmount.Text.ToString()));
        //}
        SaveChecklist();
    }

    private Boolean SelectedExist()
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

}
