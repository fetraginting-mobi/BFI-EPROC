using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masteritem : BasePage
{
    private static string TABLE_NAME            = "MASTER_ITEM_GROUP";
    private static string TABLE_NAME_DETAIL     = "MASTER_ITEM_GROUP_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        //btnLookUpACCExpensePO.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtACCExpensePO.ClientID, lblNoExpensePO.ClientID, lblNameExpensePO.ClientID);
        //btnLookUpACCAssetPO.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtACCAssetPO.ClientID, lblNoAssetPO.ClientID, lblNameAssetPO.ClientID);
        //btnLookUpACCNoINV.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtACCNoINV.ClientID, lblNoINV.ClientID, lblNameNoINV.ClientID);
        //btnLookUpACCCostFA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_1={0}&bcol_1={1}&ccol_2={2}');", txtACCCostFA.ClientID, lblNoCostFA.ClientID , lblNameCostFA.ClientID);
        //btnLookUpACCDEPRFA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_1={0}&bcol_1={1}&ccol_2={2}');", txtACCDepreFA.ClientID, lblNoDepreFA.ClientID, lblNameDepreFA.ClientID);
        //btnLookUpACCEXPNFA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_1={0}&bcol_1={1}&ccol_2={2}');", txtACCEXPNFA.ClientID, lblNoExpnFA.ClientID, lblNameExpnFA.ClientID);
        //btnLookUpAccPlFa.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_1={0}&bcol_1={1}&ccol_2={2}');", txtACCPLFA.ClientID, lblNoPLFA.ClientID, lblNamePLFA.ClientID);
        //btnLookUpAccClaimFA.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_1={0}&bcol_1={1}&ccol_2={2}');", txtAccClaimFA.ClientID, lblNoClaimFA.ClientID, lblNameClaimFA.ClientID);
       
        btnDelete.OnClientClick = "return confirm('Delete selected data?');";

        LoadInit();
        if (!Page.IsPostBack)
        {
            btnLookUpParentGroup.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LFIG&acol_0={0}&bcol_1={1}');", txtParentGroup.ClientID, lblParentGroup.ClientID);
            Shared.BindGeneralSubCode(ddlJenisItem, "ITMCAT");
            ddlJenisItem.SelectedValue = Request.Params["type"].ToString();
           // Shared.BindItemGroupByCategory(ddlParentCode, ddlJenisItem.SelectedValue);
            Shared.BindTaxScreme(ddlTaxType);
            pnlGroupDetail.Visible = false;
            ddlJenisItem.Enabled = false;
            
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                txtGroup.Enabled = false;
                BindItemGroupDetail();
                pnlGroupDetail.Visible = true;
                btnLookUpParentGroup.Enabled = false;
                txtDescription.Enabled = false;

                //if (ddlJenisItem.SelectedValue == "FA")
                //{
                //    txtAssetAmountThreshold.Visible = false;
                //    Amount.Visible = false;
                //}
                //else if (ddlJenisItem.SelectedValue == "IT")
                //{
                //    txtAssetAmountThreshold.Visible = true;
                //    Amount.Visible = true;
                //}
                //else if (ddlJenisItem.SelectedValue == "IC")
                //{
                //    txtAssetAmountThreshold.Visible = true;
                //    Amount.Visible = true;
                //}
                //else if (ddlJenisItem.SelectedValue == "ET")
                //{
                //    txtAssetAmountThreshold.Visible = true;
                //    Amount.Visible = true;
                //}
                if (ddlJenisItem.SelectedValue == "FA")
                {
                    txtAssetAmountThreshold.Visible = true;
                    Amount.Visible = true;
                    TaxType.Visible = false;
                    ddlTaxType.Visible = false;
                    rfvTaxType.Visible = false;
                    divMassaAsset.Visible = false;

                }
                else if (ddlJenisItem.SelectedValue == "IT")
                {
                    txtAssetAmountThreshold.Visible = false;
                    Amount.Visible = false;
                    TaxType.Visible = false;
                    ddlTaxType.Visible = false;
                    rfvTaxType.Visible = false;
                    divMassaAsset.Visible = false; //(+)gustian 08/03/2022
                    
                }
                else if (ddlJenisItem.SelectedValue == "IC")
                {
                    txtAssetAmountThreshold.Visible = false;
                    Amount.Visible = false;
                }
                else if (ddlJenisItem.SelectedValue == "ET")
                {
                    txtAssetAmountThreshold.Visible = false;
                    Amount.Visible = false;
                    TaxType.Visible = false;
                    ddlTaxType.Visible = false;
                    rfvTaxType.Visible = false;
                    divMassaAsset.Visible = false; //(+)gustian 08/03/2022
                }
            }

             
            else if (Request.Params["action"].Equals("copy"))
           {
                LoadData();
                
                txtGroup.Text = "";
                ddlJenisItem.Enabled = true;
                ddlTaxType.Visible = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";


            }

            else
            {

                if (ddlJenisItem.SelectedValue == "FA")
                {
                    txtAssetAmountThreshold.Visible = true;
                    Amount.Visible = true;
                    TaxType.Visible = false;
                    ddlTaxType.Visible = false;
                    rfvTaxType.Visible = false;
                    divMassaAsset.Visible = false; //(+)gustian 08/03/2022
                }
                else if (ddlJenisItem.SelectedValue == "IT")
                {
                    txtAssetAmountThreshold.Visible = false;
                    Amount.Visible = false;
                    TaxType.Visible = false;
                    ddlTaxType.Visible = false;
                    rfvTaxType.Visible = false;
                    divMassaAsset.Visible = false; //(+)gustian 08/03/2022
                }
                else if (ddlJenisItem.SelectedValue == "IC")
                {
                    txtAssetAmountThreshold.Visible = false;
                    Amount.Visible = false;
                }
                else if (ddlJenisItem.SelectedValue == "ET")
                {
                    txtAssetAmountThreshold.Visible = false;
                    Amount.Visible = false;
                    TaxType.Visible = false;
                    ddlTaxType.Visible = false;
                    rfvTaxType.Visible = false;
                    divMassaAsset.Visible = false; //(+)gustian 08/03/2022
                }

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

            //_ht["p_id"] = Request.Params["id"];
            _ht["p_category_code"] = Request.Params["categorycode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void SaveData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    int inextid = 0;
        
    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //        Shared.ApplyDefaultProp(_ht);

    //        if (Request.Params["action"].Equals("add"))
    //        {
    //            _dal.Insert(TABLE_NAME, _ht, ref inextid);
    //            lblId.Text = inextid.ToString();
    //        }
    //        else

    //            _dal.Update(TABLE_NAME, _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("masteritemgroup.aspx?action=edit&id={0}", lblId.Text));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

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

            if (Request.Params["action"].Equals("add") || Request.Params["action"].Equals("copy"))
                _dal.Insert(TABLE_NAME, _ht);
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("masteritemgroup.aspx?action=edit&type=" + Request.Params["type"] + "&categorycode={0}", txtGroup.Text));
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
        Response.Redirect("masteritemgrouplist.aspx");
    }

    protected void ddlJenisItem_OnSelectedIndex(object sender, EventArgs e)
    {
        //Shared.BindItemGroupByCategory(ddlParentCode, ddlJenisItem.SelectedValue);
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
            _ht["p_category_code"] = txtGroup.Text;

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
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (ddlJenisItem.SelectedValue == "FA")
            {                
                e.Row.Cells[4].Visible = false;
                e.Row.Cells[5].Visible = false;
                e.Row.Cells[6].Visible = false;
                e.Row.Cells[7].Visible = false;
                
            }
            else if (ddlJenisItem.SelectedValue == "IT")
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[4].Visible = false;
                e.Row.Cells[5].Visible = false;
            }
            else if (ddlJenisItem.SelectedValue == "IC")
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[6].Visible = false;
                e.Row.Cells[7].Visible = false;
            }
            else if (ddlJenisItem.SelectedValue == "ET")
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[6].Visible = false;
                e.Row.Cells[7].Visible = false;
            }
        }
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (ddlJenisItem.SelectedValue == "FA")
            {
                e.Row.Cells[4].Visible = false;
                e.Row.Cells[5].Visible = false;
                e.Row.Cells[6].Visible = false;
                e.Row.Cells[7].Visible = false;
            }
            else if (ddlJenisItem.SelectedValue == "IT")
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[4].Visible = false;
                e.Row.Cells[5].Visible = false;
            }
            else if (ddlJenisItem.SelectedValue == "IC")
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[6].Visible = false;
                e.Row.Cells[7].Visible = false;
            }
            else if (ddlJenisItem.SelectedValue == "ET")
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[6].Visible = false;
                e.Row.Cells[7].Visible = false;
            }
        }
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindItemGroupDetail();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("masteritemgroupdetail.aspx?action=add&&categorycode=" + txtGroup.Text + "&type=" + Request.Params["type"] + "&groupcategorytype=" + lblCategory.Text);
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
        if (txtGroup.Text != string.Empty)
            BindItemGroupDetail();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Response.Redirect(string.Format("masteritemgroupdetail.aspx.aspx?action=edit&id={0}", gvwList.SelectedDataKey[0].ToString() + "&categorycode=" + txtGroup.Text));
        //Response.Redirect("masteritemgroupdetail.aspx?action=edit&idheader=" + lblId.Text + "&categorycode=" + txtGroup.Text + "&accexpensepo=" + lblNoExpensePO.Text + "&accexpenseponame=" + lblNameExpensePO.Text + "&accnoinv=" + lblNoINV.Text + "&accnoinvname=" + lblNameNoINV.Text + "&accassetpo=" + lblNoAssetPO.Text + "&accassetponame=" + lblNameAssetPO.Text + "&id=" + gvwList.SelectedDataKey[0].ToString());
        Response.Redirect("masteritemgroupdetail.aspx?action=edit&id=" + gvwList.SelectedDataKey[0].ToString() + "&categorycode=" + txtGroup.Text + "&type=" + Request.Params["type"]);
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