using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_commonmst_masteritemdocument : BasePage
{
    private static string TABLE_NAME = "MASTER_ITEM";
    string sfullname = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {

            lblCode.Text = Request.Params["code"];
            lblName.Text = Request.Params["name"];


            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                if (!lblStatus.Text.Equals("NEW"))
                {
                    btnSave.Visible = false;
                    //txtDocumentName.Enabled = false;

                }
            }
            else if (Request.Params["action"].Equals("add"))
            {

            }
        }
        LoadAfterInit();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        string sNextItemcode = "";

        if (!fupFilename.HasFile)
        {
            Shared.ShowValidationError(this, "Please upload file!");
            return;
        }

        try
        {

            string sFileDirectorys = Server.MapPath("~/" + Shared.GetUploadPath("ITEM_UPLOAD_MEMO/" + Request.Params["code"]));
            string sfullname = System.IO.Path.GetFileName(fupFilename.FileName);

            int fileSize = fupFilename.PostedFile.ContentLength;
            string contentType = fupFilename.PostedFile.ContentType;
            string[] allowedMime =
            {
                "image/jpeg",
                "image/png",
                "application/pdf",
                "application/msword",
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                "application/vnd.ms-excel",
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                "application/zip",
                "application/x-zip-compressed",
                "application/x-rar-compressed",
                "application/vnd.rar",
                "application/x-7z-compressed"

            };

            bool mimeValid = false;
            for (int i = 0; i < allowedMime.Length; i++)
            {
                if (contentType == allowedMime[i])
                {
                    mimeValid = true;
                    break;
                }
            }

            if (!mimeValid)
            {
                throw new Exception("Format file tidak didukung. Gunakan file dengan tipe .pdf .zip .doc .xlx .png .jpg .jpeg");
            }
            if (fileSize > 3000000) // (+) Ari 13-09-2022 ket : cek size file Max 3MB.
            {
                throw new Exception("Maximum file size allowed is 3 mb.");
            }

            _dal = new GeneralDAL();
            _ht = new Hashtable();

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

            _ht["p_file"] = sfullname;
            _ht["p_paths"] = sFileDirectorys;
            _ht["p_item_code"] = Request.Params["code"];
            _ht["p_remarks"] = txtremark.Text;

            Shared.ApplyDefaultProp(_ht);

            //if (Request.Params["action"].Equals("add") || Request.Params["action"].Equals("copy"))
            //{
            _dal.Insert("MASTER_ITEM_DOCUMENT", _ht, ref sNextItemcode);
            lblCode.Text = sNextItemcode.ToString();

            if (!System.IO.Directory.Exists(sFileDirectorys))
                System.IO.Directory.CreateDirectory(sFileDirectorys);

            if (!System.IO.File.Exists(sFileDirectorys + sfullname))
                fupFilename.SaveAs(sFileDirectorys + sfullname);

            //}
            //else
            //    _dal.Update("MASTER_ITEM_DOCUMENT", _ht);

            //// Shared.ShowSuccessGritter(this, string.Format("masteritem.aspx?action=edit&itemcode={0}", lblItemCode.Text));
            //Shared.ShowSuccessGritter(this, string.Format("masteritemlist.aspx")); 

        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {

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
}
