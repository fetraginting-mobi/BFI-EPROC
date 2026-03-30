<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apinvoiceregistrationheader.aspx.cs" Inherits="module_apinvoice_apinvoiceregistrationheader" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
     <script type="text/javascript">
         function tab() {
             var invoice = document.getElementById('invoice');
             var liInvoice = document.getElementById('ctl00_cpb_liInvoice');

             var detail = document.getElementById('detail');
             var liDetail = document.getElementById('ctl00_cpb_liDetail');

             var fee = document.getElementById('fee');
             var liFee = document.getElementById('ctl00_cpb_liFee');

             var termin = document.getElementById('termin');
             var liTermin = document.getElementById('ctl00_cpb_liTermin');

             var chbot = document.getElementById('ctl00_cpb_rblBillType_1');
             var chbter = document.getElementById('ctl00_cpb_rblBillType_2');
             
            var ctl102 = document.getElementById('ctl00_cpb_gvwListTermin_ctl02_txtDiscountAdditional');
            function formatNumber(num) {
  return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
}
            
          
            
             if (chbot.checked) {
                 liInvoice.style.display = 'none';
                 invoice.style.display = 'none';

                 liFee.style.display = 'none';
                 fee.style.display = 'none';

                 liTermin.style.display = 'none';
                 termin.style.display = 'none';

                 detail.style.display = '';
                 liDetail.style.display = '';
                 //liDetail.className = 'active';

             }
             else if (chbter.checked) {
                 liInvoice.style.display = 'none';
                 invoice.style.display = 'none';

                 liFee.style.display = '';
                 fee.style.display = '';

                 liTermin.style.display = '';
                 termin.style.display = '';

                 detail.style.display = 'none';
                 liDetail.style.display = 'none';
             }
             else {
                 liInvoice.style.display = '';
                 invoice.style.display = '';

                 liFee.style.display = '';
                 fee.style.display = '';

                 liTermin.style.display = 'none';
                 termin.style.display = 'none';

                 detail.style.display = 'none';
                 liDetail.style.display = 'none';

             }
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
            <span>Invoice Registration Info</span>
        </header>
            <div class="panel-heading">
                <div class="row">
                    <div class="col-sm-12">
                        <cc1:XUILinkButton ID="btnSave" RoleCode="R80000010E" runat="server" CssClass="btn btn-primary" CausesValidation="true" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                        <cc1:XUILinkButton RoleCode="R80000010O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                        <cc1:XUILinkButton ID="btnPost" RoleCode="R80000010O" runat="server" CssClass="btn btn-success" ><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                        <cc1:XUILinkButton ID="btnReject" RoleCode="R80000010O" runat="server" CssClass="btn btn-danger" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                        <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    </div>
                </div>
            </div>
    </section>
    <div class="row">
        <div class="col-sm-6">
            <section class="panel">
            <div class="panel-body form-horizontal">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <%--code barcode--%>
                            <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String" style="display:none;" BindType="Both"></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String" style="display:none;" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None"  style="display:none;"></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DataType="Number" Text="100" style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel>
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">No.</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        <cc1:XUILabel ID="lbladditionalamount" runat="server" DBColumnName="ADDITIONAL_AMOUNT" DataType="String" BindType="DBToUIOnly" style="display:none" ></cc1:XUILabel>
                                    </div>
                                      <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></cc1:XUILinkButton>
                                </div>
                                </div>                            
                            </div>
                        </div> 
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Invoice Date *</label>
                                    <div class="col-sm-7">
                                        <%--<cc1:XUITextBox ID="txtInvoiceDate" runat="server" CssClass="form-control default-date-picker" placeholder="Invoice Date" DBColumnName="INVOICE_DATE" SPParameterName="p_invoice_date" MaxLength="10" DataType="DateTime" BindType="Both" Format ="dd/MM/yyyy"></cc1:XUITextBox>--%>
                                        <cc1:XUITextBox ID="txtInvoiceDate" runat="server" CssClass="form-control default-date-picker" placeholder="Invoice Date" DBColumnName="INVOICE_DATE" SPParameterName="p_invoice_date" MaxLength="14" DataType="DateTime" BindType="UItoDBOnly" Format ="dd/MM/yyyy"></cc1:XUITextBox>
                                        <asp:RequiredFieldValidator ID="rfvInvoiceDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtInvoiceDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtInvoiceDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Due Date *</label>
                                    <div class="col-sm-7">
                                       <%-- <cc1:XUITextBox ID="txtMaturityDate" runat="server" CssClass="form-control default-date-picker" placeholder="Due Date" DBColumnName="MATURITY_DATE" SPParameterName="p_maturity_date" MaxLength="10" DataType="DateTime" BindType="Both" Format ="dd/MM/yyyy"></cc1:XUITextBox>--%>
                                        <cc1:XUITextBox ID="txtMaturityDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="Due Date" DBColumnName="MATURITY_DATE" SPParameterName="p_maturity_date" MaxLength="14" DataType="DateTime" BindType="Both" Format ="dd/MM/yyyy"></cc1:XUITextBox>
                                        <asp:RequiredFieldValidator ID="rfvMaturityDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMaturityDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtMaturityDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div>
                                </div>                            
                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Bill Type</label>
                                    <div class="col-sm-8">
                                        <cc1:XUIRadioButtonList ID="rblBillType" runat="server"  DBColumnName="BILL_TYPE" SPParameterName="p_bill_type" DataType="String" BindType="Both" RepeatLayout="Table" AutoPostBack="true" OnSelectedIndexChanged="rblBillType_SelectedIndexChanged" RepeatDirection="Horizontal" onclick="javascript:tab();">
                                        <asp:ListItem Value="PO">PO&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="OT" Selected="True">Other</asp:ListItem>
                                        <asp:ListItem Value="APA">PO Termin&nbsp&nbsp</asp:ListItem>
                                    </cc1:XUIRadioButtonList>
                                    </div>
                                </div>
                            </div> 
                        </div> 
                        <div class="row" >
                            <div class="col-sm-12" runat="server" id="ADEP">
                                <div class="form-group">
                                    <label class="col-sm-4">Advance or Deposit?*</label>
                                    <div class="col-sm-5">
                                     <cc1:XUIDropDownList ID="ddlFlagAdvDps" runat="server" CssClass="form-control" DBColumnName="FLAG_ADV_DPS" SPParameterName="p_flag_adv_dps" AutoPostBack ="true" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                      <asp:RequiredFieldValidator ID="rfvFlagAdvDps" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlFlagAdvDps" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    </div>
                                </div> 
                            </div>
                        </div>
                        <div class="row" style="display:none">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Invoice Type</label>
                                    <div class="col-sm-6">
                                        <cc1:XUIDropDownList ID="ddlInvoiceTypeCode" runat="server" CssClass="form-control" DBColumnName="INVOICE_TYPE_CODE" SPParameterName="p_invoice_type_code" BindType="UIToDBOnly" DataType="String" OnSelectedIndexChanged="ddlInvoiceTypeCode_SelectedIndexChanged" AutoPostBack="true"></cc1:XUIDropDownList>    
                                    </div>
                                </div>
                            </div> 
                        </div>
                        <div class="row">
                               <div class="col-sm-12" >
                                <div class="form-group">
                                    <label class="col-sm-3">Purchase Order No.</label>
                                    <span class="col-sm-1" id="mandatory" runat="server">*</span>
                                    <span class="col-sm-1" id="spasi" runat="server">&nbsp; </span>
                                    <div class="col-sm-12"></div>
                                    <div class="col-sm-8">
                                        <asp:LinkButton runat="server" ID="btnLookUpPurchaseOrderCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                      
                                         <asp:LinkButton runat="server" ID="btnLookUpPurchaseOrderCodeTOP" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                         <cc1:XUITextBox ID="txtPurchaseOrderCode" runat="server"  CssClass="form-control" DBColumnName="PURCHASE_ORDER_CODE" SPParameterName="p_po_no" DataType="String" MaxLength="14" BindType="Both" style="display:none"></cc1:XUITextBox>
                                         <cc1:XUITextBox ID="txtPurchaseOrder"  runat="server" DBColumnName="CODE_BARCODE" DataType="String" BindType="DBToUIOnly" Text="--"  style="display:none"></cc1:XUITextBox>  
                                         <cc1:XUITextBox ID="txtPOCode"  runat="server"  DBColumnName="PO_CODE" DataType="String" BindType="DBToUIOnly" Text="--" Enabled="false" Width="200px" style="border:0px; background:inherit"></cc1:XUITextBox>                         
                                       <%--<asp:RequiredFieldValidator ID="rfvPurchaseOrderCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPurchaseOrderCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>
                            </div> 
                        </div>
                         <div class="row">
                               <div class="col-sm-12" runat="server" id="FANO">
                                <div class="form-group">
                                    <label class="col-sm-2">Fa Adjust NO.</label>
                                    <span class="col-sm-1" id="FadMan" runat="server">*</span>
                                    <span class="col-sm-1" id="FadSpa" runat="server">&nbsp; </span>
                                    <div class="col-sm-12"></div>
                                    <div class="col-sm-6">
                                        <asp:LinkButton runat="server" ID="btnLookUpPurchaseFaAdjust" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton> 
                                         <cc1:XUITextBox ID="txtFaAdjustCode" runat="server" CssClass="form-control" DBColumnName="FA_ADJUST_NO" SPParameterName="p_fa_adjust_no" DataType="String" MaxLength="14" BindType="Both"></cc1:XUITextBox>
                                        
                                       <%--<asp:RequiredFieldValidator ID="rfvPurchaseOrderCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPurchaseOrderCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>
                            </div> 
                        </div>
                         <div class="row">
                               <div class="col-sm-12" runat="server" id="DEPO">
                                <div class="form-group">
                                    <label class="col-sm-2">Req Deposit NO.</label>
                                    <span class="col-sm-1" id="DepMan" runat="server">*</span>
                                    <span class="col-sm-1" id="DepSpa" runat="server">&nbsp; </span>
                                    <div class="col-sm-12"></div>
                                    <div class="col-sm-6">
                                        <asp:LinkButton runat="server" ID="btnLookUpDepositRequest" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton> 
                                         <cc1:XUITextBox ID="txtDepositNo" runat="server" CssClass="form-control" DBColumnName="DEPOSIT_NO" SPParameterName="p_deposit_no" DataType="String" MaxLength="14" BindType="Both"></cc1:XUITextBox>
                                        
                                       <%--<asp:RequiredFieldValidator ID="rfvPurchaseOrderCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPurchaseOrderCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>
                            </div> 
                        </div>
                          <div class="row">  
                            <div class="col-sm-12">
                                <div class="form-group">
                                <label class="col-sm-4">Use Another Invoice No.?</label>
                                   <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlInvoice" st runat="server"  CssClass="form-control" DBColumnName="FLAG_INVOICE" SPParameterName="p_flag_invoice" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlInvoice_SelectedIndex" DataType="String">
                                        <asp:ListItem Value="0">-=Select=-</asp:ListItem>
                                        <asp:ListItem Value="Y">Yes</asp:ListItem>
                                        <asp:ListItem Value="N">No</asp:ListItem>
                                       
                                    </cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlInvoice" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                 
                                </div>
                            </div>                            
                        </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12" ID="RIN" runat="server">
                                <div class="form-group">
                                    <label class="col-sm-4">Reference Invoice No.</label>                               
                                    <div class="col-sm-7">
                                        <cc1:XUITextBox ID="txtInvoiceNo" runat="server"  CssClass="form-control" placeholder="Invoice No" DBColumnName="FILE_INVOICE_NO" SPParameterName="p_file_invoice_no" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                         <asp:RequiredFieldValidator ID="rfvInvoiceNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtInvoiceNo" Display="Dynamic" ></asp:RequiredFieldValidator>  
                                    </div>
                                </div>
                            </div> 
                        </div>
                         <%--<div class="row">
                            <div class="col-sm-12" ID="lblfaadjust" runat="server">
                                <div class="form-group">
                                    <label class="col-sm-4">Fa Adjust No.</label>                               
                                    <div class="col-sm-7">
                                         <cc1:XUILabel ID="lblAdjustNo" runat="server" DBColumnName="FA_ADJUST_NO" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    </div>
                                </div>
                            </div> 
                        </div>--%>
                        <div class="row" style="display:none">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Installment No.</label>                                
                                    <div class="col-sm-6">
                                        <cc1:XUITextBox ID="txtInstallmentNo" runat="server"  CssClass="form-control" placeholder="Installment No" DBColumnName="INSTALLMENT_NO" SPParameterName="p_installment_no" MaxLength="14" DataType="Integer" BindType="Both"></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Branch</label>
                                    <div class="col-sm-7">
                                        <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="BRANCH_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                        <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                        <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                    </div>
                                </div>                             
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Division</label>
                                    <div class="col-sm-7">
                                          <asp:UpdatePanel ID="updDiv" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE"  SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="revddlDivision" runat="server" ControlToValidate="ddlDivision"
                                                 ErrorMessage="Value Required!" InitialValue="-"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                      <%--<cc1:XUILabel ID="lblDepartement" runat="server" DBColumnName="DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel> --%>                       
                                    </div>
                                </div>                             
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Department</label>
                                    <div class="col-sm-7">
                                        <asp:UpdatePanel ID="updDep" runat="server">
                                            <ContentTemplate>
                                                <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                       <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlDivision" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                     </asp:UpdatePanel> 
                                      <%--<cc1:XUILabel ID="lblDepartement" runat="server" DBColumnName="DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel> --%>                       
                                    </div>
                                </div>                             
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Sub Department</label>
                                    <div class="col-sm-7">
                                      <asp:UpdatePanel ID="updSub" runat="server">
                                 <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlSubDepartment" runat="server" CssClass="form-control" DBColumnName="SUB_DEPARTMENT_CODE" SPParameterName="p_sub_department_code" OnSelectedIndexChanged= "ddlSubDepartment_SelectedIndexChanged" AutoPostBack="true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvddlSubDepartment" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                 </ContentTemplate>
                                 <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="ddlDepartment" EventName="SelectedIndexChanged" />
                                 </Triggers>
                               </asp:UpdatePanel>
                                    </div>
                                </div>                            
                            </div>
                      </div>
                       <div class="row">
                             <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Units</label>
                                    <div class="col-sm-7">
                                        <asp:UpdatePanel ID="updUn" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlUnits" runat="server" CssClass="form-control" DBColumnName="UNITS_CODE" SPParameterName="p_units_code"  DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="rfvddlUnits" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUnits" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                           <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlSubDepartment" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                    </asp:UpdatePanel>
                                    </div>
                                </div>                             
                            </div>
                         </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4" runat="server" id="lblSupplier">Supplier</label>
                                    <label class="col-sm-4" runat="server" id="lblUser">User Request</label> 
                                    <div class="col-sm-8">   
                                        <asp:LinkButton runat="server" ID="btnLookUpSupplierID" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>  
                                        <asp:LinkButton runat="server" ID="btnLookUpUserRequest" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtSupplierID" style="display:none" runat="server" CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblSupplierName" runat="server"  DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                       
                                    </div>
                                </div>                            
                            </div> 
                        </div>
                         <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                     <label class="col-sm-4">Payment By</label>
                                      <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblPaymentBy" runat="server"  DBColumnName="PAYMENT_BY" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                             <div class="col-sm-12">
                                <div class="form-group">
                                     <label class="col-sm-4">To Bank</label>
                                      <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblToBank" runat="server"  DBColumnName="SUPPLIER_BANK" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                             <div class="col-sm-12">
                                <div class="form-group">
                                     <label class="col-sm-4">Fa Adjust No</label>
                                      <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblFaAdjustNo" runat="server"  DBColumnName="FA_ADJUST_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="display:none">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Previous Invoice No.</label> 
                                    <div class="col-sm-5">   
                                        <asp:LinkButton runat="server" ID="btnLookUpPreviousInvoiceNo" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>  
                                        <cc1:XUITextBox ID="txtPreviousInvoiceNo" style="display:none" runat="server" CssClass="form-control" DBColumnName="PREVIOUS_INVOICE_NO" SPParameterName="p_previous_invoice_no" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblCodePreviousInvoiceNo" runat="server"  DBColumnName="PREVIOUS_INVOICE_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                        </div>
                        <div class="row" style="display:none"> 
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Remaining Amount</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtRemainingAmount" runat="server"  CssClass="form-control" placeholder="Remaining Amount" DBColumnName="REMAINING_AMOUNT" SPParameterName="p_remaining_amount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" style="display:none" ></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtRemainingAmount1" runat="server"  CssClass="form-control" placeholder="Remaining Amount" DBColumnName="REMAINING_AMOUNT" SPParameterName="p_remaining_amount" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="false" ></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">  
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Remarks</label>                            
                                    <div class="col-sm-7">
                                        <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both" MaxLength="400" TextMode="MultiLine" Height="58px"></cc1:XUITextBox>
                                      <%--  <asp:RequiredFieldValidator ID="rfvRemarks" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                        <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>    
                                    </div>
                                </div>                            
                            </div>
                             <%--(+) Ari 30-12-2022 ket : enhancement 2022, jika group role multiplebranch dapat akses pilih branch--%>
                            <div class="col-sm-6" style="display:none">
                                <div class="form-group">
                                    <label class="col-sm-3">Is Multiplebranch</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblMultiplebranch" runat="server" DBColumnName="MULTIPLEBRANCH" BindType="DBToUIOnly" DataType="String"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                        </div> 
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                    </Triggers>
              </asp:UpdatePanel>
                </div>
            </section>
        </div>
        <%-- right column--%>
        <div class="col-sm-6">
            <section class="panel">
                <div class="panel-body form-horizontal">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Status</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Faktur No. </label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtTaxInvoiceNo" runat="server"  CssClass="form-control" placeholder="Tax Invoice No" DBColumnName="TAX_INVOICE_NO" SPParameterName="p_tax_invoice_no" MaxLength="18" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Tax Date</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtTaxInvoiceDate" runat="server" CssClass="form-control default-date-picker" placeholder="Tax Invoice Date" DBColumnName="TAX_INVOICE_DATE" SPParameterName="p_tax_invoice_date" MaxLength="14" DataType="DateTime" BindType="Both" Format ="dd/MM/yyyy"></cc1:XUITextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtTaxInvoiceDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div>
                                </div>                            
                            </div>
                        </div>  
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Currency</label>
                                    <div class="col-sm-3">
                                       <%-- <cc1:XUITextBox ID="txtCurrency" runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" MaxLength="18" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtCurrency1" runat="server" CssClass="form-control" placeholder="CURRENCY" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" MaxLength="3" DataType="String" BindType="DBToUIOnly" Enabled="false" ></cc1:XUITextBox>--%>
                                         <cc1:XUIDropDownList ID="ddlCurrencyCode" runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <%--(+) Ari 01-08-2022 ket : enhancement 2022, + Rate--%>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Rate</label>
                                    <div class="col-sm-5">
                                         <cc1:XUITextBox ID="txtRate" runat="server" DBColumnName="RATE" SPParameterName="p_rate" DataType="Number" BindType="Both" CssClass="form-control" Text="0.00" ></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                       
                        <div class="row" style="display:none;">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Tax Type</label>
                                    <div class="col-sm-5">
                                        <%--<cc1:XUIDropDownList ID="ddlTaxType" runat="server" CssClass="form-control" DBColumnName="TAX_ID" SPParameterName="p_tax_id" BindType="Both" DataType="Integer" Enabled="false" ></cc1:XUIDropDownList>    --%>
                                        <cc1:XUILabel ID="lblTaxType" runat="server"  DBColumnName="TAX_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                        <cc1:XUITextBox ID="txtTaxType"  runat="server" style="display:none;"  CssClass="form-control" placeholder="Tax ID" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                    </Triggers>
              </asp:UpdatePanel>
                </div>
            
            </section>
        </div>
        <div class="col-sm-6">
            <section class="panel">
                <div class="panel-body form-horizontal">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                <label class="col-sm-4">Invoice Amount *</label>      
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtInvoiceAmount" runat="server"  CssClass="form-control" placeholder="Invoice Amount" DBColumnName="INVOICE_AMOUNT" SPParameterName="p_invoice_amount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Text="0.00" Enabled="false" ></cc1:XUITextBox>
                                        <asp:RequiredFieldValidator ID="rfvInvoiceAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtInvoiceAmount" Display="Dynamic"></asp:RequiredFieldValidator>     
                                        <asp:RegularExpressionValidator ID="revInvoiceAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtInvoiceAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>   
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">VAT Amount</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtPPNTax" runat="server"  CssClass="form-control" placeholder="PPN Tax" DBColumnName="PPN_TAX" SPParameterName="p_ppn_tax" MaxLength="18" DataType="Number" BindType="Both" Format="N2"  Enabled="false" Text="0.00" ></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Witholding Tax</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtPPHTax" runat="server"  CssClass="form-control" placeholder="PPH Tax" DBColumnName="PPH_TAX" SPParameterName="p_pph_tax" MaxLength="18" DataType="Number" BindType="Both" Format="N2"  Enabled="false" Text="0.00" ></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Discount</label>
                                    <asp:RequiredFieldValidator ID="rfvDiscount" runat="server" ErrorMessage="*" ControlToValidate="txtDiscount" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                    <asp:RegularExpressionValidator ID="revDiscount" runat="server" ErrorMessage="*" ControlToValidate="txtDiscount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         
                                    <div class="col-sm-5">
                                        <%--<cc1:XUITextBox ID="txtDiscount" runat="server"  CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT" SPParameterName="p_discount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>--%>
                                        <cc1:XUITextBox ID="txtDiscount" runat="server" CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT" SPParameterName="p_discount" MaxLength="18" DataType="Number" Format="N2" BindType="Both"  Text="0.00" style="display:none" ></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtDiscount1" runat="server" CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT" SPParameterName="p_discount" MaxLength="18" DataType="Number" Format="N2" BindType="DBToUIOnly"  Text="0.00" Enabled="false" ></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Discount Additional</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtDiscount" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtDiscount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtAdditionalDiscount" runat="server" CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT_ADDITIONAL" SPParameterName="p_discount_additional" MaxLength="18" DataType="Number" Format="N2" BindType="Both"  Text="0.00" style="display:none" ></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtAdditionalDiscount1" runat="server" CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT_ADDITIONAL" SPParameterName="p_discount_additional" MaxLength="18" DataType="Number" Format="N2" BindType="DBToUIOnly"  Text="0.00" Enabled="false" ></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Fee Amount</label>
                                    <%-- <asp:RequiredFieldValidator ID="rfvShippingFee" runat="server" ErrorMessage="*" ControlToValidate="txtShippingFee" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revShippingFee" runat="server" ErrorMessage="*" ControlToValidate="txtShippingFee" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         --%>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtTotalFee" runat="server" CssClass="form-control" placeholder="Total Fee" DBColumnName="TOTAL_FEE" SPParameterName="p_total_fee" MaxLength="18" DataType="Number" Format="N2" BindType="Both"  Text="0.00" Enabled="false" ></cc1:XUITextBox>
                                    </div>
                                </div>   
                            </div>                         
                        </div>
                        <div class="row" style="display:none;">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Shipping Fee</label>
                                    <%-- <asp:RequiredFieldValidator ID="rfvShippingFee" runat="server" ErrorMessage="*" ControlToValidate="txtShippingFee" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revShippingFee" runat="server" ErrorMessage="*" ControlToValidate="txtShippingFee" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         --%>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtShippingFee" runat="server" CssClass="form-control" placeholder="Shipping Fee" DBColumnName="SHIPPING_FEE" SPParameterName="p_shipping_fee" MaxLength="18" DataType="Number" Format="N2" BindType="Both"  Text="0.00" style="display:none" ></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtShippingFee1" runat="server" CssClass="form-control" placeholder="Shipping Fee" DBColumnName="SHIPPING_FEE" SPParameterName="p_shipping_fee" MaxLength="18" DataType="Number" Format="N2" BindType="DBToUIOnly"  Text="0.00" Enabled="false" ></cc1:XUITextBox>
                                    </div>
                                </div>   
                            </div>                         
                        </div>
                        <div class="row" style="display:none;">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Stamp Duty</label>
                                    <%-- <asp:RequiredFieldValidator ID="rfvShippingFee" runat="server" ErrorMessage="*" ControlToValidate="txtShippingFee" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revShippingFee" runat="server" ErrorMessage="*" ControlToValidate="txtShippingFee" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         --%>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtStampDuty" runat="server" CssClass="form-control" placeholder="Stamp Duty" DBColumnName="STAMP_DUTY" SPParameterName="p_stamp_duty" MaxLength="18" DataType="Number" Format="N2" BindType="Both"  Text="0.00" style="display:none" ></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtStampDuty1" runat="server" CssClass="form-control" placeholder="Stamp Duty" DBColumnName="STAMP_DUTY" SPParameterName="p_stamp_duty" MaxLength="18" DataType="Number" Format="N2" BindType="DBToUIOnly"  Text="0.00" Enabled="false" ></cc1:XUITextBox>
                                    </div>
                                </div>   
                            </div>                         
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Total Amount</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtTotalAmountIDR" runat="server"  CssClass="form-control" placeholder="Total Amount" DBColumnName="TOTAL_AMOUNT_IDR" SPParameterName="p_total_amount_idr" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"  Text="0.00" ></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblTotalAmountIDR" runat="server"  CssClass="form-control" placeholder="Total Amount" DBColumnName="TOTAL_AMOUNT_IDR"  SPParameterName="p_total_amount_idr" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"  Text="0.00" ></cc1:XUILabel>
                                        <asp:RequiredFieldValidator ID="rfvTotalAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTotalAmount" Display="Dynamic"></asp:RequiredFieldValidator>  
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">  <%--(+) Ari 08-08-2022 ket : enhancement 2022, + Field--%>
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4">Total Amount (IDR)</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtTotalAmount" runat="server"  CssClass="form-control" placeholder="Total Amount (IDR)" DBColumnName="TOTAL_AMOUNT" SPParameterName="p_total_amount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"  Text="0.00" ></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblTotalAmount" runat="server"  CssClass="form-control" placeholder="Total Amount (IDR)" DBColumnName="TOTAL_AMOUNT"  SPParameterName="p_total_amount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"  Text="0.00" ></cc1:XUILabel>
                                        <asp:RequiredFieldValidator ID="rfvTotalAmountIDR" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTotalAmount" Display="Dynamic"></asp:RequiredFieldValidator>  
                                    </div>
                                </div>
                            </div>
                        </div> 
                          <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4" runat="server" id="lblRemainingBalance">Remaining Balance</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtRemainingBalance" runat="server"  CssClass="form-control" placeholder="Total Amount" DBColumnName="INVOICE_REMAINING"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="false"  Text="0.00" ></cc1:XUITextBox>
                                         
                                    </div>
                                </div>
                            </div>
                        </div>       
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                    </Triggers>
              </asp:UpdatePanel>         
                </div>
            </section>
        </div>
    </div>
    <section class="panel"> 
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-4">Created </label>
                    <div class="col-sm-8">
                        <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        <span>@</span>
                        <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Modified </label>
                    <div class="col-sm-8">
                        <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "EMP_MOD" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        <span>@</span>
                        <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName= "MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </section>
    <asp:Panel runat="server" ID="pnlDetail">
    <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">       
              <li class="active" runat="server" id="liInvoice">
                  <a href="#invoice" id="invoicelist" onclick="javascript:fnSetTab('invoicelist');" data-toggle="tab" style="padding-bottom:28px">
                      GRN List 
                  </a>
              </li>
              <li class="" runat="server" id="liDetail">
                  <a href="#detail" id="detaillist" onclick="javascript:fnSetTab('detaillist');" data-toggle="tab" style="padding-bottom:28px">
                      Detail List 
                  </a>
              </li>
              <li class="" runat="server" id="liTermin">
                  <a href="#termin" id="terminlist" onclick="javascript:fnSetTab('terminlist');" data-toggle="tab" style="padding-bottom:28px">
                      TOP List 
                  </a>
              </li>
              <li class="" runat="server" id="liFee">
                  <a href="#fee" id="feelist" onclick="javascript:fnSetTab('feelist');" data-toggle="tab" style="padding-bottom:28px">
                      Fee
                  </a>
              </li>
               <li class="" runat="server" id="liAdvanceDeposit">
                  <a href="#AdvanceDeposit" id="AdDep" onclick="javascript:fnSetTab('AdDepList');" data-toggle="tab" style="padding-bottom:28px">
                     Advance Deposit
                  </a>
              </li>
             <li class="" runat="server" id="UploadDoc">
                  <a href="#UploadDoc" id="A1" onclick="javascript:fnSetTab('uploadodc');" data-toggle="tab" style="padding-bottom:28px">
                      Upload Doc
                  </a>
              </li>
          </ul>
        </header>    
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
                <div class="tab-pane active"  id="invoice">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8">
                                <cc1:XUILinkButton ID="btnAdd" Visible="false" RoleCode="R80000010E" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton ID="btnDelete" RoleCode="R80000010E" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4">
                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">      
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                    <asp:UpdatePanel ID="upd" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                            AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                OnPageIndexChanging="gvwList_PageIndexChanging" 
                                onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <span>No</span>
                                        </HeaderTemplate> 
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                    <HeaderTemplate>
                                       <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ACCEPT_CODE" HeaderText="Reff No." >
                                        <ItemStyle Width="40%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ITEM_NAME" HeaderText="Item." >
                                        <ItemStyle Width="40%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CURRENCY_DESC" HeaderText="">
                                        <ItemStyle Width="0%"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PURCHASE_AMOUNT" HeaderText="Purchase Amount" DataFormatString= {0:N2}>
                                        <ItemStyle Width="20%" HorizontalAlign="Right"/>
                                    </asp:BoundField>
                                    <asp:CommandField ShowSelectButton="true" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                </div>
                <div class="tab-pane"  id="detail">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R80000010E" ID="btnAddDetail" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R80000010E" ID="btnDeleteDetail" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteDetail_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R80000010E" ID="btnSaveDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDetail_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchDetail" runat="server" DefaultButton="btnSearchDetail" class="input-group">
                                       <asp:TextBox ID="txtSearchDetail" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchDetail" runat="server" CssClass="btn btn-info" OnClick="btnSearchDetail_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                       </div>
                                   </asp:Panel>
                             </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updDetail" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListDetail" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                    OnPageIndexChanging="gvwListDetail_PageIndexChanging" OnRowDataBound="gvwListDetail_RowDataBound"
                                    EmptyDataText="There Is No Data">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate> 
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                 <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TRX_NAME" HeaderText="Transaction Type" >
                                            <ItemStyle Width="40%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Currency">
                                          <ItemStyle Width="25%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlCurrencyCodeDetail" CssClass="form-control">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                          <ItemStyle Width="35%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtAmountDetail" CssClass="form-control"/>
                                                <asp:RegularExpressionValidator ID="revAmountDetail" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmountDetail" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                                <asp:RequiredFieldValidator ID="rfvAmountDetail" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmountDetail" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                       <%-- <asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchDetail" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteDetail" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="tab-pane" id="termin">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R80000010E" ID="btnAddTermin" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                 <cc1:XUILinkButton RoleCode="R80000010E" ID="btnSaveTermin" runat="server" CssClass="btn btn-primary" OnClick="btnSaveTermin_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R80000010E" ID="btnDeleteTermin" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteTermin_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchTermin" runat="server" DefaultButton="btnSearchTermin" class="input-group">
                                       <asp:TextBox ID="txtSearchTermin" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchTermin" runat="server" CssClass="btn btn-info" OnClick="btnSearchTermin_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                       </div>
                                   </asp:Panel>
                             </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updTermin" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListTermin" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                    OnPageIndexChanging="gvwListTermin_PageIndexChanging" OnRowDataBound="gvwListTermin_RowDataBound"
                                    EmptyDataText="There Is No Data">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate> 
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                 <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TRX_NAME" HeaderText="Transaction Type" >
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name" >
                                            <ItemStyle Width="14%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="PERCENTAGE" HeaderText="Pct (%)" DataFormatString="{0:N0}" >
                                            <ItemStyle Width="3%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ADDITIONAL_AMOUNT" HeaderText="Additional Amount" DataFormatString="{0:N0}">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Discount Additional">
                                          <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtDiscountAdditional" CssClass="form-control" />
                                                <%--<cc1:XUITextBox runat="server" BindType="Both" ID="txtDiscountAdditional" CssClass="form-control" DataType="Number" Format="N2" ></cc1:XUITextBox>--%>
                                                <asp:RegularExpressionValidator ID="revDiscountAdditional" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDiscountAdditional" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>   
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PPN" HeaderText="PPN" DataFormatString="{0:N2}">
                                            <ItemStyle Width="6%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="PPH" HeaderText="PPH" DataFormatString="{0:N2}">
                                            <ItemStyle Width="6%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="AMOUNT" HeaderText="Amount" DataFormatString="{0:N2}">
                                            <ItemStyle Width="10%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                         <asp:TemplateField HeaderText="Discount">
                                          <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtDiscount" CssClass="form-control"/>
                                                <asp:RegularExpressionValidator ID="revDiscount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDiscount" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                               
                                            </ItemTemplate>
                                        </asp:TemplateField>
<%--                                         <asp:BoundField DataField="DISCOUNT_ADDITIONAL"  HeaderText="Discount Aditional" DataFormatString="{0:N2}">
                                            <ItemStyle Width="10%" HorizontalAlign="Right" />
                                        </asp:BoundField>--%>
                                        <asp:TemplateField HeaderText="Tax">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlTax" CssClass="form-control input-sm">
                                                </asp:DropDownList> 
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="PPH Payment">
                                        <ItemStyle Width="12%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlTaxType" CssClass="form-control input-sm">
                                                 <asp:ListItem Value="Prorate"> Prorate </asp:ListItem>
                                                <asp:ListItem Value="None"> None </asp:ListItem>
                                                <asp:ListItem Value="Full"> Full </asp:ListItem>
                                                </asp:DropDownList> 
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                               
                                       <%-- <asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchTermin" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteTermin" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="tab-pane" id="fee">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                
                            </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchFee" runat="server" DefaultButton="btnSearchFee" class="input-group">
                                       <asp:TextBox ID="txtSearchFee" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchFee" runat="server" CssClass="btn btn-info" OnClick="btnSearchFee_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                       </div>
                                   </asp:Panel>
                             </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updFee" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListFee" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                    OnPageIndexChanging="gvwListFee_PageIndexChanging"
                                    EmptyDataText="There Is No Data">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate> 
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:BoundField DataField="CODE_BARCODE" HeaderText="PO No.">
                                            <ItemStyle Width="25%" HorizontalAlign="center" />
                                        </asp:BoundField>--%>
                                        <asp:BoundField DataField="TRX_NAME" HeaderText="Transaction Type" >
                                            <ItemStyle Width="30%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CURRENCY_CODE" HeaderText="Currency" >
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CHARGED_TO_DESC" HeaderText="Currency" >
                                            <ItemStyle Width="25%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AMOUNT_FEE" HeaderText="Amount" DataFormatString="{0:N2}" >
                                            <ItemStyle Width="25%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                       <%-- <asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchFee" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                   </div>
                <div class="tab-pane"  id="AdvanceDeposit">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8">
                                <cc1:XUILinkButton ID="btnAddAdDep" RoleCode="R80000010E" runat="server" CssClass="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                 <cc1:XUILinkButton ID="btnAddDep" RoleCode="R80000010E" runat="server" CssClass="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton ID="btnDeleteAdDep" RoleCode="R80000010E" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteAdDep_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                               
                            <%--     <cc1:XUILinkButton ID="btnSaveAdDep" RoleCode="R80000010E" runat="server" CssClass="btn btn-primary" OnClick="btnSaveAdDep_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>--%>
                            </div>
                            <div class="col-sm-4">
                                <asp:Panel ID="pnlSearchAdDep" runat="server" DefaultButton="btnSearchAdDep" class="input-group">      
                                <asp:TextBox ID="txtSearchAdDep" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchAdDep" runat="server" CssClass="btn btn-info" OnClick="btnSearchAdDep_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                    <asp:UpdatePanel ID="UpdAdDep" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListAdDep" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                            AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                OnPageIndexChanging="gvwListAdDep_PageIndexChanging" 
                                onselectedindexchanged="gvwListAdDep_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <span>No</span>
                                        </HeaderTemplate> 
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                    <HeaderTemplate>
                                       <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ADVANCE_CODE" HeaderText="Reff code" >
                                        <ItemStyle Width="50%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ADVANCE_AMOUNT" HeaderText="Reff Amount" DataFormatString= {0:N2} >
                                        <ItemStyle Width="50%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                  <%--  <asp:CommandField ShowSelectButton="true" />--%>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchAdDep" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnDeleteAdDep" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                </div>
                <div class="tab-pane" id="UploadDoc">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R30000150E" ID="btnAddUploadDoc" runat="server" CssClass="btn btn-primary" OnClick="btnAddUploadDoc_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000150E" ID="btnSaveDocumentDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDocumentDetail_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton> 
                            </div>
                            <div class="col-sm-4 ">
                                <asp:Panel ID="pnlSearchDocReq" runat="server" DefaultButton="btnSearchDocReq" class="input-group">
                                <asp:TextBox ID="txtSearchDocReq" runat="server" CssClass="form-control" ></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchDocReq" runat="server" CssClass="btn btn-info" OnClick="btnSearchDocReq_Click"><i class="icon-search"></i> Search</asp:LinkButton>
                                </div>
                           </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:GridView ID="gvwListDocReq" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, INVOICE_CODE, PATHS, FILE, ID"
                            OnPageIndexChanging="gvwListDocReq_PageIndexChanging" OnRowDataBound="gvwListDocReq_OnRowDataBound" OnRowCommand="gvwListDocReq_RowCommand"
                            onselectedindexchanged="gvwListDocReq_SelectedIndexChanged" EmptyDataText="There is no data"  AllowSorting="true">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <span>No</span>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DESCRIPTION" HeaderText="Document" >
                                    <ItemStyle Width="40%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="File Name">
                                    <ItemStyle Width="60%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                         <asp:Label runat="server" Text='<%# Eval("PATHS") %>' ID="lblFileName"/>
                                         <br />
                                        <asp:FileUpload runat="server" ID="fupFilename" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                               <asp:TemplateField HeaderText="">
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <%--<asp:Label ID="btnPreviewDoc" runat="server">Preview</asp:Label>--%>
                                         <asp:LinkButton ID="btnPreviewDoc" runat="server" CausesValidation="false" Text="Preview"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                   <asp:TemplateField HeaderText="">
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDeleteDoc" runat="server" CausesValidation="false" Text="Delete" CommandName="del"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div> 
                
            </div>
        </div>
    </section>
    </asp:Panel> 
</asp:Content>


