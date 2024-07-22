using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_dashboard_default : BasePage
{
    protected void Page_Init(object sender, EventArgs e)
    {
        BindData();
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {

        }
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_emp_code"] = Shared.CurrentUID;

            DataTable _dt = _dal.GetRows("EMPLOYEE_WIDGET_SUBSCRIPTION", _ht);

            UserControl ctrl = new UserControl();

            foreach (DataRow row in _dt.Rows)
            {
                ctrl = (UserControl)Page.LoadControl("~/widget/" + row["file_name"].ToString());

                if (row["widget_orientation"].Equals("L"))
                    CtrlL.Controls.Add(ctrl);
                else
                    CtrlR.Controls.Add(ctrl);
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex); ;
        }
    }
}
