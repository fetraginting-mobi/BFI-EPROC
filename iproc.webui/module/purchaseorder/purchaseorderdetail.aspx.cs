using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_purchaseorder_purchaseorderdetail : BasePage
{

    private static string TABLE_NAME = "PURCHASE_ORDER_DETAIL";
    private static string GET_MULTIPLE_BRANCH = "GET_IS_AGAS"; // (+) Ari 04-07-2022 ket : enhancement 2022

    protected void Page_Load(object sender, EventArgs e)
    {
      
        
        LoadInit();
        if (!Page.IsPostBack)
        {

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranch(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
            Shared.BindTaxScreme(ddlTaxType);

            // (+) Ari 09-01-2023 ket : jika multiplebranch ambil branch dari po header
            LoadDataagas();
          
           
            txtUnit.Text = Shared.CurrentEmployeeUnitsCode;
            //txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            // (+) Ari 09-01-2023 ket : jika agas ambil branch dari po header
            if (lblMultiplebranch.Text == "1")
            {
                txtBranch.Text = Request.Params["branch_code"];
            }
            else
            {
                txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            }
            
            txtSupplier.Text = Request.Params["suppliercode"];

            btnLookUpItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=POITM&acol_0={0}&bcol_1={1}&ccol_2={2}&parc_unit_code={3}&parc_branch={4}&parc_supplier_code={5}');", txtItemCode.ClientID, txtItemName.ClientID, ddlUnit.ClientID, txtUnit.ClientID, txtBranch.ClientID, txtSupplier.ClientID);
            btnLookUpRequestoro.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=RQST&acol_0={0}&bcol_1={1}&ccol_2={2}&ccol_3={3}&ccol_4={4}&parc_requestor={5}&parc_branch_code={6}');", txtRequestorCode.ClientID, lblRequestorName.ClientID, ddlBranch.ClientID, ddlDepartment.ClientID, ddlDivision.ClientID, txtEntry.ClientID, txtBranch.ClientID);
            btnLookUpPurchaseQuotation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LUPQC&acol_0={0}&bcol_1={1}');", txtPQCode.ClientID, lblPQCode.ClientID);
            Shared.BindItemUOM(ddlUnit,txtItemCode.Text);
          
            //Shared.BindBranch(ddlBranch);
          
            lblBarcode.Text = Request.Params["codebarcode"];

            if (Request.Params["flagprocess"] == "MNL")
            {
                btnLookUpItem.Enabled = true;
                ddlDepartment.Enabled = true;
                btnLookUpRequestoro.Enabled = true;
                ddlDivision.Enabled = true;
                ddlSubDepartment.Enabled = true;
                ddlUnits.Enabled = true;
                ddlUnit.Enabled = true;
                txtPPN.Enabled = txtPPH.Enabled = false;
                btnCancelAp.Visible = false;
            }
            else if (Request.Params["flagprocess"] == "GNR")
            {
                btnLookUpItem.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlDivision.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                btnLookUpRequestoro.Enabled = false;
                txtPPN.Enabled = txtPPH.Enabled = false;
                btnLookUpItem.Enabled = false;
                btnCancelAp.Visible = false;
            }
            if (Request.Params["flagrent"] == "1")
            {
                PST.Visible = true;
                txtStartRent.Visible = true;
              //  rfvStartRent.Enabled = true;
                txtDueRentFrom.Visible = true;
                DRF.Visible = true;
                txtDueRentFrom.Visible = true;
              //  rfvDueRentFrom.Enabled = true;
                DRT.Visible = true;
                txtDueRentTo.Visible = true;
              // rfvDueRentTo.Enabled = true;

            }
            if (Request.Params["flagrent"] == "0")
            {
                PST.Visible = false;
                txtStartRent.Visible = false;
              //  rfvStartRent.Enabled = false;
                txtDueRentFrom.Visible = false;
                DRF.Visible = false;
                txtDueRentFrom.Visible = false;
              //  rfvDueRentFrom.Enabled = false;
                DRT.Visible = false;
                txtDueRentTo.Visible = false;
              //  rfvDueRentTo.Enabled = false;

            }

            /// Arjun Agar Cabang automatis enable dan ter set tax nya non tax
            if (Request.Params["action"].Equals("add"))
            {
                ddlTaxType.Enabled = false;
                if (txtBranch.Text != "KPO")
                {

                    ddlTaxType.SelectedValue = "TS00005";

                }

                if (txtBranch.Text.Equals("KPO"))
                {

                    ddlTaxType.Enabled = true;

                }
            }

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                ddlBranch.Enabled = false;
                Shared.BindItemUOM(ddlUnit, txtItemCode.Text);
                btnCancelAp.Visible = false;
               // btnCancel.Text = "Back";
                //btnSave.Visible = false;
                lblCurrency.Text = Request.Params["currency_desc"];
                lblCurrencyUI.Text = Request.Params["currency_code"];
                lblStatus.Text = Request.Params["status"];
                ////// Arjun Selain HO tidak boleh mengubah type TAX nya
                txtPPH.Enabled = false;
                txtPPN.Enabled = false;
                ddlTaxType.Enabled = false;
                if (txtBranch.Text.Equals("KPO"))
                {

                    ddlTaxType.Enabled = true;

                }

                // Arjun selain HO automatis tidak ada tax scheme
                if (txtBranch.Text != "KPO")
                {

                    ddlTaxType.SelectedValue = "TS00005";

                }

                /// Arjun Selain HO tidak boleh mengubah type TAX nya
                if (lblStatus.Text.Equals("NEW"))
                {
                    ddlTaxType.Enabled = false;
                    if (txtBranch.Text.Equals("KPO"))
                    {

                        ddlTaxType.Enabled = true;

                    }
                }
                //////////// batas
                if (Request.Params["flagprocess"] == "MNL")
                {
                    txtOrderQuantity.Enabled = true;
                    ddlUnit.Enabled = true;
                    btnCancelAp.Visible = false;
                }
                else
                {
                    txtOrderQuantity.Enabled = false;
                    ddlUnit.Enabled = false;
                    btnCancelAp.Visible = false;
                }

                if (lblStatus.Text == "POST" || lblStatus.Text == "CLOSED" || lblStatus.Text == "CLOSED FULL" || lblStatus.Text == "CLOSED PARTIAL" || lblStatus.Text == "CANCEL")
                {
                    btnSave.Visible = false;
                    btnLookUpItem.Enabled = false;
                    txtOrderQuantity.Enabled = false;
                    txtDeliveryDuration.Enabled = false;
                    txtGuarantee.Enabled = false;
                    txtGuaranteeDuration.Enabled = false;
                    btnLookUpPurchaseQuotation.Enabled = false;
                    btnLookUpRequestoro.Enabled = false;
                    //ddlBranch.Enabled = false;
                    txtUnitPrice.Enabled = false;
                    txtCreditDuration.Enabled = false;
                    txtDescription.Enabled = false;
                    txtDueRentFrom.Enabled = false;
                    txtDueRentTo.Enabled = false;
                    txtPeriod.Enabled = false;
                    txtStartRent.Enabled = false;
                    txtAmortizationStartDate.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlTaxType.Enabled = false;
                    //ddlSubBranch.Enabled = false;
                    txtPPN.Enabled = txtPPH.Enabled = false;
                    btnCancel.Visible = true;
                   btnCancelAp.Visible = false;
                   txtAdditionalAmount.Enabled = false;
                    
                }

                if (lblStatus.Text == "ON-PROGRESS")
                {
                    btnSave.Visible = false;
                    btnCancel.Visible = true;
                    btnLookUpItem.Enabled = false;
                    txtOrderQuantity.Enabled = false;
                    txtDeliveryDuration.Enabled = false;
                    txtGuarantee.Enabled = false;
                    txtGuaranteeDuration.Enabled = false;
                    btnLookUpPurchaseQuotation.Enabled = false;
                    btnLookUpRequestoro.Enabled = false;
                    //ddlBranch.Enabled = false;
                    txtUnitPrice.Enabled = false;
                    txtCreditDuration.Enabled = false;
                    txtDescription.Enabled = false;
                    txtDueRentFrom.Enabled = false;
                    txtDueRentTo.Enabled = false;
                    txtPeriod.Enabled = false;
                    txtStartRent.Enabled = false;
                    txtAmortizationStartDate.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlDepartment.Enabled = false;
                    ddlDivision.Enabled = false;
                    ddlUnits.Enabled = false;
                    ddlSubDepartment.Enabled = false;
                    ddlTaxType.Enabled = false;
                    //ddlSubBranch.Enabled = false;
                    txtPPN.Enabled = txtPPH.Enabled = false;
                    btnCancel.Visible = true;
                    btnCancelAp.Visible = false;
                }

                if (Request.Params["flagrent"] == "1")
                {
                    PST.Visible = true;
                    txtStartRent.Visible = true;
                 //   rfvStartRent.Enabled = true;
                    txtDueRentFrom.Visible = true;
                    DRF.Visible = true;
                    txtDueRentFrom.Visible = true;
                 //   rfvDueRentFrom.Enabled = true;
                    DRT.Visible = true;
                    txtDueRentTo.Visible = true;
                 //   rfvDueRentTo.Enabled = true;
                    PRD.Visible = true;
                    txtPeriod.Visible = true;
                    btnCancelAp.Visible = false;
                }
                if (Request.Params["flagrent"] == "0")
                {
                    PST.Visible = false;
                    txtStartRent.Visible = false;
                //    rfvStartRent.Enabled = false;
                    txtDueRentFrom.Visible = false;
                    DRF.Visible = false;
                    txtDueRentFrom.Visible = false;
               //     rfvDueRentFrom.Enabled = false;
                    DRT.Visible = false;
                    txtDueRentTo.Visible = false;
              //      rfvDueRentTo.Enabled = false;
                    PRD.Visible = false;
                    txtPeriod.Visible = false;
                    btnCancelAp.Visible = false;

                }
                else
                {
                    btnCancelAp.Visible = false;
                }

            }
            else
            {
                if (Request.Params["flagprocess"] == "MNL")
                {
                    txtOrderQuantity.Enabled = true;
                }
                else
                {
                    txtOrderQuantity.Enabled = false;
                   
                }


                if (Request.Params["flagrent"] == "1")
                {
                    PST.Visible = true;
                    txtStartRent.Visible = true;
                    //   rfvStartRent.Enabled = true;
                    txtDueRentFrom.Visible = true;
                    DRF.Visible = true;
                    txtDueRentFrom.Visible = true;
                    //   rfvDueRentFrom.Enabled = true;
                    DRT.Visible = true;
                    txtDueRentTo.Visible = true;
                    //   rfvDueRentTo.Enabled = true;
                    PRD.Visible = true;
                    txtPeriod.Visible = true;
                   

                }
                if (Request.Params["flagrent"] == "0")
                {
                    PST.Visible = false;
                    txtStartRent.Visible = false;
                    //    rfvStartRent.Enabled = false;
                    txtDueRentFrom.Visible = false;
                    DRF.Visible = false;
                    txtDueRentFrom.Visible = false;
                    //     rfvDueRentFrom.Enabled = false;
                    DRT.Visible = false;
                    txtDueRentTo.Visible = false;
                    //      rfvDueRentTo.Enabled = false;
                    PRD.Visible = false;
                    txtPeriod.Visible = false;
                }





                lblEntry.Text = Shared.CurrentEmpName;
                txtEntry.Text = Shared.CurrentUID;
                //ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCode;
                ddlSubDepartment.SelectedValue = Shared.CurrentEmployeeSubDepartmentCode;
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindDivision(ddlDivision);
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                //Shared.BindBranch(ddlBranch);
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
                ddlDivision.Enabled = false;
                ddlDepartment.Enabled = false;
                ddlSubDepartment.Enabled = false;
                ddlUnits.Enabled = false;
                ddlBranch.Enabled = false;
                btnLookUpRequestoro.Enabled = true;
                lblRequestorName.Text = Shared.CurrentEmpName;
                txtRequestorCode.Text = Shared.CurrentUID; 
                btnCancelAp.Visible = false;

                // (+) Ari 09-01-2023 ket : jika agas ambil branch dari po header
                if (lblMultiplebranch.Text == "1")
                {
                    ddlBranch.SelectedValue = Request.Params["branch_code"];
                }
                else
                {
                    ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
                    Shared.BindBranch(ddlBranch);
                }

               
               // Shared.BindSubBranch(ddlSubBranch, ddlBranch.SelectedValue);
               
           

                GetDocumentNo();
                lblCurrency.Text = Request.Params["currency_desc"];
                lblCurrencyUI.Text = Request.Params["currency_code"];
                lblStatus.Text = Request.Params["status"];

            }

        }
        LoadAfterInit();
    }

    private void GetDocumentNo()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow("PURCHASE_ORDER_HEADER", _ht);

            lblPurchaseOrderCode.Text = _dr["code"].ToString();
            
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
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
            

            DBToUI.Map(this.Controls, _dr);


            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranch(ddlBranch);
            
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

            ddlBranch.SelectedValue = _dr["BRANCH_CODE"].ToString();
            ddlDivision.SelectedValue = _dr["DIVISION_CODE"].ToString();
            ddlDepartment.SelectedValue = _dr["DEPARTMENT_CODE"].ToString();
            ddlSubDepartment.SelectedValue = _dr["SUB_DEPARTMENT_CODE"].ToString();
            ddlUnits.SelectedValue = _dr["UNITS_CODE"].ToString();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    // (+) Ari 01-07-2022 ket : enhancement 2022 cek Role IS_AGAS
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
        int iNextID = 0;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            //_ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            // (+) Ari 09-01-2023 ket : jika multiplebranch ambil branch dari po header
            if (lblMultiplebranch.Text == "1")
            {
                _ht["p_branch_code"] = Request.Params["branch_code"];
            }
            else
            {
                _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            }


            //_ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
            //_ht["p_department_code"] = Shared.CurrentEmployeeDeptCode;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaseorderdetail.aspx?action=edit&id={0}&codebarcode={1}&currency_code={2}&currency_desc={3}&flagrent={4}", lblID.Text, lblBarcode.Text , lblCurrencyUI.Text , lblCurrency.Text, Request.Params["flagrent"]));
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
        //Response.Redirect("purchaseorderheader.aspx?action=edit&codebarcode=" + lblBarcode.Text + "&idartarget=" + Request.Params["idtarget"]);
        int idTarget = 0;
        String Type_app = "";

        Type_app = Request.Params["type"];

        var idTargetCondition = string.IsNullOrEmpty(Request.Params["idartarget"]) ? "0" : Request.Params["idartarget"];

        if (Type_app == "approval")
        {
            idTarget = Int32.Parse(idTargetCondition);

        }
        else
        {
            idTarget = 0;
        }

        if (Type_app == "approval")
        {

            //Shared.ShowSuccessGritter(this, string.Format("../purchaseorder/purchaseorderheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", Request.Params["codebarcode"], idTarget));
            Response.Redirect("../purchaseorder/purchaseorderheader.aspx?action=edit&type=approval&codebarcode=" + Request.Params["codebarcode"] + "&idartarget=" + idTarget);
        }
        else
        {
            Response.Redirect("purchaseorderheader.aspx?action=edit&codebarcode=" + lblBarcode.Text + "&idartarget=" + Request.Params["idtarget"]);
        }
    }
    protected void btnCancelApp_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchaseorderheader.aspx?action=edit&codebarcode=" + lblBarcode.Text + "&idartarget=" + Request.Params["idtarget"]);
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
    protected void txtItemCode_TextChanged(object sender, EventArgs e)
    {
        Shared.BindItemUOM(ddlUnit, txtItemCode.Text);
    }
     
}
