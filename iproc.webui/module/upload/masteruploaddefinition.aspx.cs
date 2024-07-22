using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_upload_masteruploaddefinition : BasePage
{
    private static string TABLE_NAME = "MASTER_UPLOAD";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            btnDeleteDefinitionColumn.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDefinitionColumn();

                txtCode.Enabled = false;

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
            else
                btnAddDefinitionColumn.Visible = btnDeleteDefinitionColumn.Visible = false;
        }
        LoadAfterInit();
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = Request.Params["code"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
                _dal.Insert(TABLE_NAME, _ht);
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("masteruploaddefinition.aspx?action=edit&code={0}", txtCode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("masteruploaddefinitionlist.aspx");
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListDefinitionColumn.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }

    #region Upload Definition Column
    protected void gvwListDefinitionColumn_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDefinitionColumn.PageIndex = e.NewPageIndex;
        BindDefinitionColumn();
    }

    protected void gvwListDefinitionColumn_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("masteruploaddefinitioncolumn.aspx?action=edit&id=" + gvwListDefinitionColumn.SelectedDataKey[0].ToString() + "&code=" + txtCode.Text);
    }

    private void BindDefinitionColumn()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_code"] = txtCode.Text;

            gvwListDefinitionColumn.DataSource = _dal.GetRows("MASTER_UPLOAD_COLUMN", _ht);
            gvwListDefinitionColumn.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindDefinitionColumn();
    }

    protected void btnAddDefinitionColumn_Click(object sender, EventArgs e)
    {
        Response.Redirect("masteruploaddefinitioncolumn.aspx?action=add&code=" + txtCode.Text);
    }

    protected void btnDeleteDefinitionColumn_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListDefinitionColumn.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataDefinitionColumn(gvwListDefinitionColumn.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDefinitionColumn();
    }

    private void DeleteDataDefinitionColumn(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete("MASTER_UPLOAD_COLUMN", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    #endregion

}
