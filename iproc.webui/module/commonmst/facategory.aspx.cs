using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_facategory : BasePage
{
    private static string TABLE_NAME = "FA_CATEGORY";

    protected void Page_Load(object sender, EventArgs e)
    {
        btnLookUpAccPL.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAccPL.ClientID, lblNameAccPL.ClientID, lblNameAccPL.ClientID);
        btnLookUpAccDepre.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAccDepre.ClientID, lblAccDepre.ClientID, lblNameAccDepre.ClientID);
        btnLookUpAkumulasi.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=ACCHT&acol_0={0}&bcol_0={1}&ccol_1={2}');", txtAkul.ClientID, lblAkul.ClientID, lblAkumulasi.ClientID);
       
        LoadInit();
        if (!Page.IsPostBack)
        {
            txtTotalValue.Enabled = false;
            txtTotalAsset.Enabled = false;
            txtLastCal.Enabled = false;
            txtTotalDepre.Enabled = false;
            Shared.BindAsset(ddlAssetType);

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblCategoryID.Enabled = false;
                txtCategoryCode.Enabled = false;
                //btnCancel.Text = "Back";
              

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

            _ht["p_fa_categoryid"] = Request.Params["facategoryid"];
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
        //System.Diagnostics.Debugger.Break();
        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref iNextID);
                lblCategoryID.Text = iNextID.ToString();
            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("facategory.aspx?action=edit&facategoryid={0}", lblCategoryID.Text));
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
        Response.Redirect("facategorylist.aspx");
    }

}
