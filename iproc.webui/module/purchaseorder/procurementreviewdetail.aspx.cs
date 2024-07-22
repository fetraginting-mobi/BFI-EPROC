using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
public partial class module_purchaseorder_procurementreviewdetail : BasePage
{
    private static string TABLE_NAME = "PROCUREMENT_REVIEW";
    protected void Page_Load(object sender, EventArgs e)
    {
         LoadInit();
        if (!Page.IsPostBack)
        {
            btnLookUpUnits.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=LFUR&acol_0={0}&bcol_1={1}');", txtTrxCode.ClientID, txtDescription.ClientID); 
              
              lblCode.Text = Request.Params["code"];
              lblBarcode.Text = Request.Params["codebarcode"];
              if (Request.Params["action"].Equals("edit"))
              {
                  btnSave.Visible = false;
                  LoadData();

                  if (lblStatus.Text == "POST")
                  {
                      btnSave.Visible = false;
                      btnLookUpUnits.Enabled = false;
                  }
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
           //_ht["p_id_detail"] = Request.Params["iddetail"];
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);
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
            _ht["p_id"] = lblId.Text;
            _ht["p_id_detail"] = Request.Params["iddetail"];
            _ht["p_pr_code"] = lblCode.Text;
            _ht["p_units_code"] = txtTrxCode.Text;
            _ht["p_remarks_review"] = "";
           

            //_ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
            //_ht["p_department_code"] = Shared.CurrentEmployeeDeptCode;

            if (Request.Params["action"].Equals("add"))
            {
                 _dal.Insert(TABLE_NAME, _ht ,ref iNextID);
                  lblId.Text = iNextID.ToString();
            }


               else
                _dal.Update(TABLE_NAME, _ht);
                btnSave.Visible = false;


                Shared.ShowSuccessGritter(this, string.Format("procurementreview.aspx?action=edit&id={0}&codebarcode={1}",Request.Params["iddetail"],Request.Params["barcode"]));
            
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
        Response.Redirect("procurementreview.aspx?action=edit&id=" + Request.Params["iddetail"] + "&codebarcode=" + Request.Params["barcode"]);
    }
}
