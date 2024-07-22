using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_supplier_purchasetender : BasePage
{
    private static string TABLE_NAME_HEADER = "PURCHASE_TENDER";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            
            Shared.BindTaxScreme(ddlTaxId);
            Shared.BindCurrencyCode(ddlCurrencyCode);

            txtSupplierCode.Text = Shared.CurrentUID;

            btnLookUpRequestTenderNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=REQTD&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&ecol_3={4}&fcol_4={5}&gcol_5={6}&hcol_6={7}&parc_object_id={8}');", txtRequestTenderNo.ClientID, txtRequestTenderNo.ClientID, txtRequestTenderCode.ClientID, txtItemCode.ClientID, txtItemName.ClientID, txtRequestQuantity.ClientID, txtTenderDate.ClientID, txtExpiredDate.ClientID, txtSupplierCode.ClientID);
            
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                
                if (lblTransFlagCode.Text == "POST")
                {
                    btnSave.Visible  = false;
                }
                 
            }
             
        }

        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/supplier/purchasetenderlist.aspx";

        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalWithCommentDialog('../../approval/genericapplication.aspx?code=AP000060&parc_object_id={0}&nexturl={1}&status={2}');", txtRequestTenderNo.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "POST");
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

            Shared.BindItemUOM(ddlUnitId, _dr["ITEM_CODE"].ToString());
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
        string sNextBarcode = "";
         
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_branch_code"] = Shared.CurrentDefaultEmployeeBranchCode;
            _ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
            _ht["p_department_code"] = Shared.CurrentEmployeeDeptCode;
            _ht["p_sub_department_code"] = Shared.CurrentEmployeeDeptCode;
            _ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
            _ht["p_supplier_code"] = Shared.CurrentUID;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                txtRequestTenderNo.Text = sNextBarcode;

            }
            else
                _dal.Update(TABLE_NAME_HEADER, _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchasetender.aspx?action=edit&codebarcode={0}", txtRequestTenderNo.Text));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
        //Response.Redirect("purchasetenderlist.aspx");
    }
    
    protected void txtItemCode_TextChanged(object sender, EventArgs e)
    {
        Shared.BindItemUOM(ddlUnitId, txtItemCode.Text);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("purchasetenderlist.aspx");
    }

}
