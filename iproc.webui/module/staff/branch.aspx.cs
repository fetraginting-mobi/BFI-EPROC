using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_staff_branch : BasePage
{
    private static string TABLE_NAME = "EMPLOYEE_BRANCH";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranch(ddlBranchCode);
            Shared.BindGroupCode(ddlGroupCode);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                btnCancel.Text = "Back";
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


            //_ht["p_emp_code"] = Request.Params["empcode"];
            _ht["p_id"] = Request.Params["id"];

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
        int iNextId = 0;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
            _ht["p_emp_code"] = Request.Params["empcode"];

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextId);
                lblId.Text = iNextId.ToString();
                Shared.ShowSuccessGritter(this, string.Format("branch.aspx?action=edit&empcode={0}&id={1}", Request.Params["empcode"], lblId.Text));
            }
            else
            {
                _dal.Update(TABLE_NAME, _ht);

                Shared.ShowSuccessGritter(this, string.Format("branch.aspx?action=edit&empcode={0}&id={1}", Request.Params["empcode"], lblId.Text));
            }
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
        Response.Redirect(string.Format("employeemain.aspx?action=edit&empcode={0}", Request.Params["empcode"]));
    }

}

