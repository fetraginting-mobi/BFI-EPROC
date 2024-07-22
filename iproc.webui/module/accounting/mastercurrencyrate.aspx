<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastercurrencyrate.aspx.cs" Inherits="module_commonmst_mastercurrencyrate" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Currency Rate</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R11000010E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblId" runat="server" DBColumnName="ID" SPParameterName="p_id" Visible="false" BindType="Both" DataType="Integer" Text="0"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Currency Code</label>
                                <div class="col-sm-4">
                                    <cc1:XUIDropDownList ID="ddlCurrency" runat="server" CssClass="form-control" DBColumnName="CURR_CODE" SPParameterName="p_curr_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Effective Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtEffDate" runat="server" CssClass="form-control default-date-picker" placeholder="Eff Date" DBColumnName="EFF_DATE" SPParameterName="p_eff_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvEffDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtEffDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtEffDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Sale Rate *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtSaleRate" runat="server" CssClass="form-control" placeholder="Sale Rate" DBColumnName="SALE_RATE" SPParameterName="p_sale_rate" MaxLength="18" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvSalesRate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSaleRate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtSaleRate" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                </div>
                            </div>                            
                        </div>
                    </div>               
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Buy Rate *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtBuyRate" runat="server" CssClass="form-control" placeholder="Buy Rate" DBColumnName="BUY_RATE" SPParameterName="p_buy_rate" MaxLength="18" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtBuyRate" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                    <asp:RequiredFieldValidator ID="rfvBuyRate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBuyRate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Mid Rate *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtSaleBuyMid" runat="server" CssClass="form-control" placeholder="Sale Buy Mid" DBColumnName="SALE_BUY_MID" SPParameterName="p_sale_buy_mid" MaxLength="18" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSaleBuyMid" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtSaleBuyMid" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
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
