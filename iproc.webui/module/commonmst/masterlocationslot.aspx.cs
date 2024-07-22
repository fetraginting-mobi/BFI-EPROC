using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterlocationslot : BasePage
{
    private static string TABLE_NAME_SLOT = "MASTER_LOCATION_SLOT";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            lblWarehouseCode.Text = Request.Params["warehousedesc"];
            txtWarehouseCode.Text = Request.Params["warehousecode"];
            btnLookUpLotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLFL&acol_0={0}&bcol_1={1}');", txtLotCode.ClientID, lblLotCode.ClientID);
            btnLookUpRakCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MRGFL&acol_0={0}&bcol_1={1}');", txtRakCode.ClientID, lblRakCode.ClientID);
            btnLookUpSlotCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MSGFL&acol_0={0}&bcol_1={1}');", txtSlotCode.ClientID, lblSlotCode.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblId.Enabled = true;

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";


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

            _ht["p_id"] = (Request.Params["id"]);
            DataRow _dr = _dal.GetRow(TABLE_NAME_SLOT, _ht);

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

            _ht["p_warehouse_code"] = txtWarehouseCode.Text;
            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_SLOT, _ht, ref iNextID);
                lblId.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME_SLOT, _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterwarehousetrx.aspx?action=edit&warehousecode={0}&id={1}", txtWarehouseCode.Text, lblId));
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
        Response.Redirect(string.Format("masterwarehousetrx.aspx?action=edit&warehousecode={0}", Request.Params["warehousecode"]));
    }
}

