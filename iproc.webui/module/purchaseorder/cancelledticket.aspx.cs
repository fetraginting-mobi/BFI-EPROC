using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_purchaseorder_cancelledticket : BasePage
{

    private static string TABLE_NAME_DETAIL = "PURCHASE_TICKET_DETAIL";



    string sfullname = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        if (!Page.IsPostBack)
        {
            lblTrxCode.Text = Request.Params["barcode"];
            txtBranch.Text = Shared.CurrentEmployeeBranchCode;

            btnLookUpRequestor.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STAFF&acol_0={0}&bcol_1={1}&parc_branch_code={2}');", txtRequestorCode.ClientID, lblRequestorName.ClientID, txtBranch.ClientID);
            btnLookUpReffNo.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/generic.aspx?code=PTR&acol_0={0}&bcol_1={1}&ccol_2={2}');", lblReffNo.ClientID, txtRequestorCode.ClientID, lblRequestorName.ClientID);
            Shared.BindBranchEmployee(ddlBranch);
            Shared.BindGeneralSubCode(ddlMaskapai, "MKP");
            Shared.BindGeneralSubCode(ddlPurpose, "PPT");

            if (ddlReffType.SelectedValue == "TH")
            {

                ddlMaskapai.Visible = false;
                MKP.Visible = false;
                txtPlafondAmount.Visible = true;
                PLA.Visible = true;

                txtLowestPrice.Visible = false;
                LPR.Visible = false;
                txtTicketPrice.Visible = false;
                TPR.Visible = false;
                txtFrom.Visible = false;
                FRM.Visible = false;
                txtdeparturetime.Visible = false;
                DTM.Visible = false;
                txtTimeArrived.Visible = false;
                WKB.Visible = false;
                txtDestiny.Visible = false;
                DTN.Visible = false;
                txtHotelName.Visible = true;
                HNM.Visible = true;
                txtNominal.Visible = true;
                NML.Visible = true;
                txtDate.Visible = false;
                DT.Visible = false;
                ddlTicketType.Visible = false;
                TT.Visible = false;
                txtCheckIndate.Visible = true;
                CID.Visible = true;
                txtCheckOutdate.Visible = true;
                CKS.Visible = true;
                rfvReffNo.Enabled = false;
                mandatory.Visible = false;
            }


            if (ddlReffType.SelectedValue == "TP")
            {
                txtHotelName.Visible = false;
                HNM.Visible = false;
                txtNominal.Visible = false;
                NML.Visible = false;
                ddlMaskapai.Visible = true;
                MKP.Visible = true;
                txtPlafondAmount.Visible = false;
                PLA.Visible = false;
                txtLowestPrice.Visible = true;
                LPR.Visible = true;
                txtTicketPrice.Visible = true;
                TPR.Visible = true;
                txtFrom.Visible = true;
                FRM.Visible = true;
                txtdeparturetime.Visible = true;
                DTM.Visible = true;
                txtTimeArrived.Visible = true;
                WKB.Visible = true;
                txtDestiny.Visible = true;
                DTN.Visible = true;
                txtDate.Visible = true;
                DT.Visible = true;
                ddlTicketType.Visible = true;
                TT.Visible = true;
                txtCheckIndate.Visible = false;
                CID.Visible = false;
                txtCheckOutdate.Visible = false;
                CKS.Visible = false;
                rfvReffNo.Enabled = true;
                mandatory.Visible = true;
                btnSave.Visible = false;
                ddlMaskapai.Enabled = false;
                ddlPurpose.Enabled = false;
                ddlReffType.Enabled = false;
                ddlTicketType.Enabled = false;
                ddlBranch.Enabled = false;
                txtCheckIndate.Enabled = false;
                txtCheckOutdate.Enabled = false;
                txtdeparturetime.Enabled = false;
                txtDestiny.Enabled = false;
                txtFrom.Enabled = false;
                txtHotelName.Enabled = false;
                txtJabatan.Enabled = false;
                txtJG.Enabled = false;
                txtLowestPrice.Enabled = false;
                txtNominal.Enabled = false;
                txtPlafondAmount.Enabled = false;
                txtReffNo.Enabled = false;
                txtRemarks.Enabled = false;
                txtRequestorCode.Enabled = false;
                txtTicketPrice.Enabled = false;
                txtTimeArrived.Enabled = false;


            }

            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();

                lblID.Enabled = false;
                ddlReffType.Enabled = false;
                btnCancel.Text = "<i class=\"icon-arrow-left\"></i> Back";
                btnCancel.CssClass = "btn btn-custome";
                txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtDate.Enabled = false;



                if (lblStatus.Text == "APPROVED" || lblStatus.Text == "REJECTED" || lblStatus.Text == "REFUNDED")
                {
                    btnSave.Visible = false;
                    ddlMaskapai.Enabled = false;
                    ddlPurpose.Enabled = false;
                    ddlReffType.Enabled = false;
                    ddlTicketType.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtCheckIndate.Enabled = false;
                    txtCheckOutdate.Enabled = false;
                    txtdeparturetime.Enabled = false;
                    txtDestiny.Enabled = false;
                    txtFrom.Enabled = false;
                    txtHotelName.Enabled = false;
                    txtJabatan.Enabled = false;
                    txtJG.Enabled = false;
                    txtLowestPrice.Enabled = false;
                    txtNominal.Enabled = false;
                    txtPlafondAmount.Enabled = false;
                    txtReffNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtRequestorCode.Enabled = false;
                    txtTicketPrice.Enabled = false;
                    txtTimeArrived.Enabled = false;
                    btnSave.Visible = false;
                    ddlMaskapai.Enabled = false;
                    ddlPurpose.Enabled = false;
                    ddlReffType.Enabled = false;
                    ddlTicketType.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtCheckIndate.Enabled = false;
                    txtCheckOutdate.Enabled = false;
                    txtdeparturetime.Enabled = false;
                    txtDestiny.Enabled = false;
                    txtFrom.Enabled = false;
                    txtHotelName.Enabled = false;
                    txtJabatan.Enabled = false;
                    txtJG.Enabled = false;
                    txtLowestPrice.Enabled = false;
                    txtNominal.Enabled = false;
                    txtPlafondAmount.Enabled = false;
                    txtReffNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtRequestorCode.Enabled = false;
                    txtTicketPrice.Enabled = false;
                    txtTimeArrived.Enabled = false;

                }

                if (ddlReffType.SelectedValue == "TH")
                {

                    ddlMaskapai.Visible = false;
                    MKP.Visible = false;
                    txtPlafondAmount.Visible = true;
                    PLA.Visible = true;

                    txtLowestPrice.Visible = false;
                    LPR.Visible = false;
                    txtTicketPrice.Visible = false;
                    TPR.Visible = false;
                    txtFrom.Visible = false;
                    FRM.Visible = false;
                    txtdeparturetime.Visible = false;
                    DTM.Visible = false;
                    txtTimeArrived.Visible = false;
                    WKB.Visible = false;
                    txtDestiny.Visible = false;
                    DTN.Visible = false;
                    txtHotelName.Visible = true;
                    HNM.Visible = true;
                    txtNominal.Visible = true;
                    NML.Visible = true;
                    txtDate.Visible = false;
                    DT.Visible = false;
                    ddlTicketType.Visible = false;
                    TT.Visible = false;
                    txtCheckIndate.Visible = true;
                    CID.Visible = true;
                    txtCheckOutdate.Visible = true;
                    CKS.Visible = true;
                    rfvReffNo.Enabled = false;
                    mandatory.Visible = false;
                    spasi.Visible = true;
                    btnSave.Visible = false;
                    ddlMaskapai.Enabled = false;
                    ddlPurpose.Enabled = false;
                    ddlReffType.Enabled = false;
                    ddlTicketType.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtCheckIndate.Enabled = false;
                    txtCheckOutdate.Enabled = false;
                    txtdeparturetime.Enabled = false;
                    txtDestiny.Enabled = false;
                    txtFrom.Enabled = false;
                    txtHotelName.Enabled = false;
                    txtJabatan.Enabled = false;
                    txtJG.Enabled = false;
                    txtLowestPrice.Enabled = false;
                    txtNominal.Enabled = false;
                    txtPlafondAmount.Enabled = false;
                    txtReffNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtRequestorCode.Enabled = false;
                    txtTicketPrice.Enabled = false;
                    txtTimeArrived.Enabled = false;
                }


                if (ddlReffType.SelectedValue == "TP")
                {
                    txtHotelName.Visible = false;
                    HNM.Visible = false;
                    txtNominal.Visible = false;
                    NML.Visible = false;
                    ddlMaskapai.Visible = true;
                    MKP.Visible = true;
                    txtPlafondAmount.Visible = false;
                    PLA.Visible = false;
                    txtLowestPrice.Visible = true;
                    LPR.Visible = true;
                    txtTicketPrice.Visible = true;
                    TPR.Visible = true;
                    txtFrom.Visible = true;
                    FRM.Visible = true;
                    txtdeparturetime.Visible = true;
                    DTM.Visible = true;
                    txtTimeArrived.Visible = true;
                    WKB.Visible = true;
                    txtDestiny.Visible = true;
                    DTN.Visible = true;
                    txtDate.Visible = true;
                    DT.Visible = true;
                    ddlTicketType.Visible = true;
                    TT.Visible = true;
                    txtCheckIndate.Visible = false;
                    CID.Visible = false;
                    txtCheckOutdate.Visible = false;
                    CKS.Visible = false;
                    rfvReffNo.Enabled = true;
                    mandatory.Visible = true;
                    spasi.Visible = false;
                    btnSave.Visible = false;
                    ddlMaskapai.Enabled = false;
                    ddlPurpose.Enabled = false;
                    ddlReffType.Enabled = false;
                    ddlTicketType.Enabled = false;
                    ddlBranch.Enabled = false;
                    txtCheckIndate.Enabled = false;
                    txtCheckOutdate.Enabled = false;
                    txtdeparturetime.Enabled = false;
                    txtDestiny.Enabled = false;
                    txtFrom.Enabled = false;
                    txtHotelName.Enabled = false;
                    txtJabatan.Enabled = false;
                    txtJG.Enabled = false;
                    txtLowestPrice.Enabled = false;
                    txtNominal.Enabled = false;
                    txtPlafondAmount.Enabled = false;
                    txtReffNo.Enabled = false;
                    txtRemarks.Enabled = false;
                    txtRequestorCode.Enabled = false;
                    txtTicketPrice.Enabled = false;
                    txtTimeArrived.Enabled = false;

                }

            }

            else
            {
                txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtDate.Enabled = false;
            }

            if (Request.Params["type"] == "RES")
            {

                btnLookUpReffNo.Visible = true;
                btnLookUpRequestor.Visible = false;
                txtReffNo.Visible = false;
                lblReffNo.Visible = true;
            }
            else
            {
                btnLookUpReffNo.Visible = false;
                btnLookUpRequestor.Visible = true;
                txtReffNo.Visible = true;
                lblReffNo.Visible = false;

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

            _ht["p_code_boking"] = Request.Params["code_booking"];

            DataRow _dr = _dal.GetRow("","xsp_purchase_ticket_detail_cancelled_getrow", _ht);

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

            if (fupFilename.HasFile)
            {
                sfullname = System.IO.Path.GetFileName(fupFilename.FileName);

                sFilePath = Shared.GetUploadPath("ADD_DOCUMENT" + Request.Params["codebarcode"]) + sfullname;
            }

            MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);
            _ht["p_file"] = sfullname;
            _ht["p_paths"] = sFilePath;

            Shared.ApplyDefaultProp(_ht);

            _ht["p_header_code"] = Request.Params["barcode"];

            if (Request.Params["action"].Equals("add"))
            {

                //if (!fupFilename.HasFile)
                //{
                //    throw new Exception("Please insert file image!");
                //}

                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();

            }
            else
            {
                if (!fupFilename.HasFile)
                {
                    _ht["p_file"] = lblFILE.Text;
                    _ht["p_paths"] = lblPATH.Text;
                }

                _dal.Update(TABLE_NAME_DETAIL, _ht);
            }

            if (!System.IO.Directory.Exists(sFileDirectorys))
                System.IO.Directory.CreateDirectory(sFileDirectorys);

            if (fupFilename.HasFile)
            {
                if (!System.IO.File.Exists(sFileDirectorys + sfullname))
                    fupFilename.SaveAs(sFileDirectorys + sfullname);
            }

            Shared.ShowSuccessGritter(this, string.Format("purchaseticketheader.aspx?action=edit&id={0}&barcode={1}", lblID.Text, lblTrxCode.Text));
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
        Response.Redirect("purchaseticketheader.aspx?action=edit&barcode=" + lblTrxCode.Text);
    }
    protected void ddlReffType_SelectedIndex(object sender, EventArgs e)
    {


        if (ddlReffType.SelectedValue == "TH")
        {

            ddlMaskapai.Visible = false;
            MKP.Visible = false;
            txtPlafondAmount.Visible = true;
            PLA.Visible = true;
            txtLowestPrice.Visible = false;
            LPR.Visible = false;
            txtTicketPrice.Visible = false;
            TPR.Visible = false;
            txtFrom.Visible = false;
            FRM.Visible = false;
            txtdeparturetime.Visible = false;
            DTM.Visible = false;
            txtTimeArrived.Visible = false;
            WKB.Visible = false;
            txtDestiny.Visible = false;
            DTN.Visible = false;
            txtHotelName.Visible = true;
            HNM.Visible = true;
            txtNominal.Visible = true;
            NML.Visible = true;
            txtDate.Visible = false;
            DT.Visible = false;
            ddlTicketType.Visible = false;
            TT.Visible = false;
            txtCheckIndate.Visible = true;
            CID.Visible = true;
            txtCheckOutdate.Visible = true;
            CKS.Visible = true;
            rfvReffNo.Enabled = false;
            mandatory.Visible = false;
            btnSave.Visible = false;
            ddlMaskapai.Enabled = false;
            ddlPurpose.Enabled = false;
            ddlReffType.Enabled = false;
            ddlTicketType.Enabled = false;
            ddlBranch.Enabled = false;
            txtCheckIndate.Enabled = false;
            txtCheckOutdate.Enabled = false;
            txtdeparturetime.Enabled = false;
            txtDestiny.Enabled = false;
            txtFrom.Enabled = false;
            txtHotelName.Enabled = false;
            txtJabatan.Enabled = false;
            txtJG.Enabled = false;
            txtLowestPrice.Enabled = false;
            txtNominal.Enabled = false;
            txtPlafondAmount.Enabled = false;
            txtReffNo.Enabled = false;
            txtRemarks.Enabled = false;
            txtRequestorCode.Enabled = false;
            txtTicketPrice.Enabled = false;
            txtTimeArrived.Enabled = false;

        }

        if (ddlReffType.SelectedValue == "TP")
        {
            txtHotelName.Visible = false;
            HNM.Visible = false;
            txtNominal.Visible = false;
            NML.Visible = false;
            ddlMaskapai.Visible = true;
            MKP.Visible = true;
            txtPlafondAmount.Visible = false;
            PLA.Visible = false;

            txtLowestPrice.Visible = true;
            LPR.Visible = true;
            txtTicketPrice.Visible = true;
            TPR.Visible = true;
            txtFrom.Visible = true;
            FRM.Visible = true;
            txtdeparturetime.Visible = true;
            DTM.Visible = true;
            txtTimeArrived.Visible = true;
            WKB.Visible = true;
            txtDestiny.Visible = true;
            DTN.Visible = true;
            txtDate.Visible = true;
            DT.Visible = true;
            ddlTicketType.Visible = true;
            TT.Visible = true;
            txtCheckIndate.Visible = true;
            CID.Visible = true;
            txtCheckOutdate.Visible = true;
            CKS.Visible = true;
            txtCheckIndate.Visible = false;
            CID.Visible = false;
            txtCheckOutdate.Visible = false;
            CKS.Visible = false;
            rfvReffNo.Enabled = true;
            mandatory.Visible = true;
            btnSave.Visible = false;
            ddlMaskapai.Enabled = false;
            ddlPurpose.Enabled = false;
            ddlReffType.Enabled = false;
            ddlTicketType.Enabled = false;
            ddlBranch.Enabled = false;
            txtCheckIndate.Enabled = false;
            txtCheckOutdate.Enabled = false;
            txtdeparturetime.Enabled = false;
            txtDestiny.Enabled = false;
            txtFrom.Enabled = false;
            txtHotelName.Enabled = false;
            txtJabatan.Enabled = false;
            txtJG.Enabled = false;
            txtLowestPrice.Enabled = false;
            txtNominal.Enabled = false;
            txtPlafondAmount.Enabled = false;
            txtReffNo.Enabled = false;
            txtRemarks.Enabled = false;
            txtRequestorCode.Enabled = false;
            txtTicketPrice.Enabled = false;
            txtTimeArrived.Enabled = false;

        }

    }



}

