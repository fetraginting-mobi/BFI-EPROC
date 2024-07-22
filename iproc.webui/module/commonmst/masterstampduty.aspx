<%@ Page Language="C#" MasterPageFile="~/iproc.master"  AutoEventWireup="true" CodeFile="masterstampduty.aspx.cs" Inherits="module_commonmst_masterstampduty" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Master Stamp Duty</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000180E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <%--<cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style = "Display:none;"></cc1:XUILabel>  --%>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-5 ">Transaction From *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTransactionFrom" runat="server" CssClass="form-control" placeholder="Transaction From" DBColumnName="TRANSACTION_FROM" SPParameterName="p_transaction_from" DataType="Number" BindType="Both" MaxLength="15" Format="N2"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvTransactionFrom" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTransactionFrom" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revTransactionFrom" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTransactionFrom" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>   
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-5 ">Transaction To *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTransactionTo" runat="server" CssClass="form-control" placeholder="Transaction To" DBColumnName="TRANSACTION_TO" SPParameterName="p_transaction_to" DataType="Number" BindType="Both" MaxLength="15" Format="N2"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvTransactionTo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTransactionTo" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revTransactionTo" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTransactionTo" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>   
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-5 ">Currency *</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlCurrency" runat="server" CssClass="form-control" placeholder="Currency" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCurrency" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlCurrency" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>   
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-5 ">Amount *</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Amount" DBColumnName="AMOUNT" SPParameterName="p_amount" DataType="Number" BindType="Both" MaxLength="15" Format="N2"></cc1:XUITextBox>
                                        <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmount" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>                            
                        </div>
                        <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-5">Active</label>
                                <div class="col-sm-5">
                                    <cc1:XUICheckBox ID="cbxIsActiveDivision" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" runat="server" Checked="true" />
                                </div>
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



