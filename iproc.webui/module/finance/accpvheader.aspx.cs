using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_finance_accpvheader : BasePage
{
    private static string TABLE_NAME = "ACC_PV_HEADER";
    private static string TABLE_NAME_DETAIL = "ACC_PV_DETAIL";
    private decimal dTotalBase = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        //btnLookUpBranch.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=BRN&acol_0={0}&bcol_1={1}');", txtBranchCode.ClientID, lblBranch.ClientID);
        //btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRNB&acol_0={0}&bcol_1={1}&ccol_2={2}&ccol_3={3}&dcol_4={4}&parc_code={5}');", txtBankCode.ClientID, lblBank.ClientID, lblBankName.ClientID, lblBankNo.ClientID, ddlOrigCurrCode.ClientID, ddlBranchCode.ClientID);
        btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&parc_code={6}');", txtBankCode.ClientID, lblBank.ClientID, lblBankName.ClientID, lblBankNo.ClientID, ddlOrigCurrCode.ClientID, txtExchRate.ClientID, ddlBranchCode.ClientID);
        btnLookUpToBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MBSG&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_1={3}&ecol_2={4}&fcol_2={5}&gcol_3={6}&hcol_3={7}&parc_supplier_code={8}');", txtBankCode.ClientID, lblBankCode.ClientID, txtBankName.ClientID, lbltoBankName.ClientID, txtToBankAccountName.ClientID, txtToBankAccountNo.ClientID, lblToBankAccountNo.ClientID, txtToBankAccountName.ClientID, lblToBankAccountName.ClientID, txtRequestor.ClientID);
        btnLookUpToBankManual.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MBG&acol_0={0}&bcol_1={1}&ccol_1={2}');", txtToBankManual.ClientID, txtBankNameManual.ClientID, lblBankNameManual.ClientID);
        if (!Page.IsPostBack)
        {
            Shared.BindCurrencyCode(ddlOrigCurrCode);
            Shared.BindCurrencyBase(txtBaseCurr);
            Shared.BindBranchEmployee(ddlBranchCode);
            txtPvDate.Text = txtValueDate.Text = DateTime.Today.ToString("dd/MM/yyyy");

            btnDeleteDetail.OnClientClick = "return confirm('Delete selected data?');";
            // btnPost.OnClientClick = "return confirm('Post selected data?');";
            // btnReject.OnClientClick = "return confirm('Cancel selected data?');";
           

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataDetail();

                btnCancel.Text = "Back";
                //iconCancel.Attributes.Add("class", "icon-arrow-left btn btn-danger");

                if (lblPvStatus.Text == "POST")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = ddlBranchCode.Enabled = false;
                    btnPrint.Visible = true;
                    btnLookUpBank.Enabled = false;
                    ddlOrigCurrCode.Enabled = false;
                    txtPvDate.Enabled = txtValueDate.Enabled = txtExchRate.Enabled = txtJmRemarks.Enabled = false;
                    txtOrigAmount.Enabled = false;
                }
                else if (lblPvStatus.Text == "REJECT")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = btnLookUpBank.Enabled = ddlBranchCode.Enabled = false;
                    btnPrint.Visible = false;
                    ddlOrigCurrCode.Enabled = false;
                    txtPvDate.Enabled = txtValueDate.Enabled = txtExchRate.Enabled = txtJmRemarks.Enabled = false;
                    txtOrigAmount.Enabled = false;
                    btnLookUpBank.Enabled = false;
                }
                else
                {
                   // btnAddDetail.Visible = btnDeleteDetail.Visible = true;
                    btnReject.Visible = btnPost.Visible = true;
                    btnPrint.Visible = false;
                }

                if (lblTrxCode.Text != "")
                {
                    btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                }

                //(+) Neng - 24/10/2016 10:04:44 - controller untuk payment intruction
                if (lblStatus.Text == "MANUAL")
                {
                    ToBankNameSupplier.Visible = false;
                    rfvToBankSupplier.Enabled = false;
                    RequestorSupplier.Visible = false;
                    rfvRequestorSupplier.Enabled = false;
                    ToBankAccountNoSupplier.Visible = false;
                    rfvToBankAccountNo.Enabled = false;
                    ToBankAccountNameSupplier.Visible = false;
                    rfvToBankAccountName.Enabled = false;
                }
                else
                {
                    ToBankNameManual.Visible = false;
                    rfvToBankManual.Enabled = false;
                    RequestorManual.Visible = false;
                    rfvRequestorManual.Enabled = false;
                    ToBankAccountNoManual.Visible = false;
                    rfvToBankAccountNoManual.Enabled = false;
                    ToBankAccountNameManual.Visible = false;
                    rfvToBankAccountNameManual.Enabled = false;
                }
            }
            else
            {
                btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                btnReject.Visible = btnPost.Visible = false;
                btnPrint.Visible = false;
                txtOrigAmount.Text = txtExchRate.Text = txtBaseAmount.Text = "0.00";

                //(+) Neng - 24/10/2016 10:04:44 - controller untuk payment intruction
                ToBankNameSupplier.Visible = false;
                rfvToBankSupplier.Enabled = false;
                RequestorSupplier.Visible = false;
                rfvRequestorSupplier.Enabled = false;
                ToBankAccountNoSupplier.Visible = false;
                rfvToBankAccountNo.Enabled = false;
                ToBankAccountNameSupplier.Visible = false;
                rfvToBankAccountName.Enabled = false;
            }
        }
        btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0055&parc_object_id={0}&parc_object_branch={1}');", lblPvNo.ClientID, lblbranch.ClientID);
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0056&parc_object_id={0}&parc_object_branch={1}');", lblPvNo.ClientID, lblbranch.ClientID);
        LoadInit();
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_pv_no"] = Request.Params["pvno"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindBranchEmployee(ddlBranchCode);
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

            _ht["p_pv_no"] = Request.Params["pvno"];

            _ht["p_trx_code"] = "";
            _ht["p_reff_no"] = "";
            _ht["p_status"] = "MANUAL";
            _ht["p_requestor_code"] = "-";

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextBarcode);
                lblPvNo.Text = sNextBarcode;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("accpvheader.aspx?action=edit&pvno={0}", lblPvNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void PostData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_acc_pv_header_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accpvheader.aspx?action=edit&pvno={0}", lblPvNo.Text));
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

            _dal.ExecRawSP("xsp_acc_pv_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accpvheader.aspx?action=edit&pvno={0}", lblPvNo.Text));
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

            _ht["p_pv_no"] = Request.Params["pvno"];
            _dal.ExecRawSP("xsp_acc_pv_header_print", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjmheader.aspx?action=edit&pvno={0}", lblPvNo.Text));
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
        Response.Redirect("accpvheaderlist.aspx");
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
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
        htParams["p_pv_no"] = lblPvNo.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_PAYMENT_VOUCHER_LIST", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
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
            _ht["p_pv_no"] = lblPvNo.Text;

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
        Response.Redirect("accpvdetail.aspx?action=add&pvno=" + lblPvNo.Text + "&currency=" + ddlOrigCurrCode.SelectedValue);
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
        Response.Redirect("accpvdetail.aspx?action=edit&id=" + gvwListDetail.SelectedDataKey[0].ToString() + "&pvno=" + lblPvNo.Text);
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

