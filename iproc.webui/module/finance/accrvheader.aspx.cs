using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_finance_accrvheader : BasePage
{
    private static string TABLE_NAME = "ACC_RV_HEADER";
    private static string TABLE_NAME_DETAIL = "ACC_RV_DETAIL";
    private decimal dTotalBase = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        //btnLookUpBranch.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=BRN&acol_0={0}&bcol_1={1}');", txtBranchCode.ClientID, lblBranch.ClientID);
        //btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRNB&acol_0={0}&bcol_1={1}&ccol_2={2}&ccol_3={3}&dcol_4={4}&parc_code={5}');", txtBankCode.ClientID, lblBank.ClientID, lblBankName.ClientID, lblBankNo.ClientID, ddlOrigCurrCode.ClientID, ddlBranchCode.ClientID);
        btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&parc_code={6}');", txtBankCode.ClientID, lblBank.ClientID, lblBankName.ClientID, lblBankNo.ClientID, ddlOrigCurrCode.ClientID, txtExchRate.ClientID, ddlBranchCode.ClientID);

        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyCode(ddlOrigCurrCode);
            Shared.BindCurrencyCode(ddlBaseCurrCode);
            Shared.BindBranchEmployee(ddlBranchCode);

            //ddlBaseCurrCode.SelectedValue = "IDR";
            txtRvDate.Text = txtValueDate.Text = DateTime.Today.ToString("dd/MM/yyyy");
            btnDeleteDetail.OnClientClick = "return confirm('Delete selected data?');";
            //  btnPost.OnClientClick = "return confirm('Post selected data?');";
            //  btnReject.OnClientClick = "return confirm('Cancel selected data?');";
          
            ddlBaseCurrCode.Enabled = ddlOrigCurrCode.Enabled = false;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataDetail();

                btnCancel.Text = "Back";
                //iconCancel.Attributes.Add("class", "icon-arrow-left btn btn-danger");
                txtBaseAmount.Enabled = false;

                if (lblRvStatus.Text == "POST" || lblRvStatus.Text == "CANCEL" || lblRvStatus.Text == "REJECT")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                    btnViewJurnal.Visible = false;
                    btnPrint.Visible = true;
                    ddlBranchCode.Enabled = false;
                    txtRvDate.Enabled = false;
                    txtExchRate.Enabled = false;
                    txtValueDate.Enabled = false;
                    txtOrigAmount.Enabled = false;
                }
                else
                {
                    //(+) Neng - 24/10/2016 13:28:11 - Control untuk kondisi manual dan automatic
                    if (lblStatus.Text == "AUTOMATIC")
                    {
                        btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                        gvwListDetail.Columns[1].Visible = false;
                    }
                    else
                    {
                        btnAddDetail.Visible = btnDeleteDetail.Visible = true;
                    }                    
                    btnReject.Visible = btnPost.Visible = true;
                    btnPrint.Visible = btnViewJurnal.Visible = false;
                }
            }
            else
            {
                btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                btnReject.Visible = btnPost.Visible = false;
                btnPrint.Visible = btnViewJurnal.Visible = false;
                txtOrigAmount.Text = txtExchRate.Text = txtBaseAmount.Text = "0.00";
            }
        }
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0058&parc_object_id={0}&parc_object_branch={1}');", lblRvNo.ClientID, lblbranch.ClientID);
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0057&parc_object_id={0}&parc_object_branch={1}');", lblRvNo.ClientID, lblbranch.ClientID);
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

            _ht["p_rv_no"] = Request.Params["rvno"];

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
        string iNextCode = "";
        try
        {
            //System.Diagnostics.Debugger.Break();
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_trx_code"] = "";
            _ht["p_reff_no"] = "";
            _ht["p_status"] = "MANUAL";

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextCode);
                lblRvNo.Text = iNextCode;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("accrvheader.aspx?action=edit&rvno={0}", lblRvNo.Text));
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
    //        //
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //        Shared.ApplyDefaultProp(_ht);

    //        _dal.ExecRawSP("xsp_acc_rv_header_post", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("accrvheader.aspx?action=edit&rvno={0}", lblRvNo.Text));
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

    //        _dal.ExecRawSP("xsp_acc_rv_header_cancel", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("accrvheader.aspx?action=edit&rvno={0}", lblRvNo.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

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

            _dal.ExecRawSP("xsp_acc_rv_header_print", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accrvheader.aspx?action=edit&rvno={0}", lblRvNo.Text));
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

            _dal.ExecRawSP("xsp_acc_rv_header_view_jurnal", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accrvheader.aspx?action=edit&rvno={0}", lblRvNo.Text));
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
        Response.Redirect("accrvheaderlist.aspx");
    }

    //protected void btnPost_Click(object sender, EventArgs e)
    //{
    //    PostData();
    //}

    //protected void btnReject_Click(object sender, EventArgs e)
    //{
    //    CancelData();
    //}

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        //PrintData();
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_rv_no"] = lblRvNo.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_RECEIPT_VOUCHER_LIST", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }
    protected void btnViewJurnal_Click(object sender, EventArgs e)
    {
        ViewJurnalData();
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
            _ht["p_rv_no"] = lblRvNo.Text;

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
        Response.Redirect("accrvdetail.aspx?action=add&rvno=" + lblRvNo.Text + "&currency=" + ddlOrigCurrCode.SelectedValue);
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

    protected void gvwListDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("accrvdetail.aspx?action=edit&id=" + gvwListDetail.SelectedDataKey[0].ToString() + "&rvno=" + lblRvNo.Text);
    }
    protected void gvwListDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            dTotalBase += Decimal.Parse(e.Row.Cells[7].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[7].Text = dTotalBase.ToString("N2");
        }
    }
    #endregion

}

