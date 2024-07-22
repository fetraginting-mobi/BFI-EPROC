using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class setting : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            btnSubscriptionWidget.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=SWIDGET&empcode={0}');", Shared.CurrentUID);
            btnSubscriptionNotifi.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=SNOTIFI&empcode={0}');", Shared.CurrentUID);
            

            btnDeleteSubscribeWidget.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteSubscribeNotifi.OnClientClick = "return confirm('Delete selected data?');";

            BindWidget();
            BindNotifi();
            
        }
    }

    protected void gvwListWidget_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListWidget.PageIndex = e.NewPageIndex;
        BindWidget();
    }

    private void BindWidget()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchWidget.Text;
            _ht["p_emp_code"] = Shared.CurrentUID;

            gvwListWidget.DataSource = _dal.GetRows("", "xsp_employee_widget_subscription_getrows", _ht);
            gvwListWidget.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListWidget_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("settingwidgetsubscriptioninfo.aspx?action=edit&empcode={0}&widgetcode={1}", Shared.CurrentUID, gvwListWidget.SelectedDataKey[0].ToString()));
    }

    protected void btnDeleteSubscribeWidget_OnClick(object sender, EventArgs e)
    {
        
        foreach (GridViewRow row in gvwListWidget.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[0].Controls[1];
            if (chb.Checked)
            {
                DeleteDataWidget(Shared.CurrentUID, gvwListWidget.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindWidget();
    }

    private void DeleteDataWidget(string empcode, string widgetcode)
    {
        

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_emp_code"] = empcode;
            _ht["p_widget_code"] = widgetcode;

            _dal.ExecRawSP("xsp_employee_widget_subscription_delete_", _ht);

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchWidget_Click(object sender, EventArgs e)
    {
        BindWidget();
    }

    protected void chbWidgetCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListWidget.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbWidgetChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    #region Notification
    protected void gvwListNotifi_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListNotifi.PageIndex = e.NewPageIndex;
        BindNotifi();
    }

    private void BindNotifi()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchNotif.Text;
            _ht["p_emp_code"] = Shared.CurrentUID;

            gvwListNotifi.DataSource = _dal.GetRows("", "xsp_employee_notification_subscription_getrows", _ht);
            gvwListNotifi.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnDeleteSubscribeNotifi_OnClick(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListNotifi.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[0].Controls[1];
            if (chb.Checked)
            {
                DeleteDataNotifi(Shared.CurrentUID, gvwListNotifi.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindNotifi();
    }

    private void DeleteDataNotifi(string empcode, string notificode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_emp_code"] = empcode;
            _ht["p_notifi_code"] = notificode;

            _dal.ExecRawSP("xsp_employee_notification_subscription_delete", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchNotif_Click(object sender, EventArgs e)
    {
            BindNotifi();
    }

    protected void chbNotifiCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListNotifi.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbNotifiChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    #endregion
}
