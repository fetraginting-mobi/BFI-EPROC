using System;
using System.Data;
using System.IO;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;

public partial class module_fa_famutationreceiptlist : BasePageList
{
    //private static string TABLE_NAME = "FA_REQUEST_MUTATION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
       
        LoadInit();
        BindData();
        

        if (!Page.IsPostBack)
        {
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;
           
        }

        LoadAfterInit();
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

       // DataView dv = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

           
            _ht["p_fm_code"] = Request.Params["fm_code"];
            _ht["p_keywords"] = txtSearch.Text;

            gvwList.DataSource = _dal.GetRows("", "xsp_fa_mutation_receipt_getrows", _ht);

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

            _dal.Update("", "xsp_fa_mutation_receipt_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("famutationreceiptlist.aspx"));
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

                DateTime Date = Shared.ToDateTime(((TextBox)row.Cells[8].Controls[1]).Text);

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
        Response.Redirect("famutationreceipt.aspx?action=edit&id=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("famutationreceiptlistlist.aspx");
    }  

}