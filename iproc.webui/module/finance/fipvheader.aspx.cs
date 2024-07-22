using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
public partial class module_finance_fipvheader : BasePage
{
    private static string TABLE_NAME = "FI_PV_HEADER";
    private static string TABLE_NAME_DETAIL = "FI_PV_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        //btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&parc_code={2}');", txtBankCode.ClientID, lblBank.ClientID, ddlBranchCode.ClientID);
        btnLookUpBank.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=BRBPV&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&ecol_4={4}&fcol_5={5}&parc_code={6}');", txtBankCode.ClientID, lblBank.ClientID, lblBankName.ClientID, lblBankNo.ClientID, txtorigCurrCode.ClientID, txtExchRate.ClientID, ddlBranchCode.ClientID);

        if (!Page.IsPostBack)
        {
            btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0038&parc_object_id={0}&parc_object_branch={1}');", lblPvNo.ClientID, txtBranchCode.ClientID);
            btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0062&parc_object_id={0}&parc_object_branch={1}');", lblPvNo.ClientID, txtBranchCode.ClientID);
            btnDeleteDetail.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {

                InitData();
                Shared.BindBranch(ddlBranchCode);
                LoadData();
                BindDataDetail();

                btnCancel.Text = "Back";
                iconCancel.Attributes.Add("class", "icon-arrow-left btn btn-danger");
                ddlBranchCode.Enabled = false;
                txtToBank.Enabled = txtToBankAccountNo.Enabled = txtToBankAccountName.Enabled = false;

                if (lblPvStatus.Text == "POST" || lblPvStatus.Text == "CANCEL")
                {
                    btnReject.Visible = false;
                    btnPost.Visible = false;
                    btnPrint.Visible = true;
                    pnlAllTab.Enabled = false;
                    btnSave.Visible = btnDeleteDetail.Visible = false;
                }
                else
                {
                    btnPost.Visible = true;
                    btnPrint.Visible = false;
                }
            }
            else
            {
                btnPost.Visible = false;
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

            _ht["p_pv_no"] = Request.Params["pvno"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);
            DBToUI.Map(this.Controls, _dr);
            //Shared.BindBank(ddlBranchBank, ddlBranchCode.Text);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void InitData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_pv_no"] = Request.Params["pvno"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            ddlBranchCode.Text = _dr["PV_BRANCH_CODE"].ToString();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void SaveData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    string sNextBarcode = "";
    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //        Shared.ApplyDefaultProp(_ht);

    //        _ht["p_pv_no"] = Request.Params["pvno"];

    //        if (Request.Params["action"].Equals("add"))
    //        {
    //            _dal.Insert(TABLE_NAME, _ht, ref sNextBarcode);
    //            lblPvNo.Text = sNextBarcode;
    //        }
    //        else
    //            _dal.Update(TABLE_NAME, _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("fipvheader.aspx?action=edit&pvno={0}", lblPvNo.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

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

            _dal.ExecRawSP("xsp_fi_pv_header_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("fipvheader.aspx?action=edit&pvno={0}", lblPvNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void RejectData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_fi_pv_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("fipvheader.aspx?action=edit&pvno={0}", lblPvNo.Text));
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

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_fi_pv_header_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("fipvheader.aspx?action=edit&pvno={0}", lblPvNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //protected void btnSave_Click(object sender, EventArgs e)
    //{
    //    SaveData();
    //}
    protected void btnReject_Click(object sender, EventArgs e)
    {
        RejectData();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("fipvheaderlist.aspx");
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {

        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_pv_no"] = lblPvNo.Text;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "RPT_PAYMENT_VOUCHER_LIST", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }


    #region FI PV DETAIL
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

    protected void gvwListDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDetail.PageIndex = e.NewPageIndex;
        BindDataDetail();
    }


    //protected void btnAddDetail_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("fipvdetail.aspx?action=add&pvno=" + lblPvNo.Text);
    //}

    protected void btnSearchDetail_Click(object sender, EventArgs e)
    {
        BindDataDetail();
    }

    protected void gvwListDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("fipvdetail.aspx?action=edit&id=" + gvwListDetail.SelectedDataKey[0].ToString() + "&pvno=" + lblPvNo.Text);
    }

    protected void btnDeleteDetail_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataDetail(gvwListDetail.DataKeys[row.RowIndex][0].ToString(), gvwListDetail.DataKeys[row.RowIndex][1].ToString());
            }
        }
        BindDataDetail();
    }


    private void DeleteDataDetail(string ID, string PR_NO)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;
            _ht["p_pr_no"] = PR_NO;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #endregion

    //private void LoadDataBranchBank()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_branch_code"] = ddlBranchCode.SelectedValue;

    //        DataRow _dr = _dal.GetRow(TABLE_NAME, "xsp_fi_pv_header_getrows_for_branch_bank", _ht);
    //        DBToUI.Map(updBranchBank.Controls, _dr);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //protected void ddlBranchCode_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    LoadDataBranchBank();
    //    Shared.BindBank(ddlBranchBank,ddlBranchCode.Text);
    //    updBranchBank.Update();
    //}
}
