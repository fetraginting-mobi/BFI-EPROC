<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apdepositallocationdetail.aspx.cs" Inherits="module_apinvoice_apdepositallocationdetail" Title="Untitled Page" %>

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
                    <asp:LinkButton ID="btnSave" RoleCode="R80000080E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" RoleCode="R80000080E" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                   <!--ID-->
                   <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                   <!--Barcode-->
                   <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="DEPOSIT_CODE" SPParameterName="p_deposit_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
                   <cc1:XUITextBox ID="txtEmpCode" style="Display:none;"  runat="server" CssClass="form-control" DBColumnName="EMP_CODE"  DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                   <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblDAStatus" runat="server" DBColumnName="DA_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNo" runat="server" DBColumnName="DEPOSIT_DESC" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Invoice No. *</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpInvoice" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                   
                                    <asp:RequiredFieldValidator ID="rfvInvoiceNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtInvoiceNo" Display="Dynamic"></asp:RequiredFieldValidator>                        
                                    <cc1:XUITextBox ID="txtInvoiceNo" style="display:none" runat="server" CssClass="form-control" DBColumnName="INVOICE_CODE" SPParameterName="p_invoice_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblInvoiceNo"  runat="server"  DBColumnName="CODE_BARCODE" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                   <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Invoice Date</label>
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="lblInvoiceDate" runat="server"  DBColumnName="INVOICE_DATE"  MaxLength="10" DataType="DateTime" BindType="DBToUIOnly" Format ="dd/MM/yyyy"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Invoice Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblBill" runat="server" CssClass="form-control" placeholder="Invoice Amount" DBColumnName="INVOICE_AMOUNT" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="False"></cc1:XUILabel> 
                                    <cc1:XUILabel ID="lblCurrencyDesc" style="display:none" runat="server" CssClass="form-control" placeholder="Currency Desc" DBColumnName="CURRENCY_DESC"  MaxLength="50" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>      
                                </div>
                            </div>                            
                        </div>
                    </div>
                   <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PPN</label>
                               <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblPPN" runat="server" CssClass="form-control" placeholder="PPN" DBColumnName="PPN"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="False"></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PPH</label>
                                <div class="col-sm-5">
                                    <cc1:XUIlabel ID="lblPPH" runat="server" CssClass="form-control" placeholder="PPH" DBColumnName="PPH"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="False"></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div>
                    </div>
                   <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Discount</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblDiscount" runat="server" CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="False"></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtNetBill" runat="server" CssClass="form-control" placeholder="Total Amount" DBColumnName="TOTAL_AMOUNT" SPParameterName="p_invoice_amount"  MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="False"></cc1:XUITextBox>    
                                </div>
                            </div>                            
                        </div>
                     </div>
                   <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remaining Bill</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtRemainingBill" runat="server" CssClass="form-control" placeholder="Remaining Bill" DBColumnName="REMAINING_BILL" SPParameterName="p_remaining_bill" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Text="0.00" Enabled="False"></cc1:XUITextBox>    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Allocation *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtAllocation" runat="server" CssClass="form-control" placeholder="Payment" DBColumnName="ALLOCATION_DEPOSIT" SPParameterName="p_allocation_deposit" MaxLength="20" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>    
                                    <asp:RequiredFieldValidator ID="rfvAllocation" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAllocation" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                   <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="200" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator> 
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

