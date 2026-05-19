using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
/// Summary description for PostMutationResult
/// </summary>
/// 
[Serializable]
public class PostMutationResult
{
    public string CodeBarcode;
    public bool IsSuccess;
    public string Message;
}
