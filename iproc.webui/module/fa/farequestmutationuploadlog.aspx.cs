using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using iProc.DataAccessLayer;


public partial class module_fa_farequestmutationuploadlog : BasePageList
{
    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "FA_MUTATION_DETAIL_UPLOAD";
        NEXT_PAGE = "";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            lblStatus.Text = Request.Params["status"]; ;
            BindData();
            if (lblStatus.Text == "VALID")
            {
                gvwList.Columns[4].Visible = false; // index kolom ERROR_MESSAGE
            }

        }
        LoadAfterInit();

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
            string p_upload_id = Request.Params["uploadid"];
            _ht["p_upload_id"] = new Guid(p_upload_id);
            _ht["p_file_name "] = Request.Params["filename"];
            _ht["p_status"] = Request.Params["status"];

            gvwList.DataSource = _dal.GetRows("", "xsp_fa_mutation_detail_upload_getrows", _ht);
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "fn2", String.Format("parent.$('GenericScreen').modal('hide'); parent.location.href='faasset.aspx?action=edit&id={0}&assetno={1}&assettype={2}';", Request.Params["id"].ToString(), Request.Params["assetno"].ToString(), Request.Params["assettype"].ToString()), true);
    }

    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl = (Label)e.Row.FindControl("lblStatusText");

            if (lbl != null)
            {
                string status = lbl.Text.Trim().ToUpper();

                if (status == "VALID")
                {
                    lbl.Text = "<i class='icon-ok' style='color:green; margin-right:5px;'></i> " + status;
                }
                else
                {
                    lbl.Text = "<i class='icon-warning-sign' style='color:red; margin-right:5px;'></i> " + status;
                }

                lbl.EnableViewState = false;
            }
        }
    }
}
