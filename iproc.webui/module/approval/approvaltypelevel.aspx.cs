using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_approval_approvaltypelevel : BasePage
{
    private static string TABLE_NAME = "APPROVAL_TYPE_LEVEL";
    private static string TABLE_NAME_POSITION = "APPROVAL_TYPE_LEVEL_POSITION";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            lblApprovalCode.Text = Request.Params["code"];

            btnDeleteApprovalTypeLevelPosition.OnClientClick = "return confirm('Delete selected data?');";
            txtOrder.Enabled = false;
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindApprovalTypeLevelPosition();

                btnCancel.Text = "Back";
                txtFromAmount.Enabled = false;
                txtToAmount.Enabled = false;
            }
            else
            {
                LoadDataDefault();
                btnAddApprovalTypeLevelPosition.Visible = btnDeleteApprovalTypeLevelPosition.Visible = false;
                pnlAll.Visible = false;
               
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

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("approvaltypelevel.aspx?action=edit&id={0}&code={1}", lblID.Text, lblApprovalCode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    private void LoadDataDefault()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_approval_code"] = Request.Params["code"];
            DataRow _dr = _dal.GetRow("", "xsp_approval_type_level_getrow_for_default", _ht);

            txtOrder.Text = ((int)_dr["NEXT_ORDER_KEY"]).ToString();
            txtFromAmount.Text = ((decimal)_dr["NEXT_FROM_AMOUNT"]).ToString();
            txtToAmount.Text = decimal.Parse("0.00").ToString();

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
        Response.Redirect("approvaltype.aspx?action=edit&code=" + lblApprovalCode.Text);
    }

    #region ApprovalTypeLevelPosition
    protected void gvwListApprovalTypeLevelPosition_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListApprovalTypeLevelPosition.PageIndex = e.NewPageIndex;
        BindApprovalTypeLevelPosition();
    }

    protected void gvwListApprovalTypeLevelPosition_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("approvaltypelevelposition.aspx?action=edit&id=" + gvwListApprovalTypeLevelPosition.SelectedDataKey[0].ToString() + "&levelid=" + lblID.Text + "&code=" + lblApprovalCode.Text + "&positioncode=" + gvwListApprovalTypeLevelPosition.SelectedDataKey[1].ToString());
    }

    private void BindApprovalTypeLevelPosition()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        DataView dv = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchPosition.Text;
            _ht["p_level_id"] = lblID.Text;

            //Add sorting griedview - 5/27/2016 16:34:29 PM - Bilal  

            gvwListApprovalTypeLevelPosition.DataSource = _dal.GetRows(TABLE_NAME_POSITION, _ht).DefaultView;

            //gvwListApprovalTypeLevelPosition.DataSource = _dal.GetRows(TABLE_NAME_POSITION, _ht);
            gvwListApprovalTypeLevelPosition.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnAddApprovalTypeLevelPosition_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("approvaltypelevelposition.aspx?action=add&levelid=" + lblID.Text + "&code=" + lblApprovalCode.Text);
    }

    protected void btnDeleteApprovalTypeLevelPosition_OnClick(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListApprovalTypeLevelPosition.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataApprovalTypeLevelPosition(gvwListApprovalTypeLevelPosition.DataKeys[row.RowIndex][0].ToString(), gvwListApprovalTypeLevelPosition.DataKeys[row.RowIndex][1].ToString());
            }
        }

        BindApprovalTypeLevelPosition();
    }

    private void DeleteDataApprovalTypeLevelPosition(string ID, string POSITION)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_level_id"] = ID;
            _ht["p_position_code"] = POSITION;

            _dal.Delete(TABLE_NAME_POSITION, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
     
    protected void btnSearchPosition_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindApprovalTypeLevelPosition();
    }
    #endregion

     
}
