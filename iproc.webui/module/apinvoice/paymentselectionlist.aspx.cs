using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_apinvoice_paymentselectionlist : BasePageList
{
    //private static string TABLE_NAME = "AP_INVOICE_REGISTRATION_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "AP_INVOICE_REGISTRATION_HEADER";
        NEXT_PAGE = "paymentselectionlist.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();

        if (!Page.IsPostBack)
        {
            //Shared.BindBranchEmployee(ddlBranch);
            //Kenny 12/06/2018 Filter Branch
            Shared.BindBranchEmployeeSort(ddlBranch);
            Shared.BindOwnerAll(ddlOwner);

            //(+) Ari 11-07-2022 ket : enhancement 2022
            ddlBranch.Items.Insert(0, "ALL");
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

            _ht["p_keywords"] = txtSelection.Text;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            //(+) Ari 11-07-2022 ket : enhancement 2022
            _ht["p_from_date"] = Shared.ToStartDateTime(txtFromDate.Text);
            _ht["p_to_date"] = Shared.ToStartDateTime(txtToDate.Text);
            _ht["p_emp_code"] = Shared.CurrentUID;
            _ht["p_owner"] = ddlOwner.SelectedValue;

            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("", "xsp_payment_selection_getrows", _ht);
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

    private void ProcessData()
    {
        
        //string InvoiceNo = "";
        //int flag = 0;
        //foreach (GridViewRow row in gvwList.Rows)
        //{
        //    CheckBox chb = (CheckBox)gvwList.Rows[row.RowIndex].Cells[1].Controls[1];
        //    if (chb.Checked)
        //    {
        //        if (flag == 0)
        //            InvoiceNo = gvwList.DataKeys[row.RowIndex][0].ToString();
        //        else
        //            InvoiceNo += ";" + gvwList.DataKeys[row.RowIndex][0].ToString();
        //        flag = 1;
        //    }
        //}
        // if (flag == 1)
        //{
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


            try
            {
                foreach (GridViewRow row in gvwList.Rows)
                {

                    CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                    if (chb.Checked)
                    {
                        _ht["p_supplier_code"] = gvwList.DataKeys[row.RowIndex][1].ToString();
                        _ht["p_invoice_no_batch"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                        Shared.ApplyDefaultProp(_ht);

                        _dal.ExecRawSP("xsp_payment_selection_generate", _ht);
                    }
                }

                Shared.ShowSuccessGritter(this, string.Format("paymentselectionlist.aspx"));
                BindData();
            }
            catch (Exception ex)
            {
                Shared.ShowErrorDialog(this, ex);
            }
        //}
        // else
        // {
        //     Shared.ShowErrorDialog(this, null);
        // }
         BindData();
    }


    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
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
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
    //(+) Ari 11-07-2022 ket : enhancement 2022
    protected void txtToDateChanged(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ddlOwner_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
