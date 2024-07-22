using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_receiptvouchertaxi : BasePage
{
   
    

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();


        if (!Page.IsPostBack)
        {

            
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
            Shared.ApplyDefaultProp(_ht);

            _ht["p_prefix_code"] = txtVoucherCode.Text;

            _dal.ExecRawSP("xsp_receipt_voucher_taxi_insert_multiple", _ht);


            Shared.ShowSuccessGritter(this, string.Format("receiptvouchertaxilist.aspx"));
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
        Response.Redirect("receiptvouchertaxilist.aspx");
    }
  
}
