<%@ WebHandler Language="C#" Class="purchasebytype" %>

using System;
using System.Text;
using System.Collections;
using System.Data;
using System.Web;

using iProc.DataAccessLayer;

public class purchasebytype : IHttpHandler {
    
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

            DataTable dt = dal.GetRows("", "xsp_purchase_by_type", ht);

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
                //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "FA Asset", 312);
                //sb.Append("},");
                //sb.Append("{");
                //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Inventory", 400);
                //sb.Append("},");
                //sb.Append("{");
                //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Inventory Consumtive", 78);
                //sb.Append("},");
                //sb.Append("{");
                //sb.AppendFormat("\"name\": \"{0}\", \"y\": {1}", "Expense", 100);
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