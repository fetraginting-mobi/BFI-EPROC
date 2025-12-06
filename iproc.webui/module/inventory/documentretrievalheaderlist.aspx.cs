using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iProc.DataAccessLayer;

public partial class module_inventory_documentretrievalheaderlist : BasePageList
{
    private static string TABLE_NAME = "DOCUMENT_RETRIEVAL_HEADER";

    protected void Page_Init(object sender, EventArgs e)
    {
        PAGE_LIST = "DOCUMENT_RETRIEVAL_HEADER";
        NEXT_PAGE = "documentretrievalheader.aspx";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInit();
        if (!Page.IsPostBack)
        {
           // Shared.BindGeneralSubCodeByTransflagCode(ddlStatus, "II");
            
            //Shared.BindBranchEmployee(ddlBranch);
            //Kenny 12/06/2018 Filter Branch
            Shared.BindBranchEmployeeSort(ddlBranch);

            BindData();
            btnDelete.OnClientClick = "return confirm('Delete selected data?');";
            gvwList.DataBind();
        }
        LoadAfterInit();

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
            _ht["p_branch_code"] = ddlBranch.SelectedValue;
            _ht["p_document_type"] = ddlDocumentType.SelectedValue;
            foreach (GridViewRow row in gvwList.Rows)
            {
                DropDownList ddlDocumentStatus = ((DropDownList)row.Cells[8].Controls[1]);
                DropDownList ddlMovedLocation = ((DropDownList)row.Cells[9].Controls[1]);
                if (ddlDocumentStatus.SelectedValue.Equals("MTT"))
                {

                    ddlMovedLocation.Enabled = true;
                }
                else if (ddlDocumentStatus.SelectedValue.Equals("0"))
                {

                    ddlMovedLocation.Enabled = false;

                }
                else
                {
                    ddlMovedLocation.Enabled = false;
                }
            }
            

            Shared.ApplyDefaultProp(_ht);

            gvwList.DataSource = _dal.GetRows("","xsp_document_receipt_detail_list_getrows", _ht);
            gvwList.DataBind();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    private void DeleteData(string code)
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;

        try
        {
            _dal = new GeneralDAL();
            _ht = new Hashtable();

            _ht["p_code_barcode"] = code;

            _dal.Delete(TABLE_NAME, _ht);
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
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("documentretrievalheader.aspx?action=add");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                DeleteData(gvwList.DataKeys[row.RowIndex][0].ToString());
            }
        }

        BindData();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected void gvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {


            DropDownList ddlDocumentStatus = (DropDownList)e.Row.FindControl("ddlDocumentStatus");
            DropDownList ddlMovedLocation = (DropDownList)e.Row.FindControl("ddlMovedLocation");
            // DropDownList ddlSwitchDepartment = (DropDownList)e.Row.FindControl("ddlSwitchDepartment");
            DropDownList ddlBranch = (DropDownList)e.Row.FindControl("ddlBranch");
            //DropDownList ddlTypeProcurment = (DropDownList)e.Row.FindControl("ddlTypeProcurment");


            Shared.BindGeneralSubCode(ddlMovedLocation, "DOCL");
            //Shared.BindGeneralSubCode(ddlTypeProcurment, "INVTYPE");




            ddlDocumentStatus.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "GOOD_STATUS"));
            ddlMovedLocation.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MOVED_LOCATION"));
            // ddlSwitchDepartment.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PURPOSE_DEPARTMENT"));
            //ddlBranch.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BRANCH"));
            //ddlTypeProcurment.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_PURCHASE"));


          
        }
    }


    private void ProcessData()
    {
        GeneralDAL _dal = null;
        Hashtable _ht = null;
        //int iNextID = 0;
        //
        //System.Diagnostics.Debugger.Break();
        if (!SelectedExist())
        {
            Exception ex = null;
            ex = new Exception("No Transaction Selected !");
            Shared.ShowErrorDialog(this, ex);
            return;
        }

        _dal = new GeneralDAL();
        _ht = new Hashtable();

        MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

        try
        {
            foreach (GridViewRow row in gvwList.Rows)
            {
                CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
                if (chb.Checked)
                {
                    //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);
                    DropDownList ddlDocumentStatus = ((DropDownList)row.Cells[8].Controls[1]);
                    DropDownList ddlMovedLocation = ((DropDownList)row.Cells[9].Controls[1]);
                    DateTime Date = Shared.ToDateTime(((TextBox)row.Cells[10].Controls[1]).Text);
                 

                  
                    _ht["p_code_barcode"] = gvwList.DataKeys[row.RowIndex][0].ToString();
                    _ht["p_good_status"] = ddlDocumentStatus.SelectedValue;
                    _ht["p_moved_location"] = ddlMovedLocation.SelectedValue;
                    _ht["p_confirm_date"] = Date;


                    //if (AuthorityBranch.Checked == true)
                    //    _ht["p_is_authority_branch"] = "1";
                    //else
                    //    _ht["p_is_authority_branch"] = "0";

                    Shared.ApplyDefaultProp(_ht);

                    _dal.ExecRawSP("xsp_document_receipt_detail_list_process", _ht);
                }
            }

            Shared.ShowSuccessGritter(this, string.Format("documentretrievalheaderlist.aspx"));
            BindData();
        }
        catch (Exception ex)
        {
            Shared.ShowErrorDialog(this, ex);
        }
    }

    //private void SaveData()
    //{
    //    GeneralDAL _dal = null;
    //    Hashtable _ht = null;
    //    //
    //    //System.Diagnostics.Debugger.Break();
    //    if (!SelectedExist())
    //    {
    //        Exception ex = null;
    //        ex = new Exception("No Transaction Selected !");
    //        Shared.ShowErrorDialog(this, ex);
    //        return;
    //    }

    //    _dal = new GeneralDAL();
    //    _ht = new Hashtable();

    //    MPF23.Shared.Mapper.UIToDB.Map(this.Controls, _ht);

    //    try
    //    {
    //        foreach (GridViewRow row in gvwList.Rows)
    //        {
    //            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
    //            if (chb.Checked)
    //            {
    //                //DropDownList PurchaseType = ((DropDownList)row.Cells[8].Controls[1]);
    //                DropDownList ddlDocumentStatus = ((DropDownList)row.Cells[6].Controls[1]);
    //                DropDownList ddlMovedLocation = ((DropDownList)row.Cells[7].Controls[1]);
    //                DateTime Date = Shared.ToDateTime(((TextBox)row.Cells[8].Controls[1]).Text);



    //                _ht["p_code_barcode"] = gvwList.DataKeys[row.RowIndex][0].ToString();
    //                _ht["p_good_status"] = ddlDocumentStatus.SelectedValue;
    //                _ht["p_moved_location"] = ddlMovedLocation.SelectedValue;
    //                _ht["p_confirm_date"] = Date;


    //                //if (AuthorityBranch.Checked == true)
    //                //    _ht["p_is_authority_branch"] = "1";
    //                //else
    //                //    _ht["p_is_authority_branch"] = "0";

    //                Shared.ApplyDefaultProp(_ht);

    //                _dal.ExecRawSP("xsp_document_receipt_detail_list_update", _ht);
    //            }
    //        }

    //        Shared.ShowSuccessGritter(this, string.Format("documentretrievalheaderlist.aspx"));
    //        BindData();
    //    }
    //    catch (Exception ex)
    //    {
    //        Shared.ShowErrorDialog(this, ex);
    //    }
    //}

    protected override void SelectedIndexChanged(object sender, EventArgs e)
    {
        base.SelectedIndexChanged(sender, e);
        Response.Redirect("documentretrievalheader.aspx?action=edit&codebarcode=" + gvwList.SelectedDataKey[0].ToString());

    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        ProcessData();
    }

    // protected void btnSave_Click(object sender, EventArgs e)
    //{
    //    SaveData();
    //}



    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlDocumentStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwList.Rows)
        {
            DropDownList ddlDocumentStatus = ((DropDownList)row.Cells[8].Controls[1]);
            DropDownList ddlMovedLocation = ((DropDownList)row.Cells[9].Controls[1]);
           if (ddlDocumentStatus.SelectedValue.Equals("MTT"))
                {

                    ddlMovedLocation.Enabled = true;
                }
                else if (ddlDocumentStatus.SelectedValue.Equals("0"))
                {

                    ddlMovedLocation.Enabled = false;

                }
                else
                {
                    ddlMovedLocation.Enabled = false;
                }
            }
        }
    
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    protected void ddlDocumentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }


    private Boolean SelectedExist()
    {
        int _RowCount = 0;
        foreach (GridViewRow row in gvwList.Rows)
        {
            CheckBox chb = (CheckBox)row.Cells[1].Controls[1];
            if (chb.Checked)
            {
                _RowCount += 1;
            }
        }

        if (_RowCount > 0)
            return true;
        else
            return false;
    }
}

