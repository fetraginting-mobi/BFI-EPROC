<%@ WebHandler Language="C#" Class="purchasebymonth" %>

using System;
using System.Text;
using System.Collections;
using System.Data;
using System.Web;

using iProc.DataAccessLayer;

public class purchasebymonth : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Write(GetData());
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


    public string GetData()
    {
        GeneralDAL dal = null;
        Hashtable ht = null;
        StringBuilder sb = null;
    
        try
        {
            dal = new GeneralDAL();
            ht = new Hashtable();
            sb = new StringBuilder();


            sb.Append("[");

         


            ht["p_year"] = DateTime.Now.Year;

            DataTable dt = dal.GetRows("", "xsp_purchase_by_month", ht);

            for (int i = 0; i < dt.Rows.Count; i++)
            {

                sb.Append("{");
                sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", dt.Rows[i].ItemArray[0].ToString(), dt.Rows[i].ItemArray[1]);
                if (i == (dt.Rows.Count - 1))
                    sb.Append("}");
                else
                    sb.Append("},");
            }




            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Jan", 65);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Feb", 23);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Mar", 45);
            //sb.Append("},");


            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Apr", 22);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "May", 38);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Jun", 61);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Jul", 32);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Aug", 35);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Sep", 54);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Oct", 49);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Nov", 21);
            //sb.Append("},");

            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Dec", 70);
            //sb.Append("}");
 
            sb.Append("]");
        }
        catch (Exception)
        {
            sb = new StringBuilder("[{\"data\":[]}]");
        }

        return sb.ToString();
    }

}
