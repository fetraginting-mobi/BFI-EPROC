using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_purchaseorder_supplierselection : BasePage
{

    //private static string TABLE_NAME = "PURCHASE_QUOTATION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        btnLookUpPQCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LUPQC&acol_0={0}&bcol_1={1}');", txtPQCode.ClientID, lblPQCode.ClientID);
        btnLookUpItemCode.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PQITM&acol_0={0}&bcol_1={1}&parc_code={2}');", txtItemCode.ClientID, lblItemName.ClientID, txtPQCode.ClientID);
        btnLookUpSupplierID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=PQSUP&acol_0={0}&bcol_1={1}&parc_code={2}&parc_item_code={3}&ccol_3={4}&dcol_4={5}&ecol_5={6}');", txtSupplierID.ClientID, lblSupplierName.ClientID, txtPQCode.ClientID, txtItemCode.ClientID, txtQuantity.ClientID, txtAmount.ClientID,txtID.ClientID);
       
        LoadInit();
        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                btnCancel.Text = "Back";

                LoadData();
                //btnPost.OnClientClick = "return confirm('Post selected data?');";
            }
            else
            {
                btnPost.Visible = false;
            }
            
            if (lblStatus.Text == "POST" )
            {
                btnSave.Visible =  btnPost.Visible = false;
            }

            else
            {
                
            }
        }
        btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=AP000035&parc_object_id={0}');", txtID.ClientID);
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

            _ht["p_id"] = Request.Params["id"];

            DataRow _dr = _dal.GetRow("", "xsp_purchase_quotation_detail_getrow_winner", _ht);

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

        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            if (Request.Params["id"] != null)
                _ht["p_old_id"] = Request.Params["id"];
            else
                _ht["p_old_id"] = 0;
            _dal.ExecRawSP("xsp_purchase_quotation_detail_update_winner", _ht);

            Shared.ShowSuccessGritter(this, string.Format("supplierselection.aspx?action=edit&id={0}",txtID.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void PostData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
    //        Shared.ApplyDefaultProp(_ht);

    //        _dal.ExecRawSP("xsp_purchase_quotation_detail_update_winner_post", _ht);

    //        Shared.ShowSuccessGritter(this, string.Format("supplierselectionlist.aspx"));
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("supplierselectionlist.aspx?action=edit");
    }
    //protected void btnPost_Click(object sender, EventArgs e)
    //{
    //    PostData();
    //}
}
