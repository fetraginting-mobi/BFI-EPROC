using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_accjurnalheader : BasePage
{
    private static string TABLE_NAME = "ACC_JURNAL_HEADER";
    private static string TABLE_NAME_DETAIL = "ACC_JURNAL_DETAIL";

    //untuk detail
    private decimal dTrxAmountDb = 0;
    private decimal dTrxAmountCr = 0;
    private decimal dTrxAmountBaseDb = 0;
    private decimal dTrxAmountBaseCr = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        btnLookUpBranch.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=BRN&acol_0={0}&bcol_1={1}');", txtBranchCode.ClientID, lblBranch.ClientID);

        if (!Page.IsPostBack)
        {

            //btnDeleteDetail.OnClientClick = "return confirm('Delete selected data?');";
            //btnPost.OnClientClick = "return confirm('Post selected data?');";
            //btnReject.OnClientClick = "return confirm('Cancel selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataDetail();

                //btnCancel.Text = "Back";

            }
             

        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //_ht["p_id"] = Request.Params["id"];

            _ht["p_voucher_no"] = Request.Params["voucherno"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);
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
        int iNextID = 0;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                txtId.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjurnalheader.aspx?action=edit&id={0}", txtId.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void BackToJM()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_voucher_no"] = lblVoucherNo.Text;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_acc_jurnal_header_backtojm", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjurnalheaderlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void BackToCashier()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_voucher_no"] = lblVoucherNo.Text;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_acc_jurnal_header_backtocashier", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjurnalheaderlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void CancelData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_acc_jurnal_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjurnalheader.aspx?action=edit&id={0}", txtId.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void PrintData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_acc_jurnal_header_print", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjurnalheader.aspx?action=edit&id={0}", txtId.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void ViewJurnalData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_acc_jurnal_header_view_jurnal", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjurnalheader.aspx?action=edit&id={0}", txtId.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("accjurnalheaderlist.aspx");
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        CancelData();
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        //PrintData();
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_voucher_no"] = lblVoucherNo.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_JURNAL_TRANSACTION", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }
    protected void btnPrintExcel_Click(object sender, EventArgs e)
    {
        //PrintData();
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_voucher_no"] = lblVoucherNo.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReportExcel(this, "RPT_JURNAL_TRANSACTION", htParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);

        Shared.PreviewReport(this, sFilename);
    }
    protected void btnViewJurnal_Click(object sender, EventArgs e)
    {
        ViewJurnalData();
    }
    protected void btnBackToJM_Click(object sender, EventArgs e)
    {
        BackToJM();
    }

    protected void btnBackToCashier_Click(object sender, EventArgs e)
    {
        BackToCashier();
    }

    #region Detail
    private void BindDataDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDetail.Text;
            _ht["p_voucher_no"] = Request.Params["voucherno"];

            gvwListDetail.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwListDetail.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataDetail(string ID)
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


    protected void gvwListDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDetail.PageIndex = e.NewPageIndex;
        BindDataDetail();
    }

    protected void btnAddDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect("accjurnaldetail.aspx?action=add&idheader=" + txtId.Text);
    }

    protected void btnDeleteDetail_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataDetail(gvwListDetail.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindDataDetail();
    }

    protected void btnSearchDetail_Click(object sender, EventArgs e)
    {
        BindDataDetail();
    }

    protected void gvwList_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            dTrxAmountDb = dTrxAmountDb + decimal.Parse(e.Row.Cells[5].Text);
            dTrxAmountCr = dTrxAmountCr + decimal.Parse(e.Row.Cells[6].Text);
            dTrxAmountBaseDb = dTrxAmountBaseDb + decimal.Parse(e.Row.Cells[8].Text);
            dTrxAmountBaseCr = dTrxAmountBaseCr + decimal.Parse(e.Row.Cells[9].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[5].Text = dTrxAmountDb.ToString("N2");
            e.Row.Cells[6].Text = dTrxAmountCr.ToString("N2");
            e.Row.Cells[8].Text = dTrxAmountBaseDb.ToString("N2");
            e.Row.Cells[9].Text = dTrxAmountBaseCr.ToString("N2");

        }
    }

    protected void gvwListDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("accjurnaldetail.aspx?action=edit&id=" + gvwListDetail.SelectedDataKey[0].ToString() + "&idheader=" + txtId.Text);
    }
    #endregion

}

