using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using System.Data;

public partial class module_inventory_inventoryopnamehistoryheader : BasePage
{
    private static string TABLE_NAME = "INVENTORY_CARD";


    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "INVENTORY_CARD";
        NEXT_PAGE = "inventorycardheaderlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {

            lblApprovalRequestTargetID.Text = Request.Params["idartarget"];
            BindData();
            gvwList.Columns[1].Visible = false;
           
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/inventoryopnamehistory.aspx";
         btnApprovalTiered.Attributes["href"] = String.Format("javascript:fnShowApprovalTieredDialog('../../approval/generictiered.aspx?parc_id_ar_target={0}&nexturl={1}&spname={2}');", lblApprovalRequestTargetID.ClientID, Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY], "xsp_application_approve_comment_insert");
      
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
            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            Shared.ApplyDefaultProp(_ht);

            DataTable dt = _dal.GetRows("", "xsp_inventory_opname_history_approval_getrows", _ht);
            gvwList.DataSource = dt;
            gvwList.DataBind();

            lblCodeBarcode.Text = dt.Rows[0]["CODE_BARCODE"].ToString();
            lblTransFlag.Text = dt.Rows[0]["TRANS_FLAG_DESC"].ToString();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME, _ht);
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
    //protected override void SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}
   

    //protected void ddlBranchList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Shared.BindLocationFilterBranch(ddlLocation, ddlBranch.SelectedValue);
    //    BindData();

    //}




}      
