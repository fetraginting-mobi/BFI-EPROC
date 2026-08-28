using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_farequestmutationdetail : BasePage
{
    private static string TABLE_NAME = "FA_REQUEST_MUTATION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            txtBranchEmp.Text = Shared.CurrentEmployeeBranchCode;
            txtBranchHeader.Text = Request.Params["branch"];
            lblIRCode.Text = Request.Params["code"];
            lblBarcode.Text = Request.Params["codebarcode"];
            txtLocation.Text = Request.Params["location"];
            txtOwner.Text = Request.Params["owner"];
            btnLookUpInventoryRequestItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FAMTT&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&ecol_4={4}&ecol_5={5}&parc_branch_code={6}&parc_location={7}&parc_owner={8}');", txtItemCode.ClientID, lblItemName.ClientID, txtBranchEmp.ClientID, lblBranchHeader.ClientID, lblBranchHeader.ClientID, txtloccode.ClientID, txtBranchHeader.ClientID, txtLocation.ClientID, txtOwner.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
            }
            else
            {
                lblDivision.Text = Shared.CurrentEmployeeDivCode;
                lblDepartement.Text = Shared.CurrentEmployeeDeptNameDefault;
            }
        }

        if (Request.Params["action"] != null && Request.Params["action"].Equals("edit"))
        {
            if (lblProcess != null && (lblProcess.Text.Trim().ToUpper() == "UPLOAD" || lblProcess.Text.Trim().ToUpper() == "UPL"))
            {
                btnSave.Visible = false;
                btnLookUpInventoryRequestItem.Enabled = false;
                btnLookUpInventoryRequestItem.Attributes["href"] = "javascript:void(0);";
                btnLookUpInventoryRequestItem.Attributes["onclick"] = "return false;";
                txtDescription.Enabled = false;
            }
        }
        LoadAfterInit();
    }

    private void GetCode()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            _ht["p_department_code"] = Request.Params["departmentcode"];
            _ht["p_division_code"] = Request.Params["divisioncode"];
            _ht["p_units_code"] = Request.Params["unitscode"];
            //_ht["p_branch_code"] = Request.Params["branchcode"];
            DataRow _dr = _dal.GetRow("FA_REQUEST_MUTATION_HEADER", _ht);

            lblIRCode.Text = _dr["code"].ToString();
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
                lblId.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("farequestmutationheader.aspx?action=edit&codebarcode={0}", lblBarcode.Text));
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
        Response.Redirect("farequestmutationheader.aspx?action=edit&codebarcode=" + lblBarcode.Text);
    }
}