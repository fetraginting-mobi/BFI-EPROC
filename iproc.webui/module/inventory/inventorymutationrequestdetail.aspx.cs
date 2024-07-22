using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_inventory_inventorymutationrequestdetail : BasePage
{
    private static string TABLE_NAME = "INVENTORY_MUTATION_REQUEST_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {


            btnLookUpInventoryRequestItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LUFCI&acol_0={0}&bcol_1={1}&ccol_2={2}&dcol_3={3}');", txtItemCode.ClientID, lblItemName.ClientID, txtLocationCode.ClientID, lblLocationDesc.ClientID);



            lblBarcode.Text = Request.Params["codebarcode"];

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                if (!lblIRStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    btnLookUpInventoryRequestItem.Enabled = false;
                    txtQuantity.Enabled = false;
                    txtItemDescription.Enabled = false;
                }
            }
            else
            {
                GetCode();

                lblBranch.Text = Shared.CurrentEmployeeBranchDesc;
                lblDivision.Text = Shared.CurrentEmployeeDivCode;
                lblDepartement.Text = Shared.CurrentEmployeeDeptNameDefault;

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

            _ht["p_id"] = Request.Params["id"];
            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            _ht["p_department_code"] = Request.Params["departmentcode"];
            _ht["p_division_code"] = Request.Params["divisioncode"];
            _ht["p_branch_code"] = Request.Params["branchcode"];
            DataRow _dr = _dal.GetRow("INVENTORY_MUTATION_REQUEST_HEADER", _ht);

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

            Shared.ShowSuccessGritter(this, string.Format("inventorymutationrequestheader.aspx?action=edit&codebarcode={0}",lblBarcode.Text));
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
        Response.Redirect("inventorymutationrequestheader.aspx?action=edit&codebarcode=" + lblBarcode.Text);
    }
}