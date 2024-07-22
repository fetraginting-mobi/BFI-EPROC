<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastercurrency.aspx.cs" Inherits="module_commonmst_mastercurrency" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Currency</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R30000050E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Currency *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtCurrencyCode" runat="server" CssClass="form-control" placeholder="Currency" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" MaxLength="3" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCurrencyCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCurrencyCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="revCurrencyCode" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtCurrencyCode" ValidationExpression="^[a-zA-Z0-9]+$"  Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revDescription" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDescription" ValidationExpression="^([\sA-Za-z0-9]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Base Currency</label>                                
                                <div class="col-sm-5">
                                    <cc1:XUICheckBox ID="chbBaseCurrency" runat="server" DBColumnName="BASE_CURRENCY" SPParameterName="p_base_currency" MaxLength="1" DataType="String" BindType="Both"></cc1:XUICheckBox>                                    
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
