using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_commonmst_masteremailnotification : BasePage
{
    private static string TABLE_NAME = "MASTER_EMAIL_NOTIFICATION";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {

                LoadData();
                btnCancel.Text = "Back";

                txtCode.Enabled = false;

                if (ddlFlag1.SelectedValue != "E" || ddlFlag2.SelectedValue != "E" || ddlFlag3.SelectedValue != "E" || ddlFlag4.SelectedValue != "E" || ddlFlag5.SelectedValue != "E")
                {
                    revEmail1.Visible = false;
                }
                else
                {
                    revEmail1.Visible = true;
                }
            }
        }
        LoadAfterInit();
    }

    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = Request.Params["code"];
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

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
                _dal.Insert(TABLE_NAME, _ht);

            else
                _dal.Update(TABLE_NAME, _ht);


            Shared.ShowSuccessGritter(this, string.Format("masteremailnotification.aspx?action=edit&code={0}", txtCode.Text));
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
        Response.Redirect(String.Format("masteremailnotificationlist.aspx"));
    }

    protected void ddlFlag1_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFlag1.SelectedValue != "E")
        {
            revEmail1.Visible = false;
        }
        else
        {
            revEmail1.Visible = true;
        }
    }

    protected void ddlFlag2_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFlag2.SelectedValue != "E")
        {
            revEmail2.Visible = false;
        }
        else
        {
            revEmail2.Visible = true;
        }
    }

    protected void ddlFlag3_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFlag3.SelectedValue != "E")
        {
            revEmail3.Visible = false;
        }
        else
        {
            revEmail3.Visible = true;
        }
    }

    protected void ddlFlag4_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFlag4.SelectedValue != "E")
        {
            revEmail4.Visible = false;
        }
        else
        {
            revEmail4.Visible = true;
        }
    }

    protected void ddlFlag5_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFlag5.SelectedValue != "E")
        {
            revEmail5.Visible = false;
        }
        else
        {
            revEmail5.Visible = true;
        }
    }

}
