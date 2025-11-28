using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_itemquotationselection : BasePageList
{
    private static string TABLE_NAME = "PURCHASE_REQUEST_DETAIL";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "PURCHASE_REQUEST_DETAIL";
        NEXT_PAGE = "itemquotationselectionlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();


        btnProcess.OnClientClick = "return confirm('Apakah Data Sudah Disimpan? Jika Sudah Silahkan Tekan OK Untuk Melanjutkan Proses');";

        if (!Page.IsPostBack)
        {
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindOwnerAll(ddlOwner);
            ddlBranch.Items.Insert(0, "ALL");

            //(+) Ari 11-07-2022 ket : enhancement 2022
            if (string.IsNullOrEmpty(txtToDate.Text))
            {
                //set tgl skrg
                txtToDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

                //set tgl 30 hari sebelum hari ini
                DateTime date = new DateTime(DateTime.Now.Year, 1, 1).AddDays(DateTime.Now.DayOfYear - 30);
                txtFromDate.Text = date.ToString("dd/MM/yyyy");

            }


            BindData();
           

        }

        
        LoadAfterInit();
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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_owner"] = ddlOwner.SelectedValue;
            _ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;

            //(+) Ari 11-07-2022 ket : enhancement 2022
            _ht["p_from_date"] = Shared.ToStartDateTime(txtFromDate.Text);
            _ht["p_to_date"] = Shared.ToStartDateTime(txtToDate.Text);

            Shared.ApplyDefaultProp(_ht);
             
            gvwList.DataSource = _dal.GetRows("", "xsp_item_quotation_selection_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }



    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("itemquotationselection.aspx?action=edit&prcode=" + gvwList.SelectedDataKey[0].ToString() + "&idprd=" + gvwList.SelectedDataKey[2].ToString());
    }



    //private void ProcessData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    String _pqrcode = "";

    //    if (!SelectedExist())
    //    {
    //        Exception ex = null;
    //        ex = new Exception("No Transaction Selected !");
    //        Shared.ShowErrorDialog(this, ex);
    //        return;
    //    }

    //    _dal = new GeneralDAL();
    //    _ht = new Hashtable();


    //    try
    //    {
    //        Shared.ApplyDefaultProp(_ht);
    //        _ht["p_quotation_review_date"] = _ht["p_cre_date"];
    //        _ht["p_exp_date"] = _ht["p_cre_date"];
    //        _ht["p_branch_code"] = ddlBranch.SelectedValue;
    //        _ht["p_division_code"] = Shared.CurrentEmployeeDivCode;
    //        _ht["p_departement_code"] = Shared.CurrentEmployeeDeptCodeDefault;
    //        _ht["p_units_code"] = Shared.CurrentEmployeeUnitsCode;
    //        _ht["p_item_group"] =  "";
    //        _ht["p_sub_department_code"] = "";
    //        _ht["p_remarks"] = "";
    //        _ht["p_flag_document"] = "QW";


    //        _dal.Insert("PURCHASE_QUOTATION_REVIEW_HEADER", _ht, ref _pqrcode);

    //        _ht.Clear();

    //        foreach (GridViewRow row in gvwList.Rows)
    //        {

    //            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //            if (chb.Checked)
    //            {
    //                _ht["p_pr_code"] = gvwList.DataKeys[row.RowIndex][0].ToString();
    //                _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
    //                _ht["p_pqr_code"] = _pqrcode;

    //                Shared.ApplyDefaultProp(_ht);

    //                _dal.ExecRawSP("xsp_item_quotation_selection_review_quotation_generate", _ht);
    //            }
    //        }

    //        Shared.ShowSuccessGritter(this, string.Format("itemquotationselectionlist.aspx"));
    //        BindData();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    private void ProcessData()
    {
      
        string PQNo = "";
        int flag = 0;
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)gvwList.Rows[row.RowIndex].Cells[1].Controls[1];
            if (chb.Checked)
            {
                if (flag == 0)
                    PQNo = gvwList.DataKeys[row.RowIndex][0].ToString();
                else
                    PQNo += ";" + gvwList.DataKeys[row.RowIndex][0].ToString();
                flag = 1;
            }
        }

        if (flag == 1)
        {
            GeneralDAL _dal = null;
            Hashtable _ht = null;

            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            try
            {
                foreach (GridViewRow row in gvwList.Rows)
                {

                    CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                    if (chb.Checked)
                    {

                        _ht["p_pr_code"] = gvwList.DataKeys[row.RowIndex][0].ToString(); ;
                        _ht["p_item_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                        //_ht["p_pqr_code"] = gvwList.DataKeys[row.RowIndex][2].ToString();

                        Shared.ApplyDefaultProp(_ht);

                        _dal.ExecRawSP("xsp_item_quotation_selection_review_quotation_generate", _ht);
                    }
                }

                Shared.ShowSuccessGritter(this, string.Format("itemquotationselectionlist.aspx"));
                BindData();
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
        }
        else
        {
            Shared.ShowErrorDialog(this, null);
        }
        BindData();
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
    }
    private void UnPostData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //

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
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {

                    _ht["p_pr_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                    _ht["p_id"] = gvwList.DataKeys[row.RowIndex][2].ToString();
                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_purchase_request_detail_delete_for_quotation_selection", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("itemquotationselectionlist.aspx"));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnUnPost_Click(object sender, EventArgs e)
    {
        UnPostData();
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
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
    //(+) Ari 11-07-2022 ket : enhancement 2022
    //protected void txtFromDate_TextChanged(object sender, EventArgs e)
    //{
    //    BindData();
    //}
    protected void txtToDateChanged(object sender, EventArgs e)
    {

        BindData();
    }
    protected void ddlOwner_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
