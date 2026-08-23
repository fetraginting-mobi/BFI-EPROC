using System;
using System.Data;
using System.Collections;
using System.Data.OleDb;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using iProc.DataAccessLayer;
using MPF23.XUI.Control;
using Microsoft.VisualBasic;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using Spreadsheet = DocumentFormat.OpenXml.Spreadsheet;
using ICSharpCode.SharpZipLib.Zip;
using System.Collections.Specialized;
using Newtonsoft.Json;

public class Shared
{
    public Shared()
    {

        //
        // TODO: Add constructor logic here
        //
    }

    public static Control FindControlRecursive(Control control, string id)
    {
        if (control == null) return null;
        //try to find the control at the current level
        Control ctrl = control.FindControl(id);

        if (ctrl == null)
        {
            //search the children
            foreach (Control child in control.Controls)
            {
                ctrl = FindControlRecursive(child, id);

                if (ctrl != null) break;
            }
        }
        return ctrl;
    }

    public static string CurrentUID
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["ID"].ToString();
        }
    }

    public static string CurrentEmpName
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["EMP_NAME"].ToString();
        }
    }



    public static string CurrentEmployeeBranchCode
    {
        get
        {
            return HttpContext.Current.Session[SessionKey.CURRENT_USER_BRANCH_CODE].ToString();
        }
    }

    public static string CurrentEmployeeBranchDesc
    {
        get
        {
            return HttpContext.Current.Session[SessionKey.CURRENT_USER_BRANCH_DESC].ToString();
        }
    }

    public static string CurrentEmployeeAppCode
    {
        get
        {
            return HttpContext.Current.Session[SessionKey.CURRENT_USER_APP_CODE].ToString();
        }
    }

    public static string CurrentEmployeeAppDesc
    {
        get
        {
            return HttpContext.Current.Session[SessionKey.CURRENT_USER_APP_DESC].ToString();
        }
    }

    public static string CurrentDefaultEmployeeBranchCode
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["DEFAULT_BRANCH_CODE"].ToString();
        }
    }
    public static string CurrentDefaultEmployeeSubBranchCode
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["DEFAULT_BRANCH_CODE"].ToString();
        }
    }

    public static string CurrentDefaultEmployeeBranchDesc
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["DEFAULT_BRANCH_NAME"].ToString();
        }
    }

    public static string CurrentEmployeeDeptCode
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["DEPARTMENT_CODE"].ToString();
        }
    }

    public static string CurrentEmployeeDeptDesc
    {
        get
        {
            return HttpContext.Current.Session[SessionKey.CURRENT_USER_DEPT_DESC].ToString();
        }
    }
    public static string CurrentEmployeeDeptCodeDefault
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["DEPARTMENT_CODE"].ToString();
        }
    }
    public static string CurrentEmployeeDivCode
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["DIVISION_CODE"].ToString();
        }
    }
    public static string CurrentEmployeeUnitsCode
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["UNITS_CODE"].ToString();
        }
    }
    public static string CurrentEmployeeUnitsDesc
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["UNITS_NAME"].ToString();
        }
    }
    public static string CurrentEmployeeSubDepartmentCode
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["SUB_DEPARTMENT_CODE"].ToString();
        }
    }
    public static string CurrentEmployeeSubDepartmentDesc
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["SUB_DEPARTMENT_NAME"].ToString();
        }
    }
    public static string CurrentEmployeeDeptNameDefault
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["DEPARTMENT_NAME"].ToString();
        }
    }
    public static string CurrentEmployeeDivNameDefault
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["DIVISION_NAME"].ToString();
        }
    }
    public static string CurrentEmployeeUnitsName
    {
        get
        {
            return ((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["UNITS_NAME"].ToString();
        }
    }
    public static string CurrentStartAccDate
    {
        get
        {
            return Convert.ToDateTime(((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["START_ACC_DATE"].ToString()).Date.ToString("dd/MM/yyyy");
        }
    }
    public static string CurrentEndAccDate
    {
        get
        {
            return Convert.ToDateTime(((DataTable)HttpContext.Current.Session[SessionKey.CURRENT_USER_SESSION_KEY]).Rows[0]["END_ACC_DATE"].ToString()).Date.ToString("dd/MM/yyyy");
        }
    }

    public static string CurrentIPAddress
    {
        get
        {
            return HttpContext.Current.Session[SessionKey.CURRENT_USER_IP_ADDRESS_SESSION_KEY].ToString();
        }
    }

    public static string DefaultErrorMessage
    {
        get { return "This is strange! Something is not right with the system. Please check the tehnical error message below."; }
    }

    public static string DefaultSuccessMessage
    {
        get { return "Your data is at the safe place now"; }
    }

    public static string DefaultSuccessTitle
    {
        get { return "Success"; }
    }
    public static string PDFTK
    {
        get { return System.Configuration.ConfigurationSettings.AppSettings["PDFTK"]; }
    }
    public static void ApplyDefaultProp(Hashtable ht)
    {
        ht["p_cre_date"] = ht["p_mod_date"] = DateTime.Now;
        ht["p_cre_by"] = ht["p_mod_by"] = CurrentUID;
        ht["p_cre_ip_address"] = ht["p_mod_ip_address"] = CurrentIPAddress;
    }

    public static void ShowSuccessGritter(Page p, string NextURL)
    {
        ScriptManager.RegisterStartupScript(p, p.GetType(), "fy", String.Format("fnShowGritter('{0}', '{1}'); location.href='{2}';", Shared.DefaultSuccessTitle, Shared.DefaultSuccessMessage, NextURL), true);
    }

    public static void ShowErrorDialog(Page p, Exception ex)
    {
        ScriptManager.RegisterStartupScript(p, p.GetType(), "fx", "fnShowErrorNotif('', '" + Shared.MakeSingleLine(ex) + "');", true);
    }

    public static string GenerateErrorDialogFromApproval(Exception ex)
    {
        return "fnShowErrorNotifFromApproval('" + Shared.DefaultErrorMessage + "', '" + Shared.MakeSingleLine(ex) + "');";
    }

    //public static void ShowErrorDialog(Page p, Exception ex)
    //{
    //    ScriptManager.RegisterStartupScript(p, p.GetType(), "fx", "fnShowErrorNotif('" + (ex.InnerException == null ? ex.Message : ex.InnerException.Message) + "','');", true);
    //}

    //public static string GenerateErrorDialogFromApproval(Exception ex)
    //{
    //    return "fnShowErrorNotifFromApproval('" + (ex.InnerException == null ? ex.Message : ex.InnerException.Message) + "','');";
    //}
    public static void ShowValidationError(Page p, string msg)
    {/*(+)Chandra - 01-Oct-2015, 8:57:48 AM*/
        //ScriptManager.RegisterStartupScript(p, p.GetType(), "fx", "fnShowErrorNotif('" + Shared.ValidationErrorMessage + "', '" + msg + "');", true);
        ScriptManager.RegisterStartupScript(p, p.GetType(), "fx", "fnShowErrorNotif('" + msg + "', '');", true);
    }

    #region Convertion
    public static DateTime ToDateTime(string dt, string format)
    {
        System.Globalization.DateTimeFormatInfo dtfi = null;

        try
        {
            dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = format;

            return DateTime.Parse(dt, dtfi);

        }
        catch (Exception)
        {
            return new DateTime(1900, 1, 1);
        }
    }

    public static DateTime ToDateTime(string dt)
    {
        System.Globalization.DateTimeFormatInfo dtfi = null;

        try
        {
            dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";

            return DateTime.Parse(dt, dtfi);

        }
        catch (Exception)
        {
            return new DateTime(1900, 1, 1);
        }
    }

    public static DateTime ToStartDateTime(string dt)
    {
        System.Globalization.DateTimeFormatInfo dtfi = null;

        try
        {
            dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";

            return DateTime.Parse(dt, dtfi);

        }
        catch (Exception)
        {
            return new DateTime(1900, 10, 10);
        }
    }

    public static DateTime ToEndDateTime(string dt)
    {
        System.Globalization.DateTimeFormatInfo dtfi = null;

        try
        {
            dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";

            return DateTime.Parse(dt, dtfi);

        }
        catch (Exception)
        {
            return new DateTime(2050, 10, 10);
        }
    }

    #endregion

    public static void BindGeneralCode(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_GENERAL_CODE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindGeneralSubCodeBranchBank(DropDownList ddl, string GeneralCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = GeneralCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_general_subcode_getrows_for_ddl", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindGeneralSubCode(DropDownList ddl, string GeneralCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = GeneralCode;

            ddl.DataSource = _dal.GetRows("MASTER_GENERAL_SUBCODE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindReasonReportAll(DropDownList ddl, string GeneralCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = GeneralCode;

            ddl.DataSource = _dal.GetRows("MASTER_GENERAL_SUBCODE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindGeneralSubCodeByCode(DropDownList ddl, string GeneralCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = GeneralCode;

            ddl.DataSource = _dal.GetRows("MASTER_GENERAL_SUBCODE", _ht);
            ddl.DataTextField = "CODE";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindGeneralSubCodeByTransflagCode(DropDownList ddl, string DocumentCode)
    {
        string cacheKey = "CACHE_GEN_SUBCODE_" + DocumentCode;
        DataTable dt;

        // GeneralDAL _dal = null;
        // Hashtable _ht = null;

        // try
        // {
        //     _dal = new GeneralDAL();
        //     _ht = new Hashtable();

        //     _ht["p_keywords"] = "";
        //     _ht["p_code"] = DocumentCode;

        //     ddl.DataSource = _dal.GetRows("", "xsp_master_general_subcode_getrows_for_ddl_transflag_code", _ht);
        //     ddl.DataTextField = "DESCRIPTION";
        //     ddl.DataValueField = "CODE";
        //     ddl.DataBind();
        // }
        // catch (Exception ex)
        // {
        // }
        try
        {
            if (HttpContext.Current.Cache[cacheKey] != null)
            {
                dt = (DataTable)HttpContext.Current.Cache[cacheKey];
            }
            else
            {
                GeneralDAL _dal = new GeneralDAL();
                Hashtable _ht = new Hashtable();
                _ht["p_keywords"] = "";
                _ht["p_code"] = DocumentCode;

                dt = _dal.GetRows("", "xsp_master_general_subcode_getrows_for_ddl_transflag_code", _ht);

                if (dt != null)
                {
                    HttpContext.Current.Cache.Insert(cacheKey, dt, null,
                        DateTime.Now.AddMinutes(60),
                        System.Web.Caching.Cache.NoSlidingExpiration);
                }
            }

            ddl.DataSource = dt;
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindGeneralLocationByBranch(DropDownList ddl, string Branch)
    {
        if (Branch == "ALL" || string.IsNullOrEmpty(Branch))
        {
            Branch = "";
        }

        string cacheKey = "CACHE_INV_LOC_" + (string.IsNullOrEmpty(Branch) ? "ALL_DATA" : Branch);
        DataTable dt;
        try
        {
            if (HttpContext.Current.Cache[cacheKey] != null)
            {
                dt = (DataTable)HttpContext.Current.Cache[cacheKey];
            }
            else
            {
                GeneralDAL _dal = new GeneralDAL();
                Hashtable _ht = new Hashtable();
                _ht["p_keywords"] = "";
                _ht["p_item_code"] = ""; 
                _ht["p_branch_code"] = Branch; 

                dt = _dal.GetRows("", "xsp_master_location_getrows_for_lookup", _ht);

                if (dt != null)
                {
                    HttpContext.Current.Cache.Insert(cacheKey, dt, null,
                        DateTime.Now.AddMinutes(120),
                        System.Web.Caching.Cache.NoSlidingExpiration);
                }
            }

            ddl.DataSource = dt;
            ddl.DataTextField = "location_desc";
            ddl.DataValueField = "code";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindReligion(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_RELIGION", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindMarital(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_MARITAL", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindNationality(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_NATIONALITY", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindPosition(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_POSITION", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindMerk(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_MERK", _ht);
            ddl.DataTextField = "MERK_NAME";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindRelation(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_RELATION", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindLanguage(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_LANGUAGE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindLocationProcurement(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "dbo.xsp_master_location_getrows_ddl", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindLocation(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "dbo.xsp_master_location_getrows_ddl", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();


        }
        catch (Exception ex)
        {
        }
    }

    public static void BindLocationFilterBranchAll(DropDownList ddl, string BranchCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = BranchCode;

            ddl.DataSource = _dal.GetRows("", "dbo.xsp_master_location_getrows_filter_ddl", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();



            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));

        }
        catch (Exception ex)
        {
        }

    }

    public static void BindLocationFilterBranch(DropDownList ddl, string BranchCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = BranchCode;

            ddl.DataSource = _dal.GetRows("", "dbo.xsp_master_location_getrows_filter_ddl", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();



            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));

        }
        catch (Exception ex)
        {
        }

    }

    public static void BindLocationFilterBranch1(DropDownList ddl, string BranchCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = BranchCode;

            ddl.DataSource = _dal.GetRows("", "dbo.xsp_master_location_getrows_filter_ddl1", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();




        }
        catch (Exception ex)
        {
        }

    }

    public static void BindWarehouseReportAll(DropDownList ddl, string BranchCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = BranchCode;

            ddl.DataSource = _dal.GetRows("", "dbo.xsp_master_location_getrows_filter_ddl1", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));


        }
        catch (Exception ex)
        {
        }

    }

    public static void BindLocationLot(DropDownList ddl, string WarehouseCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_warehouse_code"] = WarehouseCode;

            ddl.DataSource = _dal.GetRows("MASTER_LOCATION_LOT", _ht);
            ddl.DataTextField = "LOT_NAME";
            ddl.DataValueField = "LOT_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindSupplierReportAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_master_supplier_getrows_ddl", _ht);
            ddl.DataTextField = "SUPPLIER_NAME";
            ddl.DataValueField = "SUPPLIER_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindSupplierReportByCreditor(DropDownList ddl, string CreditorType)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_creditor_type"] = CreditorType;

            ddl.DataSource = _dal.GetRows("", "xsp_master_supplier_getrows_ddl", _ht);
            ddl.DataTextField = "SUPPLIER_NAME";
            ddl.DataValueField = "SUPPLIER_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindCreditorReportAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_master_creditor_all_getrows_ddl", _ht);
            ddl.DataTextField = "CREDITOR_NAME";
            ddl.DataValueField = "CREDITOR_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindCreditorTypeReportAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_CREDITOR_TYPE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CREDITORTYPE_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindSysBankReportAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_sys_branch_bank_all_getrows_ddl", _ht);
            ddl.DataTextField = "BANK_NAME";
            ddl.DataValueField = "BANK_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindSupplierLocationReportAll(DropDownList ddl, string BranchCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = BranchCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_supplier_location_getrows_ddl", _ht);
            ddl.DataTextField = "SUPPLIER_NAME";
            ddl.DataValueField = "SUPPLIER_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindLocationReportAll(DropDownList ddl, string BranchCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = BranchCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_location_all_getrows_ddl", _ht);
            ddl.DataTextField = "LOCATION_NAME";
            ddl.DataValueField = "LOCATION_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindLocationItemReportAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_master_location_item_all_getrows_ddl", _ht);
            ddl.DataTextField = "LOCATION_NAME";
            ddl.DataValueField = "LOCATION_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindItemReportAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_master_item_all_getrows_ddl", _ht);
            ddl.DataTextField = "ITEM_NAME";
            ddl.DataValueField = "ITEM_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindLocationRak(DropDownList ddl, string WarehouseCode, string LotCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_warehouse_code"] = WarehouseCode;
            _ht["p_lot_code"] = LotCode;
            ddl.DataSource = _dal.GetRows("MASTER_LOCATION_RAK", _ht);
            ddl.DataTextField = "RAK_NAME";
            ddl.DataValueField = "RAK_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindLocationSlot(DropDownList ddl, string WarehouseCode, string LotCode, string RakCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_warehouse_code"] = WarehouseCode;
            _ht["p_lot_code"] = LotCode;
            _ht["p_rak_code"] = RakCode;
            ddl.DataSource = _dal.GetRows("MASTER_LOCATION_SLOT", _ht);
            ddl.DataTextField = "SLOT_NAME";
            ddl.DataValueField = "SLOT_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindLot(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_LOT", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindRak(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_RAK", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindSlot(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_SLOT", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindLocationReceipt(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_LOCATION", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindEmpCode(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("EMPLOYEE_MAIN", _ht);
            ddl.DataTextField = "EMP_NAME";
            ddl.DataValueField = "EMP_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindDivision(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            //_ht["p_is_active"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_DIVISION", _ht);
            ddl.DataSource = _dal.GetRows("", "xsp_master_division_ddl_getrows", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindDepartment(DropDownList ddl, string DivisionCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_division_code"] = DivisionCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_department_getrows_for_dll_filter_by_division", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindSysBranchBank(DropDownList ddl, string BranchCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = BranchCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_bank_getrows_for_dll_filter_by_branch", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";

            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindSysBranchBankRek(DropDownList ddl, string Branch, string BankCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Branch;
            _ht["p_bank_code"] = BankCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_bank_rekno_getrows_for_dll_filter_by_bank", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";

            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindSysBranchBankRekNo(DropDownList ddl, string Branch, string BankCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Branch;
            _ht["p_bank_code"] = BankCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_bank_rekening_getrows_for_dll_filter_by_bank", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";

            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindSubDepartment(DropDownList ddl, string DepartmentCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_department_code"] = DepartmentCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_department_getrows_for_dll_filter_by_department", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";

            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindUnits(DropDownList ddl, string SubDepartmentCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            //  _ht["p_division_code"] = DivisionCode;
            _ht["p_sub_department_code"] = SubDepartmentCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_units_getrows_for_dll_filter_by_department", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindUnitsItemOwnSetting(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            //  _ht["p_division_code"] = DivisionCode;
            //_ht["p_department_code"] = DepartmentCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_units_getrows_for_owner_setting", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "OWNER_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindUnitsItemOwn(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            //  _ht["p_division_code"] = DivisionCode;
            //_ht["p_department_code"] = DepartmentCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_units_getrows_for_owner", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindUnitsItemOwnSale(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            //  _ht["p_division_code"] = DivisionCode;
            //_ht["p_department_code"] = DepartmentCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_units_getrows_for_owner_sale", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindUnitsItemOwnMutation(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            //  _ht["p_division_code"] = DivisionCode;
            //_ht["p_department_code"] = DepartmentCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_units_getrows_for_owner_mutation", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }


    public static void BindOwnerReportAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            //  _ht["p_division_code"] = DivisionCode;
            //_ht["p_department_code"] = DepartmentCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_units_getrows_for_owner", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();


            //ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindUnitsItem(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            //  _ht["p_division_code"] = DivisionCode;
            //_ht["p_department_code"] = DepartmentCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_units_getrows_for_prosess", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();


            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindUnitsAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            //  _ht["p_division_code"] = DivisionCode;


            ddl.DataSource = _dal.GetRows("", "xsp_master_units_getrows_for_all", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindGroupLevel(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_master_item_group_level", _ht);
            ddl.DataTextField = "GROUP_LEVEL";
            ddl.DataValueField = "GROUP_LEVEL";
            ddl.DataBind();


        }
        catch (Exception ex)
        {
        }
    }

    public static void BindItemUOM(DropDownList ddl, string ItemCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_item_code"] = ItemCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_item_getrows_uom", _ht);
            ddl.DataTextField = "UNIT_DESC";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    //public static void BindMasterUnitPR(DropDownList ddl)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_keywords"] = "";

    //        ddl.DataSource = _dal.GetRows("MASTER_UNIT", _ht);
    //        ddl.DataTextField = "UNIT_DESC";
    //        ddl.DataValueField = "ID";
    //        ddl.DataBind();

    //        ddl.Items.Insert(0, new ListItem("Pilih", "0"));
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    public static void BindCurrencyBase(TextBox txt)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            DataRow dr = _dal.GetRow("MASTER_CURRENCY", "xsp_master_currency_getrow_base", _ht);
            txt.Text = dr["CURRENCY_CODE"].ToString();

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindCostCenter(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_COST_CENTER", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindGrade(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_GRADE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindClass(DropDownList ddl, string GradeCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_grade_code"] = GradeCode;

            ddl.DataSource = _dal.GetRows("MASTER_CLASS", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindOvertimeType(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_OVERTIME", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindLeaveType(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_LEAVE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindDemotion(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_DEMOTION", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindAccPeriod(DropDownList ddl, string Branch)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Branch;

            ddl.DataSource = _dal.GetRows("ACC_TRLBAL", "xsp_acc_trlbal_getrows_accperiod", _ht);
            ddl.DataTextField = "ACC_PERIOD";
            ddl.DataValueField = "ACC_PERIOD";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindPromotion(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_PROMOTION", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindMutation(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_MUTATION", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindResignation(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_RESIGNATION", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindEmpBranch(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_emp_code"] = Shared.CurrentUID;

            ddl.DataSource = _dal.GetRows("EMPLOYEE_BRANCH", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "BRANCH_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindCreditorType(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_CREDITOR_TYPE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CREDITORTYPE_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    //Kenny 20/04/2018 'BindCreditorTypeSelect'
    public static void BindCreditorTypeSelect(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_CREDITOR_TYPE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CREDITORTYPE_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindItemGroup(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_ITEM_GROUP", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "ID";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("ROOT", "0"));
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindItemGroupByCategory(DropDownList ddl, string categoryType)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_group_category_type"] = categoryType;

            ddl.DataSource = _dal.GetRows("MASTER_ITEM_GROUP", "xsp_master_item_group_getrows_for_lookup", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CATEGORY_CODE";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("ROOT", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindItemGroupItem(DropDownList ddl, string categoryType)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_group_category_type"] = categoryType;

            ddl.DataSource = _dal.GetRows("MASTER_ITEM_GROUP", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CATEGORY_CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, new ListItem("ROOT", "0"));
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindItemGroupItemDDL(DropDownList ddl, string categoryType)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_group_category_type"] = categoryType;

            ddl.DataSource = _dal.GetRows("MASTER_ITEM_GROUP", "xsp_master_item_group_getrows_ddl", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CATEGORY_CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, new ListItem("ROOT", "0"));
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindItem(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_ITEM", _ht);
            ddl.DataTextField = "ITEM_NAME";
            ddl.DataValueField = "ITEM_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindUnit(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_UNIT", _ht);
            ddl.DataTextField = "UNIT_DESC";
            ddl.DataValueField = "UNIT_CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindSupplier(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_master_supplier_getrows_for_ddl", _ht);
            ddl.DataTextField = "SUPPLIER_NAME";
            ddl.DataValueField = "SUPPLIER_CODE";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));    //Kenny 11/04/2018 'Add'

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindSupplierSelection(DropDownList ddl, String CodeBarcode, String PQCode, String ItemCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code_barcode"] = CodeBarcode;
            _ht["p_pq_code"] = PQCode;
            _ht["p_item_code"] = ItemCode;


            ddl.DataSource = _dal.GetRows("", "xsp_supplier_selection_for_supplier_selection_getrows", _ht);
            ddl.DataTextField = "SUPPLIER_NAME";
            ddl.DataValueField = "SUPPLIER_CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, new ListItem("", " "));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindTaxScreme(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_TAX_SCHEME", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "TAX_CODE";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindTaxScreme2(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_master_tax_scheme_getrows", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "TAX_CODE";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));

        }
        catch (Exception ex)
        {
        }
    }


    public static void BindBranch(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = Shared.CurrentUID;

            ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
            //ddl.Enabled = false;
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindBranchAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            // _ht["p_code"] = Shared.CurrentUID;

            ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
            //ddl.Enabled = false;
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindBranchMutAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            // _ht["p_code"] = Shared.CurrentUID;

            ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
            //ddl.Enabled = false;
        }
        catch (Exception ex)
        {
        }
    }


    public static void BindBranchReportAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            // _ht["p_code"] = Shared.CurrentUID;

            ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
            //ddl.Enabled = false;
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindBranchItemPromotion(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            // _ht["p_code"] = Shared.CurrentUID;

            ddl.DataSource = _dal.GetRows("", "xsp_item_group_promotion_for_ddl", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
            //ddl.Enabled = false;
        }
        catch (Exception ex)
        {
        }
    }




    public static void BindSubBranch(DropDownList ddl, String CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = CODE;
            //_ht["p_code"] = Shared.CurrentUID;


            ddl.DataSource = _dal.GetRows("", "xsp_sub_branch_filter_getrows", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
            //ddl.Enabled = false;
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindBranchEmployee(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = Shared.CurrentUID;

            //ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataSource = _dal.GetRows("", "xsp_master_branch_filter_getrows", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();


        }
        catch (Exception ex)
        {
        }
    }

    public static void BindBranchEmployeeSort(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataTable dtBranch = null;

        string cacheKey = "CACHE_BRANCH_" + Shared.CurrentUID;

        //try
        //{
        //    _dal = new GeneralDAL();
        //    _ht = new Hashtable();

        //    _ht["p_keywords"] = "";
        //    _ht["p_code"] = Shared.CurrentUID;

        //    //ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
        //    ddl.DataSource = _dal.GetRows("", "xsp_master_branch_filter_sort_getrows", _ht);
        //    ddl.DataTextField = "DESCRIPTION";
        //    ddl.DataValueField = "CODE";
        //    ddl.DataBind();


        //}
        //catch (Exception ex)
        //{
        //}
        try
        {
            if (HttpContext.Current.Cache[cacheKey] != null)
            {
                dtBranch = (DataTable)HttpContext.Current.Cache[cacheKey];
            }
            else
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();
                _ht["p_keywords"] = "";
                _ht["p_code"] = Shared.CurrentUID;

                dtBranch = _dal.GetRows("", "xsp_master_branch_filter_sort_getrows", _ht);
                if (dtBranch != null && dtBranch.Rows.Count > 0)
                {
                    HttpContext.Current.Cache.Insert(
                        cacheKey,
                        dtBranch,
                        null,
                        DateTime.Now.AddMinutes(60),
                        System.Web.Caching.Cache.NoSlidingExpiration
                    );
                }

            }
            ddl.DataSource = dtBranch;
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindBranchEmployeeAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = Shared.CurrentUID;

            //ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataSource = _dal.GetRows("", "xsp_master_branch_filter_getrows_all", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();


        }
        catch (Exception ex)
        {
        }
    }
    public static void BindOwnerAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = Shared.CurrentUID;

            //ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataSource = _dal.GetRows("", "xsp_master_owner_getrows_all", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();


        }
        catch (Exception ex)
        {
        }
    }
    public static void BindGetBranch(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataTable dtBranch = null;

        string cacheKey = "CACHE_GET_BRANCH_" + Shared.CurrentUID;
        try
        {
            if (HttpContext.Current.Cache[cacheKey] != null)
            {
                dtBranch = (DataTable)HttpContext.Current.Cache[cacheKey];
            }
            else
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();
                _ht["p_keywords"] = "";
                _ht["p_code"] = Shared.CurrentUID;

                dtBranch = _dal.GetRows("", "xsp_master_branch_getrows", _ht);
                if (dtBranch != null && dtBranch.Rows.Count > 0)
                {
                    HttpContext.Current.Cache.Insert(
                        cacheKey,
                        dtBranch,
                        null,
                        DateTime.Now.AddMinutes(180),
                        System.Web.Caching.Cache.NoSlidingExpiration
                    );
                }

            }
            ddl.DataSource = dtBranch;
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindBranchEmployeeAll1(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = Shared.CurrentUID;

            //ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataSource = _dal.GetRows("", "xsp_master_branch_filter_getrows_all1", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();


        }
        catch (Exception ex)
        {
        }
    }


    public static void BindBranchEmployeeAll1SEL(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = Shared.CurrentUID;

            //ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataSource = _dal.GetRows("", "xsp_master_branch_filter_getrows_all1", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));

        }
        catch (Exception ex)
        {
        }
    }
    public static void BindBranchEmployeeApproval(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = Shared.CurrentUID;


            //ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataSource = _dal.GetRows("", "xsp_master_branch_filter_getrows", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindModul(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code"] = "";

            //ddl.DataSource = _dal.GetRows("MASTER_BRANCH", _ht);
            ddl.DataSource = _dal.GetRows("", "xsp_master_modul_filter_getrows", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }


    public static void BindCurrency(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_CURRENCY", _ht);
            ddl.DataTextField = "CURRENCY_CODE";
            ddl.DataValueField = "CURRENCY_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindCurrencyCode(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_CURRENCY", _ht);
            ddl.DataTextField = "CURRENCY_CODE";
            ddl.DataValueField = "CURRENCY_CODE";
            ddl.DataBind();
            ddl.SelectedValue = "IDR";
            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindCurrencyCodeAcc(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_master_currency_getrows_acc", _ht);
            ddl.DataTextField = "CURRENCY_CODE";
            ddl.DataValueField = "CURRENCY_CODE";
            ddl.DataBind();
            ddl.SelectedValue = "IDR";
        }
        catch (Exception ex)
        {
        }
    }


    public static void BindFaLocation(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Shared.CurrentDefaultEmployeeBranchCode;


            ddl.DataSource = _dal.GetRows("", "xsp_fa_location_ddl_getrows", _ht);
            ddl.DataTextField = "LOC_NAME";
            ddl.DataValueField = "LOC_CODE";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindFaLocationAllMut(DropDownList ddl, string Branch)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Branch;


            ddl.DataSource = _dal.GetRows("", "xsp_fa_location_mut_ddl_getrows", _ht);
            ddl.DataTextField = "LOC_NAME";
            ddl.DataValueField = "LOC_CODE";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindFaLocationAllMutCab(DropDownList ddl, string Branch)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Branch;


            ddl.DataSource = _dal.GetRows("", "dbo.xsp_fa_location_mut_cab_ddl_getrows", _ht);
            ddl.DataTextField = "LOC_NAME";
            ddl.DataValueField = "LOC_CODE";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));

        }
        catch (Exception ex)
        {
        }
    }


    public static void BindFaLocationAll(DropDownList ddl, string Branch)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Branch;


            ddl.DataSource = _dal.GetRows("", "dbo.xsp_fa_location_ddl_getrows", _ht);
            ddl.DataTextField = "LOC_NAME";
            ddl.DataValueField = "LOC_CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindFaLocationAllRecon(DropDownList ddl, string Branch)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Branch;


            ddl.DataSource = _dal.GetRows("", "dbo.xsp_fa_location_ddl_getrows", _ht);
            ddl.DataTextField = "LOC_NAME";
            ddl.DataValueField = "LOC_CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, new ListItem("ALL", "ALL"));

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindFaLocationReportAll(DropDownList ddl, string Branch)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Branch;


            ddl.DataSource = _dal.GetRows("", "dbo.xsp_fa_location_ddl_getrows", _ht);
            ddl.DataTextField = "LOC_NAME";
            ddl.DataValueField = "LOC_CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, new ListItem("ALL", "ALL"));	

        }
        catch (Exception ex)
        {
        }
    }

    public static void BindMasterUnit(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";


            ddl.DataSource = _dal.GetRows("MASTER_UNIT", _ht);
            ddl.DataTextField = "UNIT_DESC";
            ddl.DataValueField = "UNIT_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindMasterOwner(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_branch_code"] = Shared.CurrentDefaultEmployeeBranchCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_item_lookup_getrows", _ht);
            ddl.DataTextField = "OWNER";
            ddl.DataValueField = "OWNER";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }


    public static void BindMasterUnit1(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_UNIT", _ht);
            ddl.DataTextField = "UNIT_DESC";
            ddl.DataValueField = "ID";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindMasterUnitOwner(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_master_units_owner_getrows", _ht);
            ddl.DataTextField = "UNIT_DESC";
            ddl.DataValueField = "ID";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindFACategory(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("FA_CATEGORY", _ht);
            ddl.DataTextField = "CAT_NAME";
            ddl.DataValueField = "CAT_CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, "");

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindCategoryReportAll(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("FA_CATEGORY", _ht);
            ddl.DataTextField = "CAT_NAME";
            ddl.DataValueField = "CAT_CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, "");

            ddl.Items.Insert(0, new ListItem("ALL", "ALL"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindPayment(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("", "xsp_sys_payment_schedule_getrows_for_ddl", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
            ddl.SelectedValue = "MNT";
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindFAChangeCategory(DropDownList ddl, string FromCategory)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_FromCategory"] = FromCategory;

            ddl.DataSource = _dal.GetRows("FA_CATEGORY", _ht);
            ddl.DataTextField = "CAT_NAME";
            ddl.DataValueField = "CAT_CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindFAGroup(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("FA_GROUP", _ht);
            ddl.DataTextField = "NAME";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, "");

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindFACategoryFiscal(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("FA_CATEGORY_FISCAL", _ht);
            ddl.DataTextField = "CAT_NAME";
            ddl.DataValueField = "CAT_CODE";
            ddl.DataBind();
            //ddl.Items.Insert(0, "");

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    public static void BindAsset(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("SYS_ASSET_TYPE", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindWilayah(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_REGION", _ht);
            ddl.DataTextField = "REGION_NAME";
            ddl.DataValueField = "CODE";
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("-=Select=-", "0"));
        }
        catch (Exception ex)
        {
        }
    }

    private static HorizontalAlign ConvertToHorizontalAlignEnum(string s)
    {
        if (s.Equals("Left"))
            return HorizontalAlign.Left;
        else if (s.Equals("Right"))
            return HorizontalAlign.Right;
        else
            return HorizontalAlign.Center;
    }

    public static void BindLookUp(GridView gvw, string LookUpCode, ref string SPName)
    {
        string sSPName = "";

        DataTable dt = GetLookUp(LookUpCode, ref sSPName);
        ArrayList alDataKeyNames = new ArrayList();
        SPName = sSPName;
        gvw.Columns.Clear();

        if (dt != null)
        {
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["IS_DATAKEY"].ToString().Equals("0"))
                {
                    if (dr["IS_VISIBLE"].ToString().Equals("1"))
                        gvw.Columns.Add(new BoundField { DataField = dr["FIELD_NAME"].ToString(), HeaderText = dr["HEADER_NAME"].ToString(), DataFormatString = string.Format("{0}", dr["FORMAT"]), ItemStyle = { Width = Unit.Percentage(Int32.Parse(dr["WIDTH_PCT"].ToString())), HorizontalAlign = ConvertToHorizontalAlignEnum(dr["ALIGNMENT"].ToString()) } });
                }
                else
                {
                    if (dr["IS_VISIBLE"].ToString().Equals("1"))
                        gvw.Columns.Add(new BoundField { DataField = dr["FIELD_NAME"].ToString(), HeaderText = dr["HEADER_NAME"].ToString(), DataFormatString = string.Format("{0}", dr["FORMAT"]), ItemStyle = { Width = Unit.Percentage(Int32.Parse(dr["WIDTH_PCT"].ToString())), HorizontalAlign = ConvertToHorizontalAlignEnum(dr["ALIGNMENT"].ToString()) } });

                    alDataKeyNames.Add(dr["FIELD_NAME"].ToString());
                }
            }

            gvw.DataKeyNames = (string[])alDataKeyNames.ToArray(Type.GetType("System.String"));

            gvw.Columns.Add(new CommandField { ShowSelectButton = true });

            gvw.DataSource = ExecRawSP(sSPName);
            gvw.DataBind();
        }
    }

    private static DataTable GetLookUp(string LookUpCode, ref string SPName)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataTable _dt = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_lookup_code"] = LookUpCode;

            _dt = _dal.GetRows("MASTER_LOOKUP_COLUMN", _ht);

            if (_dt != null && _dt.Rows.Count > 0)
            {
                SPName = _dt.Rows[0]["SP_NAME"].ToString();
            }
            else
                throw new Exception("Fail to execute MASTER_LOOKUP_COLUMN");

            return _dt;
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    public static void BindLookUpApproval(GridView gvw, string CodeBarcode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataTable _dt = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_code_barcode"] = CodeBarcode;

            _dt = _dal.GetRows("", "dbo.xsp_approvel_review_application_getrows", _ht);


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public static void BindSubscription(string SubscribeCode, ref string TableSource, ref string TableTarget, ref string SPSaveName,
        ref string SPSourceToTarget, ref string SPTargetToSource, ref string SPParameterCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataTable _dt = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = string.Empty;
            _ht["p_subscribe_code"] = SubscribeCode;

            _dt = _dal.GetRows("MASTER_SUBSCRIPTION", _ht);

            if (_dt.Rows.Count > 0)
            {
                TableSource = _dt.Rows[0]["SP_TABLE_SOURCE"].ToString();
                TableTarget = _dt.Rows[0]["SP_TABLE_TARGET"].ToString();
                SPSaveName = _dt.Rows[0]["SP_SAVE_NAME"].ToString();
                SPSourceToTarget = _dt.Rows[0]["SP_SOURCE_TO_TARGET"].ToString();
                SPTargetToSource = _dt.Rows[0]["SP_TARGET_TO_SOURCE"].ToString();
                SPParameterCode = _dt.Rows[0]["SP_PARAMETER_CODE"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private static DataTable ExecRawSP(string SPName)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;


        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _ht["p_keywords"] = "";

            return _dal.GetRows("", SPName, _ht);
        }
        catch (Exception ex)
        {
            return null; ;
        }
    }

    public static string GenerateLookUpReturnString(string data, GridView gvw)
    {

        string queryString = data;
        string script = "";
        string[] items = queryString.Split('&');
        string obj = "";

        foreach (string item in items)
        {
            string[] xyz = item.Split('=');
            string ctrlID = xyz[1];

            if (xyz[0].Contains("col_"))
            {
                string[] abc = xyz[0].Split('_');
                int iColIndex = Int32.Parse(abc[1]);

                if (ctrlID.Contains("lbl"))
                    script += "parent.$get('" + ctrlID + "').innerHTML = '" + gvw.SelectedDataKey[iColIndex].ToString() + "';";
                else
                    script += "parent.$get('" + ctrlID + "').value = '" + gvw.SelectedDataKey[iColIndex].ToString() + "';";
            }

            else if (xyz[0] == "obj")
            {
                obj = xyz[1];
            }
        }

        if (obj == "")
            script += "parent.$('#ModalPopup').modal('hide'); parent.jsDoAfterLookUp();";
        else
            script += "parent.$('#ModalPopup').modal('hide'); parent.jsDoAfterLookUp('" + obj + "');";

        return script;
    }

    public static string MakeSingleLine(Exception ex)
    {
        string err = "";
        Exception exx = ex;

        while (exx != null)
        {
            err += exx.Message + " - ";
            exx = exx.InnerException;
        }

        return err.Replace("'", "").Replace("\n", "").Replace("\r", "");
    }

    public static string HashingPassword(string p)
    {
        return p;
    }

    public static string ExecuteReport(Page page, int ReportID, Hashtable ReportParameters, ExportFormatType ExportType)
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        ReportDocument _doc = null;

        string ReturnFileName = Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("yyyyMMddHHmmss");
        //string ResultFileName = page.Server.MapPath(@"..\..\temp\" + ReturnFileName);
        string ResultFileName = page.Server.MapPath(@"..\..\temp\pdf\" + ReturnFileName);

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ReportID;
            DataRow _dr = _dal.GetRow("MASTER_REPORT", _ht);

            //dapatin properties dari report
            string SPName = _dr["SP_NAME"].ToString();
            string TableName = _dr["TABLE_NAME"].ToString();
            string ReportName = page.Server.MapPath(@"..\..\rpt\" + _dr["RPT_NAME"].ToString());

            //execute sp report
            _dal.ExecRawSP(SPName, ReportParameters);

            //load ke report memory
            _doc = new ReportDocument();
            _doc.Load(ReportName);

            //inject security info
            ConnectionInfo connectioninfo = new ConnectionInfo();
            connectioninfo.ServerName = iProc.DataAccessLayer.Utility.Shared.RPTDBServer;
            connectioninfo.DatabaseName = iProc.DataAccessLayer.Utility.Shared.RPTDBName;
            connectioninfo.UserID = iProc.DataAccessLayer.Utility.Shared.RPTDBUID;
            connectioninfo.Password = iProc.DataAccessLayer.Utility.Shared.RPTDBPassword;

            foreach (CrystalDecisions.CrystalReports.Engine.Table table in _doc.Database.Tables)
            {
                TableLogOnInfo tloi = table.LogOnInfo;
                tloi.ConnectionInfo = connectioninfo;

                table.ApplyLogOnInfo(tloi);
            }

            string ReportFormula = "{" + TableName + ".P_USER_ID} = \"" + Shared.CurrentUID + "\"";


            if (ExportType == ExportFormatType.PortableDocFormat)
            {
                ResultFileName = ResultFileName + ".pdf";
                ReturnFileName = ReturnFileName + ".pdf";
            }
            else if (ExportType == ExportFormatType.Excel || ExportType == ExportFormatType.ExcelRecord)
            {
                ResultFileName = ResultFileName + ".xls";
                ReturnFileName = ReturnFileName + ".xls";
            }
            else if (ExportType == ExportFormatType.WordForWindows)
            {
                ResultFileName = ResultFileName + ".doc";
                ReturnFileName = ReturnFileName + ".doc";
            }

            _doc.RecordSelectionFormula = ReportFormula;
            _doc.ExportToDisk(ExportType, ResultFileName);
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return ReturnFileName;
    }
    public static string ExportToExcel(string filepath, DataTable dt, ArrayList column)
    {
        DataTable table = new DataTable();
        CreateTable(dt, ref table, column);

        string file = new ExcelHelper().ExportToExcel(table);

        if (filepath[filepath.Length - 1] != 'x')
            filepath += "x";
        File.Copy(file, filepath, true);

        return filepath;
    }
    private static void CreateTable(DataTable source, ref DataTable table, ArrayList column)
    {
        // create columns
        //int counter = 0;
        foreach (DataColumn col in source.Columns)
        {
            DataColumn datacol = new DataColumn(col.ColumnName);
            datacol.DataType = col.DataType;
            table.Columns.Add(datacol);
            //counter++;
        }

        // fill rows
        foreach (DataRow row in source.Rows)
        {
            DataRow dr;
            dr = table.NewRow();

            foreach (string col in column)
            {
                dr[col] = row[col];
            }

            table.Rows.Add(dr);
        }
    }
    public static string CombineReport(IList pdfFiles, string pdfFile)
    {
        try
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            foreach (object o in pdfFiles)
            {
                sb.Append(o.ToString());
                sb.Append(" ");
            }

            sb.AppendFormat("cat output {0} allow printing", pdfFile);

            System.Diagnostics.Process p = System.Diagnostics.Process.Start(PDFTK, sb.ToString());
            p.WaitForExit();

            return pdfFile;
        }
        catch (Exception ex)
        {
            throw new Exception("Fail to combine pdf file.", ex);
        }
    }
    public static string ExecuteReportExportExcel(Page page, string spReportName, string spResultName, Hashtable parameter, string filepath)
    {
        GeneralDAL dalReport = null;
        try
        {
            //  execute DAL first
            dalReport = new GeneralDAL();
            DataTable dt = dalReport.ExecuteExcelReport(spReportName, spResultName, parameter);
            ArrayList column = new ArrayList();

            if (spResultName != null)
            {
                column = new ArrayList();
                foreach (DataColumn col in dt.Columns)
                {
                    column.Add(col.ColumnName);
                }
                ExportToExcel(filepath, dt, column);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {

        }

        return filepath;
    }



    public static string ExecuteReportExcel(Page page, string TableName, Hashtable ReportParameters, ExportFormatType ExportType)
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        ReportDocument _doc = null;

        string ReturnFileName = TableName + Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("yyyyMMddHHmmss");
        string ResultFileName = page.Server.MapPath(@"..\..\temp\xls\" + ReturnFileName);

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();



            //dapatin properties dari report
            string SPName = "xsp_" + TableName;
            string ReportName = page.Server.MapPath(@"..\..\rpt\" + TableName + ".rpt");

            //execute sp report
            _dal.ExecRawSP(SPName, ReportParameters);

            //load ke report memory
            _doc = new ReportDocument();
            _doc.Load(ReportName);

            //inject security info
            ConnectionInfo connectioninfo = new ConnectionInfo();
            connectioninfo.DatabaseName = iProc.DataAccessLayer.Utility.Shared.RPTDBName;
            connectioninfo.ServerName = iProc.DataAccessLayer.Utility.Shared.RPTDBServer;
            connectioninfo.UserID = iProc.DataAccessLayer.Utility.Shared.RPTDBUID;
            connectioninfo.Password = iProc.DataAccessLayer.Utility.Shared.RPTDBPassword;

            foreach (CrystalDecisions.CrystalReports.Engine.Table table in _doc.Database.Tables)
            {
                TableLogOnInfo tloi = table.LogOnInfo;
                tloi.ConnectionInfo = connectioninfo;

                table.ApplyLogOnInfo(tloi);
            }

            string ReportFormula = "{" + TableName + ".P_USER_ID} = \"" + Shared.CurrentUID + "\"";


            if (ExportType == ExportFormatType.PortableDocFormat)
            {
                ResultFileName = ResultFileName + ".pdf";
                ReturnFileName = "pdf/" + ReturnFileName + ".pdf";
            }
            else if (ExportType == ExportFormatType.Excel || ExportType == ExportFormatType.ExcelRecord)
            {
                ResultFileName = ResultFileName + ".xls";
                ReturnFileName = "xls/" + ReturnFileName + ".xls";
            }
            else if (ExportType == ExportFormatType.WordForWindows)
            {
                ResultFileName = ResultFileName + ".doc";
                ReturnFileName = "doc/" + ReturnFileName + ".doc";
            }

            _doc.RecordSelectionFormula = ReportFormula;
            _doc.ExportToDisk(ExportType, ResultFileName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (_doc != null)
                _doc.Close();
        }
        return ReturnFileName;
    }

    public static string ExecuteReportExcel(Page page, string TableName, string RPT, string SPName, Hashtable ReportParameters, ExportFormatType ExportType)
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        ReportDocument _doc = null;

        string ReturnFileName = TableName + Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("yyyyMMddHHmmss");
        string ResultFileName = page.Server.MapPath(@"..\..\temp\xls\" + ReturnFileName);

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();



            //dapatin properties dari report
            //string SPName = "xsp_" + TableName;
            string ReportName = page.Server.MapPath(@"..\..\rpt\" + TableName + ".rpt");

            //execute sp report
            _dal.ExecRawSP(SPName, ReportParameters);

            //load ke report memory
            _doc = new ReportDocument();
            _doc.Load(ReportName);

            //inject security info
            ConnectionInfo connectioninfo = new ConnectionInfo();
            connectioninfo.DatabaseName = iProc.DataAccessLayer.Utility.Shared.RPTDBName;
            connectioninfo.ServerName = iProc.DataAccessLayer.Utility.Shared.RPTDBServer;
            connectioninfo.UserID = iProc.DataAccessLayer.Utility.Shared.RPTDBUID;
            connectioninfo.Password = iProc.DataAccessLayer.Utility.Shared.RPTDBPassword;

            foreach (CrystalDecisions.CrystalReports.Engine.Table table in _doc.Database.Tables)
            {
                TableLogOnInfo tloi = table.LogOnInfo;
                tloi.ConnectionInfo = connectioninfo;

                table.ApplyLogOnInfo(tloi);
            }

            string ReportFormula = "{" + TableName + ".P_USER_ID} = \"" + Shared.CurrentUID + "\"";


            if (ExportType == ExportFormatType.PortableDocFormat)
            {
                ResultFileName = ResultFileName + ".pdf";
                ReturnFileName = "pdf/" + ReturnFileName + ".pdf";
            }
            else if (ExportType == ExportFormatType.Excel || ExportType == ExportFormatType.ExcelRecord)
            {
                ResultFileName = ResultFileName + ".xls";
                ReturnFileName = "xls/" + ReturnFileName + ".xls";
            }
            else if (ExportType == ExportFormatType.WordForWindows)
            {
                ResultFileName = ResultFileName + ".doc";
                ReturnFileName = "doc/" + ReturnFileName + ".doc";
            }

            _doc.RecordSelectionFormula = ReportFormula;
            _doc.ExportToDisk(ExportType, ResultFileName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (_doc != null)
                _doc.Close();
        }
        return ReturnFileName;
    }

    public static string ExecuteReport(Page page, string TableName, Hashtable ReportParameters, ExportFormatType ExportType)
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        ReportDocument _doc = null;
        //AA
        string ReturnFileName = TableName + Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("yyyyMMddHHmmss");
        string ResultFileName = page.Server.MapPath(@"..\..\temp\pdf\" + ReturnFileName);

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();



            //dapatin properties dari report
            string SPName = "xsp_" + TableName;
            string ReportName = page.Server.MapPath(@"..\..\rpt\" + TableName + ".rpt");

            //execute sp report
            _dal.ExecRawSP(SPName, ReportParameters);

            //load ke report memory
            _doc = new ReportDocument();
            _doc.Load(ReportName);

            //inject security info
            ConnectionInfo connectioninfo = new ConnectionInfo();
            connectioninfo.ServerName = iProc.DataAccessLayer.Utility.Shared.RPTDBServer;
            connectioninfo.DatabaseName = iProc.DataAccessLayer.Utility.Shared.RPTDBName;
            connectioninfo.UserID = iProc.DataAccessLayer.Utility.Shared.RPTDBUID;
            connectioninfo.Password = iProc.DataAccessLayer.Utility.Shared.RPTDBPassword;

            foreach (CrystalDecisions.CrystalReports.Engine.Table table in _doc.Database.Tables)
            {
                TableLogOnInfo tloi = table.LogOnInfo;
                tloi.ConnectionInfo = connectioninfo;

                table.ApplyLogOnInfo(tloi);
            }

            string ReportFormula = "{" + TableName + ".P_USER_ID} = \"" + Shared.CurrentUID + "\"";


            if (ExportType == ExportFormatType.PortableDocFormat)
            {
                ResultFileName = ResultFileName + ".pdf";
                ReturnFileName = "pdf/" + ReturnFileName + ".pdf";
            }
            else if (ExportType == ExportFormatType.Excel || ExportType == ExportFormatType.ExcelRecord)
            {
                ResultFileName = ResultFileName + ".xls";
                ReturnFileName = "xls/" + ReturnFileName + ".xls";
            }
            else if (ExportType == ExportFormatType.WordForWindows)
            {
                ResultFileName = ResultFileName + ".doc";
                ReturnFileName = "doc/" + ReturnFileName + ".doc";
            }

            _doc.RecordSelectionFormula = ReportFormula;
            _doc.ExportToDisk(ExportType, ResultFileName);
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return ReturnFileName;
    }
    public static string ExecuteReportBarcode(Page page, string TableName, Hashtable ReportParameters, ExportFormatType ExportType, string PaperName)
    {

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        ReportDocument _doc = null;
        //AA
        string ReturnFileName = Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("yyyyMMddHHmmss");
        string ResultFileName = page.Server.MapPath(@"..\..\temp\pdf\" + ReturnFileName);

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();



            //dapatin properties dari report
            string SPName = "xsp_" + TableName;
            string ReportName = page.Server.MapPath(@"..\..\rpt\" + TableName + ".rpt");

            //execute sp report
            _dal.ExecRawSP(SPName, ReportParameters);

            //load ke report memory
            _doc = new ReportDocument();
            _doc.Load(ReportName);

            //inject security info
            ConnectionInfo connectioninfo = new ConnectionInfo();
            connectioninfo.ServerName = iProc.DataAccessLayer.Utility.Shared.RPTDBServer;
            connectioninfo.DatabaseName = iProc.DataAccessLayer.Utility.Shared.RPTDBName;
            connectioninfo.UserID = iProc.DataAccessLayer.Utility.Shared.RPTDBUID;
            connectioninfo.Password = iProc.DataAccessLayer.Utility.Shared.RPTDBPassword;

            foreach (CrystalDecisions.CrystalReports.Engine.Table table in _doc.Database.Tables)
            {
                TableLogOnInfo tloi = table.LogOnInfo;
                tloi.ConnectionInfo = connectioninfo;

                table.ApplyLogOnInfo(tloi);
            }

            System.Drawing.Printing.PrintDocument pd = new System.Drawing.Printing.PrintDocument();

            for (int i = 0; i < pd.PrinterSettings.PaperSizes.Count; i++)
            {
                int RawKind;

                if (pd.PrinterSettings.PaperSizes[i].PaperName == PaperName)
                {
                    RawKind = (int)(pd.PrinterSettings.PaperSizes[i].GetType().GetField("kind", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic).GetValue(pd.PrinterSettings.PaperSizes[i]));
                    _doc.PrintOptions.PaperSize = (PaperSize)RawKind;
                }
            }

            string ReportFormula = "{" + TableName + ".P_USER_ID} = \"" + Shared.CurrentUID + "\"";


            if (ExportType == ExportFormatType.PortableDocFormat)
            {
                ResultFileName = ResultFileName + ".pdf";
                ReturnFileName = ReturnFileName + ".pdf";
            }
            else if (ExportType == ExportFormatType.Excel || ExportType == ExportFormatType.ExcelRecord)
            {
                ResultFileName = ResultFileName + ".xls";
                ReturnFileName = ReturnFileName + ".xls";
            }
            else if (ExportType == ExportFormatType.WordForWindows)
            {
                ResultFileName = ResultFileName + ".doc";
                ReturnFileName = ReturnFileName + ".doc";
            }

            _doc.RecordSelectionFormula = ReportFormula;
            _doc.ExportToDisk(ExportType, ResultFileName);
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return ReturnFileName;
    }
    public static string ExecuteReport(Page page, string TableName, string RPT, string SPName, Hashtable ReportParameters, ExportFormatType ExportType)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        ReportDocument _doc = null;

        string ReturnFileName = RPT + Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("yyyyMMddHHmmss");
        string ResultFileName = page.Server.MapPath(@"..\..\temp\pdf\" + ReturnFileName);
        //string ResultFileName = page.Server.MapPath(@"..\..\temp\" + ReturnFileName);

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //dapatin properties dari report
            //string SPName_2 = SPName;
            string ReportName = page.Server.MapPath(@"..\..\rpt\" + RPT + ".rpt");

            //execute sp report
            _dal.ExecRawSP(SPName, ReportParameters);

            //load ke report memory
            _doc = new ReportDocument();
            _doc.Load(ReportName);

            //inject security info
            ConnectionInfo connectioninfo = new ConnectionInfo();
            connectioninfo.ServerName = iProc.DataAccessLayer.Utility.Shared.RPTDBServer;
            connectioninfo.DatabaseName = iProc.DataAccessLayer.Utility.Shared.RPTDBName;
            connectioninfo.UserID = iProc.DataAccessLayer.Utility.Shared.RPTDBUID;
            connectioninfo.Password = iProc.DataAccessLayer.Utility.Shared.RPTDBPassword;

            foreach (CrystalDecisions.CrystalReports.Engine.Table table in _doc.Database.Tables)
            {
                TableLogOnInfo tloi = table.LogOnInfo;
                tloi.ConnectionInfo = connectioninfo;

                table.ApplyLogOnInfo(tloi);
            }

            string ReportFormula = "{" + TableName + ".P_USER_ID} = \"" + Shared.CurrentUID + "\"";


            if (ExportType == ExportFormatType.PortableDocFormat)
            {
                ResultFileName = ResultFileName + ".pdf";
                ReturnFileName = "pdf/" + ReturnFileName + ".pdf";
            }
            else if (ExportType == ExportFormatType.Excel || ExportType == ExportFormatType.ExcelRecord)
            {
                ResultFileName = ResultFileName + ".xls";
                ReturnFileName = "xls/" + ReturnFileName + ".xls";
            }
            else if (ExportType == ExportFormatType.WordForWindows)
            {
                ResultFileName = ResultFileName + ".doc";
                ReturnFileName = "doc/" + ReturnFileName + ".doc";
            }

            _doc.RecordSelectionFormula = ReportFormula;
            _doc.ExportToDisk(ExportType, ResultFileName);
        }
        catch (Exception ex)
        {
            throw ex;
        }

        finally
        {
            _doc.Close();
            _doc.Dispose();
        }

        return ReturnFileName;
    }

    public static void PreviewReport(Page page, string filename)
    {
        ScriptManager.RegisterStartupScript(page, page.GetType(), "Report", "window.open('../../temp/" + filename + "', 'report', 'fullscreen=0, menubar=0, status=0, scrollbars=0, resizable=1, toolbar=0, width=600, height=400');", true);
    }


    public static DataTable ReadExcelFile(string sFilePath, string sFileType, string p)
    {
        throw new NotImplementedException();
    }


    public static void BindLocationOrFALocation(DropDownList ddl, string ItemCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_item_code"] = ItemCode;

            ddl.DataSource = _dal.GetRows("", "xsp_master_location_or_fa_location_getrows", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }


    public static void CheckControlRole(Page p, string sUID)
    {
        ArrayList alRoles = (ArrayList)System.Web.HttpContext.Current.Session[SessionKey.CURRENT_USER_ROLE_SESSION_KEY];
        CheckControlRole(p.Controls, alRoles);
    }

    private static void CheckControlRole(ControlCollection cc, ArrayList alRoles)
    {
        foreach (System.Web.UI.Control c in cc)
        {
            if (c.HasControls())
                CheckControlRole(c.Controls, alRoles);
            else
            {
                if (c is XUIButton)
                {

                    XUIButton btn = ((XUIButton)c);
                    if (btn.RoleCode == null || btn.RoleCode == "")
                        btn.Enabled = btn.Visible = true;
                    else if (!CheckRole(btn.RoleCode, alRoles))
                        btn.Enabled = btn.Visible = false;

                }
                else if (c is XUILinkButton)
                {
                    XUILinkButton btn = ((XUILinkButton)c);
                    if (btn.RoleCode == null || btn.RoleCode == "")
                        btn.Enabled = btn.Visible = true;
                    else if (!CheckRole(btn.RoleCode, alRoles))
                        btn.Enabled = btn.Visible = false;

                }
            }
        }
    }
    private static bool CheckRole(string sRole, ArrayList alRoles)
    {

        foreach (object role in alRoles)
        {
            if (sRole == role.ToString())
                return true;
        }

        return false;
    }

    public static void BindGroupCode(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_GROUP_SEC", _ht);
            ddl.DataTextField = "NAME";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    public static void BindApplicationCode(DropDownList ddl)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            ddl.DataSource = _dal.GetRows("MASTER_APPLICATION", _ht);
            ddl.DataTextField = "DESCRIPTION";
            ddl.DataValueField = "CODE";
            ddl.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    public static string GenerateLookUpClearString(string data)
    {
        string queryString = data;
        string script = "";
        string[] items = queryString.Split('&');

        foreach (string item in items)
        {
            string[] xyz = item.Split('=');
            string ctrlID = xyz[1];

            if (xyz[0].Contains("col_"))
            {
                string[] abc = xyz[0].Split('_');
                int iColIndex = Int32.Parse(abc[1]);

                if (ctrlID.Contains("lbl"))
                    script += "parent.$get('" + ctrlID + "').innerHTML = '';";
                else
                    script += "parent.$get('" + ctrlID + "').value = '';";
            }
        }

        script += "parent.$('#ModalPopup').modal('hide');";

        return script;
    }

    public static Boolean IsLoginLocal()
    {
        return System.Configuration.ConfigurationSettings.AppSettings["LoginLocal"].ToString().Equals("1");
    }

    public static Boolean Approval(string sPassword)
    {
        /*(+) Author Rovi 2017-06-15 */
        if (IsLoginLocal())
        {
            /*(+)Chandra - 16-Nov-2015, 11:01:39 AM*/
            GeneralDAL _dal = null;
            Hashtable _ht = null;

            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();

                _ht["p_uid"] = CurrentUID;
                _ht["p_password"] = sPassword;

                DataRow _dr = _dal.GetRow("", "xsp_master_user_main_validate_for_password_approval", _ht);

                if (_dr["UPASSAPPROVAL"].ToString().Equals(_dr["UPASSAPPROVALMD5"].ToString()))
                    return true;
                else
                    return false;
            }
            catch
            {
                return false;
            }

        }
        else
        {
            String _nik = "";
            return ValidateLoginConfins(Shared.CurrentExtUID, sPassword, ref _nik);
        }
    }

    public static string GetUploadPath(string Folder)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            DataRow _dr = _dal.GetRow("", "xsp_sys_global_param_getrow_from_get_path", _ht);
            return _dr["FILE_UPLOAD_PATH"].ToString() + Folder + "/";
        }
        catch
        {
            return "";
        }
    }
    public static Boolean CheckedRow(GridView gvw, string checkbox)
    {/*(+)Chandra - 03-Dec-2015, 11:12:14 AM*/
        Boolean bIsChecked = false;

        foreach (GridViewRow gvr in gvw.Rows)
        {
            CheckBox cb = (CheckBox)gvr.FindControl(checkbox);
            if (cb.Checked)
                bIsChecked = true;
        }

        return bIsChecked;
    }

    /*(+) Author Rovi 2017-06-15 */
    public static string CurrentExtUID
    {
        get
        {
            return HttpContext.Current.Session[SessionKey.CURRENT_EXT_USER_SESSION_KEY].ToString();
        }
    }

    /*(+) Author Rovi 2017-06-15 */
    public static bool ValidateLoginConfins(String uid, String password, ref String nik)
    {

        BfiApiService.WSProcurementSoapClient _BfiApiService = new BfiApiService.WSProcurementSoapClient();
        BfiApiService.LoginResponse _loginResponse = new BfiApiService.LoginResponse();

        //id.co.bfi.app.WSProcurement _BfiApiService = new id.co.bfi.app.WSProcurement();
        //id.co.bfi.app.WSProcurement _LoginCompletedEventArgs = new id.co.bfi.app.WSProcurement();

        String json = String.Empty;

        json = _BfiApiService.Login("Mobitech", "MobitechProcurement20170421", uid, password, "");

        EntityLogin[] users = JsonConvert.DeserializeObject(json, typeof(EntityLogin[])) as EntityLogin[];

        if (users[0].StatusAPI == "00")
        {
            nik = (users[0].NIK.Trim().Length == 5 ? "0" + users[0].NIK : users[0].NIK);
            return true;
        }
        else
        {
            return false;
        }
    }

    public static Boolean CheckFileUploadSize(Page p, FileUpload fu)
    {/*(+)check file upload size - Chandra - 14-Dec-2016, 4:37:08 PM*/
        if (fu.PostedFile.ContentLength > 3000000)
        {
            ScriptManager.RegisterStartupScript(p, p.GetType(), "fx", "fnShowErrorNotif('Maximum file size allowed is 3 mb.', '');", true);
            return false;
        }
        else
            return true;
    }

    public static bool IsUserRoleChanged()
    {
        ArrayList existingRoles = HttpContext.Current.Session[SessionKey.CURRENT_USER_ROLE_SESSION_KEY] as ArrayList;
        ArrayList freshRoles = new ArrayList();

        try
        {
            GeneralDAL _dal = new GeneralDAL();
            Hashtable _ht = new Hashtable();
            _ht["p_uid"] = CurrentUID;

            DataTable dt = _dal.GetRows("", "xsp_master_user_main_getrows_all_role", _ht);
            if (dt != null)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    freshRoles.Add(dr["ROLE_CODE"]);
                }
            }

            // Bandingkan isi existing dan fresh
            if (existingRoles == null || existingRoles.Count != freshRoles.Count)
            {
                return true;
            }

            foreach (string role in freshRoles)
            {
                if (!existingRoles.Contains(role))
                {
                    return true;
                }
            }

            return false; // semua cocok
        }
        catch
        {
            return true; // anggap berubah jika gagal ambil
        }
    }

    #region Grouping Asset
    public static void ExportToExcelDirectDownload(string tableName, string spName, Hashtable reportParameters)
    {
        GeneralDAL _dal = new GeneralDAL();
        //DataTable dt = null;
        DataTable dt = _dal.GetRows(spName, reportParameters);

        using (MemoryStream memStream = new MemoryStream())
        {
            using (SpreadsheetDocument document = SpreadsheetDocument.Create(memStream, SpreadsheetDocumentType.Workbook))
            {
                // --- SETUP WORKBOOK ---
                WorkbookPart workbookPart = document.AddWorkbookPart();
                workbookPart.Workbook = new Spreadsheet.Workbook();

                // --- STYLESHEET ---
                WorkbookStylesPart stylePart = workbookPart.AddNewPart<WorkbookStylesPart>();
                stylePart.Stylesheet = CreateStylesheet();
                stylePart.Stylesheet.Save();

                WorksheetPart worksheetPart = workbookPart.AddNewPart<WorksheetPart>();

                // --- COLUMNS & DATA ---
                Spreadsheet.Columns columns = CreateColumnsWithAutoWidth(dt);
                Spreadsheet.SheetData sheetData = new Spreadsheet.SheetData();

                worksheetPart.Worksheet = new Spreadsheet.Worksheet();
                worksheetPart.Worksheet.Append(columns);
                worksheetPart.Worksheet.Append(sheetData);

                Spreadsheet.Sheets sheets = document.WorkbookPart.Workbook.AppendChild<Spreadsheet.Sheets>(new Spreadsheet.Sheets());
                Spreadsheet.Sheet sheet = new Spreadsheet.Sheet()
                {
                    Id = document.WorkbookPart.GetIdOfPart(worksheetPart),
                    SheetId = 1,
                    Name = tableName.Length > 30 ? tableName.Substring(0, 30) : tableName
                };
                sheets.Append(sheet);

                // --- HEADER ---
                Spreadsheet.Row headerRow = new Spreadsheet.Row();
                foreach (DataColumn column in dt.Columns)
                {
                    // Gunakan Spreadsheet.CellValues
                    Spreadsheet.Cell cell = CreateCell(column.ColumnName, Spreadsheet.CellValues.InlineString);
                    cell.StyleIndex = 1;
                    headerRow.AppendChild(cell);
                }
                sheetData.AppendChild(headerRow);

                // --- DATA ---
                foreach (DataRow dsrow in dt.Rows)
                {
                    Spreadsheet.Row newRow = new Spreadsheet.Row();
                    foreach (DataColumn col in dt.Columns)
                    {
                        string cellValue = dsrow[col].ToString();

                        // Deteksi tipe data
                        Spreadsheet.CellValues dataType = IsNumericType(col.DataType) ?
                            Spreadsheet.CellValues.Number : Spreadsheet.CellValues.InlineString;

                        if (dataType == Spreadsheet.CellValues.Number && string.IsNullOrEmpty(cellValue))
                            cellValue = "0";

                        newRow.AppendChild(CreateCell(cellValue, dataType));
                    }
                    sheetData.AppendChild(newRow);
                }

                workbookPart.Workbook.Save();
            }

            // --- DOWNLOAD PROCESS ---
            string fileName = tableName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx";

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" + fileName);

            memStream.WriteTo(HttpContext.Current.Response.OutputStream);
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
        }
    }

    // Perhatikan penggunaan 'Spreadsheet.' pada return type dan isi fungsi
    private static Spreadsheet.Stylesheet CreateStylesheet()
    {
        return new Spreadsheet.Stylesheet(
            new Spreadsheet.Fonts(
                new Spreadsheet.Font(),
                new Spreadsheet.Font(new Spreadsheet.Bold(), new Spreadsheet.Color() { Rgb = "FFFFFF" })
            ),
            new Spreadsheet.Fills(
                new Spreadsheet.Fill(new Spreadsheet.PatternFill() { PatternType = Spreadsheet.PatternValues.None }),
                new Spreadsheet.Fill(new Spreadsheet.PatternFill() { PatternType = Spreadsheet.PatternValues.Gray125 }),
                new Spreadsheet.Fill(new Spreadsheet.PatternFill(new Spreadsheet.ForegroundColor() { Rgb = "4F81BD" }) { PatternType = Spreadsheet.PatternValues.Solid })
            ),
            new Spreadsheet.Borders(new Spreadsheet.Border()),
            new Spreadsheet.CellFormats(
                new Spreadsheet.CellFormat(),
                new Spreadsheet.CellFormat() { FontId = 1, FillId = 2, ApplyFill = true, ApplyFont = true }
            )
        );
    }

    private static Spreadsheet.Columns CreateColumnsWithAutoWidth(DataTable dt)
    {
        Spreadsheet.Columns cols = new Spreadsheet.Columns();
        for (int i = 0; i < dt.Columns.Count; i++)
        {
            int maxChar = dt.Columns[i].ColumnName.Length;
            foreach (DataRow row in dt.Rows)
            {
                int len = row[i].ToString().Length;
                if (len > maxChar) maxChar = len;
            }
            double width = (maxChar > 50) ? 55 : maxChar + 3.5;
            cols.Append(new Spreadsheet.Column() { Min = (uint)i + 1, Max = (uint)i + 1, Width = width, CustomWidth = true });
        }
        return cols;
    }

    private static Spreadsheet.Cell CreateCell(string text, Spreadsheet.CellValues dataType)
    {
        Spreadsheet.Cell cell = new Spreadsheet.Cell() { DataType = dataType };
        if (dataType == Spreadsheet.CellValues.InlineString)
            cell.InlineString = new Spreadsheet.InlineString(new Spreadsheet.Text(text ?? ""));
        else
            cell.CellValue = new Spreadsheet.CellValue(text ?? "0");
        return cell;
    }

    private static bool IsNumericType(Type type)
    {
        switch (Type.GetTypeCode(type))
        {
            case TypeCode.Decimal:
            case TypeCode.Double:
            case TypeCode.Int16:
            case TypeCode.Int32:
            case TypeCode.Int64:
            case TypeCode.Single: return true;
            default: return false;
        }
    }
    #endregion

}
