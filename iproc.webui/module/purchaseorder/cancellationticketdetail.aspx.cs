using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;
using MPF23.Shared.Mapper;


public partial class module_purchaseorder_cancellationticketdetail : BasePage
{

    private static string TABLE_NAME_DETAIL = "CANCELLATION_TICKET_DETAIL";

    string sfullname = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadInit();
        if (!Page.IsPostBack)
        {
            lblTrxCode.Text = Request.Params["barcode"];

            btnLookUpRequestor.Attributes["href"] = String.Format("javascript:fnShowDialog('../../lookup/genericwithparameter.aspx?code=STAFF&acol_0={0}&bcol_1={1}');", txtRequestorCode.ClientID, lblRequestorName.ClientID);
            Shared.BindBranchEmployee(ddlBranch);


            if (Request.Params["action"].Equals("edit"))
            {
                LoadData();
                lblID.Enabled = false;
                ddlReffType.Enabled = false;

                if (ddlReffType.SelectedValue == "TH")
                {

                    
                    txtTicketPrice.Visible = false;
                    TPR.Visible = false;
                    txtFrom.Visible = false;
                    FRM.Visible = false;
                    txtDestiny.Visible = false;
                    DTN.Visible = false;
                    txtHotelName.Visible = true;
                    HNM.Visible = true;
                    txtDate.Visible = false;
                    DT.Visible = false;
                    TT.Visible = false;
                }


                if (ddlReffType.SelectedValue == "TP")
                {
                    txtHotelName.Visible = false;
                    HNM.Visible = false;
                   
                    txtTicketPrice.Visible = true;
                    TPR.Visible = true;
                    txtFrom.Visible = true;
                    FRM.Visible = true;
                    txtDestiny.Visible = true;
                    DTN.Visible = true;
                    txtDate.Visible = true;
                    DT.Visible = true;
                    TT.Visible = true;
                    CID.Visible = false;
                    CKS.Visible = false;
                    txtCheckIndate.Visible = false;
                    txtCheckOutdate.Visible = false;
                   

                }

            }

            else
            {

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
        int iNextID = 0;
      

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();
            _ht["p_header_code"] = Request.Params["barcode"];

            if (Request.Params["action"].Equals("add"))
            {

                _dal.Insert(TABLE_NAME_DETAIL, _ht, ref iNextID);
                lblID.Text = iNextID.ToString();

            }
            else
            {
                _dal.Update(TABLE_NAME_DETAIL, _ht);
            }


            Shared.ShowSuccessGritter(this, string.Format("cancellationticketdetail.aspx?action=edit&id={0}&barcode={1}", lblID.Text, lblTrxCode.Text));
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
        Response.Redirect("cancellationticketheader.aspx?action=edit&barcode=" + lblTrxCode.Text);
    }
    protected void ddlReffType_SelectedIndex(object sender, EventArgs e)
    {


        if (ddlReffType.SelectedValue == "TH")
        {

           
            txtTicketPrice.Visible = false;
            TPR.Visible = false;
            txtFrom.Visible = false;
            FRM.Visible = false;
            DTM.Visible = false;
            txtDestiny.Visible = false;
            DTN.Visible = false;
            txtHotelName.Visible = true;
            HNM.Visible = true;
            txtDate.Visible = false;
            DT.Visible = false;
            TT.Visible = false;

        }

        if (ddlReffType.SelectedValue == "TP")
        {
            txtHotelName.Visible = false;
            HNM.Visible = false;
            txtTicketPrice.Visible = true;
            TPR.Visible = true;
            txtFrom.Visible = true;
            FRM.Visible = true;
            DTM.Visible = true;
            CID.Visible = false;
            CKS.Visible = false;
            txtCheckIndate.Visible = false;
            txtCheckOutdate.Visible = false;
            txtDestiny.Visible = true;
            DTN.Visible = true;
            txtDate.Visible = true;
            DT.Visible = true;
            TT.Visible = true;

        }

    }
}
