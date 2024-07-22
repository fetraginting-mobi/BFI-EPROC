using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using System.Collections;
using MPF23.Shared.Mapper;
using System.Data;

public partial class module_purchaseorder_itemquotationselection : BasePage
{
    private static string TABLE_NAME = "PURCHASE_REQUEST_DETAIL";
    private static string TABLE_NAME_HISTORY = "PURCHASE_REQUEST_HISTORY";

    public string type;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "javascript:unit();;", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "javascript:owner();;", true);
            Shared.BindMasterUnit(ddlUnitID);
            Shared.BindMasterOwner(ddlPurposeDepartment);

            lblBarcode.Text = Request.Params["prcode"];
             
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindHistory();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";

                
            }
            else
                GetCode();
        }
        LoadAfterInit();
    }

    private void GetCode()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["prcode"];
            DataRow _dr = _dal.GetRow("PURCHASE_REQUEST_HEADER", _ht);

            lblPRCode.Text = _dr["code"].ToString();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = Request.Params["idprd"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("itemquotationselectionlist.aspx");
    }

    #region History
    private void BindHistory()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchList.Text;
            _ht["p_pr_code"] = lblBarcode.Text;
            _ht["p_id_prd"] = lblId.Text;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME_HISTORY, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        // 
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlStatus = (DropDownList)e.Row.FindControl("ddlStatus");

            ddlStatus.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "FLAG_STATUS"));
              
        }
    }

    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

            
        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");

                    //string Remarks = ((TextBox)row.FindControl("txtRemarks")).Text; jaka internal qa 1911000254


                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_flag_status"] = ddlStatus.SelectedValue;
                    _ht["p_remarks"] = "";
                     
                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update(TABLE_NAME_HISTORY, _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("itemquotationselection.aspx?action=edit&prcode=" + Request.Params["prcode"] + "&idprd=" + Request.Params["idprd"]));
            BindHistory();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindHistory();
    }

    private void DeleteData(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_HISTORY, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void CreateData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        int sNextBarcode = 0;
        
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = 0;
            _ht["p_pr_code"] = lblBarcode.Text;
            _ht["p_id_prd"] = Int32.Parse(lblId.Text);

            Shared.ApplyDefaultProp(_ht);
           
            _dal.Insert(TABLE_NAME_HISTORY, _ht, ref sNextBarcode);
            BindHistory();
            

            //Shared.ShowSuccessGritter(this, string.Format("purchaserequestheader.aspx?action=edit&codebarcode={0}", lblBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        CreateData();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindHistory();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
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

        BindHistory();
    }

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
    #endregion
}
