using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_fa_peralatankerja : BasePage
{
    private static string TABLE_NAME_HEADER = "REQUEST_PERALATAN_KERJA_DETAIL";
    private static string TABLE_NAME_HEADERS = "RETURN_PERALATAN_KERJA_DETAIL";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            //(+) Ari 22-08-2022 ket : enhancement 2022
            //txtBranchCode.Text = Shared.CurrentEmployeeBranchCode;
            string status;

            txtStaffCode.Text = Request.Params["staff_code"]; // get staff code
            txtBranchCode.Text = Request.Params["branch_code"]; // get branch code

            btnLookUpItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FASTE&acol_1={0}&bcol_3={1}&ccol_1={2}&dcol_3={3}&parc_emp_code={4}&parc_branch_code={5}');", txtItemCode.ClientID, txtItemName.ClientID, lblItemCode.ClientID, lblItemName.ClientID, txtStaffCode.ClientID, txtBranchCode.ClientID);

            //txtRequestno.Text = Request.Params["request_no"];
            //btnLookUpItem.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=FASTE&acol_1={0}&bcol_3={1}&ccol_1={2}&dcol_3={3}&parc_emp_code={4}&parc_request_no={5}');", txtItemCode.ClientID, txtItemName.ClientID, lblItemCode.ClientID, lblItemName.ClientID, txtBranchCode.ClientID, txtRequestno.ClientID);
            
            if (Request.Params["action"].Equals("edit"))
            {

                LoadData();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";

                status = Request.Params["status"].ToString();
                if (status == "POST")
                {
                    btnSave.Visible = false;
                    btnLookUpItem.Enabled = false;
                }

            }
            else
            {
                
            }
        }
        LoadAfterInit();
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        string typeReq = "request";

        if (typeReq == Request.Params["ket"].ToString())
        {
            try
            {

                _dal = new GeneralDAL();
                _ht = new Hashtable();

                _ht["p_request_no"] = Request.Params["request_no"];
                _ht["p_id"] = Request.Params["id"];
                DataRow _dr = _dal.GetRow("", "xsp_request_peralatan_kerja_detail_getrow", _ht);

                DBToUI.Map(this.Controls, _dr);
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
        }
        else
        {
            try
            {

                _dal = new GeneralDAL();
                _ht = new Hashtable();

                _ht["p_return_no"] = Request.Params["return_no"];
                _ht["p_id"] = Request.Params["id"];
                DataRow _dr = _dal.GetRow("", "xsp_return_peralatan_kerja_detail_getrow", _ht);

                DBToUI.Map(this.Controls, _dr);
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
        }
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        string typeReq = "request";

        if (typeReq == Request.Params["ket"].ToString())
        {
            Response.Redirect("requestperalatankerja.aspx?action=edit&request_no=" + Request.Params["request_no"]);
        }
        else
        {
            Response.Redirect("returnperalatankerja.aspx?action=edit&return_no=" + Request.Params["return_no"]);
        }
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }
    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string sNextBarcode = "";

        string typeReq = "request";
        string typeRet = "return";

        if (typeReq == Request.Params["ket"].ToString())
        {
            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();

                MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
                Shared.ApplyDefaultProp(_ht);
                _ht["p_request_no"] = Request.Params["request_no"];
                _ht["p_id"] = Request.Params["id"];
                _ht["p_item_code"] = txtItemCode.Text;
                _ht["p_item_name"] = lblItemName.Text;

                if (Request.Params["action"].Equals("add"))
                {
                    _dal.Insert(TABLE_NAME_HEADER, _ht);
                }
                else
                    _dal.Update(TABLE_NAME_HEADER, _ht);

                Shared.ShowSuccessGritter(this, string.Format("requestperalatankerja.aspx?action=edit&request_no={0}", Request.Params["request_no"]));
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
        }
        else
        {
            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();

                MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
                Shared.ApplyDefaultProp(_ht);
                _ht["p_return_no"] = Request.Params["return_no"];
                _ht["p_id"] = Request.Params["id"];
                _ht["p_item_code"] = txtItemCode.Text;
                _ht["p_item_name"] = lblItemName.Text;

                if (Request.Params["action"].Equals("add"))
                {
                    _dal.Insert(TABLE_NAME_HEADERS, _ht);
                }
                else
                    _dal.Update(TABLE_NAME_HEADERS, _ht);

                Shared.ShowSuccessGritter(this, string.Format("returnperalatankerja.aspx?action=edit&return_no={0}", Request.Params["return_no"]));
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
        }
    }
   
}
