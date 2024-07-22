using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for BasePageList
/// </summary>
public class BasePageList : BasePage
{
    public BasePageList()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    protected override void OnLoad(EventArgs e)
    {
        if (Session[SessionKey.CURRENT_PAGE_LIST_SESSION_KEY] != null && Session[SessionKey.CURRENT_SEARCH_KEYWORD_SESSION_KEY] != null && Session[SessionKey.CURRENT_PAGE_INDEX_SESSION_KEY] != null)
        {
            if (Session[SessionKey.CURRENT_PAGE_LIST_SESSION_KEY].ToString().Equals(PAGE_LIST))
            {
                if (NEXT_PAGE == Request.UrlReferrer.Segments[Request.UrlReferrer.Segments.Length - 1])
                {
                    InputSearch = (TextBox)Shared.FindControlRecursive(this, "txtSearch");
                    if (InputSearch != null)
                        InputSearch.Text = Session[SessionKey.CURRENT_SEARCH_KEYWORD_SESSION_KEY].ToString();

                    GridViewList = (GridView)Shared.FindControlRecursive(this, "gvwList");
                    if (GridViewList != null)
                    {
                        try
                        {
                            GridViewList.PageIndex = (int)Session[SessionKey.CURRENT_PAGE_INDEX_SESSION_KEY];
                        }
                        catch (Exception) { }
                    }
                }
            }
        }

        base.OnLoad(e);
    }
  

    protected virtual void SelectedIndexChanged(object sender, EventArgs e)
    {
        InputSearch = (TextBox)Shared.FindControlRecursive(this, "txtSearch");
        GridViewList = (GridView)Shared.FindControlRecursive(this, "gvwList");

        if (InputSearch != null)
            Session[SessionKey.CURRENT_SEARCH_KEYWORD_SESSION_KEY] = InputSearch.Text;

        if (GridViewList != null)
            Session[SessionKey.CURRENT_PAGE_INDEX_SESSION_KEY] = GridViewList.PageIndex;

        Session[SessionKey.CURRENT_PAGE_LIST_SESSION_KEY] = PAGE_LIST;
    }

    
}
