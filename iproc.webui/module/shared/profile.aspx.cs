using System;
using System.IO;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class profile : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            LoadData();
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

            _ht["p_emp_code"] = Shared.CurrentUID;

            
            MPF23.Shared.Mapper.DBToUI.Map(this.Controls, _dal.GetRow("", "xsp_employee_main_getrow_for_profile", _ht));
        
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this.Page, ex);
        }
    }
}
