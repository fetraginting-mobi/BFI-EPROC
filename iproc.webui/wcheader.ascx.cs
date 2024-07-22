using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;

using iProc.DataAccessLayer;

public partial class wcheader : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblFullname.Text = Shared.CurrentEmpName;
        lblBranchCode.Text = Shared.CurrentEmployeeBranchCode;
        lblBranchDesc.Text = Shared.CurrentEmployeeBranchDesc;
        lblBranchDesc2.Text = Shared.CurrentEmployeeBranchDesc;

        //getModuleList();
    }

    //private void getModuleList()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_user_id"] = Shared.CurrentUID;

    //        DataRow _dr = _dal.GetRow("", "xsp_module_item_getrow", _ht);

    //        ModuleList.InnerHtml = _dr["MODULE_LIST"].ToString();
    //    }
    //    catch { }
    //}
}
