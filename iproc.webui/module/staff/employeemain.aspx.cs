using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_personel_employeemain : BasePage
{
    private static string TABLE_NAME = "EMPLOYEE_MAIN";
    private static string TABLE_NAME_EMP = "EMPLOYEE_BRANCH";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {

            btnSubscriptionWidget.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=SWIDGET&empcode={0}&gvw={1}');", Request.Params["empcode"], btnSearchWid.UniqueID);
            btnSubscriptionNotifi.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/subscription.aspx?code=SNOTIFI&empcode={0}&gvw={1}');", Request.Params["empcode"], btnSearchNotif.UniqueID);
            btnLookUpReportTo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=STAFF&acol_0={0}&bcol_1={1}');", txtEmpCode.ClientID, lblEmpName.ClientID);
            btnLookupPosition.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MMP&acol_0={0}&bcol_1={1}');", txtCode.ClientID, txtDesc.ClientID);

           


            Shared.BindBranch(ddlBranch);

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindBranchAll(ddlBranch);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

           
           


            ddlBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;
            //ddlSubBranch.SelectedValue = Shared.CurrentEmployeeBranchCode;

            txtMonthLoginLog.Text = DateTime.Today.ToString("MM");
            txtYearLoginLog.Text = DateTime.Today.ToString("yyyy");
            txtMonthActivityLog.Text = DateTime.Today.ToString("MM");
            txtYearActivityLog.Text = DateTime.Today.ToString("yyyy");


            Shared.BindGeneralSubCode(ddlBloodType, "GOLDAR");
            Shared.BindGeneralSubCode(ddlMarital, "MARIT");
            Shared.BindGeneralSubCode(ddlReligion, "RELIGI");
            Shared.BindGeneralSubCode(ddlNationality, "NAT");

            btnDeleteSubscribeWidget.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteEmp.OnClientClick = "return confirm('Delete selected data?');";
            btnDeleteSubscribeNotifi.OnClientClick = "return confirm('Delete selected data?');";

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindWidget();
                BindDataEmp();
                BindNotifi();
                //BindDataGroup();
                btnCancel.Text = "Back";
                
                if (lblStatus.Text == "ACTIVE")
                    btnReActive.Text = "In-Active";
            }

               
            else
            {
                btnSubscriptionWidget.Visible = btnDeleteSubscribeWidget.Visible = false;
                pnlAllEmployee.Visible = false;
                btnReActive.Visible = false;
                ddlDivision.SelectedValue = Shared.CurrentEmployeeDivCode;
                ddlDepartment.SelectedValue = Shared.CurrentEmployeeDeptCodeDefault;
                Shared.BindDivision(ddlDivision);
                Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
                Shared.BindUnits(ddlUnits, ddlDepartment.SelectedValue);
              
                
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

            _ht["p_emp_code"] = Request.Params["empcode"];
            _ht["p_uid"] = lblUid.Text;
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

            DBToUI.Map(this.Controls, _dr);

            ////mapping manual
            //Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            //Shared.BindUnits(ddlUnits, ddlDepartment.SelectedValue);
            //ddlDepartment.SelectedValue     = _dr["DIVISION_CODE"].ToString();
            //ddlUnits.SelectedValue          = _dr["DEPARTMENT_CODE"].ToString();
            //ddlSubDepartment.SelectedValue  = _dr["DEPARTMENT_CODE"].ToString();

            Shared.BindDivision(ddlDivision);
            Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
            Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
            Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);

            Shared.BindBranchAll(ddlBranch);


            /* mapping image manual */
            if (_dr["IMAGE_NAME"] != null)

                //get the file name of the posted image 
                imgPhoto.ImageUrl = "~/ImageStorage/" + _dr["IMAGE_NAME"];
        
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void ReactiveUID()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = lblCode.Text;
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_master_user_main_update_status", _ht);

            Shared.ShowSuccessGritter(this, string.Format("employeemain.aspx?action=edit&empcode={0}", lblCode.Text));
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
        string nextID = "";

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);
           
            //map manual
            _ht["p_image_name"] = fupPhoto.FileName; 

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref nextID);
                lblCode.Text = nextID;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            /* upload file */
            UpLoadImage();

            Shared.ShowSuccessGritter(this, string.Format("employeemain.aspx?action=edit&empcode={0}&uid={1}", lblCode.Text, lblUid.Text));
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

    protected void btnReActive_Click(object sender, EventArgs e)
    {
        ReactiveUID();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("employeemainlist.aspx");
    }
    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindDepartment(ddlDepartment, ddlDivision.SelectedValue);
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);



        //updDep.Update();
    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        Shared.BindSubDepartment(ddlSubDepartment, ddlDepartment.SelectedValue);
        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
    }

    protected void ddlSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {

        Shared.BindUnits(ddlUnits, ddlSubDepartment.SelectedValue);
    }


    protected void ddlBranch_SelectedIndex(object sender, EventArgs e)
    {
    

    }
    protected void ddlMarital_SelectedIndex(object sender, EventArgs e)
    {
        if (ddlMarital.SelectedValue == "SING")
        {
            txtChildren.Enabled = false;
            txtChildren.Text = "0";
        }
        else
        {
            txtChildren.Enabled = true;
        }
    }

    #region Branch Employee
    private void BindDataEmp()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchEmp.Text;
            _ht["p_emp_code"] = lblCode.Text;

            gvwListEmp.DataSource = _dal.GetRows(TABLE_NAME_EMP, _ht);
            gvwListEmp.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListEmp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListEmp.PageIndex = e.NewPageIndex;
        BindDataEmp();
    }

    protected void btnAddEmp_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("branch.aspx?action=add&empcode={0}",lblCode.Text));
    }

    protected void btnDeleteEmp_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListEmp.Rows)
        {
            CheckBox chbCheckedEmp = (CheckBox)row.Cells[1].Controls[1];
            if (chbCheckedEmp.Checked)
            {
                DeleteDataEmp(gvwListEmp.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindDataEmp();
    }



    private void DeleteDataEmp(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_EMP, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchEmp_Click(object sender, EventArgs e)
    {
        BindDataEmp();
    }
    protected void gvwListEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("branch.aspx?action=edit&empcode={0}&id={1}", lblCode.Text, gvwListEmp.SelectedDataKey[0].ToString()));
    }

    protected void chbCheckedAllEmp_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListEmp.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbCheckedEmp") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    #endregion


    #region Widget
    protected void gvwListWidget_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListWidget.PageIndex = e.NewPageIndex;
        BindWidget();
    }

    private void BindWidget()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchWid.Text;
            _ht["p_emp_code"] = Request.Params["empcode"];

            gvwListWidget.DataSource = _dal.GetRows("EMPLOYEE_WIDGET_SUBSCRIPTION", _ht);
            gvwListWidget.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListWidget_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("employeewidgetsubscriptioninfo.aspx?action=edit&empcode={0}&widgetcode={1}", gvwListWidget.SelectedDataKey[0].ToString(), gvwListWidget.SelectedDataKey[1].ToString()));
    }

    protected void btnDeleteSubscribeWidget_OnClick(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListWidget.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataWidget(gvwListWidget.DataKeys[row.RowIndex][0].ToString(), gvwListWidget.DataKeys[row.RowIndex][1].ToString());
            }
        }

        BindWidget();
    }

    private void DeleteDataWidget(string empcode, string widgetcode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_emp_code"] = empcode;
            _ht["p_widget_code"] = widgetcode;

            _dal.Delete("EMPLOYEE_WIDGET_SUBSCRIPTION", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchWid_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindWidget();
    }

    protected void chbWidgetCheckedAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in gvwListWidget.Rows)
        {
            CheckBox cbSelect = gvr.FindControl("chbWidgetChecked") as CheckBox;
            cbSelect.Checked = ((CheckBox)sender).Checked;
        }
    }
    #endregion

    //#region Group
    //private void BindDataGroup()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_uid"] = lblUid.Text;

    //        gvwListGroup.DataSource = _dal.GetRows("MASTER_USER_MAIN_GROUP_SEC", _ht);
    //        gvwListGroup.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //private void DeleteDataGroup(string ID, string Group)
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;

    //    try
    //    {
    //        _dal = new GeneralDAL();
    //        _ht = new Hashtable();

    //        _ht["p_uid"] = ID;
    //        _ht["p_group_code"] = Group;

    //        _dal.Delete("MASTER_USER_MAIN_GROUP_SEC", _ht);
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    //protected void gvwListGroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    gvwListGroup.PageIndex = e.NewPageIndex;
    //    BindDataGroup();
    //}

    //protected void btnAddGroup_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("../user/masterusermaingroup.aspx?action=add&uid=" + lblUid.Text + "&empcode=" + lblCode.Text);
    //}

    //protected void btnDeleteGroup_Click(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in gvwListGroup.Rows)
    //    {
    //        CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //        if (chb.Checked)
    //        {
    //            DeleteDataGroup(lblCode.Text, gvwListGroup.DataKeys[row.RowIndex][1].ToString());
    //        }
    //    }

    //    BindDataGroup();
    //}

    //protected void gvwListGroup_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Response.Redirect("masterusermaingroup.aspx?action=edit&uid=" + lblCode.Text + "&empcode=" + lblCode.Text);
    //}
    //#endregion

    #region Login Log
    private void BindDataLoginLog()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = lblUid.Text;
            _ht["p_year"] = txtYearLoginLog.Text;
            _ht["p_month"] = txtMonthLoginLog.Text;

            gvwListLoginLog.DataSource = _dal.GetRows("MASTER_USER_LOGIN_LOG", _ht);
            gvwListLoginLog.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListLoginLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListLoginLog.PageIndex = e.NewPageIndex;
        BindDataLoginLog();
    }

    protected void btnViewGvwListLoginLog_OnClick(object sender, EventArgs e)
    {
        BindDataLoginLog();
    }
    #endregion

    #region Activity Log
    private void BindDataActivityLog()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = lblUid.Text;
            _ht["p_year"] = txtYearActivityLog.Text;
            _ht["p_month"] = txtMonthActivityLog.Text;

            gvwListActivityLog.DataSource = _dal.GetRows("MASTER_USER_ACTIVITY_LOG", _ht);
            gvwListActivityLog.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void gvwListActivityLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListActivityLog.PageIndex = e.NewPageIndex;
        BindDataActivityLog();
    }

    protected void btnViewGvwListActivityLog_OnClick(object sender, EventArgs e)
    {
        BindDataActivityLog();
    }
    #endregion

    #region Notification
    protected void gvwListNotifi_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListNotifi.PageIndex = e.NewPageIndex;
        BindNotifi();
    }

    private void BindNotifi()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchNotif.Text;
            _ht["p_emp_code"] = Request.Params["empcode"];

            gvwListNotifi.DataSource = _dal.GetRows("EMPLOYEE_NOTIFICATION_SUBSCRIPTION", _ht);
            gvwListNotifi.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnDeleteSubscribeNotifi_OnClick(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListNotifi.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataNotifi(gvwListNotifi.DataKeys[row.RowIndex][0].ToString(), gvwListNotifi.DataKeys[row.RowIndex][1].ToString());
            }
        }

        BindNotifi();
    }

    private void DeleteDataNotifi(string empcode, string notificode)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_emp_code"] = empcode;
            _ht["p_notifi_code"] = notificode;

            _dal.Delete("EMPLOYEE_NOTIFICATION_SUBSCRIPTION", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearchNotif_Click(object sender, EventArgs e)
    {
        if (Request.Params["action"].Equals("edit"))
            BindNotifi();
    }
    #endregion

    #region Insert Image

    private void UpLoadImage()
    {

        //get the file name of the posted image 
        string imgName = fupPhoto.FileName.ToString();
        string imgPath = "~/ImageStorage/" + imgName;


        //get the size in bytes that 
        int imgSize = fupPhoto.PostedFile.ContentLength;
        lblImageName.Text = imgName;

        //validates the posted file before saving 
        if (fupPhoto.PostedFile != null && fupPhoto.PostedFile.FileName != "")
        {

            if (fupPhoto.PostedFile.ContentLength > 5120000) // 5120 KB means 5MB 204800 (5120000=satuan byte)
            {
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('File is too big, Max size 5Mb')", true);
            }

            else
            {
                //save to folder 
                fupPhoto.SaveAs(Server.MapPath(imgPath));
            }
        }
    }
    #endregion

}
