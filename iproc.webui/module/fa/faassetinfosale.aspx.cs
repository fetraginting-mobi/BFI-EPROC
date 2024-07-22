using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_faassetinfosale : BasePage
{
    private static string TABLE_NAME = "FA_ASSET";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            btnLookUpLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=FALOC&acol_0={0}&bcol_1={1}');", txtLocation.ClientID, lblLocation.ClientID);
            btnLookUpFAParent.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=FAITM&acol_0={0}&bcol_1={1}');", txtFAParent.ClientID, lblFAParent.ClientID);
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=STAFF&acol_0={0}&bcol_1={1}');", txtSupplierID.ClientID, lblSupplierName.ClientID);
            //  btnDeleteInsurance.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                imgBarcode.ImageUrl = @"~\temp\qrcodes\" + lbNobarcode.Text + ".png";
                imgBarcode.AlternateText = "image for barcode:" + lbNobarcode.Text + " not found. Please hit save button to update data.";


                //LoadAssetSpecificInfo();
                lblID.Enabled = false;
               // btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                txtResidualValue.Enabled = false;
                btnLookUpFAParent.Enabled = false;
                btnLookUpLocation.Enabled = false;
                btnLookUpUserRequest.Enabled = false;




            }

            else
            {
                LoadData();
                btnbtnclose.Visible = false;
                txtResidualValue.Enabled = false;
                btnLookUpFAParent.Enabled = false;
                btnLookUpLocation.Enabled = false;
                btnLookUpUserRequest.Enabled = false;




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

            _ht["p_id"] = Request.Params["id"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(UpdatePanel1.Controls, _dr);
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
        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("edit"))
            {
                _dal.Update(TABLE_NAME, _ht);
            }
            else
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }

            Shared.ShowSuccessGritter(this, string.Format("faasset.aspx?action=edit&id={0}&assettype={1}&assetno={2}",
                                                                                    lblID.Text, Request.Params["assettype"].ToString(),
                                                                                    Request.Params["assetno"].ToString()));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void GenerateData()
    {
        try
        {
            new qr_gen().QRGen(lblBarcode.Text);
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
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GenerateData();
    }
    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    //Response.Redirect("faassetlist.aspx?catcode="   + Request.Params["catcode"].ToString()
    //    //                                                + "&loccode=" + Request.Params["loccode"].ToString()
    //    //                                                + "&branchcode=" + Request.Params["branchcode"].ToString()
    //    //                                                + "&astcode=" + Request.Params["astcode"].ToString());
    //    Response.Redirect("fainsurancelist.aspx");
    //}

}