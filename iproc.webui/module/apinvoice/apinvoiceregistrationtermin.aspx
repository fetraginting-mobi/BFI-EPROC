<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apinvoiceregistrationtermin.aspx.cs" Inherits="module_apinvoice_apinvoiceregistrationtermin" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Termin Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R80000010E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                     <!--ID-->
                     <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                     <!--Barcode-->
                     <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="INVOICE_CODE" SPParameterName="p_invoice_code" style="Display:none;" DataType="String" BindType="UIToDBOnly"  ></cc1:XUILabel>
                     <cc1:XUITextBox ID="txtCodeBarcode" runat="server" CssClass="form-control" placeholder="No" style="Display:none;"  MaxLength="15" DataType="String" BindType="None"></cc1:XUITextBox>    
                     <!--Barcode PO-->
                     <cc1:XUITextBox ID="txtPocode" runat="server" CssClass="form-control" placeholder="No" DBColumnName="PO_CODE" style="Display:none;"  MaxLength="15" DataType="String" BindType="DBToUIOnly" Format="N2"></cc1:XUITextBox>    
                     <cc1:XUITextBox ID="lblType" runat="server" DBColumnName="TYPE" DataType="String" BindType="DBToUIOnly" style="Display:none;"></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Transaction Code.</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlTrxCode" runat="server" DBColumnName="TRX_CODE" DataType="String" BindType="Both" AutoPostBack="true"  ></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Reff No</label>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpReffNo" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                         
                                    <cc1:XUITextBox ID="txtReffNo" style="display:none" runat="server"  CssClass="form-control" DBColumnName="REFF_NO" SPParameterName="p_reff_no" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblReffNo" runat="server" DBColumnName="REFF_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>      
                                    <asp:RequiredFieldValidator ID="rfvReffNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReffNo" Display="Dynamic"></asp:RequiredFieldValidator>  
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Percentage (%) *</label> 
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="lblPercentage" runat="server" DBColumnName="PERCENTAGE" SPParameterName="p_percentage" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N0"></cc1:XUILabel>      
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Amount</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblAmount" runat="server" DBColumnName="AMOUNT" SPParameterName="p_amount" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>                      
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

