using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_fa_fadepreciationlist : BasePageList
{
    private static string TABLE_NAME_HEADER = "FA_ASSET_HISTORY_DEPRECIATION";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "FA_ASSET_HISTORY_DEPRECIATION";
        NEXT_PAGE = "fadepreciationlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            //txtMonthDepre.Text = DateTime.Today.ToString("MM");
            //txtYearDepre.Text = DateTime.Today.ToString("yyyy");
            //BindDataDepre();
            Shared.BindBranchEmployeeAll(ddlBranch);
           
            DateTime depre = DateTime.Now;
            //Shared.BindGeneralSubCodeByCode(ddlMonthDepre, "MNH");
           // ddlMonthDepre.Text = depre.Month.ToString();
            txtYearDepre.Text = depre.Year.ToString();
            ddlMonthDepre.SelectedValue = depre.Month.ToString();
            BindDataDepre();
            txtYearDepre.Enabled = false;
           // ddlMonthDepre.Enabled = false;
            btnPost.OnClientClick = "return confirm('Post selected data?');";
        }
        LoadAfterInit();
    }

    private void BindDataDepre()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_year"] = txtYearDepre.Text;
            _ht["p_month"] = ddlMonthDepre.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            gvwListDepre.DataSource = _dal.GetRows("", "xsp_fa_depreciation_list_getrows", _ht);
            gvwListDepre.DataBind();
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




        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwListDepre.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);

                    // _ht["p_id"] = gvwListnotin.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_branch_code"] = gvwListDepre.DataKeys[row.RowIndex][0].ToString();
                   






                    //if (AuthorityBranch.Checked == true)
                    //    _ht["p_is_authority_branch"] = "1";
                    //else
                    //    _ht["p_is_authority_branch"] = "0";

                    Shared.ApplyDefaultProp(_ht);

                    _dal.Update("", "xsp_fa_asset_depretiation_post", _ht);

                }
            }

            Shared.ShowSuccessGritter(this, string.Format("fadepreciationlist.aspx"));
            BindDataDepre();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void GenerateData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;


        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
           


            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_fa_depretiation_history_generate", _ht);

            Shared.ShowSuccessGritter(this, string.Format("fadepreciationlist.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwListDepre.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }



    protected void gvwListDepre_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDepre.PageIndex = e.NewPageIndex;
        BindDataDepre();
    }

    protected void btnViewGvwListDepre_OnClick(object sender, EventArgs e)
    {
        BindDataDepre();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataDepre();
    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GenerateData();
    }

    protected void gvwListDepre_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("fadepretiationlistlist.aspx?action=edit&branchcode={0}&year={1}&month={2}", gvwListDepre.SelectedDataKey[0].ToString(), txtYearDepre.Text,ddlMonthDepre.SelectedValue));
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _htParameters = null;

        try
        {
            _dal = new GeneralDAL();
            _htParameters = new Hashtable();

            _htParameters.Clear();
            _htParameters["p_year"] = txtYearDepre.Text;
            _htParameters["p_month"] = ddlMonthDepre.Text;
            _htParameters["p_branch_code"] = ddlBranch.SelectedValue;

            string pdfName = "upload_row_format" + Shared.CurrentUID + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx"; ;
            // string pdfPath = Server.MapPath(@"..\..\template\" + pdfName);
            string pdfPath = Server.MapPath(@"..\..\temp\" + pdfName);

            string filetype = "xls";

            // menampilkan xls yang sudah dibuat
            Shared.ExecuteReportExportExcel(this, null, "xsp_fa_depreciation_list_download_getrows", _htParameters, pdfPath);
            ScriptManager.RegisterStartupScript(this, GetType(), "Report", "window.open('../../temp/" + pdfName + "', 'Report', 'fullscreen=0,menubar=0,status=0,scrollbars=0,resizable=1,toolbar=0,width=600,height=400');", true);
        }

        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
}

