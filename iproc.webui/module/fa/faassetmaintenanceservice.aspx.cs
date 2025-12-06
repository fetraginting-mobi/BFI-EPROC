using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_faassetmaintenanceservice : BasePage
{
    private static string TABLE_NAME = "FA_ASSET_MAINTENANCE_SERVICE";


    protected void Page_Load(object sender, EventArgs e)
    {

        btnLookUpService.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MITES&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_requestor={3}');", txtServiceCode.ClientID, txtServiceDesc.ClientID, lblServiceDesc.ClientID, lblIDHeader.ClientID);
        LoadInit();
        if (!Page.IsPostBack)
        {
            txtId.Text = Request.Params["id"];
            lblIDHeader.Text = Request.Params["idheader"];
            lblBarcode.Text = Request.Params["barcode"];
            //btnLookUpService.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MITES&acol_0={0}&bcol_1={1}&ccol_1={2}&parc_requestor={3}');", txtServiceCode.ClientID, txtServiceDesc.ClientID, lblServiceDesc.ClientID, lblIDHeader.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

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
        //string nextID = "";
        //string NextUrl = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            int inextId = 0;


            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref inextId);
                txtId.Text = inextId.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);


            Shared.ShowSuccessGritter(this, string.Format("faassetmaintenanceservice.aspx?action=edit&id={0}&idheader={1}&barcode={2}", txtId.Text, Request.Params["idheader"], Request.Params["barcode"]));
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
        Response.Redirect(String.Format("faassetmaintenance.aspx?action=edit&id=" + lblIDHeader.Text));
    }

    
}

