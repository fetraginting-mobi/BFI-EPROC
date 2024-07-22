using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_falocation : BasePage
{

    private static string TABLE_NAME = "FA_LOCATION";
    private static string TABLE_NAME_ITEM = "FA_LOCATION_ITEM";

    protected void Page_Load(object sender, EventArgs e)
    {
       LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindEmpBranch(ddlBranch);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
                btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                lblLocationID.Enabled = false;
                txtLocationCode.Enabled = false;
                detail.Visible = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
            else
            {
                detail.Visible = false;
                ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchDesc;
                detail.Visible = false;
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

            _ht["p_fa_locationid"] = Request.Params["falocationid"];
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
        int iNextID = 0;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblLocationID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("falocation.aspx?action=edit&falocationid={0}", lblLocationID.Text));
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
        Response.Redirect("falocationlist.aspx");
    }

    #region FA LOCATION ITEM
    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_fa_loc_id"] = Request.Params["falocationid"];

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_ITEM, _ht);
            gvwList.DataBind();
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

            _ht["p_code"] = ID;

            _dal.Delete(TABLE_NAME_ITEM, _ht);
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
        Response.Redirect("falocationitem.aspx?action=add&falocationid=" + Request.Params["falocationid"]);
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    protected void SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("falocationitem.aspx?action=edit&code=" + gvwList.SelectedDataKey[0].ToString() + "&falocationid=" + Request.Params["falocationid"]);
    }
    #endregion
}
