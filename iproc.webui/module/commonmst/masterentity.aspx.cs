using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterentity : BasePage
{
    private static string SParams = string.Empty;

    protected void Page_Init(object sender, EventArgs e)
    {
        CheckEntity();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindGeneralSubCode(ddlCorporateType, "CORPTYPE");

            if (SParams == "edit")
                LoadData();
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

            _ht["p_code"] = "ALL";
            DataRow _dr = _dal.GetRow("MASTER_ENTITY", _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    
    private void CheckEntity()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string IsNull = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_is_null"] = "";
            _dal.ExecRawSP("xsp_master_entity_check_is_null", _ht, ref IsNull);

            if (IsNull == "0")
                SParams = "edit";
            else
                SParams = "add";
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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (SParams == "add")
                _dal.Insert("MASTER_ENTITY", _ht);
            else
                _dal.Update("MASTER_ENTITY", _ht);

            Shared.ShowSuccessGritter(this, "masterentity.aspx?action=edit");
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
}
