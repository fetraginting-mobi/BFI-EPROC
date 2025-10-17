using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
public partial class module_commonmst_eomconfiguration : BasePage
{
    private static string TABLE_NAME = "EOM_CONFIGURATION";
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        if (!Page.IsPostBack)
        {
            LoadData();
        }
        LoadAfterInit();
    }

    protected void txtEomStartDate_TextChanged(object sender, EventArgs e)
    {
        // Now you can access the value from txtRequestDate
        string selectedDateTime = txtEomStartDate.Text;
        // Use the value as needed
    }

    private void LoadData()
    {


        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

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
            _dal.Insert(TABLE_NAME, _ht, ref iNextID);
            Shared.ShowSuccessGritter(this, string.Format("eomconfiguration.aspx"));
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
        Response.Redirect("eomconfiguration.aspx");
    }


}