<%@ WebHandler Language="C#" Class="purchasebyquarter" %>

using System;
using System.Text;
using System.Collections;
using System.Data;
using System.Web;

using iProc.DataAccessLayer;

public class purchasebyquarter : IHttpHandler {
    
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
        StringBuilder sb = null;


        try
        {
            dal = new GeneralDAL();
            ht = new Hashtable();
            sb = new StringBuilder();


            sb.Append("[");


            ht["p_year"] = DateTime.Now.Year;

            DataTable dt = dal.GetRows("", "xsp_purchase_by_quarter", ht);

            for (int i = 0; i < dt.Rows.Count; i++)
            {

                sb.Append("{");
                sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", dt.Rows[i].ItemArray[0].ToString(), dt.Rows[i].ItemArray[1]);
                if (i == (dt.Rows.Count - 1))
                    sb.Append("}");
                else
                    sb.Append("},");
            }
            
            //foreach (DataRow dr in dt.Rows)
            //{
            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Q1", 133);
            //sb.Append("},");
            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Q2", 121);
            //sb.Append("},");
            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Q3", 121);
            //sb.Append("},");
            //sb.Append("{");
            //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Q4", 140);
            //sb.Append("}");
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