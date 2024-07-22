using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_reviewheader : BasePage
{
    private static string TABLE_NAME = "PROCUREMENT_REVIEW";

   
    protected void Page_Load(object sender, EventArgs e)
    {
         LoadInit();
        if (!Page.IsPostBack)
        {

            lblid.Text = Request.Params["id"];
            btnPost.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";
           
              LoadData();

              if (lblStatus.Text == "POST")
              {
                  txtRemarksReview.Enabled = false;
                  btnPost.Visible = false;
                  btnSave.Visible = false;
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

            DataRow _dr = _dal.GetRow("", "xsp_procurement_review_detail_getrow", _ht);
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
              Shared.ApplyDefaultProp(_ht);

              _ht["p_id"] = Request.Params["id"];
              _ht["p_remarks_review"] = txtRemarksReview.Text;
              _ht["p_item_code"] = txtItemCode.Text;
              _ht["p_ir_code"] = lblIrNo.Text;



              //_ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
              //_ht["p_department_code"] = Shared.CurrentEmployeeDeptCode;



              _dal.ExecRawSP("xsp_procurement_review_detail_update", _ht);


              Shared.ShowSuccessGritter(this, string.Format("reviewlist.aspx"));

          }
          catch (Exception ex)
          {
              Shared.ShowErrorDialog(this, ex);
          }
      }

      private void PostData()
      {
          GeneralDAL _dal = null;
          Hashtable _ht = null;

          try
          {
              _dal = new GeneralDAL();
              _ht = new Hashtable();

              MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
              Shared.ApplyDefaultProp(_ht);

              _ht["p_id"] = Request.Params["id"];
              _ht["p_remarks_review"] = txtRemarksReview.Text;


              //_ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
              //_ht["p_department_code"] = Shared.CurrentEmployeeDeptCode;



              _dal.ExecRawSP("xsp_procurement_review_detail_update_post", _ht);


              Shared.ShowSuccessGritter(this, string.Format("reviewlist.aspx"));

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
    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("reviewlist.aspx");
    }
}

