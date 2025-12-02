using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_inventoryamortizationheader : BasePage
{
    private static string TABLE_NAME_DETAIL = "INVENTORY_AMORTIZATION_DETAIL";
    private static string TABLE_NAME_HEADER = "INVENTORY_AMORTIZATION_HEADER";


    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeSort(ddlBranch);
            btnLookUpInvBarcode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=INVBR&acol_0={0}&bcol_1={1}&ccol_2={2}&ccol_5={3}&ccol_6={4}&parc_branch_code={5}');", txtBarcode.ClientID, txtItemCode.ClientID, txtItemName.ClientID, txtUnitPrice.ClientID, lblPoNo.ClientID,ddlBranch.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindData();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                txtAmortizationDate.Enabled = false;
                //btnDeleteDetail.OnClientClick = "return confirm('Delete selected data?');";
                btnChange.Visible = false;
                if (lblStatus.Text == "PROCESSED")
                {
                    btnSave.Visible = btnProcess.Visible = false;
                    ddlBranch.Enabled = true;
                    btnChange.Visible = true;
                    txtAmortizationDate.Enabled = false;

                } 
                if (lblStatus.Text == "REFUND" || lblStatus.Text == "REFUND-INPROGRESS")
                {
                    btnSave.Visible = btnProcess.Visible = false;
                    txtAmortizationDate.Enabled = false;
                    txtItemName.Enabled = false;
                    btnLookUpInvBarcode.Enabled = false;
                    txtBarcode.Enabled = false;
                    ddlBranch.Enabled = false;

                }
            }
            else
            {
                //btnDeleteDetail.Visible = false;
                pnlAmortization.Visible = false;
                btnChange.Visible = false;
                ddlBranch.Enabled = true;
                txtAmortizationDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            }
        }
        Session[SessionKey.CURRENT_NEXT_URL_SESSION_KEY] = "../module/inventory/inventoryamortizationheaderlist.aspx";

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

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME_HEADER, _ht);

            DBToUI.Map(this.Controls, _dr);
            Shared.BindBranchEmployee(ddlBranch);
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
        string sNextBarcode = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_HEADER, _ht, ref sNextBarcode);
                lblCodeBarcode.Text = sNextBarcode.ToString();
            }
            else
            {
                _dal.Update(TABLE_NAME_HEADER, _ht);
            }

            Shared.ShowSuccessGritter(this, string.Format("inventoryamortizationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveDataBranch()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            Shared.ApplyDefaultProp(_ht);

            _dal.Update("", "xsp_inventory_amortization_header_update_branch", _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventoryamortizationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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

    protected void btnChange_Click(object sender, EventArgs e)
    {
        SaveDataBranch();
    }


    protected void btnProcess_Click(object sender, EventArgs e)
    {
        GenerateData();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("inventoryamortizationheaderlist.aspx");
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_amortization_code"] = Request.Params["codebarcode"];


            gvwList.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void DeleteData(string code)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_id"] = code;

    //        _dal.Delete(TABLE_NAME_DETAIL, _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    //protected void btnDeleteDetail_Click(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in gvwList.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
    //        }
    //    }

    //    BindData();
    //}

    private void GenerateData()
    {
        GeneralDAL _dal = null;

        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();


            _ht["p_code_barcode"] = Request.Params["codebarcode"];

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);


            _dal.ExecRawSP("xsp_inventory_amortization_header_process", _ht);

            Shared.ShowSuccessGritter(this, string.Format("inventoryamortizationheaderlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCodeBarcode.Text != string.Empty)
            BindData();
    }

     protected void txtPeriod_TextChanged(object sender, EventArgs e)
    {
        decimal amount = 0;
        decimal pct = 0;
         
        amount = Decimal.Parse(txtUnitPrice.Text.Replace(".00", "")) / Decimal.Parse(txtPeriod.Text.Replace(".00", "")) ;
        txtAccrueAmount.Text = amount.ToString();

        pct = (Decimal.Parse(txtUnitPrice.Text.Replace(".00", "")) / Decimal.Parse(txtPeriod.Text.Replace(".00", ""))) / Decimal.Parse(txtUnitPrice.Text.Replace(".00", "")) * 100;
        txtAccruePct.Text = pct.ToString();
       // txtPercentage.Enabled = false;
    }

  

    protected void txtAccrueAmount_TextChanged(object sender, EventArgs e) {
        txtPeriod.Text = "0";
        txtAccruePct.Text = "0";
    }
    
}
