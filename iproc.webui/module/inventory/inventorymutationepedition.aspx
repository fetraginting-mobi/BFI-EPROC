<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventorymutationepedition.aspx.cs" Inherits="module_inventory_inventorymutationepedition" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Inventory Mutation Expedition Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R60000110E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Inventory Mutation No.</label>
                                <div class="col-sm-5">
                                   <%-- <cc1:XUILabel ID="lblExpedition" runat="server" DBColumnName="CODE_BARCODE" DataType="String" BindType="DBToUIOnly" MaxLength="14" ></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtExpedition" Style="display:none" runat="server"  CssClass="form-control" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String" BindType="Both"></cc1:XUITextBox>--%>
                                        <!--ID-->
                                    <cc1:XUILabel ID="lblID" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0" style= "display:none;"></cc1:XUILabel>
                                    <!--Barcode-->
                                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" Visible="false" BindType="Both" DBColumnName="IM_CODE" SPParameterName="p_im_code" DataType="String" Text="0" style= "display:none;"></cc1:XUILabel>
                                    <!--Location-->
                                             
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblIMStatus" runat="server" DBColumnName="IM_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                </div>
                            </div>      
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Trx Code *</label>
                                <div class="col-sm-5">    
                                    <cc1:XUIDropDownList ID="ddlTRX" runat="server" CssClass="form-control" placeholder="TRX" DBColumnName="TRX_CODE" SPParameterName="p_trx_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Amount *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Amount" DBColumnName="AMOUNT" SPParameterName="p_amount" DataType="Number" BindType="Both" MaxLength="15" Format="N2"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmount" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>                            
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <%--<asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

