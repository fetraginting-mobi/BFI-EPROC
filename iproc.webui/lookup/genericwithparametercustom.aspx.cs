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
using System.Collections.Generic;


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

            ValidateMoveParentAsset(dal, sourceGaCode, barcodes);

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

    private void ValidateMoveParentAsset(GeneralDAL dal, string sourceGaCode, string barcodes)
    {
        Hashtable ht = new Hashtable();
        ht["p_keywords"] = String.Empty;
        ht["p_fa_group_asset_code"] = sourceGaCode;

        DataTable dt = dal.GetRows("fa_grouping_asset_detail", ht);

        if (dt == null || dt.Rows.Count == 0)
            return;

        List<string> selectedBarcodes = new List<string>(
            barcodes.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries));

        bool parentSelected = false;

        foreach (DataRow row in dt.Rows)
        {
            string barcode = Convert.ToString(GetDataRowValue(row, "BARCODE")).Trim();
            if (String.IsNullOrEmpty(barcode) || !ContainsText(selectedBarcodes, barcode))
                continue;

            if (IsCheckedValue(GetDataRowValue(row, "is_parent")))
            {
                parentSelected = true;
                break;
            }
        }

        if (parentSelected && selectedBarcodes.Count < dt.Rows.Count)
        {
            throw new Exception("Asset cannot be moved to a grouping because it is flagged as parent.");
        }
    }

    private bool ContainsText(List<string> values, string value)
    {
        foreach (string item in values)
        {
            if (String.Equals(item.Trim(), value, StringComparison.OrdinalIgnoreCase))
                return true;
        }

        return false;
    }

    private bool IsCheckedValue(object value)
    {
        if (value == null || value == DBNull.Value)
            return false;

        string stringValue = Convert.ToString(value).Trim();

        return stringValue.Equals("1")
            || stringValue.Equals("true", StringComparison.OrdinalIgnoreCase)
            || stringValue.Equals("y", StringComparison.OrdinalIgnoreCase)
            || stringValue.Equals("yes", StringComparison.OrdinalIgnoreCase)
            || stringValue.Equals("active", StringComparison.OrdinalIgnoreCase);
    }

    private object GetDataRowValue(DataRow dr, string columnName)
    {
        if (dr == null || dr.Table == null)
            return null;

        foreach (DataColumn column in dr.Table.Columns)
        {
            if (String.Equals(column.ColumnName, columnName, StringComparison.OrdinalIgnoreCase))
                return dr[column];
        }

        return null;
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
