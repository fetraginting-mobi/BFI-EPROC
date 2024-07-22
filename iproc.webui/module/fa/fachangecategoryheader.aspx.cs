using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_fachangecategoryheader : BasePage
{
    private static string TABLE_NAME_HEADER = "FA_CHANGE_CATEGORY";

    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        LinkButton btn = btnViewHistory as LinkButton;
        btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/approvelreviewapplication.aspx?action=edit&codebarcode={0}');", Request.Params["codebarcode"]);
      
        if (!Page.IsPostBack)
        {
            //Shared.BindFACategory(ddlFromCategory);
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            txtUnits.Text = Shared.CurrentEmployeeUnitsCode;
            Shared.BindBranchEmployeeAll(ddlBranch);
            Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);
            //Shared.BindFAChangeCategory(ddlToCategory,txtCategory.Text);
            //btnLookUpParentGroup.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LFIT&acol_0={0}&bcol_1={1}&parc_category_item={2}');", txtParentGroup.ClientID, lblParentGroup.ClientID, txtCategory.ClientID);
            //btnLookUpAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FACAT&acol_10={0}&bcol_0={1}&ccol_1={2}&dcol_5={3}&ecol_4={4}&fcol_9={5}&gcol_8={6}&parc_branch_code={7}');", txtItemCode.ClientID, lblItemCode.ClientID, lblItemName.ClientID, txtCategory.ClientID, lblCategory.ClientID,lblFadeprecommercial.ClientID,lblFAdeprefiscal.ClientID, txtBranch.ClientID);
            btnLookUpAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FACAT&acol_1={0}&bcol_0={1}&ccol_2={2}&dcol_3={3}&ecol_4={4}&fcol_9={5}&gcol_10={6}&hcol_11={7}&icol_12={8}&jcol_8={9}&parc_branch_code={10}&parc_units_code={11}&parc_location_code={12}');", txtItemCode.ClientID, lblItemCode.ClientID, lblItemName.ClientID, txtCategory.ClientID, lblCategory.ClientID, lblFadeprecommercial.ClientID, lblFAdeprefiscal.ClientID, lblCostPrice.ClientID, lblNetBookValue.ClientID, lblItemGroup.ClientID,ddlBranch.ClientID, txtUnits.ClientID,ddlFromLocationCode.ClientID);

            btnLookToUpAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FATCT&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_5={3}&ecol_6={4}&fcol_3={5}&gcol_7={6}&hcol_4={7}&icol_2={8}&parc_branch_code={9}&parc_units_code={10}');", txtToItemCode.ClientID, lblToItemCode.ClientID, lblToItemName.ClientID, txtToDepreFis.ClientID, lblToDepreFis.ClientID, txtToDpreCom.ClientID, lblToDpreCom.ClientID, txtToCategoryCode.ClientID, lblToCategoryCode.ClientID, txtBranch.ClientID, txtUnits.ClientID); //lblCategory.ClientID, ddlFACategoryFiscalCode.ClientID, ddlFACategoryBookCode.ClientID, txtBranch.ClientID);

            //btnLookUpParentGroup.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FCIT&acol_0={0}&bcol_1={1}&parc_category_item={2}');", txtParentGroup.ClientID, lblParentGroup.ClientID, txtCategory.ClientID);
           // btnLookUpParentGroupTo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FCIT&acol_0={0}&bcol_1={1}&parc_category_item={2}');", txtParentGroupTo.ClientID, lblParentGroupTo.ClientID, ddlToCategory.ClientID);

            //Shared.BindFAGroup(ddlFACategoryBookCode);
            //Shared.BindFACategoryFiscal(ddlFACategoryFiscalCode);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                //btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                // btnPost.OnClientClick = "return confirm('Post selected data?');";
                // btnReject.OnClientClick = "return confirm('Cancel selected data?');";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                txtChangeDate.Enabled = false;
                lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
                ddlBranch.Enabled = false;
                ddlFromLocationCode.Enabled = false;
                //ddlFACategoryBookCode.Enabled = false;
                //ddlFACategoryFiscalCode.Enabled = false;
                btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses!');";
                //btnLookUpParentGroup.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LFIT&acol_0={0}&bcol_1={1}&parc_category_item={2}');", txtParentGroup.ClientID, lblParentGroup.ClientID, txtCategory.ClientID);

                if (lblTransFlagCode.Text == "POST")
                {
                    btnSave.Visible = false;
                    txtChangeDate.Enabled = false;
                    btnPost.Visible = false;
                    
                  //  ddlToCategory.Enabled = false;
                    txtDescription.Enabled = false;
                    txtRemarks.Enabled = false;
                    btnLookUpAsset.Enabled = false;
                    btnLookToUpAsset.Enabled = false;
                   // ddlFACategoryBookCode.Enabled = false;
                   // ddlFACategoryFiscalCode.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlFromLocationCode.Enabled = false;


                }
                if (lblTransFlagCode.Text == "ONPROGRESS")
                {

                    btnSave.Visible = false;
                    txtChangeDate.Enabled = false;
                    btnPost.Visible = false;
                    btnLookUpAsset.Enabled = false;


                    //ddlToCategory.Enabled = false;
                    txtDescription.Enabled = false;
                    txtRemarks.Enabled = false;

                    btnLookToUpAsset.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlFromLocationCode.Enabled = false;
                    // ddlFACategoryBookCode.Enabled = false;
                    //ddlFACategoryFiscalCode.Enabled = false;

                }
                else if (lblTransFlagCode.Text == "NEW")// (+) Ari 27-12-2022 ket : saat New muncul, error list BFI_QA
                {
                    btnPost.Visible = true; 
                }

                if (!lblApprovalRequestTargetID.Text.Equals(""))
                    btnApprovalTiered.Visible = true;

            }
            else
            {
                txtChangeDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtChangeDate.Enabled = false;
                btnPost.Visible = false;
                Shared.BindBranchEmployeeAll(ddlBranch);
                Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);
                //ddlFACategoryBookCode.Enabled = false;
                //ddlFACategoryFiscalCode.Enabled = false;
            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/fa/fachangecategoryheaderlist.aspx";
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=APP0059&parc_object_id={0}&nexturl={1}&status={2}&parc_object_branch={3}&parc_object_amount={4}&parc_branch_code={5}&parc_object_description={6}&parc_object_code={7}');", lblCodeBarcode.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST", lblbranch.ClientID, lblAmount.ClientID, lblbranch.ClientID, txtRemarks.ClientID, lblCode.ClientID);
        btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
       // btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0059&parc_object_id={0}');", lblCodeBarcode.ClientID);
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
            Shared.BindBranchEmployeeAll(ddlBranch);
            Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);
            //Shared.BindFAGroup(ddlFACategoryBookCode);
            //Shared.BindFACategoryFiscal(ddlFACategoryFiscalCode);

           
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
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("fachangecategoryheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    //        _ht["p_code_barcode"] = lblCodeBarcode.Text;
    //        Shared.ApplyDefaultProp(_ht);

    //        _dal.ExecRawSP("xsp_fa_change_category_post", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("fachangecategoryheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    //        _dal.ExecRawSP("xsp_fa_mutation_header_cancel", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("famutationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {


           
            Shared.BindFaLocationAll(ddlFromLocationCode, ddlBranch.SelectedValue);
            txtItemCode.Text = null;
            lblItemName.Text = "--";

            

        //updDep.Update();
    }

    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {



     
        txtItemCode.Text = null;
        lblItemName.Text = "--";



        //updDep.Update();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("fachangecategoryheaderlist.aspx");
    }
    //protected void btnPost_Click(object sender, EventArgs e)
    //{
    //    PostData();
    //}
    //protected void btnReject_Click(object sender, EventArgs e)
    //{
    //    CancelData();
    //}



}

