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


public partial class module_purchaseorder_verifikasirequestdetail : BasePage
{
    private static string TABLE_NAME = "PURCHASE_REQUEST_DETAIL";

    public string type;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {

            lblBarcode.Text = Request.Params["codebarcode"];

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                if (!lblPRStatus.Text.Equals("PROCESSED"))
                    btnSave.Visible = false;
            }
            else
                GetCode();
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
            DataRow _dr = _dal.GetRow("", "xsp_purchase_request_detail_getrow_verifikasi", _ht);

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
            DataRow _dr = _dal.GetRow("", "xsp_purchase_request_detail_getrow_verifikasi", _ht);

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
                _dal.Update("", "xsp_purchase_request_detail_update_verifikasi", _ht);

            Shared.ShowSuccessGritter(this, string.Format("verifikasirequestdetail.aspx?action=edit&id={0}&codebarcode={1}", lblId.Text, lblBarcode.Text));
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
        Response.Redirect("verifikasirequestheader.aspx?action=edit&codebarcode=" + lblBarcode.Text);
    }
}
