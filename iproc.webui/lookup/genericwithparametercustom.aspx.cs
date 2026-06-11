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
        if (IsMoveAssetLookup())
        {
            MoveSelectedAssets();
            return;
        }

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

    private bool IsMoveAssetLookup()
    {
        return String.Equals(Request.Params["code"], "FGAMV", StringComparison.OrdinalIgnoreCase);
    }

    private void MoveSelectedAssets()
    {
        GeneralDAL dal = null;

        try
        {
            string sourceGaCode = GetRequestValue("move_source_ga_code", "par_source_ga_code");
            string barcodes = GetRequestValue("move_barcodes_string", "par_barcodes_string");
            string targetGaCode = GetSelectedTargetGaCode();

            if (String.IsNullOrEmpty(sourceGaCode))
                throw new Exception("Source Asset Group Code tidak ditemukan.");

            if (String.IsNullOrEmpty(targetGaCode))
                throw new Exception("Target Asset Group Code tidak ditemukan.");

            if (String.IsNullOrEmpty(barcodes))
                throw new Exception("Pilih minimal 1 asset terlebih dahulu.");

            if (String.Equals(sourceGaCode, targetGaCode, StringComparison.OrdinalIgnoreCase))
                throw new Exception("Target Asset Group tidak boleh sama dengan source.");

            dal = new GeneralDAL();

            Hashtable ht = new Hashtable();
            ht["p_source_ga_code"] = sourceGaCode;
            ht["p_target_ga_code"] = targetGaCode;
            ht["p_barcodes_string"] = barcodes;
            ht["p_user_id"] = Shared.CurrentUID;
            ht["p_ip_address"] = Shared.CurrentIPAddress;

            dal.Update("", "xsp_fa_grouping_asset_move_update", ht);

            RegisterMoveResultScript("SUCCESS", "Asset(s) successfully moved.");
        }
        catch (Exception ex)
        {
            RegisterMoveResultScript("FAILED", ex.Message);
        }
    }

    private string GetSelectedTargetGaCode()
    {
        if (gvwList.SelectedDataKey == null)
            return String.Empty;

        string targetGaCode = GetSelectedDataKeyValue("FA_GROUP_ASSET_CODE");
        if (!String.IsNullOrEmpty(targetGaCode))
            return targetGaCode;

        targetGaCode = GetSelectedDataKeyValue("fa_group_asset_code");
        if (!String.IsNullOrEmpty(targetGaCode))
            return targetGaCode;

        if (gvwList.SelectedDataKey.Values.Count > 0)
            return Convert.ToString(gvwList.SelectedDataKey[0]);

        return String.Empty;
    }

    private string GetRequestValue(string key, string fallbackKey)
    {
        string value = Request.Params[key];

        if (String.IsNullOrEmpty(value))
            value = Request.Params[fallbackKey];

        return value;
    }

    private string GetSelectedDataKeyValue(string key)
    {
        foreach (DictionaryEntry entry in gvwList.SelectedDataKey.Values)
        {
            if (String.Equals(Convert.ToString(entry.Key), key, StringComparison.OrdinalIgnoreCase))
                return Convert.ToString(entry.Value);
        }

        return String.Empty;
    }

    private void RegisterMoveResultScript(string status, string message)
    {
        bool isSuccess = String.Equals(status, "SUCCESS", StringComparison.OrdinalIgnoreCase);
        string escapedMessage = EscapeJavaScript(message);
        string script = "alert('" + escapedMessage + "');";

        if (isSuccess)
        {
            script += "if (window.parent && window.parent !== window) {"
                + "if (window.parent.$) { window.parent.$('#ModalPopup').modal('hide'); }"
                + "window.parent.location.reload();"
                + "} else if (window.opener) {"
                + "window.opener.location.reload(); window.close();"
                + "}";
        }

        ScriptManager.RegisterStartupScript(
            this,
            GetType(),
            "MoveAssetResult",
            script,
            true);
    }

    private string EscapeJavaScript(string value)
    {
        if (String.IsNullOrEmpty(value))
            return String.Empty;

        return value
            .Replace("\\", "\\\\")
            .Replace("'", "\\'")
            .Replace("\r", "\\r")
            .Replace("\n", "\\n");
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    #endregion
}
