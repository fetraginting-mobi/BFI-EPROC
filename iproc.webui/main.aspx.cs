using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class main : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
    }

}
