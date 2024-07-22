using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_accounting_accjurnalheaderlist : BasePageList
{
    private static string TABLE_NAME = "ACC_JURNAL_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "ACC_JURNAL_HEADER";
        NEXT_PAGE = "accjurnalheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployee(ddlBranch);
            txtFromDueDate.Text = Shared.CurrentStartAccDate;
            txtToDueDate.Text = Shared.CurrentEndAccDate;
            //txtToDueDate.Text = DateTime.Today.ToString("dd/MM/yyyy");
            //txtFromDueDate.Text = DateTime.Today.AddMonths(-1).ToString("dd/MM/yyyy");
            //btnDelete.OnClientClick = "return confirm('Delete selected data?');";
            btnUnPost.OnClientClick = "return confirm('Unpost selected data?');";
            btnPost.OnClientClick = "return confirm('Post selected data?');";

            BindData();
        }

        //btnUnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0099&parc_object_id={0}&parc_object_branch={1}');", gvwList.SelectedDataKey[1].ToString(), ddlBranch.ClientID);
        //btnPost.Attributes["href"] = String.Format("javascript:fnShowApprovalDialog('../../approval/generic.aspx?code=APP0100&parc_object_id={0}&parc_object_branch={1}');", gvwList.SelectedDataKey[1].ToString(), ddlBranch.ClientID);
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_status"] = ddlStatus.SelectedValue;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_to_due_date"] = txtToDueDate.Text;
            _ht["p_from_due_date"] = txtFromDueDate.Text;
            _ht["p_type"] = ddlType.SelectedValue;

            gvwList.DataSource = _dal.GetRows(TABLE_NAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void PostData(string voucher)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            //
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
                    Shared.ApplyDefaultProp(_ht);

                    _ht["p_voucher_no"] = voucher;

                    _dal.ExecRawSP("xsp_acc_jurnal_header_post", _ht);
                }
            }

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

        BindData();

        //GeneralDAL _dal = null;
        //Hashtable _ht = null;

        //try
        //{
        //    //
        //    _dal = new GeneralDAL();
        //    _ht = new Hashtable();

        //    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
        //    Shared.ApplyDefaultProp(_ht);

        //    _ht["p_voucher_no"] = voucher;

        //    _dal.ExecRawSP("xsp_acc_jurnal_header_post", _ht);

        //    Shared.ShowSuccessGritter(this, string.Format("accjurnalheaderlist.aspx"));
        //}
        //catch (Exception ex)
        //{
        //    Shared.ShowErrorDialog(this, ex);
        //}
    }

    private void DeleteData(string ID)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["id"] = ID;

            _dal.Delete(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("accjurnalheaderlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void UnPost()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            //
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
                    Shared.ApplyDefaultProp(_ht);

                    _ht["p_voucher_no"] = gvwList.DataKeys[row.RowIndex][2].ToString();

                    _dal.ExecRawSP("xsp_acc_jurnal_header_unpost", _ht);
                }
            }

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

        BindData();
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Hashtable htReportParams = null;
     
        try
        {
            htReportParams = new Hashtable();

            htReportParams["p_user_id"] = Shared.CurrentUID;
            htReportParams["p_from_date"] = Shared.ToDateTime(txtFromDueDate.Text);
            htReportParams["p_to_date"] = Shared.ToDateTime(txtToDueDate.Text);
            htReportParams["p_branch_code"] = ddlBranch.SelectedValue;
            htReportParams["p_status"] = ddlStatus.SelectedValue;
            htReportParams["p_type"] = "ALL";

            //UIToDB.Map(this.Controls, htReportParams);
            //if (rblPrinterOption.SelectedValue.ToString() == "1")
            {
                string filename = Shared.ExecuteReportExcel(this, "RPT_REKAP_JURNAL_TRANSACTION_LIST", htReportParams, CrystalDecisions.Shared.ExportFormatType.ExcelRecord);
                Shared.PreviewReport(this, filename);
            }
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnUnPost_Click(object sender, EventArgs e)
    {
        UnPost();
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("accjurnalheader.aspx?action=add");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                //if (gvwList.DataKeys[row.RowIndex][1].ToString() == "HOLD")
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindData();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                PostData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }
        BindData();
    }

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("accjurnalheader.aspx?action=edit&voucherno=" + gvwList.SelectedDataKey[0].ToString());
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddltype_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

}
