using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class widget_wcquicksendemail : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            lblEmpCode.Text = Shared.CurrentUID;
    }

    public void btnSend_Click(object sender, EventArgs e)
    {
        //EmailValidation();

        SendEmail();
    }
    
    private void SendEmail() 
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            _dal.ExecRawSP("xsp_widget_process_quick_send_email", _ht);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this.Page, ex);
        }
    }

}
