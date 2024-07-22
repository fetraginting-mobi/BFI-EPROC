
using CrystalDecisions.ReportSource;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;


public class CustomHttpHandler : IHttpHandler, IRequiresSessionState
{ 
    //private HttpSessionState _session;
    BasePage basePage = new BasePage();
    Hashtable _ht = new Hashtable();

    public void ProcessRequest(HttpContext context)
    {
        //System.Diagnostics.Debugger.Break();
        HttpRequest request = context.Request;
        HttpResponse response = context.Response;

        string fileURL;
        string appPath;
        string fileName;
        string fileRawURL;
        string RequestedPage = context.Request.Url.Segments[2].ToLower();

        

        if (context.Session.Count == 0)
        {
            response.StatusCode = 401;
            response.Write("<html>\r\n");
            response.Write("<head><title>Access Denied</title></head>\r\n");
            response.Write("<body>\r\n");
            response.Write("<h1>Access Denied</h1>\r\n");
            response.Write("</body>\r\n");
            response.Write("</html>");
        }
        else
        {
            if (RequestedPage == "temp/" || RequestedPage == "file/")
            {
                appPath = request.PhysicalPath;
                //appPath = request.PhysicalApplicationPath;
                fileRawURL = request.RawUrl.Substring(1);
                fileRawURL = fileRawURL.Replace("/", "\\");
                //fileName = context.Request.Url.Segments[context.Request.Url.Segments.Count() - 1];

                //byte[] fileBytes = File.ReadAllBytes(appPath + "\\" + fileName);
                //byte[] fileBytes = File.ReadAllBytes(appPath + fileRawURL);
                byte[] fileBytes = File.ReadAllBytes(appPath);

                try
                {
                    context.Response.ContentType = "application/" + Path.GetExtension(fileRawURL).ToLower();
                    context.Response.AddHeader("Accept-Range", "bytes");
                    context.Response.BinaryWrite(fileBytes);
                }
                catch (Exception ex)
                {
                    response.StatusCode = 500;
                    response.Write("<html>\r\n");
                    response.Write("<head><title>INTERNAL SERVER ERROR</title></head>\r\n");
                    response.Write("<body>\r\n");
                    response.Write("<h1>INTERNAL SERVER ERROR</h1>\r\n");
                    response.Write("<h1>" + ex + "</h1>\r\n");
                    response.Write("</body>\r\n");
                    response.Write("</html>");
                }

                //Shared.PreviewReport(this, appPath + fileRawURL);
            }
            //else if (RequestedPage == "file/")
            //{
            //    appPath = request.PhysicalApplicationPath;
            //    fileRawURL = request.RawUrl.Substring(1);
            //    fileRawURL = fileRawURL.Replace("/", "\\");
            //    byte[] fileBytes = File.ReadAllBytes(appPath + fileRawURL);

            //    context.Response.ContentType = "application/" + Path.GetExtension(fileRawURL).ToLower();
            //    context.Response.AddHeader("Accept-Range","bytes");
            //    context.Response.BinaryWrite(fileBytes);


            //}
        }
    }
    public bool IsReusable
    {
        get { return false; }
    }
}