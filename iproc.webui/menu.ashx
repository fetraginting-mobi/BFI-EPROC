<%@ WebHandler Language="C#" Class="menu" %>

using System;
using System.Web;
using System.Data;
using System.Collections;

using iProc.DataAccessLayer;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MPF23.Shared.Mapper;

public class menu : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write(GenerateMenu(context));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    private string GenerateMenu(HttpContext context)
    {
        string sMenu = "";

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            sMenu += "<ul class='sidebar-menu' id='nav-accordian'>";
            //sMenu += "<li><a class='active' href='module/dashboard/default.aspx' target='ifr'><i class='icon-dashboard'></i><span>Dashboard</span></a></li>";


            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_module"] = context.Request.Params["mod"];
            _ht["p_application_code"] = Shared.CurrentEmployeeAppCode;
            
            DataTable dtParent = _dal.GetRows("", "xsp_master_menu_getrows_parent", _ht);

            foreach (DataRow drParent in dtParent.Rows)
            {

                //begin -> menu parent
                //sMenu += String.Format("<li class='sub-menu'><a href='javascript:;'><i class='{0}'></i><span>{1}</span></a>", drParent["CSS_CLASS"].ToString(), drParent["NAME"].ToString());

                _ht.Clear();
                _ht["p_parent_id"] = (int)drParent["ID"];
                _ht["p_emp_code"] = Shared.CurrentUID;
                _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
                _ht["p_application_code"] = Shared.CurrentEmployeeAppCode;

                DataTable dtChildren = _dal.GetRows("", "xsp_master_menu_getrows_children", _ht);
                //DataTable dtChildren = _dal.GetRows("", "xsp_master_menu_getrows_master_only", _ht);
                if (dtChildren.Rows.Count > 0)
                {
                    sMenu += String.Format("<li class='sub-menu'><a href='javascript:;'><i class='{0}'></i><span>{1}</span></a>", drParent["CSS_CLASS"].ToString(), drParent["NAME"].ToString());

                    sMenu += "<ul class='sub'>";



                    foreach (DataRow drChild in dtChildren.Rows)
                    {
                        sMenu += String.Format("<li><a href='{0}' target='ifr' class='menuitem' onclick='selmenu(this)'>{1}</a></li>", drChild["URL"].ToString(), drChild["NAME"].ToString());
                    }

                    //end -> menu parent
                    sMenu += "</ul></li>";
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        sMenu += "</ul>";

        return sMenu;
    }

}