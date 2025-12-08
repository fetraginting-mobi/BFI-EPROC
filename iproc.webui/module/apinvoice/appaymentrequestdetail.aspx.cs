using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_apinvoice_appaymentrequestdetail : BasePage
{
    private static string TABLE_NAME_DETAIL = "AP_PAYMENT_REQUEST_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        
        LoadInit();
        if (!Page.IsPostBack)
        {
            lblCodeBarcode.Text = Request.Params["codebarcode"];
            lblDepartement.Text = Request.Params["departmentcode"];
            lblDivision.Text = Request.Params["divisioncode"];

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                //btnCancel.Text = "Back";
                if (!lblPRStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    cbkPaid.Enabled = false;
                }
            }
            else
            {
                txtType.Text = Request.Params["flag"];
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
            DataRow _dr = _dal.GetRow("AP_PAYMENT_REQUEST_HEADER", _ht);

            lblPaymentInvoice.Text = _dr["code"].ToString();
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

            txtType.Text = Request.Params["flag"];

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveData()
    {
        //
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

            Shared.ShowSuccessGritter(this, string.Format("appaymentrequestdetail.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, lblCodeBarcode.Text));
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
        Response.Redirect("appaymentrequestheader.aspx?action=edit&codebarcode=" + lblCodeBarcode.Text);
    }  
}
