using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_purchaserequesttender : BasePage
{
    private static string TABLE_NAME_HEADER = "PURCHASE_REQUEST_TENDER";
    private static string TABLE_NAME_DETAIL = "PURCHASE_TENDER";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranch(ddlBranch);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblCodeBarcode.Enabled = false;
                 

                BindTender();
                //btnPost.OnClientClick = "return confirm('Post selected data?');";
                //btnReject.OnClientClick= "return confirm('Cancel selected data?');";

            }
            else
            {
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                
                pnlQuotation.Visible = false;
            }
        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/purchaseorder/purchaserequesttenderlist.aspx";

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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchaserequesttenderlist.aspx");
    }

    private void ClosedData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //string sNextBarcode = "";
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            
            Shared.ApplyDefaultProp(_ht);
            _ht["p_code_barcode"] = Request.Params["codebarcode"];


            _dal.ExecRawSP("xsp_purchase_request_tender_closed", _ht);


            Shared.ShowSuccessGritter(this, string.Format("purchaserequesttenderlist.aspx"));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnClosed_Click(object sender, EventArgs e)
    {
        ClosedData();
    }
    
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_pq_code"] = lblCodeBarcode.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_APPROVE_MEMO_LIST", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }

    #region purchase tender

    private void BindTender()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_request_tender_no"] = Request.Params["codebarcode"];

            gvwList.DataSource = _dal.GetRows("", "xsp_purchase_tender_getrows_by_request", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void Winner(string barcode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //string sNextBarcode = "";
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_code_barcode"] = barcode;


            _dal.ExecRawSP("xsp_purchase_tender_update_winner", _ht);

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void DeleteData(string codebarcode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = codebarcode;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
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
    
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindTender();
    }

    protected void btnWinner_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                Winner(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindTender();

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

        BindTender();

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindTender();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("purchaserequesttenderdetail.aspx?action=edit&id={0}&requesttenderno={1}&codebarcode={2}", gvwList.SelectedDataKey[1].ToString(), gvwList.SelectedDataKey[0].ToString(), Request.Params["codebarcode"]));
    }
    #endregion
}
