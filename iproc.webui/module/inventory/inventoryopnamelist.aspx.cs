using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryopnamelist : BasePageList
{
    //private static string TABLE_NAME = "INVENTORY_OPNAME";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "INVENTORY_OPNAME";
        NEXT_PAGE = "inventoryopnamelist.aspx";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
       
        btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";

        txtAmount.Text = "100.00";
       
        
        if (!Page.IsPostBack)
        {

            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
            Shared.BindLocationLot(ddlLot, ddlLocation.SelectedValue);
            Shared.BindLocationRak(ddlRak, ddlLocation.SelectedValue, ddlLot.SelectedValue);
            Shared.BindLocationSlot(ddlSlot, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue);
            lblBranch.Text = Shared.CurrentDefaultEmployeeBranchCode;
          
            if (Request.Params["action"] == "edt")
            {
                ddlBranch.SelectedValue = Request.Params["branchcode"];
                Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
                ddlLocation.SelectedValue = Request.Params["locationcode"];
                Shared.BindLocationLot(ddlLot, ddlLocation.SelectedValue);
                ddlLot.SelectedValue = Request.Params["lotcode"];
                Shared.BindLocationRak(ddlRak, ddlLocation.SelectedValue, ddlLot.SelectedValue);
                ddlRak.SelectedValue = Request.Params["rakcode"];
                Shared.BindLocationSlot(ddlSlot, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue);
                ddlSlot.SelectedValue = Request.Params["slotcode"];
            }

            BindData();
            //GenerateData();     
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/inventoryopnamelist.aspx?action=edit";
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000051&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblBranch.Text, txtAmount.Text, lblBranch.Text, lblBranch.Text, lblCode.Text);
       //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000013&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
       
        
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
      
        LoadAfterInit();

    }
     
    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

       // System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            //_ht["p_branch"] = ddlBranch.SelectedValue;
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_lot_code"] = ddlLot.SelectedValue;
            _ht["p_rak_code"] = ddlRak.SelectedValue;
            _ht["p_slot_code"] = ddlSlot.SelectedValue;

            Shared.ApplyDefaultProp(_ht);
          
            
            DataTable dt = _dal.GetRows("", "xsp_inventory_opname_getrows", _ht);
            gvwList.DataSource = dt;
            gvwList.DataBind();
            if (dt.Rows.Count != 0)
            {
                lblCodeBarcode.Text = dt.Rows[0]["CODE_BARCODE"].ToString();
                lblCode.Text = dt.Rows[0]["CODE"].ToString();
                lblTransFlag.Text = dt.Rows[0]["TRANS_FLAG_DESC"].ToString();
                //txtAmount.Text = dt.Rows[0]["OBJECT_AMOUNT"].ToString();
                

                if (lblTransFlag.Text == "ONPROGRESS" || lblTransFlag.Text == "POST")
                {
                    btnPost.Visible = false;
                    btnSave.Visible = false;
                    btnGenerate.Visible = false;
                }
                else
                {
                    btnPost.Visible = true;
                    btnSave.Visible = true;
                    btnGenerate.Visible = true;
                }
              
            }
            else
            {
                lblCodeBarcode.Text = "";
                lblCode.Text = "";
                lblTransFlag.Text = "";
            }

            if (lblTransFlag.Text == "ONPROGRESS" || lblTransFlag.Text == "POST")
            {
                btnPost.Visible = false;
                btnSave.Visible = false;
                btnGenerate.Visible = false;
            }
            else
            {
                btnPost.Visible = true;
                btnSave.Visible = true;
                btnGenerate.Visible = true;
            }

           
            LinkButton btn = btnViewHistory as LinkButton;
            btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", lblCodeBarcode.Text);
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtQty = (TextBox)e.Row.FindControl("txtQty");

            txtQty.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QUANTITY_OPNAME"));
        }
    }
    private void GenerateData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        try
        {

            _ht["p_code_barcode"] = "";
            _ht["p_entry_date"] = DateTime.Now;
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_location_code"] = ddlLocation.SelectedValue;
            _ht["p_lot_code"] = ddlLot.SelectedValue;
            _ht["p_rak_code"] = ddlRak.SelectedValue;
            _ht["p_slot_code"] = ddlSlot.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_inventory_opname_insert", _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventoryopnamelist.aspx?action=edt&branchcode={0}&locationcode={1}&lotcode={2}&rakcode={3}&slotcode={4}",
                                                                                    ddlBranch.SelectedValue, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue, ddlSlot.SelectedValue));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GenerateData();
    }
    private void SaveData()
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

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
         
        try
        {
 
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    string Qty = ((TextBox)row.Cells[11].Controls[1]).Text;

                    _ht["p_code_barcode"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_location_code"] = gvwList.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_lot_code"] = gvwList.DataKeys[row.RowIndex][3].ToString();
                    _ht["p_rak_code"] = gvwList.DataKeys[row.RowIndex][4].ToString();
                    _ht["p_slot_code"] = gvwList.DataKeys[row.RowIndex][5].ToString();
                    _ht["p_quantity_stock"] = gvwList.DataKeys[row.RowIndex][6].ToString();
                    _ht["p_quantity_opname"] = Qty;
                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_inventory_opname_update", _ht);

                }
            }
            Shared.ShowSuccessGritter(this, string.Format("inventoryopnamelist.aspx?action=edt&branchcode={0}&locationcode={1}&lotcode={2}&rakcode={3}&slotcode={4}", 
                                                                                    ddlBranch.SelectedValue, ddlLocation.SelectedValue,ddlLot.SelectedValue,ddlRak.SelectedValue,ddlSlot.SelectedValue));
            BindData();

             

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void ValidatePost()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {

                string Qty = ((TextBox)row.Cells[11].Controls[1]).Text;

                _ht["p_code_barcode"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                _ht["p_location_code"] = gvwList.DataKeys[row.RowIndex][2].ToString();
                _ht["p_lot_code"] = gvwList.DataKeys[row.RowIndex][3].ToString();
                _ht["p_rak_code"] = gvwList.DataKeys[row.RowIndex][4].ToString();
                _ht["p_slot_code"] = gvwList.DataKeys[row.RowIndex][5].ToString();
                _ht["p_quantity_stock"] = gvwList.DataKeys[row.RowIndex][6].ToString();
                _ht["p_quantity_opname"] = Qty;
                Shared.ApplyDefaultProp(_ht);

                _dal.ExecRawSP("xsp_inventory_opname_update", _ht);

            }

            Shared.ShowSuccessGritter(this, string.Format("inventoryopnamelist.aspx"));
            BindData();
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
    private void ProcessData()
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

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_code_barcode"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_location_code"] = gvwList.DataKeys[row.RowIndex][2].ToString();
                    _ht["p_lot_code"] = gvwList.DataKeys[row.RowIndex][3].ToString();
                    _ht["p_rak_code"] = gvwList.DataKeys[row.RowIndex][4].ToString();
                    _ht["p_slot_code"] = gvwList.DataKeys[row.RowIndex][5].ToString();
                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_inventory_opname_process", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("inventoryopnamelist.aspx"));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
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

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
        Shared.BindLocationLot(ddlLot, ddlLocation.SelectedValue);
        Shared.BindLocationRak(ddlRak, ddlLocation.SelectedValue, ddlLot.SelectedValue);
        Shared.BindLocationSlot(ddlSlot, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue);
       
        Shared.ShowSuccessGritter(this, string.Format("inventoryopnamelist.aspx?action=edt&branchcode={0}&locationcode={1}&lotcode={2}&rakcode={3}&slotcode={4}",
                                                                                    ddlBranch.SelectedValue, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue, ddlSlot.SelectedValue));
        BindData();
     
    }

    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationLot(ddlLot, ddlLocation.SelectedValue);
        Shared.BindLocationRak(ddlRak, ddlLocation.SelectedValue, ddlLot.SelectedValue);
        Shared.BindLocationSlot(ddlSlot, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue);
        Shared.ShowSuccessGritter(this, string.Format("inventoryopnamelist.aspx?action=edt&branchcode={0}&locationcode={1}&lotcode={2}&rakcode={3}&slotcode={4}",
                                                                                   ddlBranch.SelectedValue, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue, ddlSlot.SelectedValue));
        BindData();
     

         
        
    }
    protected void ddlLot_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationRak(ddlRak, ddlLocation.SelectedValue, ddlLot.SelectedValue);
        Shared.ShowSuccessGritter(this, string.Format("inventoryopnamelist.aspx?action=edt&branchcode={0}&locationcode={1}&lotcode={2}&rakcode={3}&slotcode={4}",
                                                                                   ddlBranch.SelectedValue, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue, ddlSlot.SelectedValue));
        BindData();
        
      

    }
    protected void ddlRak_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindLocationSlot(ddlSlot, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue);
        Shared.ShowSuccessGritter(this, string.Format("inventoryopnamelist.aspx?action=edt&branchcode={0}&locationcode={1}&lotcode={2}&rakcode={3}&slotcode={4}",
                                                                                   ddlBranch.SelectedValue, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue, ddlSlot.SelectedValue));
        BindData();
      
         
        
    }
    protected void ddlSlot_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.ShowSuccessGritter(this, string.Format("inventoryopnamelist.aspx?action=edt&branchcode={0}&locationcode={1}&lotcode={2}&rakcode={3}&slotcode={4}",
                                                                                   ddlBranch.SelectedValue, ddlLocation.SelectedValue, ddlLot.SelectedValue, ddlRak.SelectedValue, ddlSlot.SelectedValue));
        BindData();
      
    }
}
