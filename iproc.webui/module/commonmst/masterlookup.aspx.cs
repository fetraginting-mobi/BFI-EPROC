using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masterlookup : BasePage
{
    private static string TABLE_NAME    = "MASTER_LOOKUP";
    private static string TABLE_NAME_2  = "MASTER_LOOKUP_COLUMN";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataLookupColumn();
                txtCode.Enabled = false;
                btnDeleteLookupColumn.OnClientClick = "return confirm('Delete selected data?');";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
            else
            {
                btnAddLookupColumn.Visible = btnDeleteLookupColumn.Visible = false;
                pnlLookup.Visible = false;
            }

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

            Shared.ShowSuccessGritter(this, string.Format("masterlookup.aspx?action=edit&code={0}", txtCode.Text));            
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
        Response.Redirect("masterlookuplist.aspx");
    }


    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListLookupColumn.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }



    #region Lookup Column
    
    private void BindDataLookupColumn()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchLookupColumn.Text;
            _ht["p_lookup_code"] = txtCode.Text;

            gvwListLookupColumn.DataSource = _dal.GetRows(TABLE_NAME_2, _ht);
            gvwListLookupColumn.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataLookupColumn(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_2, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListLookupColumn_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListLookupColumn.PageIndex = e.NewPageIndex;
        BindDataLookupColumn();
    }

    protected void btnAddLookupColumn_Click(object sender, EventArgs e)
    {
        Response.Redirect("masterlookupcolumn.aspx?action=add&code="+ txtCode.Text);
    }

    protected void btnDeleteLookupColumn_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListLookupColumn.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataLookupColumn(gvwListLookupColumn.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataLookupColumn();
    }

    protected void btnSearchLookupColumn_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindDataLookupColumn();
    }
    protected void gvwListLookupColumn_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("masterlookupcolumn.aspx?action=edit&id=" + gvwListLookupColumn.SelectedDataKey[0].ToString() + "&code=" + txtCode.Text);
    }
    #endregion Lookup Colum 
}