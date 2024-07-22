using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_accounting_accountingclosingprocess : BasePageList
{
    protected void Page_Init(object sender, EventArgs e)
    {

    }

    private string sPeriod = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            //Shared.BindFundingBank(ddlBank);
            txtDate.Text = DateTime.Today.ToString("dd/MM/yyyy");

            btnProcess.OnClientClick = "return confirm('Closing current accounting period ?');";

            BindData();
        }
    }

    private void BindData()
    {
        //
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;

            DataRow _dr = _dal.GetRow("SYS_BRANCH_ACC_FIRST_PERIOD", _ht);

            txtperiod.Text = _dr["acc_period"].ToString();
            //txtperiod.Text = "201511";
            sPeriod = txtperiod.Text.Substring(4, 2);

            if (sPeriod != "12")
            {
                rdRvProcess.Equals('1');
                rdRvProcess.Enabled = false;
            }

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void btnProcess_Click(object sender, EventArgs e)
    {
        //
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            //MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_branch_code"] = Shared.CurrentEmployeeBranchCode;
            _ht["p_date"] = Shared.ToDateTime(txtDate.Text);
            _ht["p_flag"] = "N";
            Shared.ApplyDefaultProp(_ht);

            if (rdRvProcess.SelectedValue.ToString().Equals("1"))
            {
                _dal.ExecRawSP("xsp_acc_close_month", _ht);
            }
            else
            {
                _dal.ExecRawSP("xsp_acc_close_year", _ht);
            }
            Shared.ShowSuccessGritter(this, string.Format("accountingclosingprocess.aspx"));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }

        BindData();
    }
}

