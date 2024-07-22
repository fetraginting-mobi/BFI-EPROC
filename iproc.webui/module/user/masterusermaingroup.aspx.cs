using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

//using AjaxControlToolkit;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_user_masterusermaingroup : BasePage
{
    private static string TABLE_NAME = "MASTER_USER_MAIN_GROUP_SEC";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        btnLookUpGroup.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=UGRUP&acol_0={0}&bcol_1={1}');", txtGroupCode.ClientID, lblGroupName.ClientID);

        if (!Page.IsPostBack)
        {
            lblUID.Text = Request.Params["uid"];

            GetEmpData(lblUID.Text);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                btnCancel.Text = "Back";

            }

        }
    }

    private void GetEmpData(string EmpCode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_emp_code"] = EmpCode;
            DataRow _dr = _dal.GetRow("EMPLOYEE_MAIN", _ht);

            lblName.Text = _dr["EMP_NAME"].ToString();
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

            _ht["p_uid"] = Request.Params["uid"];
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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht);
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("masterusermaingroup.aspx?action=edit&uid={0}", lblUID.Text)); 
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
        Response.Redirect("../staff/employeemain.aspx?action=edit&empcode=" + lblUID.Text);
    }
}
