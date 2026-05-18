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


public partial class lookup_genericwithparametercustom : BasePage
{
    private static string SPNAME = string.Empty;

    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            InitializeLookup();
            BindData();
        }
    }

    #endregion


    #region Initialization

    private void InitializeLookup()
    {
        Shared.BindLookUp(gvwList, Request.Params["code"], ref SPNAME);
    }

    #endregion


    #region Data Binding

    private void BindData()
    {
        GeneralDAL dal = null;

        try
        {
            dal = new GeneralDAL();

            gvwList.DataSource = dal.GetRows(
                "",
                SPNAME,
                BuildLookupParameters());

            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private Hashtable BuildLookupParameters()
    {
        Hashtable ht = new Hashtable();

        ht["p_keywords"] = txtSearch.Text.Trim();
        ht["p_user_id"] = Shared.CurrentUID;

        for (int i = 0; i < Request.Params.Count; i++)
        {
            string key = Request.Params.AllKeys[i];

            if (String.IsNullOrEmpty(key))
                continue;

            if (key.StartsWith("par_"))
            {
                string paramName = key.Substring(4);
                ht["p_" + paramName] = Request.Params[i];
            }
            else if (key.StartsWith("parc_"))
            {
                string paramName = key.Substring(5);
                ht["p_" + paramName] = Request.Params[i];
            }
        }

        return ht;
    }

    #endregion


    #region Button Events

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvwList.PageIndex = 0;
        BindData();
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearch.Text = String.Empty;

        string script = Shared.GenerateLookUpClearString(ClientQueryString);

        ScriptManager.RegisterStartupScript(
            this,
            GetType(),
            "LookupClear",
            script,
            true);
    }

    #endregion


    #region Grid Events

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        string script = Shared.GenerateLookUpReturnString(
            ClientQueryString,
            gvwList);

        ScriptManager.RegisterStartupScript(
            this,
            GetType(),
            "LookupReturn",
            script,
            true);
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    #endregion
}
