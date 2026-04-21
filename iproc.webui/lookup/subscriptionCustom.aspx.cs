using System;
using System.Collections;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;

public partial class lookup_subscriptionCustom : BasePage
{
    private string SP_TABLE_SOURCE { get { return (string)ViewState["SPSource"]; } set { ViewState["SPSource"] = value; } }
    private string SP_TABLE_TARGET { get { return (string)ViewState["SPTarget"]; } set { ViewState["SPTarget"] = value; } }
    private string SP_SOURCE_TO_TARGET { get { return (string)ViewState["SPSTT"]; } set { ViewState["SPSTT"] = value; } }
    private string SP_TARGET_TO_SOURCE { get { return (string)ViewState["SPTTS"]; } set { ViewState["SPTTS"] = value; } }
    private string SP_PARAMETER_CODE { get { return (string)ViewState["SPParam"]; } set { ViewState["SPParam"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string tblSrc = "", tblTrg = "", saveName = "", srcTrg = "", trgSrc = "", pCode = "";
            Shared.BindSubscription(Request.Params["code"], ref tblSrc, ref tblTrg, ref saveName, ref srcTrg, ref trgSrc, ref pCode);

            SP_TABLE_SOURCE = tblSrc;
            SP_TABLE_TARGET = tblTrg;
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
        foreach (string key in Request.Params.AllKeys)
        {
            if (string.IsNullOrEmpty(key)) continue;
            if (key.StartsWith("par_")) ht["p_" + key.Substring(4)] = Request.Params[key];
            else if (key.StartsWith("parc_")) ht["p_" + key.Substring(5)] = Request.Params[key];
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

    protected void gvwListSource_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            TableCell tc = new TableCell();e.Row.Cells.AddAt(0, tc);
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TableCell tc = new TableCell(); CheckBox chb = new CheckBox(); chb.ID = "chbChecked";
            tc.Controls.Add(chb); tc.HorizontalAlign = HorizontalAlign.Center; e.Row.Cells.AddAt(0, tc);
        }
    }

    protected void gvwListTarget_RowDataBound(object sender, GridViewRowEventArgs e) { gvwListSource_RowDataBound(sender, e); }

    protected void btnAdd_Click(object sender, EventArgs e)
    { 
        ExecuteMovement(gvwListSource, SP_SOURCE_TO_TARGET); 
    }
    protected void btnRemove_Click(object sender, EventArgs e) 
    { ExecuteMovement(gvwListTarget, SP_TARGET_TO_SOURCE); 
    }

    private void ExecuteMovement(GridView gvw, string spName)
    {
        try
        {
            GeneralDAL dal = new GeneralDAL();
            int codeIdx = -1;
            for (int i = 0; i < gvw.HeaderRow.Cells.Count; i++)
            {
                if (gvw.HeaderRow.Cells[i].Text.ToUpper() == "CODE") { codeIdx = i; break; }
            }
            if (codeIdx == -1) return;

            foreach (GridViewRow row in gvw.Rows)
            {
                CheckBox chb = (CheckBox)row.FindControl("chbChecked");
                if (chb != null && chb.Checked)
                {
                    Hashtable ht = GetCommonParams();
                    ht[SP_PARAMETER_CODE] = row.Cells[codeIdx].Text;
                    Shared.ApplyDefaultProp(ht);
                    dal.Insert("", spName, ht);
                }
            }
            BindDataSource();
            BindDataTarget();
            string pGvw = Request.Params["gvw"] ?? "ctl00$cpb$btnSearch";
            ScriptManager.RegisterStartupScript(this, GetType(), "refresh", "parent.__doPostBack('" + pGvw + "','');", true);
        }
        catch (Exception ex) { Shared.ShowErrorDialog(this, ex); }
    }

    protected void btnSearchSource_Click(object sender, EventArgs e) 
    { 
        BindDataSource(); 
    }
    protected void btnSearchTarget_Click(object sender, EventArgs e) 
    { 
        BindDataTarget(); 
    }
    protected void gvwListSource_PageIndexChanging(object sender, GridViewPageEventArgs e) 
    { 
        gvwListSource.PageIndex = e.NewPageIndex; BindDataSource(); 
    }
    protected void gvwListTarget_PageIndexChanging(object sender, GridViewPageEventArgs e) 
    { 
        gvwListTarget.PageIndex = e.NewPageIndex; BindDataTarget(); 
    }
}