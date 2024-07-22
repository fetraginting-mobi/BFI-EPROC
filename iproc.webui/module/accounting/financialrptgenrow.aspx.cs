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

public partial class module_accounting_financialrptgenrow : BasePage
{
    private static string TABLE_NAME = "SYS_MASTER_REPORT_FINANCIAL_ROW";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        btnLookUpDefaultRC.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}&dcol_1={3}');", txtRelationCode.ClientID, lblRelationCode.ClientID, txtDescription.ClientID, lblDesc.ClientID);

        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                //BindDataDetail();
                btnCancel.Text = "Back";
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                //btnDelete.OnClientClick = "return confirm('Delete selected data?');";
                //txtCode.Enabled = false;
            }
            //else
            //{
            //    btnAdd.Visible = btnDelete.Visible = false;
            //}
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

            _ht["p_id"] = Request.Params["id"];
            //_ht["p_bi_code"] = Request.Params["bicode"];
            //_ht["p_acc_no"] = Request.Params["accno"];

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

            _ht["p_fmt_desc"] = txtDescription.Text;
            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            //_ht["p_id"] = lblID.Text;
            _ht["p_id"] = lblRowID.Text;
            _ht["p_row_no"] = txtRptNo.Text;
            _ht["p_report_code"] = Request.Params["reportcode"];
            _ht["p_fmt_desc"] = txtDescription.Text;
            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblRowID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);


            Shared.ShowSuccessGritter(this, string.Format("financialrptgenrow.aspx?action=edit&reportcode={0}&id={1}", Request.Params["reportcode"], lblRowID.Text));
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
        Response.Redirect(String.Format("financialrptgen.aspx?action=edit&code={0}", Request.Params["reportcode"]));
    }

}
