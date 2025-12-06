using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_fa_fadepretiationlistlist : BasePage
{
    //private static string TABLE_NAME_HEADER = "FA_ASSET_HISTORY_DEPRECIATION";

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
            DateTime depre = DateTime.Now;
           
            txtMonth.Text = depre.Month.ToString();
            txtYear.Text = depre.Year.ToString();
            //Shared.BindGeneralSubCodeByCode(ddlMonthDepre, "MNH");
            // ddlMonthDepre.Text = depre.Month.ToString();
            //txtYearDepre.Text = depre.Year.ToString();
            BindDataDepre();

            //btnPost.OnClientClick = "return confirm('Post selected data?');";
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
            _ht["p_year"] = Request.Params["year"];
            _ht["p_month"] = Request.Params["month"];
            _ht["p_branch_code"] = Request.Params["branchcode"];

            gvwListDepre.DataSource = _dal.GetRows("", "xsp_fa_depreciation_list_list_getrows", _ht);
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

        //
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            foreach (GridViewRow row in gvwListDepre.Rows)
            {
               
                _ht["p_year"] = Request.Params["year"];
                _ht["p_month"] = Request.Params["month"];
                _ht["p_branch_code"] = Request.Params["branch"];

                Shared.ApplyDefaultProp(_ht);

                _dal.ExecRawSP("xsp_fa_asset_history_depreciation_post", _ht);

                //CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                //if (chb.Checked)
                //{
                //    _ht["p_fa_id"] = Int32.Parse(gvwListDepre.DataKeys[row.RowIndex][0].ToString());
                //    _ht["p_year"] = txtYearDepre.Text;
                //    _ht["p_month"] = txtMonthDepre.Text;

                //    Shared.ApplyDefaultProp(_ht);

                //    _dal.ExecRawSP("xsp_fa_asset_history_depreciation_post", _ht);

                //    Shared.ShowSuccessGritter(this, string.Format("fadepreciationlist.aspx"));
                //}
            }

            _ht["p_year"] = Request.Params["year"];
            _ht["p_month"] = Request.Params["month"];
            Shared.ApplyDefaultProp(_ht);
            _dal.ExecRawSP("xsp_jurnal_fa_depresiasi", _ht);

            Shared.ShowSuccessGritter(this, string.Format("fadepreciationlist.aspx"));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
        BindDataDepre();
    }

    protected void gvwListDepre_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwListDepre.PageIndex = e.NewPageIndex;
        BindDataDepre();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("fadepreciationlist.aspx?action=edit&year=" + txtYear.Text + "&month"  + txtMonth.Text );
    }
  
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataDepre();
    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        PostData();
    }
}