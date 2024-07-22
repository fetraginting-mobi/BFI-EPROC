using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_sysdimension : BasePage
{
    private static string TABLE_NAME = "SYS_DIMENSION";
    private static string TABLE_NAME_DETAIL = "SYS_DIMENSION_VALUE";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataDetail();
                txtCode.Enabled = false;
                rblType_SelectedIndexChanged(null, null);
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";

                ////(+) Start - 2015/12/14 - 08:47 - Adi - [for checking and creating lock]
                //LockTransaction(txtCode.Text, "GENERAL CODE INFO", lblLocked);
                ////(+) End - 2015/12/14 - 08:47 - Adi -
            }
            else
            {
                rblType_SelectedIndexChanged(null, null);
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

            Shared.ShowSuccessGritter(this, string.Format("sysdimension.aspx?action=edit&code={0}", txtCode.Text));
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
        Response.Redirect("sysdimensionlist.aspx");
    }

    protected void rblType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblType.SelectedValue.Equals("T"))
        {
            pnlTable.Visible = true;
            pnlFunction.Visible = false;
            txtFunction.Text = "";
        }
        else
        {
            pnlTable.Visible = false;
            pnlFunction.Visible = true;
            txtTableName.Text = txtColumnName.Text = txtPrimaryColumn.Text = "";
        }
    }

    #region detail
    private void BindDataDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataView dv = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_dimension_code"] = Request.Params["code"];

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht).DefaultView;
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
        BindDataDetail();
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!Shared.CheckedRow(gvwList, "chbSelect"))
        {
            Shared.ShowValidationError(this, "There is no data selected");
            return;
        }
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString(), txtCode.Text);
            }

        }

        BindDataDetail();
        Response.Redirect(string.Format("sysdimension.aspx?action=edit&code={0}", Request.Params["code"]));

    }

    private void DeleteData(string ID, string CODE)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;
            _ht["p_dimension_code"] = CODE;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataDetail();
    }
    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "edt", string.Format("javascript:fnShowGenericScreen('../../module/commonmst/sysdimensionvalue.aspx?action=edit&code={0}&id={1}');", Request.Params["code"], gvwList.SelectedDataKey[0].ToString()), true);
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "edt", string.Format("javascript:fnShowGenericScreen('../../module/commonmst/sysdimensionvalue.aspx?action=add&code={0}');", Request.Params["code"]), true);
    }

    


    #endregion
}

