using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masteritem : BasePage
{
    private static string TABLE_NAME = "MASTER_ITEM";
    private static string TABLE_NAME_DOC_DETAIL = "MASTER_ITEM_DOCUMENT";
    private static string TABLE_NAME_DOC_DETAIL_HISTORY = "MASTER_ITEM_DOCUMENT_HISTORY";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            //btnLookUpType.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ITMTP&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtType.ClientID, lblType.ClientID, lblTypeName.ClientID);
            btnLookUpMerk.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ITMMK&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_2={3}&fcol_3={4}&gcol_4={5}&hcol_5={6}');", txtMerk.ClientID, lblMerk.ClientID, lblMerkName.ClientID, txtType.ClientID, lblTypeName.ClientID, txtModel.ClientID, lblModelName.ClientID);

            btnLookUpType.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LUFTM&acol_0={0}&bcol_1={1}&parc_code={2}');", txtType.ClientID, lblTypeName.ClientID, txtMerk.ClientID);

            btnLookUpModel.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MMDL&acol_0={0}&bcol_1={1}&parc_code={2}');", txtModel.ClientID, lblModelName.ClientID, txtType.ClientID);

            btnLookUpParentGroup.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=LFIT&acol_0={0}&bcol_1={1}&parc_jenis_item={2}');", txtParentGroup.ClientID, lblParentGroup.ClientID, ddlJenisItem.ClientID);

            Shared.BindGeneralSubCode(ddlJenisItem, "ITMCAT");
            Shared.BindUnitsItemOwn(ddlOwner);
            Shared.BindUnitsItem(ddlProcessBy);
            ddlJenisItem.SelectedValue = Request.Params["jenis"];

            Shared.BindMasterUnit(ddlPOUnitCode);
            Shared.BindMasterUnit(ddlUOM2);
            Shared.BindMasterUnit(ddlUOM3);
            Shared.BindFAGroup(ddlFACategoryBookCode);
            Shared.BindFACategoryFiscal(ddlFACategoryFiscalCode);
            Shared.BindFACategory(ddlFaCategory);
            // Shared.BindUnitsItemOwn(ddlOwner);
            Shared.BindUnitsItem(ddlProcessBy);
            btnDeleteDocument.OnClientClick = "return confirm('Delete selected data?');";



            ddlJenisItem.Enabled = false;
            txtPOLatestCost.Enabled = false;
            txtPOAverageCost.Enabled = false;

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataDocRequest();
                BindDataHistoryDoc();

                lblItemCode.Enabled = false;
                ddlJenisItem.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";


            }
            else if (Request.Params["action"].Equals("copy"))
            {
                LoadData();
                BindDataDocRequest();
                BindDataHistoryDoc();
                lblItemCode.Text = "";
                ddlJenisItem.Enabled = true;
                txtPOAverageCost.Text = "0";
                txtPOLatestCost.Text = "0";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }

            if (ddlJenisItem.SelectedValue.Equals("IT") || ddlJenisItem.SelectedValue.Equals("ET"))
            {
                ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = false;
                ddlFaCategory.Items.Clear();
                ddlFACategoryBookCode.Items.Clear();
                ddlFACategoryFiscalCode.Items.Clear();
                FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = false;
                ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = false;
                rfvFACategoryBookCode.Enabled = false;
                rfvFACategoryFiscalCode.Enabled = false;
                rfvFaCategory.Enabled = false;
                Maintc.Visible = false;
                ddlMaintenance.Visible = false;
                DatePromotion.Visible = false;
                cbxDatePromotion.Visible = false;
                Rounding.Visible = false;
                txtRounding.Visible = false;


            }
            else if (ddlJenisItem.SelectedValue.Equals("IC"))
            {
                ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = false;
                ddlFaCategory.Items.Clear();
                ddlFACategoryBookCode.Items.Clear();
                ddlFACategoryFiscalCode.Items.Clear();
                FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = false;
                ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = false;
                rfvFACategoryBookCode.Enabled = false;
                rfvFACategoryFiscalCode.Enabled = false;
                rfvFaCategory.Enabled = false;

            }
            else
            {
                Shared.BindFAGroup(ddlFACategoryBookCode);
                Shared.BindFACategoryFiscal(ddlFACategoryFiscalCode);
                Shared.BindFACategory(ddlFaCategory);
                //Shared.BindUnitsItemOwn(ddlOwner);
                //Shared.BindUnitsItem(ddlProcessBy);
                ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = true;
                FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = true;
                ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = true;
                rfvFACategoryBookCode.Enabled = true;
                rfvFACategoryFiscalCode.Enabled = true;
                rfvFaCategory.Enabled = true;
                rfvMaintenance.Enabled = false;
                Maintc.Visible = false;

                ddlMaintenance.Visible = false;
                chbGenerateBarcode.Visible = false;
                lblGenerateBarcode.Visible = false;
                DatePromotion.Visible = false;
                cbxDatePromotion.Visible = false;
                Rounding.Visible = false;
                txtRounding.Visible = false;

            }
        }
        LoadAfterInit();

    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();


            _ht["p_item_code"] = Request.Params["itemcode"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);

            //Shared.BindItemGroupItemDDL(ddlItemGroup, ddlJenisItem.SelectedValue);

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
        string sNextItemcode = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add") || Request.Params["action"].Equals("copy"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref sNextItemcode);
                lblItemCode.Text = sNextItemcode.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            // Shared.ShowSuccessGritter(this, string.Format("masteritem.aspx?action=edit&itemcode={0}", lblItemCode.Text));
            Shared.ShowSuccessGritter(this, string.Format("masteritemlist.aspx"));
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
        Response.Redirect("masteritemlist.aspx");
    }

    protected void ddlJenisItem_OnSelectedIndex(object sender, EventArgs e)
    {

        // Shared.BindItemGroupItem(ddlItemGroup, ddlJenisItem.SelectedValue);
        if (ddlJenisItem.SelectedValue.Equals("IT") || ddlJenisItem.SelectedValue.Equals("ET"))
        {
            ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = false;
            ddlFaCategory.Items.Clear();
            ddlFACategoryBookCode.Items.Clear();
            ddlFACategoryFiscalCode.Items.Clear();
            FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = false;
            ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = false;
            rfvFACategoryBookCode.Enabled = false;
            rfvFACategoryFiscalCode.Enabled = false;
            rfvFaCategory.Enabled = false;
            Rounding.Visible = false;
            txtRounding.Visible = false;

        }
        else if (ddlJenisItem.SelectedValue.Equals("IC"))
        {
            ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = false;
            ddlFaCategory.Items.Clear();
            ddlFACategoryBookCode.Items.Clear();
            ddlFACategoryFiscalCode.Items.Clear();
            FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = false;
            ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = false;
            rfvFACategoryBookCode.Enabled = false;
            rfvFACategoryFiscalCode.Enabled = false;
            rfvFaCategory.Enabled = false;
        }
        else
        {
            Shared.BindFAGroup(ddlFACategoryBookCode);
            Shared.BindFACategoryFiscal(ddlFACategoryFiscalCode);
            Shared.BindFACategory(ddlFaCategory);
            ddlFaCategory.Enabled = ddlFACategoryBookCode.Enabled = ddlFACategoryFiscalCode.Enabled = true;
            FaDeprFis.Visible = FaDepCat.Visible = FaCategory.Visible = true;
            ddlFaCategory.Visible = ddlFACategoryBookCode.Visible = ddlFACategoryFiscalCode.Visible = true;
            rfvFACategoryBookCode.Enabled = true;
            rfvFACategoryFiscalCode.Enabled = true;
            rfvFaCategory.Enabled = true;
            Rounding.Visible = false;
            txtRounding.Visible = false;

        }

    }
    protected void btnAddUploadDoc_Click(object sender, EventArgs e)
    {
        Response.Redirect("masteritemdocument.aspx?action=add&code=" + HttpUtility.UrlEncode(lblItemCode.Text) + "&name=" + HttpUtility.UrlEncode(txtItemName.Text) + "&jenis=" + HttpUtility.UrlEncode(Request.Params["jenis"]));
    }
    protected void gvwListDocReq_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("auditdetail.aspx?action=edit&auditno={0}&id={1}&idartarget={2}", gvwListDocReq.SelectedDataKey["BATCH_NO"].ToString(), gvwListDocReq.SelectedDataKey["REMARKS"].ToString(), Request.Params["idartarget"]));
    }
    protected void gvwListDocReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDocReq.PageIndex = e.NewPageIndex;
        BindDataDocRequest();
    }
    protected void gvwListHist_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListHist.PageIndex = e.NewPageIndex;
        BindDataHistoryDoc();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvwListHist.PageIndex = 0;
        BindDataHistoryDoc();
    }
    protected void gvwListDocReq_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFileName = (Label)e.Row.FindControl("lblFileName");
            LinkButton btnPreview = (LinkButton)e.Row.FindControl("btnPreviewDoc");

            if (lblFileName == null || string.IsNullOrEmpty(lblFileName.Text))
            {
                btnPreview.Visible = false;
                return;
            }
            string paths = gvwListDocReq.DataKeys[e.Row.RowIndex]["PATHS"].ToString();
            string file = gvwListDocReq.DataKeys[e.Row.RowIndex]["FILE"].ToString();

            string filePath = gvwListDocReq.DataKeys[e.Row.RowIndex]["PATHS"].ToString();

            btnPreview.Attributes["onclick"] =
                "window.open('../../" + filePath +
                "', 'viewer', 'width=600,height=400,scrollbars=1'); return false;";
        }
    }
    protected void gvwListDocHist_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFileName = (Label)e.Row.FindControl("lblFileNameHist");
            LinkButton btnPreview = (LinkButton)e.Row.FindControl("btnPreviewDocHist");

            if (lblFileName == null || string.IsNullOrEmpty(lblFileName.Text))
            {
                btnPreview.Visible = false;
                return;
            }

            string filePath = gvwListHist.DataKeys[e.Row.RowIndex]["PATHS"].ToString();

            btnPreview.Attributes["onclick"] =
                "window.open('../../" + filePath +
                "', 'viewer', 'width=600,height=400,scrollbars=1'); return false;";
        }
    }
    protected void gvwListDocReq_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        LinkButton btn = null;
        GridViewRow row = null;
        int rowIndex = 0;

        try
        {
            btn = ((LinkButton)e.CommandSource);
            row = (GridViewRow)(btn.NamingContainer);

            if (row.RowType == DataControlRowType.DataRow)
            {
                rowIndex = row.RowIndex;

                if (e.CommandName == "del")
                {
                    try
                    {
                        string ITEM_CODE = (string)gvwListDocReq.DataKeys[rowIndex][1];
                        string FileName = ((Label)row.Cells[2].Controls[1]).Text;
                        int ID = (int)gvwListDocReq.DataKeys[rowIndex][4];


                        //delete data di database server
                        //DeleteDoc(ID);

                        //delete file di app server 
                        //DeleteDocFile(ApplicationNo, FileName);
                    }
                    catch (Exception ex)
                    {
                        Shared.ShowErrorDialog(this, ex);
                    }

                    BindDataDocRequest();
                }
            }
        }
        catch (Exception)
        {
        }
    }
    private void BindDataDocRequest()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataView dvItemDoc = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";
            _ht["p_item_code"] = lblItemCode.Text;
            _ht["p_id"] = Request.Params["id"];

            dvItemDoc = _dal.GetRows(TABLE_NAME_DOC_DETAIL, _ht).DefaultView;

            if (dirItemDoc == SortDirection.Ascending)
                dvItemDoc.Sort = ExpressionItemDoc + " ASC";
            else
                dvItemDoc.Sort = ExpressionItemDoc + " DESC";

            gvwListDocReq.DataSource = dvItemDoc;
            gvwListDocReq.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    public SortDirection dirItemDoc
    {

        get
        {
            if (ViewState["dirStateQUOTATIONDOC"] == null)
            {
                ViewState["dirStateQUOTATIONDOC"] = SortDirection.Descending;
            }

            return (SortDirection)ViewState["dirStateQUOTATIONDOC"];
        }

        set { ViewState["dirStateQUOTATIONDOC"] = value; }
    }
    public string ExpressionItemDoc
    {

        get
        {
            if (ViewState["expressionStateQUOTATIONDOC"] == null)
            {
                ViewState["expressionStateQUOTATIONDOC"] = "MOD_DATE";
            }

            return (string)ViewState["expressionStateQUOTATIONDOC"];
        }

        set { ViewState["expressionStateQUOTATIONDOC"] = value; }
    }
    private string CombinePath(object paths, object file)
    {
        string p = paths == null ? "" : paths.ToString();
        string f = file == null ? "" : file.ToString();

        if (p.Length == 0) return f;
        if (f.Length == 0) return p;

        if (!p.EndsWith("\\"))
            p += "\\";

        return p + f;
    }

    protected void btnDeleteDocument_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListDocReq.Rows)
        {
            CheckBox chbDoc = (CheckBox)row.Cells[1].Controls[1];
            if (chbDoc.Checked)
            {
                DeleteItemDocument(gvwListDocReq.DataKeys[row.RowIndex]["ID"].ToString());
            }
        }

        BindDataDocRequest();
        BindDataHistoryDoc();
    }
    private void DeleteItemDocument(string id)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = id;
            _ht["p_item_code"] = Request.Params["itemcode"];
            Shared.ApplyDefaultProp(_ht);

            _dal.Update(TABLE_NAME_DOC_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void BindDataHistoryDoc()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataView dvItemDoc = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //_ht["p_keywords"] = txtSearch.Text;
            _ht["p_item_code"] = lblItemCode.Text;
            _ht["p_id"] = Request.Params["id"];

            dvItemDoc = _dal.GetRows(TABLE_NAME_DOC_DETAIL_HISTORY, _ht).DefaultView;

            if (dirItemDoc == SortDirection.Ascending)
                dvItemDoc.Sort = ExpressionItemDoc + " ASC";
            else
                dvItemDoc.Sort = ExpressionItemDoc + " DESC";

            gvwListHist.DataSource = dvItemDoc;
            gvwListHist.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
}
