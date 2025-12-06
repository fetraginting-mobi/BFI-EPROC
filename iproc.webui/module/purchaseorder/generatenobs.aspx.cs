using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_generatenobs : BasePage
{
    //private static string TABLE_NAME = "RECEIPT_VOUCHER_TAXI";
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
       

        if (!Page.IsPostBack)
        {
            // LoadDataDefault();
            txtFirstDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtFirstDate.Enabled = false;

            if (Request.Params["action"].Equals("edit"))
            {

                LoadData();
              
                if (lblstatus.Text == "POST")
                {
                    btnGenerate.Visible = false;
                    txtBarcode.Enabled = false;
                    txtStart.Enabled = false;
                    txtEnd.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtVoucherCode.Enabled = false;
                }
            }
            else
            {
                LoadDataDefault();
            }

            btnLookUpInventoryRequestItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LUFBG&acol_0={0}&bcol_1={1}');", txtBarcode.ClientID, lblItemName.ClientID);
        }
        LoadAfterInit();
    }

    private void LoadDataDefault()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            // _ht["p_id"] = 0;
            DataRow _dr = _dal.GetRow("", "xsp_generate_no_bs_generate_getrow", _ht);

            txtStart.Text = ((int)_dr["end2"]).ToString();


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

            _ht["p_barcode"] = Request.Params["barcode"];
            DataRow _dr = _dal.GetRow("","xsp_generate_no_bs_getrow", _ht);

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

            _ht["p_id"] = Request.Params["id"];
            _ht["p_barcode"] = txtBarcode.Text;

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {

                _dal.ExecRawSP("xsp_generate_no_bs_insert_generate", _ht);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.ExecRawSP("xsp_generate_no_bs_insert_generate", _ht);

            Shared.ShowSuccessGritter(this, string.Format("generatenobslist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void GenerateData()
    {
        GeneralDAL _dal = null;

        Hashtable _ht = null;
       
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

           
            _ht["p_barcode"] = txtBarcode.Text;

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);


            _dal.ExecRawSP("xsp_generate_no_bs_process", _ht);

            Shared.ShowSuccessGritter(this, string.Format("generatenobslist.aspx"));
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


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("generatenobslist.aspx");
    }

}
