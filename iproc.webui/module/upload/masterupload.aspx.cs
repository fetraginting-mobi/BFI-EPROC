using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;

public partial class module_upload_masterupload : BasePage
{
    private static string TABLE_NAME = "MASTER_UPLOAD";

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            if (Request.Params["action"].Equals("edit"))
            {
                lblCode.Text = Request.Params["code"];
                LoadDetail();
            }
        }
        LoadAfterInit();
    }

    private void LoadDetail()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code"] = lblCode.Text;
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
        string sFileName = System.IO.Path.GetFileName(fup.FileName);
        string sFileType = System.IO.Path.GetExtension(fup.FileName);
        string sFilePath = Server.MapPath("~/temp/upload/" + Shared.CurrentUID + lblCode.Text + DateTime.Now.ToString("ddMMyyHHmmss") + sFileName);
        int iCount = 0;
        GeneralDAL _dal = null;
        string sSPName = lblSPName.Text;
        string sLastField = "";
        string sLastValue = "";

        try
        {
            _dal = new GeneralDAL();

            if (sFileType == ".xls" || sFileType == ".xlsx")
            {
                fup.SaveAs(sFilePath);

                DataTable _dt = Shared.ReadExcelFile(sFilePath, sFileType, "[Sheet1$]");

                if (_dt != null)
                {                    
                    Hashtable _ht = new Hashtable();
                    _ht["p_keywords"] = "";
                    _ht["p_code"] = lblCode.Text;

                    //read definition
                    DataTable _dtUploadDefinition = _dal.GetRows("", "xsp_master_upload_column_getrows", _ht);
                                        
                    foreach (DataRow _dr in _dt.Rows)
                    {
                        _ht.Clear();

                        foreach (DataRow _drUploadDefinition in _dtUploadDefinition.Rows)
                        {
                            sLastField = _drUploadDefinition[2].ToString();
                            sLastValue = _dt.Rows[iCount][_drUploadDefinition[2].ToString()].ToString();

                            _ht[_drUploadDefinition[3].ToString().ToLower()] = ReadData(_dt, iCount, _drUploadDefinition);
                        }

                        Shared.ApplyDefaultProp(_ht);

                        //exec sp
                        _dal.ExecRawSP(sSPName, _ht);

                        iCount++;
                    }
                }
                else
                {
                    Exception ext = new Exception(string.Format("There is no data in the selected excel sheet."));

                    Shared.ShowErrorDialog(this, ext);
                }
            }
            else
            {
                Exception ext = new Exception(string.Format("Please use excel file type."));

                Shared.ShowErrorDialog(this, ext);
            }

            Shared.ShowSuccessGritter(this, "");
        }
        catch (Exception ex)
        {
            Exception ext = new Exception(String.Format("Row: {0}, Field: {1}, Value: {2}", iCount.ToString(), sLastField, sLastValue), ex);

            Shared.ShowErrorDialog(this, ext);
        }
    }

    private object ReadData(DataTable _dt, int index, DataRow _dr)
    {
        if (_dr[4].ToString().Contains("NVARCHAR"))
            return _dt.Rows[index][_dr[2].ToString()].ToString();
        else if (_dr[4].ToString().Contains("INT"))
            return Int32.Parse(_dt.Rows[index][_dr[2].ToString()].ToString());
        else if (_dr[4].ToString().Contains("DECIMAL"))
            return Decimal.Parse(_dt.Rows[index][_dr[2].ToString()].ToString());
        else
            return (DateTime)_dt.Rows[index][_dr[2].ToString()];
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("masteruploadlist.aspx");
    }
}
