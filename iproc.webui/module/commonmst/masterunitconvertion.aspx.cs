using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterunitconvertion : BasePage
{
    private static string TABLE_NAME = "MASTER_UNIT_CONVERTION";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            btnLookUpFromUnit.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=UNIT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtFromUnitCode.ClientID, lblFromUnitCode.ClientID, lblFromUnitName.ClientID);
            btnLookUpToUnit.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=UNIT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtToUnitCode.ClientID, lblToUnitCode.ClientID, lblToUnitName.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblId.Enabled = true; 
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
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
            Shared.ShowSuccessGritter(this, string.Format("masterunitconvertionlist.aspx"));
            //Shared.ShowSuccessGritter(this, string.Format("masterunitconvertion.aspx?action=edit&id={0}", lblId.Text));
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
        Response.Redirect("masterunitconvertionlist.aspx");
    }

}