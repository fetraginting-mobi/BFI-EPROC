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


public partial class module_purchaseorder_purchaserequestdeatil : BasePage
{
    private static string TABLE_NAME = "PURCHASE_REQUEST_DETAIL";
    private static string TABLE_NAME_HISTORY = "PURCHASE_REQUEST_HISTORY";

    public string type;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
       
       

        if (!Page.IsPostBack)
        {

            btnLookUpItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MIPR&acol_0={0}&bcol_1={1}&dcol_1={2}&ecol_3={3}');", txtItemCode.ClientID, txtItemName.ClientID, txtSpecification.ClientID, txtPurposeDepartment.ClientID);
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "javascript:unit();;", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "fx", "javascript:owner();;", true);
            Shared.BindItemUOM(ddlUnitID, txtItemCode.Text);
            //Shared.BindMasterOwner(ddlPurposeDepartment);

            lblBarcode.Text = Request.Params["codebarcode"];



             
            //if (txtItemCode.Text.Equals(""))
            //{
            //    ddlUnitID.Attributes.Add("style", "display:none");
            //    unit.Attributes.Add("style", "display:none");
            //}
            //else
            //{
            //    ddlUnitID.Attributes.Add("style", "");
            //    unit.Attributes.Add("style", "");
            //}

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindHistory();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                Shared.BindItemUOM(ddlUnitID, txtItemCode.Text);


               
              

                if (!lblPRStatus.Text.Equals("POST"))
                {
                    btnSave.Visible = false;
                    txtApproveQuantity.Enabled = true;
                    txtDescription.Enabled = false;
                    txtQuantity.Enabled = false;
                    txtSpecification.Enabled = false;
                    btnLookUpItem.Enabled = false;
                    appqty.Visible = true;
                   // ddlPurposeDepartment.Enabled = false;
                    ddlPurchaseBy.Enabled = false;
                   

                }

                if (lblStatusDetail.Text.Equals("UN-POST"))
                {
                    btnSave.Visible = true;
                    txtApproveQuantity.Enabled = true;
                    txtDescription.Enabled = true;
                    txtQuantity.Enabled = true;
                    txtSpecification.Enabled = true;
                    btnLookUpItem.Enabled = true;
                    appqty.Visible = true;
                   // ddlPurposeDepartment.Enabled = false;
                    ddlPurchaseBy.Enabled = true;


                }

                 if (lblStatusDetail.Text.Equals("PROCESSED"))
                {
                    btnSave.Visible = false;
                    txtApproveQuantity.Enabled = true;
                    txtDescription.Enabled = false;
                    txtQuantity.Enabled = false;
                    txtSpecification.Enabled = false;
                    btnLookUpItem.Enabled = false;
                    appqty.Visible = true;
                   // ddlPurposeDepartment.Enabled = false;
                    ddlPurchaseBy.Enabled = false;



                }

                if (lblStatusDetail.Text.Equals("NEW"))
                {
                    btnSave.Visible = true;
                    txtApproveQuantity.Visible = true;
                    txtDescription.Enabled = true;
                    txtQuantity.Enabled = true;
                    txtSpecification.Enabled = true;
                    btnLookUpItem.Enabled = true;
                    appqty.Visible = true;
                    lblAppQty.Visible = true;
                    ddlPurchaseBy.Enabled = true;
                    lblconversi.Visible = true;

                   

                }
                if (!lblRounding.Text.Equals(1))
                {
                    lblconversi.Visible = true;
                }

                else
                  lblconversi.Visible = false;
                

                //    if (lblPRStatus.Text.Equals("VERIFIED"))
                //    {
                //        appqty.Visible = true;

                //    }
                //}
                //else
                //    GetCode();
            }
            else
            {
                btnViewHistory.Visible = false;
              
            }

            btnViewHistory.Attributes["href"] = String.Format("javascript:fnShowGenericScreen('../purchaseorder/requeststatus.aspx?action=edit&prcode={0}&itemcode={1}');", lblBarcode.Text, txtItemCode.Text);
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

            _ht["p_code_barcode"] = Request.Params["codebarcode"];
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

            _ht["p_id"] = Request.Params["id"];
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
                lblId.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchaserequestheader.aspx?action=edit&id={0}&codebarcode={1}", lblId.Text, lblBarcode.Text));
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
        Response.Redirect("purchaserequestheader.aspx?action=edit&codebarcode=" + lblBarcode.Text);
    }

    protected void txtItemCode_TextChanged(object sender, EventArgs e)
    {
        Shared.BindItemUOM(ddlUnitID, txtItemCode.Text);
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

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindHistory();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindHistory();
    }

    #endregion
}
