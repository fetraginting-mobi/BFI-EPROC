using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
public partial class module_purchaseorder_procurementreview : BasePage
{
   
    //private static string TABLE_NAME_HEADER = "PURCHASE_REQUEST_DETAIL";
    private static string TABLE_NAME_DETAIL = "PROCUREMENT_REVIEW";


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        btnProcess.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
       // txtItemCode.Text = txtItemCode.Text;
     
       

        
        if (!Page.IsPostBack)
        {
            //Shared.BindItemUOM(ddlUOM, lblItemCode.Text);
            txtBranch.Text = Shared.CurrentDefaultEmployeeBranchCode;
            Shared.BindGeneralSubCode(ddlType, "TR");
            btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&parc_item_code={2}&parc_branch_code={3}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtItemCode.ClientID, txtBranch.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                LinkButton btn = btnViewStock as LinkButton;
                 btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../inventory/inventoryviewstock.aspx?action=edit&itemcode={0}');", txtItemCode.Text);

                Shared.BindItemUOM(ddlUOM, lblItemCode.Text);
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";

                if (lblReview.Text == "NO")
                {
                    btnAdd.Visible = btnDelete.Visible = btnSearch.Visible = txtSearch.Visible = false;
                    pnlItemList.Visible = false;
                    
                }
                if (lblReview.Text == "YES")
                {
                    btnAdd.Visible = btnDelete.Visible = true;
                    BindDetail();
                }
                else
                {

                    btnAdd.Visible = btnDelete.Visible = false;
                    pnlItemList.Visible = false;
                    ddlPurchaseBy.Visible = false;
              
                }
                if (lblJenisItem.Text == "FA" || lblJenisItem.Text == "ET")
                {
                    txtQuantityInventory.Enabled = false;
                    btnLookUpWarehouseCode.Enabled = false;
                    ddlFlagAction.Enabled = false;
                    rvfWarehouse.Enabled = false;
                    rfvFlagAction.Enabled = false;
                    
                }
                else
                {
                    txtQuantityInventory.Enabled = true;
                    btnLookUpWarehouseCode.Enabled = true;
                    ddlFlagAction.Enabled = true;
                    rvfWarehouse.Enabled = false;
                    rfvFlagAction.Enabled = false;
                }
            }

            btnViewDocument.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/documentrequest.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
        }

        //Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/verifikasirequestheaderlist.aspx";



        //btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");

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

            _ht["p_id"] = Request.Params["id"];
            lblid.Text = Request.Params["id"];
            
           

            DataRow _dr = _dal.GetRow("", "xsp_purchase_request_header_getrow_procurment_review", _ht);
          
            DBToUI.Map(this.Controls, _dr);
           // Shared.BindGeneralSubCode(ddlType, "TR");
            //Shared.BindItemUOM(ddlUOM, lblItemCode.Text);
            
          
          
          
         
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
       

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _ht["p_id"] = Request.Params["id"];
            _ht["p_pr_code"] = Request.Params["codebarcode"];

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_purchase_request_header_update_procurment", _ht);

            Shared.ShowSuccessGritter(this, string.Format("procurementreview.aspx?action=edit&id={0}&codebarcode={1}",Request.Params["id"], Request.Params["codebarcode"]));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void ProcessData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _ht["p_id"] = Request.Params["id"];
            _ht["p_pr_code"] = Request.Params["codebarcode"];
           

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_purchase_request_header_process_procurment", _ht);

            Shared.ShowSuccessGritter(this, string.Format("procurmentheaderlist.aspx"));
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

            _ht["p_pr_code"] = Request.Params["codebarcode"];
            _ht["p_id"] = Request.Params["id"];
           
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_purchase_request_detail_delete_for_procurment", _ht);

            Shared.ShowSuccessGritter(this, string.Format("procurmentheaderlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

     private void Cancel()
     {
         GeneralDAL _dal = null;
         Hashtable _ht = null;


         try
         {
             _dal = new GeneralDAL();
             _ht = new Hashtable();

             _ht["p_pr_code"] = Request.Params["codebarcode"];
             _ht["p_id"] = Request.Params["id"];

             Shared.ApplyDefaultProp(_ht);

             _dal.ExecRawSP("xsp_purchase_request_detail_cancel_for_procurment", _ht);

             Shared.ShowSuccessGritter(this, string.Format("procurmentheaderlist.aspx"));
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


    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
    }
   
     
     protected void  btnUnPost_Click(object sender, EventArgs e)
      {
          UnpostData();
      }
     protected void btnCancelReq_Click(object sender, EventArgs e)
     {
         Cancel();
     }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("procurmentheaderlist.aspx");
    }


    #region Detail
    private void BindDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_id_detail"] = Request.Params["id"];
            gvwList.DataSource = _dal.GetRows("","xsp_procurement_review_detail_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(String ID)
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

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindDetail();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("procurementreviewdetail.aspx?action=add&iddetail=" + Request.Params["id"]  + "&barcode=" + Request.Params["codebarcode"] + "&code=" + lblCode.Text);
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDetail();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindDetail();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("procurementreviewdetail.aspx?action=edit&id={0}&iddetail={1}&barcode={2}&code={3}", gvwList.SelectedDataKey[0].ToString(),Request.Params["id"], Request.Params["codebarcode"], lblCode.Text));
    }

    #endregion
         

}
