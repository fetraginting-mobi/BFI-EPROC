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
using System.Collections.Generic;

public partial class module_inventory_inventorymutationpostsummary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            List<PostMutationResult> results =
                Session[SessionKey.POST_MUTATION_RESULTS]
                    as List<PostMutationResult>;

            if (results != null)
            {
                gvSummary.DataSource = results;
                gvSummary.DataBind();
            }
        }
    }

    private void BindSummary()
    {
        ArrayList results =
            Session[SessionKey.POST_MUTATION_RESULTS] as ArrayList;

        if (results != null)
        {
            gvSummary.DataSource = results;
            gvSummary.DataBind();
        }
        else
        {
            gvSummary.DataSource = null;
            gvSummary.DataBind();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        // kembali ke list
        Response.Redirect("inventorymutationheaderlist.aspx");
    }
}
