using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_approval_approvaltypelist : BasePageList
{
    private static string TABLE_NAME = "APPROVAL_TYPE";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "APPROVAL_TYPE";
        NEXT_PAGE = "approvaltype.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            BindData();

            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
        } LoadAfterInit();
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("approvaltype.aspx?action=add");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindData();
    }

    //private void btnPrintPDF_Click()
    //{
    //    GeneralDAL _dal;
    //    Hashtable _ht;
    //    IList listPDF = new ArrayList();

    //    string rptName = "rpt_approval_list";
    //    string rptPath;
    //    string pdfPath;
    //    string tamp;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_user_id"] = Shared.CurrentUID;

    //        rptPath = Server.MapPath(@"..\..\rpt\" + rptName + ".rpt");
    //        tamp = Shared.ExecuteReport(this, rptName, _ht, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
    //        string[] spl = tamp.Split('/');
    //        pdfPath = Server.MapPath(@"..\..\temp\" + spl[0]);
    //        listPDF.Add(pdfPath);

    //        string sPdfName;
    //        sPdfName = rptName + "_" + Shared.CurrentUID.Replace(" ", "") + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".pdf";
    //        string sPdfPath = Server.MapPath(@"..\..\temp\" + sPdfName);
    //        Shared.CombineReport(listPDF, sPdfPath);
    //        ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/" + sPdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);

    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void btnPrintPDF_Click(object sender, EventArgs e)
    {

        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "rpt_approval_list", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
        Shared.PreviewReport(this, sFilename);
    }

    protected void btnPrintExcel_Click(object sender, EventArgs e)
    {

        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;

        string sFilename = "";

        sFilename = Shared.ExecuteReport(this, "rpt_approval_list", htParams, CrystalDecisions.Shared.ExportFormatType.Excel);
        Shared.PreviewReport(this, sFilename);
    }

    private void DeleteData(string Code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = Code;

            _dal.Delete(TABLE_NAME, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnAppCopy_Click(object sender, EventArgs e)
    {
        //Session[SessionKey.CURRENT_TAB_INDEX_SESSION_KEY] = txtTabCode.Text;

        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                Response.Redirect("approvaltype.aspx?action=copy&code=" + gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("approvaltype.aspx?action=edit&code=" + gvwList.SelectedDataKey[0].ToString());
    }

}

