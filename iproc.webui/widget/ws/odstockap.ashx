<%@ WebHandler Language="C#" Class="odstockap" %>

using System;
using System.Text;
using System.Collections;
using System.Data;
using System.Web;

using iProc.DataAccessLayer;

public class odstockap : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write(GetData());
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    public string GetData()
    {
        GeneralDAL dal = null;
        Hashtable ht = null;
        //DataTable dt = null;
        StringBuilder sb = null;

        //int i = 0;

        try
        {
            dal = new GeneralDAL();
            ht = new Hashtable();
            sb = new StringBuilder();


            sb.Append("[");


            //foreach (DataRow dr in dt.Rows)
            //{
            sb.Append("{");
            sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "<= 15", 11);
            sb.Append("},");
            sb.Append("{");
            sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "16 - 30", 19);
            sb.Append("},");
            sb.Append("{");
            sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "31 - 60", 9);
            sb.Append("},");
            sb.Append("{");
            sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "61 - 90", 8);
            sb.Append("},");
            sb.Append("{");
            sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "> 90", 5);
            sb.Append("}");
            //i++;

            //if (i != dt.Rows.Count)
            //    sb.AppendFormat(",");
            //}


            sb.Append("]");
        }
        catch (Exception)
        {
            sb = new StringBuilder("[{\"data\":[]}]");
        }

        return sb.ToString();
    }

}