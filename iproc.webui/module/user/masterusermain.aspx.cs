using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_user_masterusermain : BasePage
{
    private static string TABLE_NAME = "MASTER_USER_MAIN";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            btnDeleteGroup.OnClientClick = "return confirm('Delete selected data?');";

            txtMonthLoginLog.Text = DateTime.Today.ToString("MM");
            txtYearLoginLog.Text = DateTime.Today.ToString("yyyy");
            txtMonthActivityLog.Text = DateTime.Today.ToString("MM");
            txtYearActivityLog.Text = DateTime.Today.ToString("yyyy");

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataGroup();

                btnCancel.Text = "Back";

                if (lblIsActive.Text == "1")
                    btnActive.Enabled = false;
            }
        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = Request.Params["uid"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void ReactiveUID()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = Request.Params["uid"];
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_master_user_main_update_status", _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterusermain.aspx?action=edit&uid={0}", lblID.Text)); 
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnActive_Click(object sender, EventArgs e)
    {
        ReactiveUID();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("masterusermainlist.aspx");
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListGroup.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    #region Group
    private void BindDataGroup()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = lblID.Text;

            gvwListGroup.DataSource = _dal.GetRows("MASTER_USER_MAIN_GROUP_SEC", _ht);
            gvwListGroup.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataGroup(string ID, string Group)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = ID;
            _ht["p_group_code"] = Group;

            _dal.Delete("MASTER_USER_MAIN_GROUP_SEC", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListGroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListGroup.PageIndex = e.NewPageIndex;
        BindDataGroup();
    }

    protected void btnAddGroup_Click(object sender, EventArgs e)
    {
        Response.Redirect("masterusermaingroup.aspx?action=add&uid=" + lblID.Text);
    }

    protected void btnDeleteGroup_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListGroup.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataGroup(lblID.Text, gvwListGroup.DataKeys[row.RowIndex][1].ToString());
            }
        }

        BindDataGroup();
    }

    protected void gvwListGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("masterusermaingroup.aspx?action=edit&uid=" + lblID.Text);
    }
    #endregion

    #region Login Log
    private void BindDataLoginLog()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = lblID.Text;
            _ht["p_year"] = txtYearLoginLog.Text;
            _ht["p_month"] = txtMonthLoginLog.Text;

            gvwListLoginLog.DataSource = _dal.GetRows("MASTER_USER_LOGIN_LOG", _ht);
            gvwListLoginLog.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListLoginLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListLoginLog.PageIndex = e.NewPageIndex;
        BindDataLoginLog();
    }

    protected void btnViewGvwListLoginLog_OnClick(object sender, EventArgs e)
    {
        BindDataLoginLog();
    }
    #endregion

    #region Activity Log
    private void BindDataActivityLog()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = lblID.Text;
            _ht["p_year"] = txtYearActivityLog.Text;
            _ht["p_month"] = txtMonthActivityLog.Text;

            gvwListActivityLog.DataSource = _dal.GetRows("MASTER_USER_ACTIVITY_LOG", _ht);
            gvwListActivityLog.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListActivityLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListActivityLog.PageIndex = e.NewPageIndex;
        BindDataActivityLog();
    }

    protected void btnViewGvwListActivityLog_OnClick(object sender, EventArgs e)
    {
        BindDataActivityLog();
    }
    #endregion
}
