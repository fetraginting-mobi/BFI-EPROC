using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonsec_mastergroupsec : BasePage
{
    private static string TABLE_NAME_GROUP_SEC = "MASTER_GROUP_SEC";
    //private static string TABLE_NAME_ROLE_SEC = "MASTER_ROLE_SEC";
    private static string TABLE_NAME_GROUP_ROLE_SEC = "MASTER_GROUP_ROLE_SEC";

    private const int APP_NAME_INDEX = 1;
    private const int MODULE_NAME_INDEX = 2;
    private const int CREATE_INDEX = 3;
    private const int DELETE_INDEX = 4;
    private const int EDIT_INDEX = 5;
    private const int PROCESS_INDEX = 6;
    private const int PRINT_INDEX = 7;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                btnCancel.Text = "Back";
                txtCode.Enabled = false;
            }
            else
            {
                btnSaveGroupRole.Visible = false;
            }

            BindDataRoleSec();
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

            _ht["p_code"] = Request.Params["code"];
            DataRow _dr = _dal.GetRow(TABLE_NAME_GROUP_SEC, _ht);
            DBToUI.Map(this.Controls, _dr);

            //if (txtIsAgas.ToString() == "1")
            //    _ht["p_is_agas"] = chbIsAgas.Checked = true;
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

            if (chbIsAgas.Checked) // (+) Ari 01-07-2022 ket : enhancement 2022
                _ht["p_is_agas"] = "1";
            else
                _ht["p_is_agas"] = "0";

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME_GROUP_SEC, _ht);
            }
            else
                _dal.Update(TABLE_NAME_GROUP_SEC, _ht);

            Shared.ShowSuccessGritter(this, string.Format("mastergroupsec.aspx?action=edit&code={0}", txtCode.Text));
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
        Response.Redirect("mastergroupseclist.aspx");
    }


    #region GroupRoleSec
    private void BindDataRoleSec()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = "";

            gvwListRoleSec.DataSource = _dal.GetRows("", "xsp_master_role_sec_getrows_for_group", _ht);
            gvwListRoleSec.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveDataGroupRole()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            Shared.ApplyDefaultProp(_ht);

            _ht["p_group_code"] = txtCode.Text;
            _dal.ExecRawSP("xsp_master_group_role_sec_delete_all", _ht);

            foreach (GridViewRow row in gvwListRoleSec.Rows)
            {
                string sRoleCode = gvwListRoleSec.DataKeys[row.RowIndex][0].ToString();

                CheckBox chbCreate = (CheckBox)row.Cells[CREATE_INDEX].Controls[1];
                CheckBox chbDelete = (CheckBox)row.Cells[DELETE_INDEX].Controls[1];
                CheckBox chbEdit = (CheckBox)row.Cells[EDIT_INDEX].Controls[1];
                CheckBox chbProcess = (CheckBox)row.Cells[PROCESS_INDEX].Controls[1];
                CheckBox chbPrint = (CheckBox)row.Cells[PRINT_INDEX].Controls[1];
                string sAppCode = row.Cells[APP_NAME_INDEX].Text;


                _ht["p_application_code"] = sAppCode;

                if (chbCreate.Checked)
                {
                    //insert 
                    _ht["p_role_code"] = sRoleCode + "C";
                    _ht["p_application_code"] = gvwListRoleSec.DataKeys[row.RowIndex][1].ToString();
                    _dal.Insert(TABLE_NAME_GROUP_ROLE_SEC, _ht);
                }

                if (chbDelete.Checked)
                {
                    //insert 
                    _ht["p_role_code"] = sRoleCode + "D";
                    _ht["p_application_code"] = gvwListRoleSec.DataKeys[row.RowIndex][1].ToString();
                    _dal.Insert(TABLE_NAME_GROUP_ROLE_SEC, _ht);
                }

                if (chbEdit.Checked)
                {
                    //insert 
                    _ht["p_role_code"] = sRoleCode + "E";
                    _ht["p_application_code"] = gvwListRoleSec.DataKeys[row.RowIndex][1].ToString();
                    _dal.Insert(TABLE_NAME_GROUP_ROLE_SEC, _ht);
                }

                if (chbProcess.Checked)
                {
                    //insert 
                    _ht["p_role_code"] = sRoleCode + "O";
                    _ht["p_application_code"] = gvwListRoleSec.DataKeys[row.RowIndex][1].ToString();
                    _dal.Insert(TABLE_NAME_GROUP_ROLE_SEC, _ht);
                }


                if (chbPrint.Checked)
                {
                    //insert 
                    _ht["p_role_code"] = sRoleCode + "P";
                    _ht["p_application_code"] = gvwListRoleSec.DataKeys[row.RowIndex][1].ToString();
                    _dal.Insert(TABLE_NAME_GROUP_ROLE_SEC, _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("mastergroupsec.aspx?action=edit&code={0}", txtCode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSaveGroupRole_Click(object sender, EventArgs e)
    {
        SaveDataGroupRole();
    }

    protected void gvwListRoleSec_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string sRoleCode = gvwListRoleSec.DataKeys[e.Row.RowIndex][0].ToString();

            CheckBox chbCreate = (CheckBox)e.Row.Cells[CREATE_INDEX].Controls[1];
            chbCreate.InputAttributes["class"] = "gsCreate";

            CheckBox chbDelete = (CheckBox)e.Row.Cells[DELETE_INDEX].Controls[1];
            chbDelete.InputAttributes["class"] = "gsDelete";

            CheckBox chbEdit = (CheckBox)e.Row.Cells[EDIT_INDEX].Controls[1];
            chbEdit.InputAttributes["class"] = "gsEdit";

            CheckBox chbProcess = (CheckBox)e.Row.Cells[PROCESS_INDEX].Controls[1];
            chbProcess.InputAttributes["class"] = "gsProses";

            CheckBox chbPrint = (CheckBox)e.Row.Cells[PRINT_INDEX].Controls[1];
            chbPrint.InputAttributes["class"] = "gsPrint";

            string sAppCode = e.Row.Cells[APP_NAME_INDEX].Text;

            GeneralDAL _dal = null;
            Hashtable _ht = null;

            try
            {
                _dal = new GeneralDAL();
                _ht = new Hashtable();


                //dapatkan data di table master role
                chbCreate.Visible = false;
                chbDelete.Visible = false;
                chbEdit.Visible = false;
                chbProcess.Visible = false;
                chbPrint.Visible = false;

                _ht["p_parent_role_code"] = sRoleCode;
                _ht["p_application_code"] = sAppCode;

                DataTable dt = _dal.GetRows("", "xsp_master_role_sec_getrows_by_parent", _ht);

                if (dt.Rows.Count == 0)
                {
                    e.Row.Cells[MODULE_NAME_INDEX].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[MODULE_NAME_INDEX].Font.Bold = true;
                }

                foreach (DataRow dr in dt.Rows)
                {

                    if (dr["CODE"].ToString().EndsWith("C"))
                    {
                        chbCreate.Visible = true;
                    }

                    if (dr["CODE"].ToString().EndsWith("D"))
                    {
                        chbDelete.Visible = true;
                    }

                    if (dr["CODE"].ToString().EndsWith("E"))
                    {
                        chbEdit.Visible = true;
                    }

                    if (dr["CODE"].ToString().EndsWith("O"))
                    {
                        chbProcess.Visible = true;
                    }

                    if (dr["CODE"].ToString().EndsWith("P"))
                    {
                        chbPrint.Visible = true;
                    }
                }

                //dapatkan data di table master_group_role_sec

                _ht["p_group_code"] = txtCode.Text;
                _ht["p_application_code"] = sAppCode;

                dt = _dal.GetRows("", "xsp_master_group_role_sec_getrows_by_parent_role_code", _ht);

                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["ROLE_CODE"].ToString().EndsWith("C"))
                    {
                        chbCreate.Checked = true;
                    }

                    if (dr["ROLE_CODE"].ToString().EndsWith("D"))
                    {
                        chbDelete.Checked = true;
                    }

                    if (dr["ROLE_CODE"].ToString().EndsWith("E"))
                    {
                        chbEdit.Checked = true;
                    }

                    if (dr["ROLE_CODE"].ToString().EndsWith("O"))
                    {
                        chbProcess.Checked = true;
                    }

                    if (dr["ROLE_CODE"].ToString().EndsWith("P"))
                    {
                        chbPrint.Checked = true;
                    }
                }
            }
            catch (Exception)
            {
            }


        }
    }

    protected void gvwListRoleSec_RowDataCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            CheckBox chbCreateAll = (CheckBox)e.Row.Cells[CREATE_INDEX].Controls[1];
            chbCreateAll.Attributes["onclick"] = String.Format("javascript:fnCheckAll('{0}', 'gsCreate')", chbCreateAll.ClientID);

            CheckBox chbDeleteAll = (CheckBox)e.Row.Cells[DELETE_INDEX].Controls[1];
            chbDeleteAll.Attributes["onclick"] = String.Format("javascript:fnCheckAll('{0}', 'gsDelete')", chbDeleteAll.ClientID);

            CheckBox chbEditAll = (CheckBox)e.Row.Cells[EDIT_INDEX].Controls[1];
            chbEditAll.Attributes["onclick"] = String.Format("javascript:fnCheckAll('{0}', 'gsEdit')", chbEditAll.ClientID);

            CheckBox chbProsesAll = (CheckBox)e.Row.Cells[PROCESS_INDEX].Controls[1];
            chbProsesAll.Attributes["onclick"] = String.Format("javascript:fnCheckAll('{0}', 'gsProses')", chbProsesAll.ClientID);

            CheckBox chbPrintAll = (CheckBox)e.Row.Cells[PRINT_INDEX].Controls[1];
            chbPrintAll.Attributes["onclick"] = String.Format("javascript:fnCheckAll('{0}', 'gsPrint')", chbPrintAll.ClientID);

        }
    }


    #endregion

}
