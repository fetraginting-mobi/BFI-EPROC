using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_approval_approvaltype : BasePage
{
    private static string TABLE_NAME = "APPROVAL_TYPE";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        btnLookUpDim1.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim1Code.ClientID, txtDim1Description.ClientID);
        btnLookUpDim2.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim2Code.ClientID, txtDim2Description.ClientID);
        btnLookUpDim3.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim3Code.ClientID, txtDim3Description.ClientID);
        btnLookUpDim4.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim4Code.ClientID, txtDim4Description.ClientID);
        btnLookUpDim5.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim5Code.ClientID, txtDim5Description.ClientID);
        btnLookUpDim6.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim6Code.ClientID, txtDim6Description.ClientID);
        btnLookUpDim7.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim7Code.ClientID, txtDim7Description.ClientID);
        btnLookUpDim8.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim8Code.ClientID, txtDim8Description.ClientID);
        btnLookUpDim9.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim9Code.ClientID, txtDim9Description.ClientID);
        btnLookUpDim10.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=DCDIM&acol_0={0}&bcol_1={1}');", txtDim10Code.ClientID, txtDim10Description.ClientID);
        btnLookUpType.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=APTC&acol_0={0}&bcol_1={1}');", txtTypeCode.ClientID, txtDescriptionType.ClientID);

        if (!Page.IsPostBack)
        {

            //Shared.BindGeneralSubCode(ddlType, "APPT");
            btnDeleteApprovalTypeLevel.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindApprovalTypeLevel();

                txtCode.Enabled = false;

                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
            }

            else if (Request.Params["action"].Equals("copy"))
            {
                LoadData();

                
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";


            }
            else
                btnAddApprovalTypeLevel.Visible = btnDeleteApprovalTypeLevel.Visible = false;
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
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex); ;
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

            if (Request.Params["action"].Equals("add") || (Request.Params["action"].Equals("copy")) )
            

                _dal.Insert(TABLE_NAME, _ht);

              
            
           
            

               // _ht["p_code";
             
           


            else

                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("approvaltype.aspx?action=edit&code={0}", txtCode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex); ;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("approvaltypelist.aspx");
    }

    #region Toolbar
    //protected void btnSave_Click(object sender, EventArgs e)
    //{
    //    SaveData();
    //}

    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("approvaltypelist.aspx");
    //}

    protected void btnDelDim1_Click(object sender, EventArgs e)
    {
        txtDim1Code.Text = txtDim1Description.Text = "";
        txtDimValueFrom1.Text = "";
        txtDimValueTo1.Text = "";
        updDimension.Update();
    }

    protected void btnDelDim2_Click(object sender, EventArgs e)
    {
        txtDim2Code.Text = txtDim2Description.Text = "";
        txtDimValueFrom2.Text = "";
        txtDimValueTo2.Text = "";
        updDimension.Update();
    }

    protected void btnDelDim3_Click(object sender, EventArgs e)
    {
        txtDim3Code.Text = txtDim3Description.Text = "";
        txtDimValueFrom3.Text = "";
        txtDimValueTo3.Text = "";
        updDimension.Update();
    }

    protected void btnDelDim4_Click(object sender, EventArgs e)
    {
        txtDim4Code.Text = txtDim4Description.Text = "";
        txtDimValueFrom4.Text = "";
        txtDimValueTo4.Text = "";
        updDimension.Update();
    }

    protected void btnDelDim5_Click(object sender, EventArgs e)
    {
        txtDim5Code.Text = txtDim5Description.Text = "";
        txtDimValueFrom5.Text = "";
        txtDimValueTo5.Text = "";
        updDimension.Update();
    }

    protected void btnDelDim6_Click(object sender, EventArgs e)
    {
        txtDim6Code.Text = txtDim6Description.Text = "";
        txtDimValueFrom6.Text = "";
        txtDimValueTo6.Text = "";
        updDimension.Update();
    }

    protected void btnDelDim7_Click(object sender, EventArgs e)
    {
        txtDim7Code.Text = txtDim7Description.Text = "";
        txtDimValueFrom7.Text = "";
        txtDimValueTo7.Text = "";
        updDimension.Update();
    }

    protected void btnDelDim8_Click(object sender, EventArgs e)
    {
        txtDim8Code.Text = txtDim8Description.Text = "";
        txtDimValueFrom8.Text = "";
        txtDimValueTo8.Text = "";
        updDimension.Update();
    }

    protected void btnDelDim9_Click(object sender, EventArgs e)
    {
        txtDim9Code.Text = txtDim9Description.Text = "";
        txtDimValueFrom9.Text = "";
        txtDimValueTo9.Text = "";
        updDimension.Update();
    }

    protected void btnDelDim10_Click(object sender, EventArgs e)
    {
        txtDim10Code.Text = txtDim10Description.Text = "";
        txtDimValueFrom10.Text = "";
        txtDimValueTo10.Text = "";
        updDimension.Update();
    }
    #endregion

    #region ApprovalTypeLevel
    protected void gvwListApprovalTypeLevel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListApprovalTypeLevel.PageIndex = e.NewPageIndex;
    }

    protected void gvwListApprovalTypeLevel_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("approvaltypelevel.aspx?action=edit&id=" + gvwListApprovalTypeLevel.SelectedDataKey[0].ToString() + "&code=" + txtCode.Text);
    }

    private void BindApprovalTypeLevel()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_approval_code"] = txtCode.Text;

            gvwListApprovalTypeLevel.DataSource = _dal.GetRows("APPROVAL_TYPE_LEVEL", _ht);
            gvwListApprovalTypeLevel.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnAddApprovalTypeLevel_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("approvaltypelevel.aspx?action=add&code=" + txtCode.Text);
    }

    protected void btnDeleteApprovalTypeLevel_OnClick(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListApprovalTypeLevel.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataApprovalTypeLevel(gvwListApprovalTypeLevel.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindApprovalTypeLevel();
    }

    private void DeleteDataApprovalTypeLevel(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete("APPROVAL_TYPE_LEVEL", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindApprovalTypeLevel();
    }
    #endregion
}
