using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_famutationreceipt : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {

            lblBarcode.Text = Request.Params["codebarcode"];

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                //txtQuantity.Enabled = false;
                txtItemDescription.Enabled = false;
                txtReceiveDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtReceiveDate.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";

            }
            txtReceiveDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtReceiveDate.Enabled = false;
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

            DataRow _dr = _dal.GetRow("", "xsp_fa_mutation_receipt_getrow", _ht);

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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            _ht["p_id"] = lblId.Text;
            _ht["p_receive_date"] = Shared.ToDateTime(txtReceiveDate.Text);

            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("edit"))
                _dal.Update("", "xsp_fa_mutation_receipt_update", _ht);

            Shared.ShowSuccessGritter(this, string.Format("famutationreceipt.aspx?action=edit&id={0}", lblId.Text));
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
        Response.Redirect("famutationreceiptlist.aspx?action=edit&fm_code=" + lblIrBarcode.Text);
    }  
}