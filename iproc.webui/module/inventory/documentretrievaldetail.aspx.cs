using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_inventory_documentretrievaldetail : BasePage
{
   

    private static string TABLE_NAME_DETAIL = "DOCUMENT_RETRIEVAL_DETAIL";

    string sfullname = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        if (!Page.IsPostBack)
        {
            lblIICode.Text = Request.Params["codebarcode"];
            //btnReceiveLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFR&acol_0={0}&bcol_1={1}');", txtReceiveLocation.ClientID, lblReceiveLocation.ClientID);
           // btnMovedLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFR&acol_0={0}&bcol_1={1}');", txtMovedLocation.ClientID, lblMovedLocation.ClientID);
        
            
        
           
     
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
              
            }
           

        }
        LoadAfterInit();
    }

 
    private void LoadData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_id"] = Request.Params["id"];
            DataRow _dr = _dal.GetRow(TABLE_NAME_DETAIL, _ht);

            DBToUI.Map(this.Controls, _dr);
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void SaveData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
      
            if (Request.Params["action"].Equals("add"))
            {
                _dal.Update(TABLE_NAME_DETAIL, _ht);
            }


            Shared.ShowSuccessGritter(this, string.Format("documentretrievaldetail.aspx?action=edit&id={0}&codebarcode={1}", Request.Params["codebarcode"]));
       
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("documentretrievalheader.aspx?action=edit&codebarcode=" + Request.Params["codebarcode"]);
    }  

}
