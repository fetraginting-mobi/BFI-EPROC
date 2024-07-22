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

public partial class module_accounting_eodmanual : BasePageList
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            btnProcess.OnClientClick = "return confirm('Are you sure to click this button ?');";
            txtDate.Text = DateTime.Today.ToString("dd/MM/yyyy");
        }
    }

    private void ProcessData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        try
        {
           

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _ht["p_eod_date"] = txtDate.Text;
            _ht["p_eom_date"] = txtDate.Text;

            if (rbType.SelectedValue.Equals("EOD"))
            {
                _dal.ExecRawSP("xsp_eod", _ht);
            }
            else
            {
                _dal.ExecRawSP("xsp_eom", _ht);
            }
           
            Shared.ShowSuccessGritter(this, string.Format("eodmanual.aspx"));

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }


    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
    }
}
