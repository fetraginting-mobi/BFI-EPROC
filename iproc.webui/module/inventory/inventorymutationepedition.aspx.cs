using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_inventory_inventorymutationepedition : BasePage
{
    private static string TABLE_NAME = "INVENTORY_MUTATION_EXPEDITION";

    protected void Page_Load(object sender, EventArgs e)
    {


        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindGeneralSubCode(ddlTRX, "EXP");

            //Shared.BindUnit(ddlUnit);

            lblCodeBarcode.Text = Request.Params["codebarcode"];

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                
                if (!lblIMStatus.Text.Equals("NEW"))
                    btnSave.Visible = false;
                    txtAmount.Enabled = false;

                // btnCancel.Text = "Back";
                //btnSave.Visible = false;
            }
            else
            {
                GetCode();
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
            DataRow _dr = _dal.GetRow("INVENTORY_MUTATION_HEADER", _ht);

            lblCode.Text = _dr["code"].ToString();
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

            //_ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventorymutationepedition.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, lblCode.Text));
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
        Response.Redirect("inventorymutationheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text);
    }

}
