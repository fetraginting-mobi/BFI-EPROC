using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SessionKey
/// </summary>
public class SessionKey
{
    public SessionKey()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string CURRENT_USER_SESSION_KEY
    {
        get { return "SessionUserProfile"; }
    }

    public static string CURRENT_USER_ROLE_SESSION_KEY
    {
        get { return "SessionUserRole"; }
    }

    public static string CURRENT_USER_IP_ADDRESS_SESSION_KEY
    {
        get { return "SessionUserIPAddress"; }
    }

    public static string CURRENT_USER_BRANCH_CODE
    {
        get { return "SessionUserBranchCode"; }
    }

    public static string CURRENT_USER_BRANCH_DESC
    {
        get { return "SessionUserBranchDesc"; }
    }

    public static string CURRENT_SEARCH_KEYWORD_SESSION_KEY
    {
        get { return "SessionSearchKeyword"; }
    }

    public static string CURRENT_PAGE_INDEX_SESSION_KEY
    {
        get { return "SessionPageIndex"; }
    }

    public static string CURRENT_PAGE_LIST_SESSION_KEY
    {
        get { return "SessionPageList"; }
    }

    public static string CURRENT_USER_APP_CODE
    {
        get { return "SessionUserAppCode"; }
    }

    public static string CURRENT_USER_APP_DESC
    {
        get { return "SessionUserAppDesc"; }
    }
    public static string CURRENT_TAB_INDEX_SESSION_KEY
    {
        get { return "SessionTabIndex"; }
    }
    public static string CURRENT_USER_DEPT_CODE
    {
        get { return "SessionUserDeptCode"; }
    }
    public static string CURRENT_USER_DEPT_DESC
    {
        get { return "SessionUserDeptDesc"; }
    }

    public static string CURRENT_USER_DIV_CODE
    {
        get { return "SessionUserDivCode"; }
    }
    public static string CURRENT_USER_DIV_DESC
    {
        get { return "SessionUserDivDesc"; }
    }

    public static string CURRENT_NEXT_URL_SESSION_KEY
    {
        get { return "SessionNextURL"; }
    }

    public static string CURRENT_EXT_USER_SESSION_KEY
    {
        get { return "SessionExtUserProfile"; }
    }

    public const string POST_MUTATION_RESULTS = "POST_MUTATION_RESULTS";
    public const string POST_MUTATION_LIST = "POST_MUTATION_LIST";    
    public const string POST_MUTATION_FA_RESULTS = "POST_FA_MUTATION_RESULTS";
    public const string POST_MUTATION_FA_LIST = "POST_FA_MUTATION_LIST";
}
