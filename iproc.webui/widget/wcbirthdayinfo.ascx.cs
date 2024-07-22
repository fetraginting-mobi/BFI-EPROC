using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class widget_wcbirthdayinfo : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindData();
            lblMonth.Text = DateTime.Today.ToString("MMMM yyyy");
        }
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_this_month"] = DateTime.Today.Month;

            gvwListBDay.DataSource = _dal.GetRows("", "xsp_widget_process_birthday_info_getrows", _ht);
            gvwListBDay.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this.Page, ex);
        }
    }

    protected void gvwListBDay_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListBDay.PageIndex = e.NewPageIndex;
        BindData();
    }
}
