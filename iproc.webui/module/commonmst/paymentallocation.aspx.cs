using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_paymentallocation : BasePage
{
    private static string TABLE_NAME = "MASTER_PAYMENT_ALLOCATION";
    private static string TABLE_NAME_DETAIL = "MASTER_PAYMENT_ALLOCATION_DETAIL";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindItemGroupDetail();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
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
            {
                _dal.Insert(TABLE_NAME, _ht);
            }
            else
                _dal.Update(TABLE_NAME, _ht);
            Shared.ShowSuccessGritter(this, string.Format("paymentallocationlist.aspx")); 
            //Shared.ShowSuccessGritter(this, string.Format("paymentallocationlist.aspx?action=edit&code={0}", TxtCode.Text));
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
        Response.Redirect("paymentallocationlist.aspx");
    }

     #region item group detail

    private void BindItemGroupDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_allocation_id"] = TxtCode.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = code;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwList_RowCreated(object sender, GridViewRowEventArgs e)
    {
       
    }
    

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindItemGroupDetail();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("paymentallocationdetail.aspx?action=add&&allocationcode=" + TxtCode.Text);
        //Response.Redirect("masteritemgroupdetail.aspx?action=add&idheader=" + lblId.Text + "&categorycode=" + txtGroup.Text + "&accexpensepo=" + lblNoExpensePO.Text + "&accexpenseponame=" + lblNameExpensePO.Text + "&accnoinv=" + lblNoINV.Text + "&accnoinvname=" + lblNameNoINV.Text + "&accassetpo=" + lblNoAssetPO.Text + "&accassetponame=" + lblNameAssetPO.Text);
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

        BindItemGroupDetail();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
       
            BindItemGroupDetail();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Response.Redirect(string.Format("masteritemgroupdetail.aspx.aspx?action=edit&id={0}", gvwList.SelectedDataKey[0].ToString() + "&categorycode=" + txtGroup.Text));
        //Response.Redirect("masteritemgroupdetail.aspx?action=edit&idheader=" + lblId.Text + "&categorycode=" + txtGroup.Text + "&accexpensepo=" + lblNoExpensePO.Text + "&accexpenseponame=" + lblNameExpensePO.Text + "&accnoinv=" + lblNoINV.Text + "&accnoinvname=" + lblNameNoINV.Text + "&accassetpo=" + lblNoAssetPO.Text + "&accassetponame=" + lblNameAssetPO.Text + "&id=" + gvwList.SelectedDataKey[0].ToString());
        Response.Redirect("paymentallocationdetail.aspx?action=edit&id=" + gvwList.SelectedDataKey[0].ToString() + "&allocationcode=" + TxtCode.Text);
    }

    protected void chbCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwList.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    #endregion

}


