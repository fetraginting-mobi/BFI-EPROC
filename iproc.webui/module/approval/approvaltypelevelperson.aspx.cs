using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_approval_approvaltypelevelperson : BasePage
{
    private static string TABLE_NAME = "APPROVAL_TYPE_LEVEL_PERSON";
    private static string CODE = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        CODE = Request.Params["code"];

        LoadInit();
        if (!Page.IsPostBack)
        {
            lblLevelID.Text = Request.Params["levelid"];

            btnLookUpUID.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=STAFF&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtUIDCode.ClientID, lblUIDCode.ClientID, lblUIDName.ClientID);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                btnCancel.Text = "Back";
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

            _ht["p_id"] = Request.Params["id"];
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

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("approvaltypelevelperson.aspx?action=edit&id={0}&levelid={1}&code={2}", lblID.Text, lblLevelID.Text, CODE));
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
        Response.Redirect("approvaltypelevel.aspx?action=edit&id=" + lblLevelID.Text + "&code=" + CODE);
    }
}

