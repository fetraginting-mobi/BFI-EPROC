using System;
using System.Data;
using System.IO;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;

public partial class module_inventory_inventorymutationreceiptlist : BasePageList
{
    //private static string TABLE_NAME = "INVENTORY_MUTATION_REQUEST_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "IM");
        txtbranch.Text = Shared.CurrentDefaultEmployeeBranchCode;
      
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
            _ht["p_im_code"] = Request.Params["im_code"];

            gvwList.DataSource = _dal.GetRows("", "xsp_inventory_mutation_receipt_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    private void SaveData(string ID, DateTime Date)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;
            _ht["p_receive_date"] = Date;

            Shared.ApplyDefaultProp(_ht);

            _dal.Update("", "xsp_inventory_mutation_receipt_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventorymutationreceiptlist.aspx?"));
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
        Response.Redirect("inventorymutationreceipt.aspx?action=edit&id=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventorymutationreceiptlistlist.aspx?action=edit&id=" + txtbranch.Text);
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