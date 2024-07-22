using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

using iProc.DataAccessLayer;


public partial class lookup_genericwithparameter : System.Web.UI.Page
{
    private static string SPNAME = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindData();
        }
    }

    private void BindData()
    {
        
        Shared.BindLookUp(gvwList, Request.Params["code"], ref SPNAME);
        BindDataWithParam();
    }

    private void BindDataWithParam()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_user_id"] = Shared.CurrentUID;

            for (int i = 0; i < Request.Params.Count; i++)
            {
                if (Request.Params.AllKeys[i] != null)
                {
                    if (Request.Params.AllKeys[i].StartsWith("par_"))
                    {
                        string par = Request.Params.AllKeys[i].Substring(4);

                        _ht["p_" + par] = Request.Params[i];
                    }
                    else if (Request.Params.AllKeys[i].StartsWith("parc_"))
                    {
                        string par = Request.Params.AllKeys[i].Substring(5);

                        _ht["p_" + par] = Request.Params[i];

                    }
                }
            }
          
            gvwList.DataSource = _dal.GetRows("", SPNAME, _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataWithParam();
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        string script = Shared.GenerateLookUpClearString(ClientQueryString);
        ScriptManager.RegisterStartupScript(this, GetType(), "fn2", script, true);
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        //
        string script = Shared.GenerateLookUpReturnString(ClientQueryString, gvwList);
        ScriptManager.RegisterStartupScript(this, GetType(), "fn2", script, true);
    }

    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }
}
