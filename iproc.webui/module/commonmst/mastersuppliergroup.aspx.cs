using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_mastersuppliergroup : BasePage
{
    private static string TABLE_NAME = "MASTER_SUPPLIER_ITEM_GROUP";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

       if (!Page.IsPostBack)

        {
           lblId.Text = Request.Params["id"];
           Shared.BindGeneralSubCode(ddlJenisItem, "ITMCAT");
            ddlJenisItem.SelectedValue = Request.Params["jenis"];
            Shared.BindItemGroupItemDDL(ddlItemGroup, ddlJenisItem.SelectedValue);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                LinkButton btn = btnViewStock as LinkButton;
                btn.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../commonmst/listitemsuplier.aspx?action=edit&itemgroup={0}');", ddlItemGroup.SelectedValue);
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";

                      if (Request.Params["status"] == "VALID")
                {
                    btnSave.Visible = false;
                    ddlItemGroup.Enabled = false;
                    ddlJenisItem.Enabled = false;
                    txtRemarks.Enabled = false;
                }

            }
            else
            {

            }
        }
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

            _ht["p_id"] = Request.Params["id_dt"];

            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);


            DBToUI.Map(this.Controls, _dr);


            Shared.BindItemGroupItemDDL(ddlItemGroup, ddlJenisItem.SelectedValue);
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
        //string sNextURL = "";
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            _ht["p_id"] = Request.Params["id_dt"];
            _ht["p_supplier_code"] = Request.Params["suppliercode"];

            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                //lblbranchcode.Text = Request.Params["branchcode"].ToString();
                //
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblId.Text = iNextID.ToString();

                Shared.ShowSuccessGritter(this, string.Format("mastersuppliergroup.aspx?action=edit&suppliercode={0}&id={1}&id_dt={2}", Request.Params["suppliercode"], Request.Params["id"], lblId.Text));
                btnSave.Visible = false;
            }

            else
            {

                _dal.Update(TABLE_NAME, _ht);
               

                Shared.ShowSuccessGritter(this, string.Format("mastersuppliergroup.aspx?action=edit&suppliercode={0}&id={1}&id_dt={2}", Request.Params["suppliercode"], Request.Params["id"], lblId.Text));
            }

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
        Response.Redirect(string.Format("mastersupplier.aspx?action=edit&suppliercode={0}&id={1}", Request.Params["suppliercode"], Request.Params["id"]));
    }

    protected void ddlJenisItem_OnSelectedIndex(object sender, EventArgs e)
    {
        Shared.BindItemGroupItemDDL(ddlItemGroup, ddlJenisItem.SelectedValue);
    }
}
