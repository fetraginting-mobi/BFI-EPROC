using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventorymaintenance : BasePage
{
    private static string TABLE_NAME = "INVENTORY_MAINTENANCE";
    private static string TABLE_NAME_DETAIL = "INVENTORY_MAINTENANCE_SERVICE";

    protected void Page_Load(object sender, EventArgs e)
    {
        //btnLookUpAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=AMN&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_1={3}&ecol_2={4}&fcol_2={5}&gcol_3={6}&hcol_3={7}&icol_4={8}&jcol_4={9}');",
        //                                    txtAssetMainNo.ClientID, lblAssetMainNo.ClientID, txtAssetNo.ClientID, lblAssetNo.ClientID, txtAgreementNo.ClientID, lblAgreementNo.ClientID, txtClientName.ClientID, lblClientName.ClientID, txtDescription.ClientID, lblDescription.ClientID);

       
        LoadInit();
        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            btnLookUpInventory.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=IMFL&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&ecol_3={4}&parc_branch_code={5}');", lblBarcode.ClientID, txtBarcode.ClientID, lblAssetCode.ClientID, lblAssetName.ClientID, lblLocation.ClientID,txtBranch.ClientID);
            //btnPost.OnClientClick = "return confirm('Are you sure post this data ?');";
            btnLookUpRequestoro.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=RQST&acol_0={0}&bcol_1={1}&ccol_2={2}&ccol_3={3}&ccol_4={4}&parc_requestor={5}');", txtRequestorCode.ClientID, lblRequestorName.ClientID, ddlBranch.ClientID, ddlDepartment.ClientID, ddlDivision.ClientID, txtEntry.ClientID);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData(); 
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                txtTrxDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtTrxDate.Enabled = false;
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
                //iconCancel.Attributes.Add("class", "icon-arrow-left btn btn-danger");

                if (lblPaidStatus.Text == "PAID")
                {
                    txtVendorBy.Visible = true;
                    vendor.Visible = true;

                }

                else
                {
                    txtVendorBy.Visible = false;
                    vendor.Visible = false;
                }
            }
            else
            {
                btnPost.Visible = false;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                ddlSubDepartment.SelectedValue = Shared.CurrentEmployeeSubDepartmentCode;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                vendor.Visible = false;
                txtVendorBy.Visible = false;
                txtRequestorCode.Text = Shared.CurrentUID;
                lblRequestorName.Text = Shared.CurrentEmpName;
              
               
                pnlService.Visible = false;
                txtTrxDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtTrxDate.Enabled = false;
            }
            if
                (lblStatus.Text == "POST")
            {
                

                btnSave.Visible = false;
                btnPost.Visible = false;
                txtTrxAmount.Enabled = false;
                txtVendorBy.Visible = true;
                txtTrxDate.Enabled = false;
                txtReceiptNo.Enabled = false;
                txtRemarks.Enabled = false;
                btnLookUpInventory.Enabled = false;
                btnLookUpRequestoro.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                ddlBranch.Enabled = false;
                ddlDivision.Enabled = false;
                ddlSubDepartment.Enabled = false;
                btnAdd.Visible = false;
                btnDelete.Visible = false;
                vendor.Visible = false;
                txtVendorBy.Visible = false;
                if (lblPaidStatus.Text == "PAID")
                {
                    txtVendorBy.Visible = true;
                    vendor.Visible = true;

                }

                else
                {
                    txtVendorBy.Visible = false;
                    vendor.Visible = false;
                }
            }

        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/inventorymaintenanceheaderlist.aspx";

        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000045&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", txtId.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, txtId.ClientID);
       // btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000045&parc_object_id={0}&parc_object_branch={1}');", txtId.ClientID, lblbranch.ClientID);
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
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
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
        string nextID = "";
        string NextUrl = "";

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


            Shared.ShowSuccessGritter(this, string.Format("inventorymaintenance.aspx?action=edit&id={0}", txtId.Text));
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
    //protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
    //    //updDep.Update();
    //}
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
        Response.Redirect(String.Format("inventorymaintenanceheaderlist.aspx"));
    }

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);



        //updDep.Update();
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


    #region Inventory Maintenance Service

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
        Response.Redirect("inventorymaintenanceservice.aspx?action=add&idheader=" + txtId.Text + "&barcode=" + txtBarcode.Text);
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
        Response.Redirect(string.Format("inventorymaintenanceservice.aspx?action=edit&idheader={0}&id={1}&barcode={2}", txtId.Text, gvwList.SelectedDataKey[0].ToString(), txtBarcode.Text));
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



