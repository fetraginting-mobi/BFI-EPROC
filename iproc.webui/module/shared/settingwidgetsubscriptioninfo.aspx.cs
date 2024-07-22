using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_personel_settingwidgetsubscriptioninfo : BasePage
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                btnCancel.Text = "Back";
            }
        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            //
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_emp_code"] = Request.Params["empcode"];
            _ht["p_widget_code"] = Request.Params["widgetcode"];

            DataRow _dr = _dal.GetRow("", "xsp_employee_widget_subscription_getrow", _ht);

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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_emp_code"] = Request.Params["empcode"];
            _ht["p_widget_code"] = Request.Params["widgetcode"];

            if (Request.Params["action"].Equals("add"))
                _dal.Insert("", "xsp_employee_widget_subscription_insert", _ht);
            else
                _dal.Update("", "xsp_employee_widget_subscription_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("settingwidgetsubscriptioninfo.aspx?action=edit&empcode={0}&widgetcode={1}", Request.Params["empcode"], lblWidgetCode.Text));
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
        Response.Redirect("setting.aspx?action=edit&empcode=" +Request.Params["empcode"]);
    }
}
