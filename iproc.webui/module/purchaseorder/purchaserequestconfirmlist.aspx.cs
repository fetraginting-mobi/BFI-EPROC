using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_purchaserequestconfirmlist : BasePage
{
    private static string TABLE_NAME = "PROCUREMENT_REQUEST_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            BindPRDetail();
        }

        LoadAfterInit();
    }

    private void BindPRDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataView dv = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_user_id"] = Shared.CurrentUID;

            dv = _dal.GetRows("", "xsp_purchase_request_detail_getrows_confirm", _ht).DefaultView;

         

            gvwList.DataSource = dv;
            //gvwList.DataSource = _dal.GetRows("", "xsp_purchase_request_detail_getrows_confirm", _ht);
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
            _ht["p_confirm_date"] = Date;

            Shared.ApplyDefaultProp(_ht);

            _dal.Update("", "xsp_purchase_request_detail_update_confirm", _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaserequestconfirmlist.aspx?"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindPRDetail();
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

                DateTime Date = Shared.ToDateTime(((TextBox)row.Cells[7].Controls[1]).Text);

                SaveData(gvwList.DataKeys[row.RowIndex][0].ToString(), Date);
            }
        }

        //if (iRowSelected < 1)
        //    Shared.ShowValidationError(this, "There is no data selected!");

        BindPRDetail();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //if (Request.Params["action"].Equals("edit"))
        BindPRDetail();
    }
}

