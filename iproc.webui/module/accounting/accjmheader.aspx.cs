using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_accjmheader : BasePage
{
    private static string TABLE_NAME = "ACC_JM_HEADER";
    private static string TABLE_NAME_DETAIL = "ACC_JM_DETAIL";

    //untuk total
    private decimal dBaseDb = 0;
    private decimal dBaseCr = 0;
    private decimal dOrigCr = 0;
    private decimal dOrigDb = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindBranch(ddlBranchCode);

            btnDeleteDetail.OnClientClick = "return confirm('Delete selected data?');";
            // btnPost.OnClientClick = "return confirm('Post selected data?');";
            // btnReject.OnClientClick = "return confirm('Cancel selected data?');";
            btnReject.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0054&parc_object_id={0}&parc_object_branch={1}');", lblJmNo.ClientID, lblbranch.ClientID);
            btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0019&parc_object_id={0}&parc_object_branch={1}');", lblJmNo.ClientID, lblbranch.ClientID);
            txtJmDate.Text = DateTime.Today.ToString("dd/MM/yyyy");

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                BindDataDetail();

                lblJmNo.Enabled = false;
                btnCancel.Text = "Back";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                ddlBranchCode.Enabled = false;

                if (lblJmStatus.Text == "POST" || lblJmStatus.Text == "CANCEL")
                {
                    btnSave.Visible = btnPost.Visible = btnReject.Visible = false;
                    btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                    btnPrint.Visible = true;
                    txtJmDate.Enabled = txtJmRemarks.Enabled = txtValueDate.Enabled = false;
                }
                else
                {
                    btnAddDetail.Visible = btnDeleteDetail.Visible = true;
                    btnReject.Visible = btnPost.Visible = true;
                    //btnPrint.Visible = false;
                }
            }
            else
            {
                btnAddDetail.Visible = btnDeleteDetail.Visible = false;
                btnReject.Visible = btnPost.Visible = false;
                btnPrint.Visible = false;
            }
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

            _ht["p_jm_no"] = Request.Params["jmno"];

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
        string iNextID = "";
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_jm_no"] = Request.Params["jmno"];

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblJmNo.Text = iNextID;
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjmheader.aspx?action=edit&jmno={0}", lblJmNo.Text));
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

            _ht["p_jm_no"] = Request.Params["jmno"];
            _dal.ExecRawSP("xsp_acc_jm_header_post", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjmheader.aspx?action=edit&jmno={0}", lblJmNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void CancelData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_jm_no"] = Request.Params["jmno"];
            _dal.ExecRawSP("xsp_acc_jm_header_cancel", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjmheader.aspx?action=edit&jmno={0}", lblJmNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void PrintData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_jm_no"] = Request.Params["jmno"];
            _dal.ExecRawSP("xsp_acc_jm_header_print", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjmheader.aspx?action=edit&jmno={0}", lblJmNo.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void ViewJurnalData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_jm_no"] = Request.Params["jmno"];

            _dal.ExecRawSP("xsp_acc_jm_header_view_jurnal", _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjmheader.aspx?action=edit&jmno={0}", lblJmNo.Text));
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
        Response.Redirect("accjmheaderlist.aspx");
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        CancelData();
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        //PrintData();
        Hashtable htParams = new Hashtable();
        htParams["p_user_id"] = Shared.CurrentUID;
        htParams["p_voucher_no"] = lblJmNo.Text;
        string sFilename = "";
        //
        sFilename = Shared.ExecuteReport(this, "RPT_JURNAL_MEMORIAL", htParams, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

        Shared.PreviewReport(this, sFilename);
    }

    protected void btnViewJurnal_Click(object sender, EventArgs e)
    {
        ViewJurnalData();
    }


    #region Detail
    private void BindDataDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearchDetail.Text;
            _ht["p_jm_no"] = lblJmNo.Text;

            gvwListDetail.DataSource = _dal.GetRows(TABLE_NAME_DETAIL, _ht);
            gvwListDetail.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteDataDetail(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = ID;

            _dal.Delete(TABLE_NAME_DETAIL, _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void gvwListDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDetail.PageIndex = e.NewPageIndex;
        BindDataDetail();
    }

    protected void btnAddDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect("accjmdetail.aspx?action=add&jmno=" + lblJmNo.Text);
    }

    protected void btnDeleteDetail_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwListDetail.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteDataDetail(gvwListDetail.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindDataDetail();
    }

    protected void btnSearchDetail_Click(object sender, EventArgs e)
    {
        BindDataDetail();
    }

    protected void gvwListDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("accjmdetail.aspx?action=edit&id=" + gvwListDetail.SelectedDataKey[0].ToString() + "&jmno=" + lblJmNo.Text);
    }

    protected void gvwListDetail_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            dOrigCr = dOrigCr + decimal.Parse(e.Row.Cells[8].Text);
            dOrigDb = dOrigDb + decimal.Parse(e.Row.Cells[7].Text);
            dBaseCr = dBaseCr + decimal.Parse(e.Row.Cells[11].Text);
            dBaseDb = dBaseDb + decimal.Parse(e.Row.Cells[10].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[7].Text = dOrigDb.ToString("N2");
            e.Row.Cells[8].Text = dOrigCr.ToString("N2");
            e.Row.Cells[10].Text = dBaseDb.ToString("N2");
            e.Row.Cells[11].Text = dBaseCr.ToString("N2");
        }
    }

    #endregion

}
