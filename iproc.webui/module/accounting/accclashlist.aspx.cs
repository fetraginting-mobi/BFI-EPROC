using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_accclashlist : BasePageList
{
    private static string TABLE_NAME = "ACC_CLASS";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            BindGainLoss();
        }
    }

    #region gain loss

    #region bind

    private void BindGainLoss()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchClass.Text;
            _ht["p_trans_code"] = "RTE";
            gvwGainLoss.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwGainLoss.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    #endregion

    #region toolbar

    protected void btnAddClass_Click(object sender, EventArgs e)
    {
        Response.Redirect("accclash.aspx?action=add");
    }

    protected void btnDeleteClass_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            foreach (GridViewRow row in gvwGainLoss.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    _ht["p_id"] = Int32.Parse(gvwGainLoss.DataKeys[row.RowIndex][0].ToString());
                    _dal.Delete("ACC_CLASS", _ht);
                }

                BindGainLoss();
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchClass_Click(object sender, EventArgs e)
    {
        BindGainLoss();
    }

    #endregion

    #region gridview

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("accclash.aspx?action=edit&id=" + gvwGainLoss.SelectedDataKey[0].ToString());
    }

    

    #endregion

    #endregion
}
