using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class widget_wcbasicinfo : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            BindData();
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_emp_code"] = Shared.CurrentUID;

            DataRow _dr = _dal.GetRow("", "xsp_employee_main_getrow", _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this.Page, ex);
        }
    }

    public void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
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

            _dal.ExecRawSP("xsp_widget_process_basic_info_update", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this.Page, ex);
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtAddress.Text = string.Empty;
        txtCity.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtEmail2.Text = string.Empty;
        txtHP.Text = string.Empty;
        txtPhone.Text = string.Empty;
        txtPostCode.Text = string.Empty;
    }
}
