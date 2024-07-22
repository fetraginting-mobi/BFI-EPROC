using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;
public partial class module_inventory_documentreceiptdetail : BasePage
{

    private static string TABLE_NAME_DETAIL = "DOCUMENT_RECEIPT_DETAIL";

    string sfullname = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        if (!Page.IsPostBack)
        {
            btnLookUpUserRequest.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=STALL&acol_0={0}&bcol_1={1}');", txtDocumentPIC.ClientID, lblSupplierName.ClientID);
            lblTrxCode.Text = Request.Params["codebarcode"];
            //btnReceiveLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFR&acol_0={0}&bcol_1={1}');", txtReceiveLocation.ClientID, lblReceiveLocation.ClientID);
           // btnMovedLocation.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=MLGFR&acol_0={0}&bcol_1={1}');", txtMovedLocation.ClientID, lblMovedLocation.ClientID);
            Shared.BindGeneralSubCode(ddlReceiveLocation, "DOCL");
            
            Shared.BindGeneralSubCode(ddlDocumentCategory,"DOCCAT");
           
     
            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;

                if (!lblIEStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    txtDocumentName.Enabled = false;
                    txtDocumentPIC.Enabled = false;
                    ddlReceiveLocation.Enabled = false;
                    txtRemarks.Enabled = false;
                    ddlDocumentCategory.Enabled = false;
                    txtDocumentNo.Enabled = false;
                    fupFilename.Enabled = false;
                    txtShipperName.Enabled = false;
                    btnLookUpUserRequest.Enabled = false;
                    ddlType.Enabled = false;
                    ddlRating.Enabled = false;
                }
            }
            else
            {
                
            }

            btnPreviewDoc.Attributes["onclick"] = String.Format("javascript:window.open('../../" + lblPATH.Text + "', 'viewer', 'fullscreen=0, status=0, menubar=0, scrollbars=0, resizeable=1, toolbar=0, width=600, height=400');");

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
        int iNextID = 0;
        string sFileDirectorys;
        FileUpload fupFile;
        string lblFileName;
        string sFileName;
        String sFilePath;
        sFilePath = string.Empty;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();


            sFileDirectorys = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/" + Request.Params["codebarcode"]));

            if (fupFilename.HasFile)
            {
                sfullname = System.IO.Path.GetFileName(fupFilename.FileName);

                sFilePath = Shared.GetUploadPath("ADD_DOCUMENT/" + Request.Params["codebarcode"]) + sfullname;

            }


            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_file"] = sfullname;
            _ht["p_paths"] = sFilePath;
            Shared.ApplyDefaultProp(_ht);


            if (Request.Params["action"].Equals("add"))
            {
                //if (!fupFilename.HasFile)
                //{
                //    throw new Exception("Please insert file image!");
                //}

                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();

            }
            
                _dal.Update(TABLE_NAME_DETAIL, _ht);

            if (!System.IO.Directory.Exists(sFileDirectorys))
                System.IO.Directory.CreateDirectory(sFileDirectorys);

            if (fupFilename.HasFile)
            {
                if (!System.IO.File.Exists(sFileDirectorys + sfullname))
                    fupFilename.SaveAs(sFileDirectorys + sfullname);
            }

            Shared.ShowSuccessGritter(this, string.Format("documentreceiptdetail.aspx?action=edit&id={0}&codebarcode={1}", lblID.Text, lblTrxCode.Text));
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("documentreceiptheader.aspx?action=edit&codebarcode=" + lblTrxCode.Text);
    }  
}
