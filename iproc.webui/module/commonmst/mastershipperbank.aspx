<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastershipperbank.aspx.cs" Inherits="module_commonmst_mastershipperbank" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Bank Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000160E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <%--<cc1:XUILabel ID="lblbranchcode" runat="server"  DBColumnName="BRANCH_CODE" Visible="true" SPParameterName="p_branch_code" BindType="Both" DataType="String" Style="display:none" ></cc1:XUILabel>--%>
                    <cc1:XUITextBox ID="txtShipperCode" runat="server" CssClass="form-control" DBColumnName="TRX_CODE" SPParameterName="p_trx_code" MaxLength="10" DataType="String" BindType="Both" Style="display:none" ></cc1:XUITextBox>
                    <cc1:XUILabel ID="lblId" runat="server" DBColumnName="ID" SPParameterName="p_id" BindType="Both" DataType="Integer" Text="0" Style="display:none"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Currency</label>
                                <div class="col-sm-4">
                                    <cc1:XUIDropDownList ID="ddlCurrency" runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Bank *</label>
                                <div class="col-sm-3">
                                    <%--<cc1:XUIDropDownList ID="ddlBankName" runat="server" CssClass="form-control" placeholder="Bank Name" DBColumnName="BANK_NAME" SPParameterName="p_bank_name" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUIDropDownList>--%>
                                    <asp:LinkButton runat="server" ID="btnLookUpBank" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtBankCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="BANK_CODE" SPParameterName="p_bank_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblBankCode" runat="server" DBColumnName="BANK_CODE" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtBankName" style="display:none" runat="server"  CssClass="form-control" DBColumnName="BANK_NAME" SPParameterName="p_bank_name" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblBankName"  runat="server"  DBColumnName="BANK_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBankCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    
                                </div>
                            </div>                            
                        </div>
                   </div>
                      <div class="row">
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Bank Branch *</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtBankBranch" runat="server" CssClass="form-control" placeholder="Bank Branch" DBColumnName="BANK_BRANCH" SPParameterName="p_bank_branch" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBankBranch" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="revBankBranch" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtBankBranch" ValidationExpression="^([\sA-Za-z]+)$" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Account No. *</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtBankAccount" runat="server" CssClass="form-control" placeholder="Bank Account No." DBColumnName="BANK_ACCOUNT_NO" SPParameterName="p_bank_account_no" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RqvBankAccount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBankAccount" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revBankAccount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtBankAccount" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Account Name *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtAccountName" runat="server" CssClass="form-control" placeholder="Account Name" DBColumnName="BANK_ACCOUNT_NAME" SPParameterName="p_bank_account_name" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rqvAccountName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccountName" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                   </div>
                    <div class="row" >
                        <div class="col-sm-12" Style="display:none">
                            <div class="form-group">
                                <label class="col-sm-2">Bank Type</label>
                                <div class="col-sm-2">
                                    <cc1:XUIDropDownList ID="ddlBankType" runat="server" CssClass="form-control" DBColumnName="BANK_TYPE" SPParameterName="p_bank_type" BindType="Both" DataType="String" >
                                    <asp:ListItem Value="KONVENSIONAL"></asp:ListItem>
                                    <asp:ListItem Value="SYARIAH"></asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>                            
                       </div>
                  </div>
                  <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Chart Of Account *</label>
                                <div class="col-sm-3">
                                    <asp:LinkButton runat="server" ID="btnLookUpAccChart" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtAccNo" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ACC_NO" SPParameterName="p_acc_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAccNo" runat="server" DBColumnName="ACC_NO" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblName"  runat="server"  DBColumnName="ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvtxtAccNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>                             
                  </div>
                    <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Default Flag</label>
                            <div class="col-sm-5">
                                <cc1:XUICheckBox ID="chbIsDefaultFlag" runat="server" DBColumnName="DEFAULT_FLAG" SPParameterName="p_default_flag" DataType="String" BindType="Both"></cc1:XUICheckBox>
                            </div>
                        </div>                            
                    </div>
                  </div> 
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                  <%--  <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

