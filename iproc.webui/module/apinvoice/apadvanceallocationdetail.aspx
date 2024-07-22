<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apadvanceallocationdetail.aspx.cs" Inherits="module_apinvoice_apadvanceallocationdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Invoice Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R80000070E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
              <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                       <!--ID-->
                       <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                       <!--Barcode-->
                       <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="ADVANCE_CODE" SPParameterName="p_advance_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
                       <!--EMP_CODE-->
                       <cc1:XUITextBox ID="txtEmpCode" style="Display:none;"  runat="server" CssClass="form-control" DBColumnName="EMP_CODE"  DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                       <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">No.</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblAAStatus" runat="server" DBColumnName="AA_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                        <cc1:XUILabel ID="lblNo" runat="server" DBColumnName="ADVANCE_DESC" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>    
                                    </div>
                                </div>                            
                            </div> 
                        </div>
                       <div class="row">
                        <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Invoice No. *</label>
                                    <div class="col-sm-8">
                                        <asp:LinkButton runat="server" ID="btnLookUpInvoice" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                                     
                                        <cc1:XUITextBox ID="txtInvoiceNo" style="display:none" runat="server" CssClass="form-control" DBColumnName="INVOICE_CODE" SPParameterName="p_invoice_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblInvoiceDesc"  runat="server"  DBColumnName="INVOICE_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>    
                                        <asp:RequiredFieldValidator ID="rfvInvoiceNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtInvoiceNo" Display="Dynamic"></asp:RequiredFieldValidator>    
                                    </div>
                                </div>                            
                            </div> 
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Invoice Date</label>
                                    <div class="col-sm-4">
                                        <cc1:XUILabel ID="lblInvoiceDate" runat="server" placeholder="Invoice Date" DBColumnName="INVOICE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format ="dd/MM/yyyy"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblDepartmentDesc" runat="server" DBColumnName="DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
                                    <cc1:XUITextBox ID="txtDepartmentCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblDivision" runat="server" DBColumnName="DIVISION_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
                                    <cc1:XUITextBox ID="txtDivision" style="display:none" runat="server"  CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>
                    </div>
                       <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">PPN</label>
                                    <div class="col-sm-5">
                                        <cc1:XUILabel ID="lblPPN" runat="server"  placeholder="PPN" DBColumnName="PPN"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>    
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">PPH</label>
                                    <div class="col-sm-5">
                                        <cc1:XUILabel ID="lblPPH" runat="server" placeholder="PPH" DBColumnName="PPH"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>    
                                    </div>
                                </div>                            
                            </div>
                        </div>
                       <div class="row">
                             <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Invoice Amount</label>
                                    <div class="col-sm-5">
                                        <cc1:XUILabel ID="lblBill" runat="server"  placeholder="Bill" DBColumnName="INVOICE_AMOUNT"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel> 
                                        <cc1:XUILabel ID="lblCurrencyDesc" style="display:none" runat="server" CssClass="form-control" placeholder="Currency Desc" DBColumnName="CURRENCY_DESC"  MaxLength="50" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>   
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Total Amount</label>
                                    <div class="col-sm-5">
                                        <cc1:XUILabel ID="lblNetBill" runat="server"  placeholder="Total Amount" DBColumnName="TOTAL_AMOUNT"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>    
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Discount</label>
                                    <div class="col-sm-5">
                                        <cc1:XUILabel ID="lblDiscount" runat="server"  placeholder="DIscount" DBColumnName="DISCOUNT" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>    
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Allocation Advance *</label>
                                    <div class="col-sm-5">   
                                         <cc1:XUITextBox ID="txtAllocationAdvance" runat="server" CssClass="form-control" placeholder="Allocation Advance" DBColumnName="ALLOCATION_ADVANCE" SPParameterName="p_allocation_advance" DataType="Number" BindType="Both" MaxLength="20" Format="N2"  ></cc1:XUITextBox>
                                        <asp:RequiredFieldValidator ID="rfvAllocationAdvance" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAllocationAdvance" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="refAllocationAdvance" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAllocationAdvance" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                    </div>
                                </div>                            
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Remaining Bill</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtRemainingBill" style="display:none" runat="server" CssClass="form-control" placeholder="Remaining Bill" DBColumnName="REMAINING_BILL" SPParameterName="remaining_bill" DataType="Number" BindType="Both" Format="N2" Text= "0"></cc1:XUITextBox>    
                                        <cc1:XUILabel ID="lblRemainingBill" runat="server" DBColumnName="REMAINING_BILL"  DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>    
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Payment</label>
                                    <%--<asp:RequiredFieldValidator ID="rfvPayment" runat="server" ErrorMessage="*" ControlToValidate="txtPayment" Display="Dynamic"></asp:RequiredFieldValidator> --%>
                                    <div class="col-sm-5">
                                        <cc1:XUILabel ID="lblPayment" runat="server" DBColumnName="payment_advance"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" ></cc1:XUILabel>  
                                        <cc1:XUITextBox ID="txtpayment" style="display:none" runat="server" CssClass="form-control" DBColumnName="payment_advance" SPParameterName="p_payment_advance" MaxLength="14" DataType="Number" BindType="Both"></cc1:XUITextBox>     
                                    </div>
                                </div>                            
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-sm-6" style="display:none">
                                <div class="form-group">
                                    <label class="col-sm-4">Description</label>
                                    <div class="col-sm-7">
                                        <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="200" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>
                        </div> 
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

