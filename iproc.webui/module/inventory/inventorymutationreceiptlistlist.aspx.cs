using System;
using System.Data;
using System.IO;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;

public partial class module_inventory_inventorymutationreceiptlistlist : BasePageList
{
    //private static string TABLE_NAME = "INVENTORY_MUTATION_REQUEST_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        //Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "IM");

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeSort(ddlBranch);
            BindData();
        }

        LoadAfterInit();
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        //DataView dv = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_status"] = ddlStatus.SelectedValue;

            gvwList.DataSource = _dal.GetRows("", "xsp_inventory_mutation_receipt_list_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    private void SaveData(string IM_CODE, DateTime Date)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_im_code"] = IM_CODE;
            _ht["p_receive_date"] = Date;

            Shared.ApplyDefaultProp(_ht);

            _dal.Update("", "xsp_inventory_mutation_receipt_list_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventorymutationreceiptlistlist.aspx?"));
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Int16 iRowSelected = 0;

        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                iRowSelected++;

                DateTime Date = Shared.ToDateTime(((TextBox)row.Cells[6].Controls[1]).Text);

                SaveData(gvwList.DataKeys[row.RowIndex][0].ToString(), Date);
            }
        }



        BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //if (Request.Params["action"].Equals("edit"))
        BindData();
    }

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("inventorymutationreceiptlist.aspx?action=edit&im_code=" + gvwList.SelectedDataKey[0].ToString());
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

}
