using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_fa_historyperalatan : BasePage
{
    //private static string TABLE_NAME_REQUEST = "REQUEST_PERALATAN_KERJA_HEADER";
    //private static string TABLE_NAME_RETURN = "RETURN_PERALATAN_KERJA_HEADER";
   
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            //Shared.BindLocation(ddlLocation);
            BindData();
            //gvwList.Columns[1].Visible = false;
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

            _ht["p_code"] = Request.Params["code"];
            //_ht["p_keywords"] = txtSearch.Text;
            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_history_request_return_peralatan_kerja_getrow", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void DeleteData(string ID)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_id"] = ID;

    //        _dal.Delete(TABLE_NAME, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}


    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
}