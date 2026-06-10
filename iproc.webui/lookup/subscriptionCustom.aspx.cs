using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using iProc.DataAccessLayer;

public partial class lookup_subscriptionCustom : BasePage
{
    private string SP_TABLE_SOURCE { get { return (string)ViewState["SPSource"] ?? string.Empty; } set { ViewState["SPSource"] = value; } }
    private string SP_TABLE_TARGET { get { return (string)ViewState["SPTarget"] ?? string.Empty; } set { ViewState["SPTarget"] = value; } }
    private string SP_SAVE_NAME { get { return (string)ViewState["SPSaveName"] ?? string.Empty; } set { ViewState["SPSaveName"] = value; } }
    private string SP_SOURCE_TO_TARGET { get { return (string)ViewState["SPSTT"] ?? string.Empty; } set { ViewState["SPSTT"] = value; } }
    private string SP_TARGET_TO_SOURCE { get { return (string)ViewState["SPTTS"] ?? string.Empty; } set { ViewState["SPTTS"] = value; } }
    private string SP_PARAMETER_CODE { get { return (string)ViewState["SPParam"] ?? string.Empty; } set { ViewState["SPParam"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string tblSrc = "", tblTrg = "", saveName = "", srcTrg = "", trgSrc = "", pCode = "";
            Shared.BindSubscription(Request.Params["code"], ref tblSrc, ref tblTrg, ref saveName, ref srcTrg, ref trgSrc, ref pCode);

            SP_TABLE_SOURCE = tblSrc;
            SP_TABLE_TARGET = tblTrg;
            SP_SAVE_NAME = saveName;
            SP_SOURCE_TO_TARGET = srcTrg;
            SP_TARGET_TO_SOURCE = trgSrc;
            SP_PARAMETER_CODE = pCode;

            BindDataSource();
            BindDataTarget();
        }
    }

    private Hashtable GetCommonParams()
    {
        Hashtable ht = new Hashtable();
        ht["p_emp_code"] = Request.Params["empcode"];

        for (int i = 0; i < Request.Params.Count; i++)
        {
            if (Request.Params.AllKeys[i] != null)
            {
                string key = Request.Params.AllKeys[i];
                if (key.StartsWith("par_")) ht["p_" + key.Substring(4)] = Request.Params[i];
                else if (key.StartsWith("parc_")) ht["p_" + key.Substring(5)] = Request.Params[i];
            }
        }
        return ht;
    }

    private void BindDataSource()
    {
        try
        {
            GeneralDAL dal = new GeneralDAL();
            Hashtable ht = GetCommonParams();
            ht["p_keywords"] = txtSearchSource.Text.Trim();

            gvwListSource.DataSource = dal.GetRows("", SP_TABLE_SOURCE, ht);
            gvwListSource.DataBind();
        }
        catch (Exception ex) { Shared.ShowErrorDialog(this, ex); }
    }

    private void BindDataTarget()
    {
        try
        {
            GeneralDAL dal = new GeneralDAL();
            Hashtable ht = GetCommonParams();
            ht["p_keywords"] = txtSearchTarget.Text.Trim();

            gvwListTarget.DataSource = dal.GetRows("", SP_TABLE_TARGET, ht);
            gvwListTarget.DataBind();
        }
        catch (Exception ex) { Shared.ShowErrorDialog(this, ex); }
    }

    protected void btnSearchSource_Click(object sender, EventArgs e) { BindDataSource(); }
    protected void btnSearchTarget_Click(object sender, EventArgs e) { BindDataTarget(); }

    protected void gvwListSource_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListSource.PageIndex = e.NewPageIndex;
        BindDataSource();
    }

    protected void gvwListTarget_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListTarget.PageIndex = e.NewPageIndex;
        BindDataTarget();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        bool isSaved = false;

        foreach (GridViewRow row in gvwListSource.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chb = (CheckBox)row.FindControl("chbChecked");

                if (chb != null && chb.Checked)
                {
                    string codeValue = gvwListSource.DataKeys[row.RowIndex].Value.ToString().Trim();
                    AddDataToTargetGVW(codeValue);
                    isSaved = true;
                }
            }
        }

        if (isSaved)
        {
            CallParentPostBack();
        }
        BindDataSource();
        BindDataTarget();
    }

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        bool isRemoved = false;

        foreach (GridViewRow row in gvwListTarget.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chb = (CheckBox)row.FindControl("chbChecked");

                if (chb != null && chb.Checked)
                {
                    string codeValue = gvwListTarget.DataKeys[row.RowIndex].Value.ToString().Trim();
                    AddDataToSourceGVW(codeValue);
                    isRemoved = true;
                }
            }
        }

        if (isRemoved)
        {
            CallParentPostBack();
        }
        BindDataSource();
        BindDataTarget();
    }

    private void CallParentPostBack()
    {
        string script = "";
        if (Request.Params["gvw"] == null)
            script += "javascript:parent.__doPostBack('ctl00$cpb$btnSearch','');";
        else
            script += "javascript:parent.__doPostBack('" + Request.Params["gvw"] + "','');";

        ScriptManager.RegisterStartupScript(this, GetType(), "fn2", script, true);
    }

    private void AddDataToTargetGVW(string Code)
    {
        try
        {
            GeneralDAL _dal = new GeneralDAL();
            Hashtable _ht = GetCommonParams();
            _ht[SP_PARAMETER_CODE] = Code;
            Shared.ApplyDefaultProp(_ht);
            _dal.Insert("", SP_SOURCE_TO_TARGET, _ht);
        }
        catch (Exception ex) { Shared.ShowErrorDialog(this, ex); }
    }
    
    private void AddDataToSourceGVW(string Code)
    {
        try
        {
            GeneralDAL _dal = new GeneralDAL();
            Hashtable _ht = GetCommonParams();
            _ht[SP_PARAMETER_CODE] = Code;
            Shared.ApplyDefaultProp(_ht);
            _dal.Insert("", SP_TARGET_TO_SOURCE, _ht);
        }
        catch (Exception ex) { Shared.ShowErrorDialog(this, ex); }
    }
}