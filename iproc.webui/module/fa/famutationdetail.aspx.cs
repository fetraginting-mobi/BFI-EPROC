using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
 
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_fa_famutationdetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "FA_MUTATION_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        txtLocation.Text = Request.Params["location"];
        btnLookUpFaAsset.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FASST&acol_0={0}&bcol_2={1}&ccol_2={2}&dcol_3={3}&ecol_3={4}&fcol_1={5}&gcol_1={6}&hcol_4={7}&icol_7={8}&parc_location={9}');", txtFaID.ClientID, txtAssetCode.ClientID, lblAssetCode.ClientID, lblAssetName.ClientID, txtNameAsset.ClientID, lblBarcode.ClientID, txtBarcode.ClientID,txtFromLocation,txtFromcc, txtLocation.ClientID);
        LoadInit();
        if (!Page.IsPostBack)
        {

            //Shared.BindFaLocation(ddlFromLocationCode);
            Shared.BindBranchAll(ddlTocc);
            Shared.BindFaLocationAll(ddlToLocationCode, ddlTocc.SelectedValue);
           
            //Shared.BindBranchAll(ddlFromcc);
           
            lblCodeBarcode.Text = Request.Params["codebarcode"];
        

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                btnLookUpFaAsset.Enabled = false;
                Shared.BindFaLocationAll(ddlToLocationCode, ddlTocc.SelectedValue);
          
             
                if (!lblFMStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    btnLookUpFaAsset.Enabled = false;
                    txtDescription.Enabled = false;
                   // ddlFromLocationCode.Enabled = false;
                    ddlToLocationCode.Enabled = false;
                    //ddlFromcc.Enabled = false;
                    ddlTocc.Enabled = false;
                }
            }
            else
            {
                GetCode();
            }
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
            DataRow _dr = _dal.GetRow("FA_MUTATION_HEADER", _ht);

            lblFaMutationCode.Text = _dr["code"].ToString();
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
            DataRow _dr = _dal.GetRow(TABLE_NAME_DETAIL, _ht);

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
                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME_DETAIL, _ht);

            Shared.ShowSuccessGritter(this, string.Format("famutationheader.aspx?action=edit&codebarcode={0}", lblCodeBarcode.Text));
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
        Response.Redirect("famutationheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text + "&idartarget=" + Request.Params["idtarget"]);
    }

    protected void ddlTocc_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        Shared.BindFaLocationAll(ddlToLocationCode, ddlTocc.SelectedValue);
        
    }
}
