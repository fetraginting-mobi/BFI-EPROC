using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

using iProc.DataAccessLayer;

public partial class module_shared_approvalhistory : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
            Shared.BindModul(ddlModul);
            Shared.BindBranchEmployeeSort(ddlBranch);
            BindData();
        }
    }

    private void BindData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_keywords"] = txtSearch.Text;
            _ht["p_modul"] = ddlModul.SelectedValue;
            _ht["p_emp_code"] = Shared.CurrentUID;
            _ht["p_branch_code"] = ddlBranch.SelectedValue;

            gvwList.DataSource = _dal.GetRows("", "xsp_approval_history_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }



    protected void gvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwList.PageIndex = e.NewPageIndex;
        BindData();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlModul_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void gvwList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000001"))
            Response.Redirect(string.Format("../purchaseorder/purchaserequestheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000003"))
            Response.Redirect(string.Format("../purchaseorder/purchasequotationheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000005"))
            Response.Redirect(string.Format("../purchaseorder/purchaseorderheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000023"))
            Response.Redirect(string.Format("../purchaseorder/goodreceiptnoteheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000009"))
            Response.Redirect(string.Format("../inventory/inventoryissueheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000009"))
            Response.Redirect(string.Format("../inventory/inventoryissueheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000011"))
            Response.Redirect(string.Format("../inventory/inventoryadjustmentheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000013"))
            Response.Redirect(string.Format("../inventory/inventorymutationheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000017"))
            Response.Redirect(string.Format("../fa/famutationheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000019"))
            Response.Redirect(string.Format("../fa/fasaleheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000041"))
            Response.Redirect(string.Format("../apadvanceanddeposit/apadvancerefundheaderlist.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000025"))
            Response.Redirect(string.Format("../apadvanceanddeposit/apadvanceregistration.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000029"))
            Response.Redirect(string.Format("../apinvoice/apadvanceallocationheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000027"))
            Response.Redirect(string.Format("../apinvoice/apinvoiceregistrationheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000036"))
            Response.Redirect(string.Format("../apinvoice/apinvoiceregistrationheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000035"))
            Response.Redirect(string.Format("../purchaseorder/supplierselectionheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000021"))
            Response.Redirect(string.Format("../fa/fadisposalheader.aspx?action=edit&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000007"))
            Response.Redirect(string.Format("../inventory/inventoryrequestheader.aspx?action=edit&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("APP0063"))
            Response.Redirect(string.Format("../purchaseorder/purchaseticketheader.aspx?action=edit&barcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("APP0059"))
            Response.Redirect(string.Format("../fa/fachangecategoryheader.aspx?action=edit&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000051"))
            Response.Redirect(string.Format("../inventory/inventoryopnamehistoryheader.aspx?action=edit&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000052"))
            Response.Redirect(string.Format("../fa/faadjustheader.aspx?action=edit&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000031"))
            Response.Redirect(string.Format("../fa/faentryheader.aspx?action=edit&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("AP000053"))
            Response.Redirect(string.Format("../apadvanceanddeposit/apdepositregistration.aspx?action=edit&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
        else if (gvwList.SelectedDataKey["TYPE"].ToString().Equals("APP0072"))
            Response.Redirect(string.Format("../inventory/refundinventoryamortizationheader.aspx?action=edit&type=approval&codebarcode={0}&idartarget={1}", gvwList.SelectedDataKey["OBJECT_ID"].ToString(), "".ToString()));
    }

}
