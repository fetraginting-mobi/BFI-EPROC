using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Text;
using System.Web;

public class TokenService
{
    public static string GetToken(string code)
    {
        string tokenUrl =
            ConfigurationManager.AppSettings["KC_BASE_URL"] +
            "/realms/" +
            ConfigurationManager.AppSettings["KC_REALM"] +
            "/protocol/openid-connect/token";

        string postData =
            "grant_type=authorization_code" +
            "&code=" + HttpUtility.UrlEncode(code) +
            "&client_id=" + HttpUtility.UrlEncode(ConfigurationManager.AppSettings["KC_CLIENT_ID"]) +
            "&client_secret=" + HttpUtility.UrlEncode(ConfigurationManager.AppSettings["KC_CLIENT_SECRET"]) +
            "&redirect_uri=" + HttpUtility.UrlEncode(ConfigurationManager.AppSettings["KC_REDIRECT_URI"]);

        HttpWebRequest req = (HttpWebRequest)WebRequest.Create(tokenUrl);
        req.Method = "POST";
        req.ContentType = "application/x-www-form-urlencoded";

        byte[] bytes = Encoding.UTF8.GetBytes(postData);
        req.ContentLength = bytes.Length;

        using (Stream s = req.GetRequestStream())
        {
            s.Write(bytes, 0, bytes.Length);
        }

        using (HttpWebResponse resp = (HttpWebResponse)req.GetResponse())
        using (StreamReader sr = new StreamReader(resp.GetResponseStream()))
        {
            return sr.ReadToEnd();
        }
    }
}
