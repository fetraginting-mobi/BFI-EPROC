<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="purchaseorderheader.aspx.cs" Inherits="module_purchaseorder_purchaseorderheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>Purchase Order Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R50000070E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" ValidationGroup="Header"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000070O" ID="btnApprovalTiered" Visible ="false" runat="server" CssClass="btn btn-success"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R50000070O" runat="server" CssClass="btn btn-success" CausesValidation="true" ValidationGroup="Header"><i class="icon-envelope"></i>   Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnReject" RoleCode="R50000070O" runat="server" CssClass="btn btn-danger" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnClose" RoleCode="R50000070O" runat="server" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnClose_Click"><i class="icon-remove"></i>  Closed PO</cc1:XUILinkButton>
                     <cc1:XUILinkButton ID="BtnCancelPO" RoleCode="R50000070O" runat="server" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnCancelPO_Click"><i class="icon-remove"></i>  Cancel PO</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPrint" RoleCode="R50000070P" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPrintPDF" RoleCode="R50000070P" runat="server" CssClass="btn btn-primary" OnClick="btnPrintPDF_Click" CausesValidation="false"><i class="icon-print"></i>  Print PDF</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                     <%--ID APPROVEL--%>
                      <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                       <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DBColumnName="OBJECT_AMOUNT" DataType="Number" Text="0" style="display:none;" BindType="Both"></cc1:XUILabel>
                    <div class="row">
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUILabel>
                        <cc1:XUITextBox ID="txtCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUITextBox>
                        <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String"  BindType="Both" style="display:none;"></cc1:XUILabel>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PO No.</label>
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                                    <cc1:XUILabel ID="lblFlagProcess" runat="server" DBColumnName="FLAG_PROCESS" DataType="String" BindType="DBToUIOnly" style="display:none;"  ></cc1:XUILabel>
                                   
                                </div>
                                <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></cc1:XUILinkButton>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status / Process</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagDesc" runat="server"  DBColumnName="TRANS_FLAG_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> /
                                    <cc1:XUILabel ID="lblProcess" runat="server"  DBColumnName="PROCESS" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtOrderDate" runat="server" CssClass="form-control default-date-picker" placeholder="Order Date" DBColumnName="ORDER_DATE" SPParameterName="p_order_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvOrderDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtOrderDate" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtOrderDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-6">
                                 <asp:UpdatePanel ID="UpB" runat="server">
                                        <ContentTemplate>
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" AutoPostBack= "true" BindType="Both" Enabled="false" ></cc1:XUIDropDownList>
                                    <cc1:XUITextBox ID="txtBranchCode" runat="server"  CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" MaxLength="18" BindType="DBToUIOnly" style="display:none"></cc1:XUITextBox>
                                    </ContentTemplate>
                                  </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Due Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtDueDate" runat="server" CssClass="form-control default-date-picker" placeholder="Due Date" DBColumnName="DUE_DATE" SPParameterName="p_due_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="revDueDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDueDate" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="reDuedate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtDueDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <asp:UpdatePanel ID="updDiv" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE"  SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="revddlDivision" runat="server" ControlToValidate="ddlDivision"
                                                 ErrorMessage="Value Required!" InitialValue="-"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Estimate Arrived Date</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtEstimateArrivedDate" runat="server" CssClass="form-control default-date-picker" placeholder="Estimate Arrived Date" DBColumnName="ESTIMATE_ARRIVED_DATE" SPParameterName="p_estimate_arrived_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                 
                                </div>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtEstimateArrivedDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                         </div>                      
                         <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                <asp:UpdatePanel ID="updDep" runat="server">
                                    <ContentTemplate>
                                        <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlDepartment" InitialValue="0" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator> 
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlDivision" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel> 
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Supplier *</label> 
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpSupplier" class="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtSupplierCode" runat="server"  CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" DataType="String" MaxLength="18" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtSupplier"  runat="server" DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"  Enabled="false" Width="200px" TextMode="MultiLine"  style="border:0px; background:inherit"></cc1:XUITextBox> 
                                    <asp:RequiredFieldValidator ID="rfvSupplier" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplier" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Sub Department</label>
                            <div class="col-sm-6">
                               <asp:UpdatePanel ID="updSub" runat="server">
                                 <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlSubDepartment" runat="server" CssClass="form-control" DBColumnName="SUB_DEPARTMENT_CODE" SPParameterName="p_sub_department_code" OnSelectedIndexChanged= "ddlSubDepartment_SelectedIndexChanged" AutoPostBack="true" DataType="String" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvddlSubDepartment" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator> 
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
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Order Type</label>
                                <div class="col-sm-8">
                                    <cc1:XUIRadioButtonList ID="rblOrderType" runat="server"  DBColumnName="ORDER_TYPE" SPParameterName="p_order_type" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" >
                                        <asp:ListItem Value="PO" Selected="True">PO&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="SPK">SPK&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="CNT">Contract</asp:ListItem>
                                    </cc1:XUIRadioButtonList>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                           <div class="form-group">
                               <label class="col-sm-4">Units</label>
                               <div class="col-sm-6">
                                   <asp:UpdatePanel ID="updUn" runat="server">
                                       <ContentTemplate>
                                           <cc1:XUIDropDownList ID="ddlUnits" runat="server" CssClass="form-control" DBColumnName="UNITS_CODE" SPParameterName="p_units_code"  DataType="String" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                                           <asp:RequiredFieldValidator ID="rfvddlUnits" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUnits" InitialValue="0" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator> 
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
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Additional Amount</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtAdditionalAmount" runat="server" CssClass="form-control" placeholder="Additional Amount" DBColumnName="ADDITIONAL_AMOUNT" SPParameterName="p_additional_amount" MaxLength="15" DataType="Number" Enabled="false" Text="0.00" Format="N2" BindType="Both" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total Price</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTotalAmount" runat="server" CssClass="form-control" placeholder="Total Amount" DBColumnName="TOTAL_AMOUNT" SPParameterName="p_total_amount" MaxLength="15" DataType="Number" Text="0.00" Format="N2" BindType="Both" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Fee Amount</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTotalFee" runat="server" CssClass="form-control" placeholder="Fee Amount" DBColumnName="TOTAL_FEE" SPParameterName="p_total_fee" MaxLength="15" DataType="Number" Format="N2" BindType="Both" Text="0.00" Enabled="false" ></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revTotalFee" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTotalFee" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator> 
                                </div>
                            </div>                            
                        </div>
                       <div class="col-sm-6">
                           <div class="form-group">
                                <label class="col-sm-4">PPH Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPPH" runat="server" CssClass="form-control" placeholder="PPH" DBColumnName="PPH" SPParameterName="p_pph" MaxLength="15" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>    
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Discount Amount</label>       
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtDiscount" runat="server" CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT" SPParameterName="p_discount" MaxLength="15" DataType="Number" Format="N2" BindType="Both" Text="0" Enabled="false" ></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revDiscount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDiscount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                </div>
                            </div>                            
                         </div> 
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PPN Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPPN" runat="server" CssClass="form-control" placeholder="PPN" DBColumnName="PPN" SPParameterName="p_ppn" MaxLength="15" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Deposit Amount</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtDepositAmount" runat="server" CssClass="form-control" placeholder="Deposit Amount" DBColumnName="DEPOSIT_AMOUNT" SPParameterName="p_deposit_amount" MaxLength="15" DataType="Number" Text="0.00" Format="N2" BindType="Both" ></cc1:XUITextBox>
                                     <asp:RegularExpressionValidator ID="refDepositAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDepositAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total PO</label>     
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTotalPOIDR" runat="server" CssClass="form-control" Enabled="false" placeholder="Total Amount" DBColumnName="TOTAL_PO_IDR" SPParameterName="p_total_amount_idr" MaxLength="15" DataType="Number" Text="0.00" Format="N2" BindType="DBToUIOnly"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblTotalPOIDR" runat="server" CssClass="form-control" Enabled="false" placeholder="Total Amount" DBColumnName="TOTAL_PO_IDR" SPParameterName="p_total_amount_idr" MaxLength="15" DataType="Number" Text="0.00" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-8">
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
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total PO (IDR)</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTotalPO" runat="server" CssClass="form-control" Enabled="false" placeholder="Total Amount IDR" DBColumnName="TOTAL_PO" SPParameterName="p_total_amount" MaxLength="15" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblTotalPO" runat="server" CssClass="form-control" Enabled="false" placeholder="Total Amount IDR" DBColumnName="TOTAL_PO" SPParameterName="p_total_amount" MaxLength="15" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Deposit No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDepositNo" runat="server"  placeholder="Deposit Reff No" DBColumnName="DEPOSIT_NO" SPParameterName="p_deposit_no" MaxLength="400" DataType="String" style="display:none;" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblDepositCode" runat="server" DBColumnName="DEPOSIT_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Is Termin</label>
                                   <div class="col-sm-6">
                                    <cc1:XUICheckBox ID="chbIsTermin" runat="server" BindType="Both" DataType="String" DBColumnName="IS_TERMIN" SPParameterName="p_is_termin"  ></cc1:XUICheckBox>
                                    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Currency</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlCurrency"  runat="server"  AutoPostBack="true"   OnSelectedIndexChanged="ddlCurrency_SelectedIndex" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                                </div>
                            </div>                             
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Rent Flag</label>
                                <div class="col-sm-5">
                                    <cc1:XUICheckBox ID="chbIsDefaultFlag" runat="server" DBColumnName="FLAG_PO_RENT" SPParameterName="p_flag_po_rent" DataType="String" BindType="Both"></cc1:XUICheckBox>
                                    <cc1:XUITextBox ID="txtRentFlag" runat="server" style="display:none;" CssClass="form-control" placeholder="Flag Rent"  DataType="String"  BindType="None" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>   
                        
                    </div>
                    
                    
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                               <label class="col-sm-4">Rate </label>
                                  <div class="col-sm-4">
                                     <cc1:XUITextBox ID="txtRate" runat="server" CssClass="form-control" DBColumnName="RATE" SPParameterName="p_rate" Text="1.00" Format="N2" DataType="Number" BindType="Both"></cc1:XUITextBox>
                                </div>
                             </div>
                        </div>
                         <div class="col-sm-6" runat="server" id="ToBank">
                            <div class="form-group">
                               <label class="col-sm-4">To Bank *</label>
                              
                                  <div class="col-sm-4">
                                     <asp:LinkButton runat="server" ID="btnLookUpToBank" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtToBank" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_BANK" SPParameterName="p_to_bank" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblBankName"  runat="server" TextMode="MultiLine" DBColumnName="TO_BANK_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <asp:RequiredFieldValidator ID="rfvToBank" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToBank" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator>
                                </div>
                             </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                               <label class="col-sm-4">Payment By *</label>
                                  <div class="col-sm-4">
                                     <cc1:XUIDropDownList ID="ddlPaymentBy" runat="server" CssClass="form-control" DBColumnName="PAYMENT_BY" SPParameterName="p_payment_by" AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentBy_SelectedIndex" BindType="Both" DataType="String">
                                       <asp:ListItem Selected Value="0" Text="-=Select=-"></asp:ListItem>
                                        <asp:ListItem Text="HO" Value="HO"></asp:ListItem>
                                        <asp:ListItem Text="BRANCH" Value="BRANCH"></asp:ListItem>
                                     </cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="rfvPaymentBy" runat="server" ErrorMessage="Required Field!"  InitialValue="0" ControlToValidate="ddlPaymentBy" ValidationGroup="Header" ></asp:RequiredFieldValidator>
                                </div>
                             </div>
                        </div>
                       <div class="col-sm-6">
                            <div class="form-group" style="display:none;">
                                <label class="col-sm-4" style="display:none;"></label>
                                <div class="col-sm-8">
                                    <cc1:XUIRadioButtonList ID="rblPaymentType" runat="server"  DBColumnName="TYPE" SPParameterName="p_type" DataType="String" style="display:none;" BindType="Both" RepeatLayout="Table"  RepeatDirection="Horizontal" >
                                        <asp:ListItem Value="TRF" Selected="True">TRANSFER&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="CSH">CASH&nbsp&nbsp</asp:ListItem>
                                    </cc1:XUIRadioButtonList>
                                </div>
                            </div>
                        </div>
                       <div class="col-sm-6" runat="server" id="ToRekName">
                            <div class="form-group">
                               <label class="col-sm-4">To Rek Name</label>
                                  <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtToRekName" runat="server" CssClass="form-control" placeholder="To Rek Name" DBColumnName="TO_REK_NAME" SPParameterName="p_to_rek_name" MaxLength="30" DataType="String" BindType="Both" TextMode="MultiLine"  style="border:0;  background:inherit;"></cc1:XUITextBox>
                                </div>
                             </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Receipt By *</label>
                                <div class="col-sm-4">
                                    <cc1:XUIDropDownList ID="ddlReceiptBy" runat="server" CssClass="form-control" DBColumnName="RECEIPT_BY" SPParameterName="p_receipt_by" BindType="Both" DataType="String">
                                       <asp:ListItem Selected Value="0" Text="-=Select=-"></asp:ListItem>
                                        <asp:ListItem Text="HO" Value="H"></asp:ListItem>
                                        <asp:ListItem Text="REQUESTOR" Value="R"></asp:ListItem>
                                     </cc1:XUIDropDownList>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required Field!"  InitialValue="0" ControlToValidate="ddlReceiptBy" ValidationGroup="Header" ></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6" runat="server" id="ToRekNo">
                            <div class="form-group">
                               <label class="col-sm-4">To Rek No</label>
                                  <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtToRekNo" runat="server" CssClass="form-control" placeholder="To Rek No." DBColumnName="TO_REK_NO" SPParameterName="p_to_rek_no" MaxLength="20" DataType="String" BindType="Both" TextMode="MultiLine" style="border:0; background:inherit;"></cc1:XUITextBox>
                                </div>
                             </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator2" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created </label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Modified </label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "EMP_NAME_MOD" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName= "MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div>                                        
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click"/>
                    <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click"/>
                    <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click"/>
                    <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click"/>
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click"/>
                </Triggers>
           </asp:UpdatePanel>
        </div>
    </section>
    
    <%--<asp:Panel runat="server" ID="pnlDetail">
    <section class="panel">  
        <div class="panel-body">                    
            <div class="tab-content tasi-tab"> --%>
    <%--tab panel 2--%>
    <asp:Panel runat="server" ID="pnlDetail">
    <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">       
              <li class="active">
                  <a href="#itemlist" id="poitemlist" onclick="javascript:fnSetTab('poitemlist');" data-toggle="tab" style="padding-bottom:28px">
                      Item List 
                  </a>
              </li>
              
              <li class="">
                  <a href="#TOP" id="poTOP" onclick="javascript:fnSetTab('poTOP');" data-toggle="tab" style="padding-bottom:28px">
                      Term of Payment
                  </a>
              </li> 
              <li class="">
                  <a href="#feeList" id="pofeelist" visible="false"  onclick="javascript:fnSetTab('pofeelist');" data-toggle="tab" style="padding-bottom:28px">
                      Fee
                  </a>
              </li>
              <li class="">
                  <a href="#UploadDoc" id="poupdoc" onclick="javascript:fnSetTab('poupdoc');" data-toggle="tab" style="padding-bottom:28px">
                       Upload Doc
                  </a>
              </li>
          </ul>
        </header>    
        
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
               <div class="tab-pane active" id="itemlist">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8">
                                <cc1:XUILinkButton RoleCode="R50000070E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000070E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="upd" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID,CURRENCY_CODE,PR_CODE,ITEM_CODE"
                                    OnRowDataBound="gvwList_OnRowDataBound" ShowFooter="true" 
                                    OnPageIndexChanging="gvwList_PageIndexChanging" 
                                    onselectedindexchanged="gvwList_SelectedIndexChanged"  EmptyDataText="There is no data" Width="100%" >
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
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                            <ItemStyle Width="25%"/>  
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ORDER_QUANTITY" HeaderText="Order Qty" DataFormatString= {0:N2} >
                                            <ItemStyle Width="5%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UNIT_DESC" HeaderText="UOM">
                                            <ItemStyle Width="15%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UNIT_PRICE" HeaderText="Unit Price" DataFormatString= {0:N2}>
                                            <ItemStyle Width="20%" HorizontalAlign="Right" />
                                            <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="True" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SUBTOTAL" HeaderText="Sub Total" DataFormatString= {0:N2}>
                                            <ItemStyle Width="20%" HorizontalAlign="Right" />
                                            <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="True" />
                                        </asp:BoundField>
                                            <asp:TemplateField HeaderText="Action">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                         <ItemTemplate>
                                        <asp:LinkButton ID="btnViewDocument" runat="server" CausesValidation="false" Text="View Document Request"/>
                                        </ItemTemplate>
                                         </asp:TemplateField>
                            
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                <%--<asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />--%>
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
               <div class="tab-pane" id="TOP">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R50000070E" ID="btnAddTOP" runat="server" CssClass="btn btn-primary" OnClick="btnAddTOP_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000070E" ID="btnDeleteTOP" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteTOP_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchTOP" runat="server" DefaultButton="btnSearchTOP" class="input-group">
                                       <asp:TextBox ID="txtSearchTOP" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchTOP" runat="server" CssClass="btn btn-info" OnClick="btnSearchTOP_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                                       </div>
                                   </asp:Panel>
                             </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updTOP" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListTOP" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID, TRX_CODE"
                                    OnPageIndexChanging="gvwListTOP_PageIndexChanging" 
                                    onselectedindexchanged="gvwListTOP_SelectedIndexChanged" EmptyDataText="There Is No Data">
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
                                        <%--<asp:BoundField DataField="CODE_BARCODE" HeaderText="PO No.">
                                            <ItemStyle Width="25%" HorizontalAlign="center" />
                                        </asp:BoundField>--%>
                                        <asp:BoundField DataField="TRX_CODE_NAME" HeaderText="Trx Code" >
                                            <ItemStyle Width="40%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PERCENTAGE" HeaderText="Percentage" DataFormatString="{0:N6}">
                                            <ItemStyle Width="30%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="AMOUNT" HeaderText="Amount"  DataFormatString="{0:N2}">
                                            <ItemStyle Width="30%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchTOP" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteTOP" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
               <div class="tab-pane" id="feeList" >
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R50000070E" ID="btnAddFee"  runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000070E" ID="btnDeleteFee" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteFee_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000070E" ID="btnSaveFee"  runat="server" CssClass="btn btn-primary" OnClick="btnSaveFee_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchFee" runat="server" DefaultButton="btnSearchFee" class="input-group">
                                       <asp:TextBox ID="txtSearchFee" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchFee" runat="server" CssClass="btn btn-info" OnClick="btnSearchFee_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
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
                                    OnPageIndexChanging="gvwListFee_PageIndexChanging" OnRowDataBound="gvwListFee_RowDataBound"
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
                                        <%--<asp:BoundField DataField="CODE_BARCODE" HeaderText="PO No.">
                                            <ItemStyle Width="25%" HorizontalAlign="center" />
                                        </asp:BoundField>--%>
                                        <asp:BoundField DataField="TRX_NAME" HeaderText="Transaction Type" >
                                            <ItemStyle Width="30%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Currency">
                                          <ItemStyle Width="20%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlCurrencyCode" CssClass="form-control">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Charged To">
                                          <ItemStyle Width="25%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlChargedTo" CssClass="form-control">
                                                </asp:DropDownList>
                                                   <asp:RequiredFieldValidator ID="rfvddlChargedTo" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlChargedTo" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                          <ItemStyle Width="25%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtAmountFee" CssClass="form-control"/>
                                                <asp:RegularExpressionValidator ID="revAmountFee" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmountFee" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                                <asp:RequiredFieldValidator ID="rfvAmountFee" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmountFee" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                       <%-- <asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchFee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteFee" EventName="Click" />
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
                        AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, PO_CODE, PATHS, FILE, ID"
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
                                <asp:BoundField DataField="DESCRIPTION" HeaderText="Document">
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
