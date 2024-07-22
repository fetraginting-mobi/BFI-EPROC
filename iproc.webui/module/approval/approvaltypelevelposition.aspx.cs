using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_approval_approvaltypelevelposition : BasePage
{
    private static string TABLE_NAME = "APPROVAL_TYPE_LEVEL_POSITION";
    private static string CODE = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        CODE = Request.Params["code"];

        LoadInit();
        if (!Page.IsPostBack)
        {
            txtLevelID.Text = Request.Params["levelid"];

            btnLookupPosition.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=MP&acol_0={0}&bcol_1={1}&parc_level_id={2}');", txtCode.ClientID, txtDesc.ClientID, txtLevelID.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindApprovalTypeLevelPerson();

                btnCancel.Text = "<i class='icon-arrow-left'></i> Back";

                btnLookupPosition.Enabled = false;
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

            _ht["p_level_id"] = Request.Params["levelid"];
            _ht["p_position_code"] = Request.Params["positioncode"];
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

            Shared.ShowSuccessGritter(this, string.Format("approvaltypelevelposition.aspx?action=edit&levelid={0}&positioncode={1}&code={2}", txtLevelID.Text, txtCode.Text, CODE));
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
        Response.Redirect("approvaltypelevel.aspx?action=edit&id=" + txtLevelID.Text + "&code=" + CODE);
    }

    #region ApprovalTypeLevelPerson
    protected void gvwListApprovalTypeLevelPerson_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListApprovalTypeLevelPerson.PageIndex = e.NewPageIndex;
        BindApprovalTypeLevelPerson();
    }

    protected void gvwListApprovalTypeLevelPerson_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("approvaltypelevelperson.aspx?action=edit&id=" + gvwListApprovalTypeLevelPerson.SelectedDataKey[0].ToString() + "&levelid=" + txtLevelID.Text + "&code=" + CODE + "&positioncode=" + txtCode.Text);
    }

    private void BindApprovalTypeLevelPerson()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataView dv = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_position_code"] = txtCode.Text;

            gvwListApprovalTypeLevelPerson.DataSource = _dal.GetRows("", "xsp_approval_type_level_person_getrows_by_position", _ht);

            gvwListApprovalTypeLevelPerson.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnAddApprovalTypeLevelPerson_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("approvaltypelevelperson.aspx?action=add&levelid=" + txtLevelID.Text + "&code=" + CODE + "&positioncode=" + txtCode.Text);
    }

    protected void btnDeleteApprovalTypeLevelPerson_OnClick(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListApprovalTypeLevelPerson.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataApprovalTypeLevelPerson(gvwListApprovalTypeLevelPerson.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindApprovalTypeLevelPerson();
    }

    private void DeleteDataApprovalTypeLevelPerson(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete("APPROVAL_TYPE_LEVEL_PERSON", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindApprovalTypeLevelPerson();
    }
    #endregion
}
