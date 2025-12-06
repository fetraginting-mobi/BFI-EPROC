using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_faassetmaintenance : BasePage
{
    private static string TABLE_NAME = "FA_ASSET_MAINTENANCE";
    private static string TABLE_NAME_DETAIL = "FA_ASSET_MAINTENANCE_SERVICE";
    private static string GET_MULTIPLE_BRANCH = "GET_IS_AGAS"; // (+) Ari 30-12-2022 ket : enhancement 2022

    protected void Page_Load(object sender, EventArgs e)
    {
        //btnLookUpAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=AMN&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_1={3}&ecol_2={4}&fcol_2={5}&gcol_3={6}&hcol_3={7}&icol_4={8}&jcol_4={9}');",
        //                                    txtAssetMainNo.ClientID, lblAssetMainNo.ClientID, txtAssetNo.ClientID, lblAssetNo.ClientID, txtAgreementNo.ClientID, lblAgreementNo.ClientID, txtClientName.ClientID, lblClientName.ClientID, txtDescription.ClientID, lblDescription.ClientID);
        
       

        if (!Page.IsPostBack)
        {
            //btnPost.OnClientClick = "return confirm('Are you sure post this data ?');";
            btnLookUpRequestoro.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=RQST&acol_0={0}&bcol_1={1}&ccol_2={2}&ccol_3={3}&ccol_4={4}&parc_requestor={5}');", txtRequestorCode.ClientID, lblRequestorName.ClientID, ddlBranch.ClientID, ddlDepartment.ClientID, ddlDivision.ClientID, txtEntry.ClientID);
            Shared.BindDivision(ddlDivision);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            //btnLookUpFaAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FAMGL&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&ecol_3={4}&parc_location={5}');", lblBarcode.ClientID, txtBarcode.ClientID, lblAssetCode.ClientID, lblAssetName.ClientID, lblLocation.ClientID, txtBranch.ClientID);

            //(+) Ari 30-12-2022 ket : enhancement 2022, ambil aset sesuai dengan pilihan branch pada ddl.
            LoadDataagas(); // (+) Ari 30-12-2022 ket : enhancement 2022
            // (+) Ari 30-06-2022 ket : enhancement 2022 (jika Role Flag Is Agas bisa edit ddlBranch)
            if (lblMultiplebranch.Text == "1")
            {
                //ddlBranch.Enabled = true;
                btnLookUpFaAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FAMGL&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&ecol_3={4}&parc_location={5}');", lblBarcode.ClientID, txtBarcode.ClientID, lblAssetCode.ClientID, lblAssetName.ClientID, lblLocation.ClientID, ddlBranch.ClientID);
            }
            else
            {
                btnLookUpFaAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FAMGL&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&ecol_3={4}&parc_location={5}');", lblBarcode.ClientID, txtBarcode.ClientID, lblAssetCode.ClientID, lblAssetName.ClientID, lblLocation.ClientID, txtBranch.ClientID);
            }
            LoadInit();
          

            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
                txtTrxDate.Enabled = false;
                if (lblType.Text == "VHCL")
                {
                    lastkm.Visible = true;
                    rfvLastKm.Enabled = true;
                    txtLastKm.Visible = true;
                }
                else
                {
                    lastkm.Visible = false;
                    rfvLastKm.Enabled = false;
                    txtLastKm.Visible = false;
                }

                //btnCancel.Text = "Back";
                //iconCancel.Attributes.Add("class", "icon-arrow-left btn btn-danger");
            
            }
            else
            {
                btnPost.Visible = false;
                lblRequestorUID.Text = Shared.CurrentUID;
                lblEntry.Text = Shared.CurrentEmpName;
                txtEntry.Text = Shared.CurrentUID;
                txtRequestorCode.Text = Shared.CurrentUID;
                lblRequestorName.Text = Shared.CurrentEmpName;
                btnAdd.Visible = false;
                btnDelete.Visible = false;
                pnlService.Visible = false;
                txtTrxDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtTrxDate.Enabled = false;
                lastkm.Visible = false;
                rfvLastKm.Enabled = false;
                txtLastKm.Visible = false;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
               
                
            }
            if
                (lblStatus.Text == "POST")
            {
                btnSave.Visible = false;
                btnPost.Visible = false;
                txtTrxAmount.Enabled = false;
               // txtVendorBy.Enabled = false;
                txtTrxDate.Enabled = false;
               // txtReceiptNo.Enabled = false;
                txtRemarks.Enabled = false;
                btnLookUpFaAsset.Enabled = false;
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                ddlBranch.Enabled = false;
                txtLastKm.Enabled = false;
                btnAdd.Visible = false;
                btnDelete.Visible = false;

            }
           
        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/fa/faassetmaintenancelist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000038&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", txtId.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "PROCESSED", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, txtId.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000038&parc_object_id={0}&parc_object_branch={1}');", txtId.ClientID, lblbranch.ClientID);
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

            _ht["p_user_id"] = Shared.CurrentUID; // (+) Ari 30-12-2022 ket : enhancement 2022
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
           


        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    // (+) Ari 30-12-2022 ket : enhancement 2022 cek Role IS_AGAS
    private void LoadDataagas()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();


            _ht["p_user_id"] = Shared.CurrentUID;
            Shared.ApplyDefaultProp(_ht);
            DataRow _dr = _dal.GetRow(GET_MULTIPLE_BRANCH, _ht);

            //DBToUI.Map(this.Controls, _dr);
            lblMultiplebranch.Text = _dr.ItemArray[0].ToString();


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
        //string nextID = "";
        //string NextUrl = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            int inextId = 0;


            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref inextId);
                txtId.Text = inextId.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);


            Shared.ShowSuccessGritter(this, string.Format("faassetmaintenance.aspx?action=edit&id={0}", txtId.Text));
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
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //        Shared.ApplyDefaultProp(_ht);

    //        _ht["p_id"] = txtId.Text;

    //        _dal.ExecRawSP("xsp_asset_maintenance_post", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("assetmaintenance.aspx?action=edit&id={0}", txtId.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}
    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
        
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

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

       
        //updDep.Update();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }
    //protected void btnPost_Click(object sender, EventArgs e)
    //{
    //    PostData();
    //}
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("faassetmaintenancelist.aspx"));
    }

    #region Fa Asset Maintenance Service

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_id_header"] = txtId.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = code;

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
        BindData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("faassetmaintenanceservice.aspx?action=add&idheader=" + txtId.Text + "&barcode=" + txtBarcode.Text);
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

        BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (txtId.Text != string.Empty)
            BindData();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("faassetmaintenanceservice.aspx?action=edit&idheader={0}&id={1}&barcode={2}", txtId.Text, gvwList.SelectedDataKey[0].ToString(),txtBarcode.Text));
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwList.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    #endregion
}


