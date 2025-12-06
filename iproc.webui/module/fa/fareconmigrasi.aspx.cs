using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_fareconmigrasi : BasePage
{
    private static string TABLE_NAME = "FA_ASSET";
    private static string TABLE_NAME_FA_ASSET_INSURANCE = "FA_ASSET_INSURANCE";
    private static string TABLE_NAME_FA_ASSET_HISTORY_LOCATION = "FA_ASSET_HISTORY_LOCATION";
    //private static string TABLE_NAME_FA_ASSET_HISTORY_DEPRECIATION = "FA_ASSET_HISTORY_DEPRECIATION";

    private static string TABLE_NAME_SYS_ASSET_TYPE = "SYS_ASSET_TYPE";


    protected void Page_Init(object sender, EventArgs e)
    {
        LoadAssetSpecificInfo();
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindFAGroup(ddlDepreCategoryBook);
            Shared.BindFACategoryFiscal(ddlDepreCategoryFiscal);
            btnLookUpLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FALOC&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtLocation.ClientID, lblLocation.ClientID, ddlBranch.ClientID);
            btnLookUpFAParent.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FAITM&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtFAParent.ClientID, lblFAParent.ClientID, txtBranch.ClientID);
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STAFF&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtSupplierID.ClientID, lblSupplierName.ClientID, txtBranch.ClientID);
            btnDeleteInsurance.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                imgBarcode.ImageUrl = @"~\temp\qrcodes\" + lbNobarcode.Text + ".png";
                imgBarcode.AlternateText = "image for barcode:" + lbNobarcode.Text + " not found. Please hit save button to update data.";
                BindData();
                BindDataa();
                BindDataDepre();
                BindDataaMaintenance();
                BindDataDepCom();
                BindDataDepFis();
                BindDataAdjHis();
                //LoadAssetSpecificInfo();
                lblID.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";

                if (Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] != null)
                    txtTabCode.Text = Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY].ToString();
            }


        }
        LoadAfterInit();
    }

    private void LoadAssetSpecificInfo()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = Request.Params["assettype"]; // "VHCL"; // ddlAssetType.Text;

            _ht["p_asset_no"] = Request.Params["assetno"];

            DataRow _dr = _dal.GetRow(TABLE_NAME_SYS_ASSET_TYPE, _ht);

            if (_dr != null && pnlPlaceholder.Page != null)
                pnlPlaceholder.Controls.Add(LoadControl("../../" + _dr["FILENAME"].ToString()));
        }
        catch (Exception)
        {
            //Shared.ShowErrorDialog(this, ex);
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

            _ht["p_id"] = Request.Params["id"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);
            

            DBToUI.Map(UpdatePanel1.Controls, _dr);
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
        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("edit"))
            {
                _dal.Update("","xsp_fa_asset_recon_update", _ht);
            }
            else
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }

            Shared.ShowSuccessGritter(this, string.Format("fareconmigrasi.aspx?action=edit&id={0}&assettype={1}&assetno={2}",
                                                                                    lblID.Text, Request.Params["assettype"].ToString(),
                                                                                    Request.Params["assetno"].ToString()));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void GenerateData()
    {
        try
        {
            new qr_gen().QRGen(lblBarcode.Text);
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
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GenerateData();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //Response.Redirect("faassetlist.aspx?catcode="   + Request.Params["catcode"].ToString()
        //                                                + "&loccode=" + Request.Params["loccode"].ToString()
        //                                                + "&branchcode=" + Request.Params["branchcode"].ToString()
        //                                                + "&astcode=" + Request.Params["astcode"].ToString());
        Response.Redirect("faassetlist.aspx");
    }

   

    #region Insurance detail

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = Request.Params["id"];
            _ht["p_keywords"] = txtSearchInsurance.Text;
            _ht["p_ast_code"] = txtAstCode.Text;


            gvwListInsurance.DataSource = _dal.GetRows(TABLE_NAME_FA_ASSET_INSURANCE, _ht);
            gvwListInsurance.DataBind();
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

            _dal.Delete(TABLE_NAME_FA_ASSET_INSURANCE, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListInsurance_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        gvwListInsurance.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void btnAddInsurance_Click(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        //Response.Redirect("faassetdetail.aspx?action=add&codebarcode="  + lblBarcode.Text 
        //                                                                + "&astcode=" + txtAstCode.Text 
        //                                                                + "&id=" + lblID.Text 
        //                                                                + "&assettype=" + Request.Params["assettype"]
        //                                                                + "&catcode=" + Request.Params["catcode"].ToString()
        //                                                                + "&loccode=" + Request.Params["loccode"].ToString()
        //                                                                + "&branchcode=" + Request.Params["branchcode"].ToString()
        //                                                                + "&astcode=" + Request.Params["astcode"].ToString());
        Response.Redirect("faassetdetail.aspx?action=add&codebarcode=" + lblBarcode.Text + "&astcode=" + txtAstCode.Text + "&id=" + lblID.Text + "&assettype=" + Request.Params["assettype"]);
    }

    protected void btnDeleteInsurance_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListInsurance.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwListInsurance.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindData();
    }

    protected void btnSearchInsurance_Click(object sender, EventArgs e)
    {
        if (txtAstCode.Text != string.Empty)
            BindData();
    }
    protected void gvwListInsurance_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        Response.Redirect(string.Format("faassetdetail.aspx?action=edit&id={0}&astcode={1}&faid={2}&assettype={3}&catcode={4}&loccode={5}&branchcode={6}&astcode={7}",
                                                                        gvwListInsurance.SelectedDataKey[0].ToString(), txtAstCode.Text,
                                                                        Request.Params["id"], Request.Params["assettype"].ToString(),
                                                                        Request.Params["catcode"].ToString(), Request.Params["loccode"].ToString(),
                                                                        Request.Params["branchcode"].ToString(), Request.Params["astcode"].ToString()));
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListInsurance.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbSelect") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    #endregion


    #region History

    private void BindDataa()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_code_barcode"] = lblBarcode.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_FA_ASSET_HISTORY_LOCATION, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindDataa();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataa();
    }
    #endregion

    #region Depre
    private void BindDataDepre()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDesp.Text;
            _ht["p_barcode"] = Request.Params["assetno"];
            gvwListDesp.DataSource = _dal.GetRows("FA_ASSET_HISTORY_DEPRECIATION", _ht);
            gvwListDesp.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListDesp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDesp.PageIndex = e.NewPageIndex;
        BindDataDepre();
    }

    protected void btnViewGvwListDesp_OnClick(object sender, EventArgs e)
    {
        Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;
        BindDataDepre();
    }
    protected void btnSearchDesp_Click(object sender, EventArgs e)
    {
        BindDataDepre();
    }
    #endregion

    #region Maintenance

    private void BindDataaMaintenance()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //_ht["p_keywords"] = txtSearch.Text;
            _ht["p_barcode"] = Request.Params["assetno"];

            gvwListMain.DataSource = _dal.GetRows("", "xsp_asset_maintenance_history_getrows", _ht);
            gvwListMain.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindDataaMaintenance();
    }

    protected void btnSearchMain_Click(object sender, EventArgs e)
    {
        BindDataa();
    }
    #endregion

    #region DepCom

    private void BindDataDepCom()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDepfis.Text;
            _ht["p_barcode"] = Request.Params["assetno"];

            gvwcomdep.DataSource = _dal.GetRows("", "xsp_fa_asset_depreciation_schedule_getrows", _ht);
            gvwcomdep.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListComdep_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwcomdep.PageIndex = e.NewPageIndex;
        BindDataDepCom();
    }


    protected void btnSearchcom_Click(object sender, EventArgs e)
    {
        BindDataDepCom();
    }
    #endregion

    #region DepFis

    private void BindDataDepFis()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDepfis.Text;
            _ht["p_barcode"] = Request.Params["assetno"];

            gvwcomfis.DataSource = _dal.GetRows("", "xsp_fa_asset_depreciation_schedule_fiscal_getrows", _ht);
            gvwcomfis.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListComfis_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwcomfis.PageIndex = e.NewPageIndex;
        BindDataDepFis();
    }

    protected void btnSearchcomfis_Click(object sender, EventArgs e)
    {
        BindDataDepFis();
    }


    #endregion

    #region AdjHis

    private void BindDataAdjHis()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDepfis.Text;
            _ht["p_barcode"] = Request.Params["assetno"];

            gvwadjhis.DataSource = _dal.GetRows("", "xsp_fa_adjust_history_getrows", _ht);
            gvwadjhis.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListadjhis_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwadjhis.PageIndex = e.NewPageIndex;
        BindDataAdjHis();
    }

    protected void btnSearchadjhis_Click(object sender, EventArgs e)
    {
        BindDataAdjHis();
    }


    #endregion
}

