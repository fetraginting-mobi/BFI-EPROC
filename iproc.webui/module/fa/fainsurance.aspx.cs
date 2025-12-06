using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_fainsurance : BasePage
{
    private static string TABLE_NAME_DETAIL = "FA_ASSET_INSURANCE";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                txtAstCode.Enabled = false;
                lblfaid.Text = Request.Params["faid"];
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
            }
            else
            {
                lblBarcode.Text = Request.Params["codebarcode"];
                lblAstCode.Text = Request.Params["astcode"];
                lblfaid.Text = Request.Params["id"];
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

            _ht["p_barcode"] = Request.Params["codebarcode"];
            DataRow _dr = _dal.GetRow("","xsp_fa_insurance_getrow", _ht);

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


            _ht["p_id"] = Request.Params["id"];
            _ht["p_fa_a_id"] = lblfaid.Text;
            _ht["p_ast_code"] = lblAstCode.Text;

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME_DETAIL, _ht);

            //    Shared.ShowSuccessGritter(this, string.Format("faassetdetail.aspx?action=edit&id={0}&codebarcode={1}&faid={2}&assettype={3}&catcode={4}&loccode={5}&branchcode={6}&astcode={7}", 
            //                                                                                lblID.Text, Request.Params["codebarcode"],
            //                                                                                lblfaid.Text, Request.Params["assettype"],
            //                                                                                Request.Params["catcode"].ToString(), Request.Params["loccode"].ToString(),
            //                                                                                Request.Params["branchcode"].ToString(), Request.Params["astcode"].ToString()));
            //}
            Shared.ShowSuccessGritter(this, string.Format("fainsurance.aspx?action=edit&id={0}&codebarcode={1}&faid={2}&assettype={3}", lblID.Text, Request.Params["codebarcode"]));
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
        //Response.Redirect("faasset.aspx?action=edit&id=" + lblfaid.Text 
        //                                            + "&assettype=" + Request.Params["assettype"]
        //                                            + "&catcode="   + Request.Params["catcode"].ToString()
        //                                            + "&loccode=" + Request.Params["loccode"].ToString()
        //                                            + "&branchcode=" + Request.Params["branchcode"].ToString()
        //                                            + "&astcode=" + Request.Params["astcode"].ToString());
        Response.Redirect("fainsurancelist.aspx");
    }  
}