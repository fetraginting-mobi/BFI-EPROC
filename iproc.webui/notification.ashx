<%@ WebHandler Language="C#" Class="notification" %>

using System;
using System.Web;
using System.Data;
using System.Collections;

using iProc.DataAccessLayer;

public class notification : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write(GetNotification());
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    private string GetNotification()
    {
        string sMsg = "";
        int iCountMsg = 0;
        int iCountRowMsg = 0;

        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_uid"] = Shared.CurrentUID;
            _ht["p_keywords"] = "";
            _ht["p_is_top_ten"] = "1";

            DataTable dtMsg = _dal.GetRows("", "xsp_user_notification_subscription_getrows", _ht);

            if (dtMsg == null || dtMsg.Rows.Count == 0)
                iCountMsg = 0;
            else
                iCountMsg = (int)dtMsg.Rows[0]["total_new_message"];

            sMsg += "<li id=\"header_notification_bar\" class=\"dropdown\">";

            if (iCountMsg == 0)
                sMsg += "<a data-toggle=\"dropdown\" class=\"dropdown-toggle\" href=\"#\"><i class=\"icon-bell-alt\"></i></a>";
            else
                sMsg += "<a data-toggle=\"dropdown\" class=\"dropdown-toggle\" href=\"#\"><i class=\"icon-bell-alt\"></i><span class=\"badge bg-important\">" + iCountMsg.ToString() + "</span></a>";

            sMsg += "<ul class=\"dropdown-menu extended inbox\"><div class=\"notify-arrow notify-arrow-red\"></div>";


            sMsg += "<li><p class=\"red\">You have " + iCountMsg.ToString() + " new notifications</p></li>";


            foreach (DataRow drMsg in dtMsg.Rows)
            {
                if (iCountRowMsg < 5)
                {
                    if (drMsg["is_read"].ToString() == "0")
                        sMsg += "<li><a href=\"#\" style=\"white-space:inherit\"><span class=\"subject\"><span class=\"from\"> " + drMsg["notifi_message"].ToString() + "</span><span class=\"message\">" + ((DateTime)drMsg["log_date"]).ToString("dd/MM/yyyy HH:mm:ss") + "</span></a></li>";
                    else
                        sMsg += "<li><a href=\"#\" style=\"white-space:inherit\"><span class=\"subject\"><span class=\"from-unread\"> " + drMsg["notifi_message"].ToString() + "</span><span class=\"message\">" + ((DateTime)drMsg["log_date"]).ToString("dd/MM/yyyy HH:mm:ss") + "</span></a></li>";

                    iCountRowMsg += 1;
                }
            }

            sMsg += "<li><a href=\"module/shared/notification.aspx\" target=\"ifr\">See all notifications</a></li>";

            sMsg += "</ul></li>";
        }
        catch (Exception ex)
        {
        }

        return sMsg;
    }

}