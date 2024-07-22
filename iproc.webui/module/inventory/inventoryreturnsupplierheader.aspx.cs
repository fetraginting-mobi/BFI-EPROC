using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
using System.Web.UI.HtmlControls;

public partial class module_inventory_inventoryreturnsupplierheader : BasePage
{
    private static string TABLE_NAME_HEADER = "INVENTORY_RETURN_SUPPLIER_HEADER";
    private static string TABLE_NAME_DETAIL = "INVENTORY_RETURN_SUPPLIER_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            btnLookUpGRNCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=GRNOT&acol_0={0}&bcol_1={1}');", txtGRNCode.ClientID, lblGRNCode.ClientID);
            // btnPrint.Visible = false;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                lblCodeBarcode.Enabled = false;
                btnLookUpGRNCode.Enabled = false;

                BindData();

                //btnDeleteIssueDetail.OnClientClick = "return confirm('Delete selected data?');";
                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnReject.OnClientClick = "return confirm('Cancel selected data?');";

                if (lblTransFlagDesc.Text == "POST" || lblTransFlagDesc.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    // btnDeleteIssueDetail.Visible = false;
                    txtRetrunDate.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpGRNCode.Enabled = false;
                    gvwList.Columns[1].Visible = false;
                    btnSaveDetail.Visible = false;
                    //btnPrint.Visible = true;

                }
            }
            else
            {
                btnReject.Visible = btnPost.Visible = false;
                //btnDeleteIssueDetail.Visible = false;
                lblBranchUID.Text = Shared.CurrentEmployeeBranchCode;
                pnlIssue.Visible = false;
                btnPrint.Visible = false;
            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/inventoryreturnsupplierheaderlist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000044&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblBranchUID.ClientID, lblCode.ClientID);
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000010&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_code={4}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "CANCEL", lblBranchUID.ClientID, lblCode.ClientID);
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
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);
            Shared.ShowSuccessGritter(this, string.Format("inventoryreturnsupplierheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
        Response.Redirect("inventoryreturnsupplierheaderlist.aspx");
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

    private void SaveDataDetail()
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
                    
                    string Quantity = ((TextBox)row.Cells[9].Controls[1]).Text;
                     

                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_quantity"] = Quantity;


                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_inventory_return_supplier_detail_update", _ht);
                }


            }

            Shared.ShowSuccessGritter(this, string.Format("inventoryreturnsupplierheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtQuantity = (TextBox)e.Row.FindControl("txtQuantity");
            
            txtQuantity.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "QUANTITY"));

            
            if (lblTransFlagDesc.Text == "POST" || lblTransFlagDesc.Text == "CANCEL")
            {
                txtQuantity.Enabled = false;
            }
        }
    }
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
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

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_code_barcode"] = lblCodeBarcode.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_INVENTORY_RETURN", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }

}
