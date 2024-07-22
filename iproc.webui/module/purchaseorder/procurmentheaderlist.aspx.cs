using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_procurmentheaderlist : BasePageList
{
    private static string TABLE_NAME = "PURCHASE_REQUEST_DETAIL";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "PURCHASE_REQUEST_DETAIL";
        NEXT_PAGE = "procurmentheaderlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeAll(ddlBranch);

            //(+) Ari 11-07-2022 ket : enhancement 2022
            if (string.IsNullOrEmpty(txtToDate.Text))
            {
                //set tgl skrg
                txtToDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

                //set tgl 30 hari sebelum hari ini
                DateTime date = new DateTime(DateTime.Now.Year, 1, 1).AddDays(DateTime.Now.DayOfYear - 30);
                txtFromDate.Text = date.ToString("dd/MM/yyyy");

            }


            BindData();

        }
       // btnUnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000034&parc_object_id={0}&parc_object_branch={1}');", lblCodeBarcode.ClientID, ddlBranch.ClientID);
        LoadAfterInit();
       
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_is_promotion"] = ddlPromotion.SelectedValue;
            _ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
            _ht["p_item_type"] = ddlItemType.SelectedValue;
            _ht["p_branch_emp"] = Shared.CurrentDefaultEmployeeBranchCode;

            //(+) Ari 11-07-2022 ket : enhancement 2022
            _ht["p_from_date"] = Shared.ToStartDateTime(txtFromDate.Text);
            _ht["p_to_date"] = Shared.ToStartDateTime(txtToDate.Text);
            _ht["p_emp_code"] = Shared.CurrentUID;

            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_purchase_request_header_getrows_procurment", _ht);
            gvwList.DataBind();

            foreach (GridViewRow row in gvwList.Rows)
            {
                //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);
                //DropDownList ddlTypeProcurment = ((DropDownList)row.Cells[9].Controls[1]);
                //if (PurchaseType.SelectedValue.Equals("INV"))
                //{

                //    ddlTypeProcurment.Enabled = false;
                //}
                //else
                //{

                //    ddlTypeProcurment.Enabled = true;
                //}
            }
   

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
 

    //protected void ddlProcurment_SelectedIndexChanged(object sender, EventArgs e)
    //{
     
    //    DropDownList ddlTypeProcurment = (DropDownList)sender;
    //    GridViewRow grdrDropDownRow = ((GridViewRow)ddlTypeProcurment.Parent.Parent);

    //}


    //protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    //{

    //   // 
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
            
    //        TextBox txtUomCode = (TextBox)e.Row.FindControl("txtUomCode");
    //        TextBox txtItemCode = (TextBox)e.Row.FindControl("txtItemCode");
    //        TextBox txtItemName = (TextBox)e.Row.FindControl("txtItemName");
    //        TextBox txtQtyInventory = (TextBox)e.Row.FindControl("txtQtyInventory");
    //        TextBox txtQtyPurchase = (TextBox)e.Row.FindControl("txtQtyPurchase");
    //        DropDownList ddlUOM = (DropDownList)e.Row.FindControl("ddlUOM");
    //        DropDownList ddlType = (DropDownList)e.Row.FindControl("ddlType");
    //        DropDownList ddlBranch = (DropDownList)e.Row.FindControl("ddlBranch");
    //        DropDownList ddlReview = ((DropDownList)e.Row.FindControl("ddlReview"));

    //        //DropDownList ddlTypeProcurment = (DropDownList)e.Row.FindControl("ddlTypeProcurment");
            

    //        Shared.BindGeneralSubCode(ddlType, "TR");
    //        //Shared.BindGeneralSubCode(ddlTypeProcurment, "INVTYPE");
            
         
    //        txtItemName.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ITEM_NAME"));
    //        txtItemCode.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ITEM_CODE"));

    //        txtQtyInventory.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QTY_INVENTORY"));
    //        txtQtyPurchase.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QTY_PURCHASE"));

    //        if (txtQtyInventory.Text == "")
    //        {
    //            txtQtyInventory.Text = "0.00";
    //        }

    //        if (txtQtyPurchase.Text == "")
    //        {
    //            txtQtyPurchase.Text = "0.00";
    //        }
            
    //        Shared.BindItemUOM(ddlUOM, txtItemCode.Text);
    //        ddlUOM.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UOM"));
    //        ddlType.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE"));
    //        ddlBranch.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BRANCH"));
    //        ddlReview.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IS_REVIEW"));
            
    //        LinkButton btnLookUp = (LinkButton)e.Row.FindControl("btnLookupItem");
    //        LinkButton btnFillUOM = (LinkButton)e.Row.FindControl("btnFillUOM");

    //        LinkButton btnLookUpStock = (LinkButton)e.Row.FindControl("btnLookupStock");

    //        btnLookUp.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MITEM&acol_0={0}&bcol_1={1}&dcol_3={2}&obj={3}');", txtItemCode.ClientID, txtItemName.ClientID, ddlUOM.ClientID, btnFillUOM.UniqueID);
    //        LinkButton btn = e.Row.FindControl("btnViewStock") as LinkButton;
    //        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../inventory/inventorycardlist.aspx?action=edit&itemcode={0}');", txtItemCode.Text);
    //    }
    //}

    //protected void gvwList_RowCreated(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        LinkButton btnFillUOM = (LinkButton)e.Row.FindControl("btnFillUOM");
    //        btnFillUOM.Click += new EventHandler(btnFillUOM_Click);
    //    }
    //}

    //public void btnFillUOM_Click(object sender, EventArgs e)
    //{
    //    //
        
    //    LinkButton btn = (LinkButton)sender;

    //    int iRowIndex = Int32.Parse(btn.CommandArgument.ToString());

    //    GridViewRow row = gvwList.Rows[iRowIndex];

    //    TextBox txt = (TextBox)row.Cells[4].Controls[1];

    //    UpdatePanel updUom = (UpdatePanel)row.FindControl("updUom"); ;
    //    DropDownList ddl = (DropDownList)row.FindControl("ddlUOM");
      

    //    Shared.BindItemUOM(ddl, txt.Text);
      
    //    //updUom.Update();
    //}

    

    //private void ProcessData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    //
    //    
    //    if (!SelectedExist())
    //    {
    //        Exception ex = null;
    //        ex = new Exception("No Transaction Selected !");
    //        Shared.ShowErrorDialog(this, ex);
    //        return;
    //    }

    //    _dal = new GeneralDAL();
    //    _ht = new Hashtable();

    //    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

    //    try
    //    {
    //        foreach (GridViewRow row in gvwList.Rows)
    //        {
    //            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //            if (chb.Checked)
    //            {
    //                //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);
    //                DropDownList Type = ((DropDownList)row.Cells[10].Controls[1]);
    //                DropDownList UOM = ((DropDownList)row.FindControl("ddlUOM"));
    //                DropDownList PurposeDepartment = ((DropDownList)row.FindControl("ddlSwitchDepartment"));
    //                DropDownList Branch = ((DropDownList)row.FindControl("ddlBranch"));
    //                DropDownList Review = ((DropDownList)row.FindControl("ddlReview"));
    //                //CheckBox AuthorityBranch = ((CheckBox)row.FindControl("cbAuthorityByBranch"));
    //                string ItemCode = ((TextBox)row.Cells[4].Controls[1]).Text;
    //                string QtyInventory = ((TextBox)row.Cells[7].Controls[1]).Text;
    //                string QtyPurchase = ((TextBox)row.Cells[8].Controls[1]).Text;

    //                _ht["p_item_code"] = ItemCode;
    //                //_ht["p_purchase_type"] = PurchaseType.SelectedValue;
    //                _ht["p_type"] = Type.SelectedValue;
    //                _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
    //                _ht["p_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
    //                _ht["p_pr_code"] = gvwList.DataKeys[row.RowIndex][2].ToString();
    //                _ht["p_unit_code"] = UOM.SelectedValue;
    //                //_ht["p_purpose_department"] = PurposeDepartment.SelectedValue;
    //                _ht["p_branch"] = Branch.SelectedValue;
    //                _ht["p_qty_inventory"] = QtyInventory;
    //                _ht["p_qty_purchase"] = QtyPurchase;
    //                _ht["p_is_review"] = Review.SelectedValue;

    //                //if (AuthorityBranch.Checked == true)
    //                //    _ht["p_is_authority_branch"] = "1";
    //                //else
    //                //    _ht["p_is_authority_branch"] = "0";

    //                Shared.ApplyDefaultProp(_ht);

    //                _dal.ExecRawSP("xsp_purchase_request_header_process_procurment", _ht);
    //            }
    //        }

    //        Shared.ShowSuccessGritter(this, string.Format("procurmentheaderlist.aspx"));
    //        BindData();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlItemType_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }


    protected void ddlPromotion_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    //protected void btnProcess_Click(object sender, EventArgs e)
    //{
    //    ProcessData();
    //}

    //private void SaveData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //   // 

    //    if (!SelectedExist())
    //    {
    //        Exception ex = null;
    //        ex = new Exception("No Transaction Selected !");
    //        Shared.ShowErrorDialog(this, ex);
    //        return;
    //    }

    //    _dal = new GeneralDAL();
    //    _ht = new Hashtable();

    //    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

    //    try
    //    {
    //        foreach (GridViewRow row in gvwList.Rows)
    //        {
    //            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //            if (chb.Checked)
    //            {
    //                //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);
    //                DropDownList Type = ((DropDownList)row.Cells[10].Controls[1]);
    //                string ItemCode = ((TextBox)row.Cells[4].Controls[1]).Text;
              
    //                DropDownList UOM = ((DropDownList)row.FindControl("ddlUOM"));
    //                //DropDownList PurposeDepartment = ((DropDownList)row.FindControl("ddlSwitchDepartment"));
    //                DropDownList Branch = ((DropDownList)row.FindControl("ddlBranch"));
    //                DropDownList Review = ((DropDownList)row.FindControl("ddlReview"));
    //                //CheckBox AuthorityBranch = ((CheckBox)row.FindControl("cbAuthorityByBranch"));
    //                string QtyInventory = ((TextBox)row.Cells[7].Controls[1]).Text;
    //                string QtyPurchase = ((TextBox)row.Cells[8].Controls[1]).Text;

    //                _ht["p_item_code"] = ItemCode;
    //                //_ht["p_purchase_type"] = PurchaseType.SelectedValue;
    //                _ht["p_type"] = Type.SelectedValue;
    //                _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
    //                _ht["p_pr_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
    //                _ht["p_code"] = gvwList.DataKeys[row.RowIndex][2].ToString();
    //                _ht["p_unit_code"] = UOM.SelectedValue;
    //                //_ht["p_purpose_department"] = PurposeDepartment.SelectedValue;
    //                _ht["p_branch"] = Branch.SelectedValue;
    //                _ht["p_qty_inventory"] = QtyInventory;
    //                _ht["p_qty_purchase"] = QtyPurchase;
    //                _ht["p_is_review"] = Review.SelectedValue;

    //                //if (AuthorityBranch.Checked == true)
    //                //    _ht["p_is_authority_branch"] = "1";
    //                //else
    //                //    _ht["p_is_authority_branch"] = "0";

    //                Shared.ApplyDefaultProp(_ht);

    //                _dal.ExecRawSP("xsp_purchase_request_header_update_procurment", _ht);
    //            }
    //        }

    //        Shared.ShowSuccessGritter(this, string.Format("procurmentheaderlist.aspx"));
    //        BindData();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //protected void btnSave_Click(object sender, EventArgs e)
    //{
    //    SaveData();
    //}

    //private void UnPostData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    //

    //    if (!SelectedExist())
    //    {
    //        Exception ex = null;
    //        ex = new Exception("No Transaction Selected !");
    //        Shared.ShowErrorDialog(this, ex);
    //        return;
    //    }

    //    _dal = new GeneralDAL();
    //    _ht = new Hashtable();

    //    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

    //    try
    //    {
    //        foreach (GridViewRow row in gvwList.Rows)
    //        {
    //            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //            if (chb.Checked)
    //            {

    //                _ht["p_pr_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
    //                _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
    //                Shared.ApplyDefaultProp(_ht);

    //                _dal.ExecRawSP("xsp_purchase_request_detail_delete_for_procurment", _ht);
    //            }
    //        }

    //        Shared.ShowSuccessGritter(this, string.Format("procurmentheaderlist.aspx"));
    //        BindData();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}
    //protected void btnUnPost_Click(object sender, EventArgs e)
    //{
    //    UnPostData();
    //}

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {

        Response.Redirect("procurementreview.aspx?action=edit&id=" + gvwList.SelectedDataKey[0].ToString() + "&codebarcode=" + gvwList.SelectedDataKey[1].ToString());
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

    //protected void ddlTypeProcurment_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in gvwList.Rows)
    //    {
    //        DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);
     
    //        if (PurchaseType.SelectedValue.Equals("0"))
    //        {
    //            ddlTypeProcurment.Enabled = false;
    //            PurposeDepartment.Enabled = true;
    //        }
    //        else
    //        {
    //            ddlTypeProcurment.Enabled = true;
    //            PurposeDepartment.Enabled = false;
    //        }
    //    }
    //}

    //(+) Ari 11-07-2022 ket : enhancement 2022
    //protected void txtFromDate_TextChanged(object sender, EventArgs e)
    //{
    //    BindData();
    //}
    protected void txtToDateChanged(object sender, EventArgs e)
    {

        BindData();
    }

}


