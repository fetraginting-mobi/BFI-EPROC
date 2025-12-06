using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_purchaseorder_purchasequotationdocumentdetail : BasePage
{
    private static string TABLE_NAME = "PURCHASE_QUOTATION_DOCUMENT_DETAIL";

    string sfullname = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            lblCode.Text = Request.Params["code"];


            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
               
            }
            else if (Request.Params["action"].Equals("add"))
            {
                
            }
        }
        LoadAfterInit();
    }


    private void GetCode()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = Request.Params["code"];
            _ht["p_id"] = Request.Params["id"];
            DataRow _dr = _dal.GetRow("PURCHASE_QUOTATION_HEADER", _ht);

            lblCode.Text = _dr["code"].ToString();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
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
            DataRow _dr = _dal.GetRow(TABLE_NAME, _ht);

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
        int inextid = 0;
        string sFileDirectorys;
        //FileUpload fupFile;
        //string lblFileName;
        //string sFileName;
        String sFilePath;
        sFilePath = string.Empty;
 
        try
        {
           
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            


            sFileDirectorys = Server.MapPath("~/" + Shared.GetUploadPath("ADD_DOCUMENT/" + Request.Params["codebarcode"]));
            string sFileType = System.IO.Path.GetExtension(fupFilename.FileName);  // (+) Ari 13-09-2022 ket : validasi extension

            if (
                            sFileType == ".xls" || sFileType == ".xlsx"     // EXCEL
                            || sFileType == ".doc" || sFileType == ".docx"     // WORD
                            || sFileType == ".jpeg" || sFileType == ".jpg"      // Image
                            || sFileType == ".png" //|| sFileType == ".gif"
                            || sFileType == ".pdf" //|| sFileType == ".csv"      // PDF
                            || sFileType == ".zip" || sFileType == ".rar"      // File
                            || sFileType == ".7z"

                )
            {
                sfullname = System.IO.Path.GetFileName(fupFilename.FileName);

                sFilePath = Shared.GetUploadPath("ADD_DOCUMENT/" + Request.Params["codebarcode"]) + sfullname;
            }
            else
            {
                Shared.ShowValidationError(this, "Please upload file with format type (.pdf .zip .doc .xlx .png .jpg .jpeg). Max file size allowed is 3 mb.");
                return;
            }

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            int fileSize = fupFilename.PostedFile.ContentLength;

            if (fupFilename.PostedFile.ContentLength > 3000000) // (+) Ari 13-09-2022 ket : cek size file Max 3MB.
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "fx", "fnShowErrorNotif('Maximum file size allowed is 3 mb.', '');", true);
                return;
            }

            _ht["p_file"] = sfullname;
            _ht["p_paths"] = sFilePath;
            _ht["p_pq_code"] = Request.Params["codebarcode"];
            _ht["p_general_doc_code"] = txtDocumentName.Text;
            _ht["p_id"] = lblId.Text;
            //_ht["p_id_detail"] = Request.Params["iddetail"];

            Shared.ApplyDefaultProp(_ht);

            if (Request.Params["action"].Equals("add"))
            {
                _dal.Insert(TABLE_NAME, _ht, ref inextid);
                lblId.Text = inextid.ToString();

                if (!System.IO.Directory.Exists(sFileDirectorys))
                    System.IO.Directory.CreateDirectory(sFileDirectorys);

                if (!System.IO.File.Exists(sFileDirectorys + sfullname))
                    fupFilename.SaveAs(sFileDirectorys + sfullname);

            }
            else
                _dal.Update(TABLE_NAME, _ht);

            Shared.ShowSuccessGritter(this, string.Format("purchasequotationheader.aspx?action=edit&codebarcode={0}",  Request.Params["codebarcode"]));
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
        Response.Redirect("purchasequotationheader.aspx?action=edit&codebarcode=" + Request.Params["codebarcode"]);
    }
}
