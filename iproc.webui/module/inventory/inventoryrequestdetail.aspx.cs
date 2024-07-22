using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryrequestdetail : BasePage
{
    private static string TABLE_NAME = "INVENTORY_REQUEST_DETAIL";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            lblBarcode.Text = Request.Params["codebarcode"];
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
            btnLookUpInventoryRequestItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LUFCI&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}&parc_branch_code={4}');", txtItemCode.ClientID, txtItemName.ClientID, txtWarehouseCode.ClientID, txtWarehouseName.ClientID, ddlBranch.ClientID);
            btnLookUpWarehouseCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MLGFL&acol_0={0}&bcol_1={1}&parc_item_code={2}&parc_branch_code={3}');", txtWarehouseCode.ClientID, txtWarehouseName.ClientID, txtItemCode.ClientID, txtBranch.ClientID);
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

            lblId.Text = Request.Params["id"];
            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                if (!lblIRStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    btnLookUpInventoryRequestItem.Enabled = false;
                    txtQuantity.Enabled = false;
                    txtItemDescription.Enabled = false;
                    ddlBranch.Enabled = false;
                    ddlDepartment.Enabled = ddlDivision.Enabled = ddlSubDepartment.Enabled = ddlUnits.Enabled = false;
                }
            }
            else
            {
                GetCode();

               
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
                ddlUnits.SelectedValue = Shared.CurrentEmployeeUnitsCode;
                Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

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
            _ht["p_branch_code"] = Request.Params["branchcode"];
            DataRow _dr = _dal.GetRow("INVENTORY_REQUEST_HEADER", _ht);

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
            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
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

            Shared.ShowSuccessGritter(this, string.Format("inventoryrequestheader.aspx?action=edit&codebarcode={0}", lblBarcode.Text));
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
        Response.Redirect("inventoryrequestheader.aspx?action=edit&codebarcode=" + lblBarcode.Text);
    }

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlDepartment.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);

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
}