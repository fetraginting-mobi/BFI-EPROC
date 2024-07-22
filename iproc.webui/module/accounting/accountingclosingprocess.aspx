<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accountingclosingprocess.aspx.cs" Inherits="module_accounting_accountingclosingprocess" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>End Of Month / Year Closing</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R12000140O" ID="btnProcess" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-certificate"></i>  Proceed</cc1:XUILinkButton>  
                </div>
            </div>
        </div>
        <div class="panel-body">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Period</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtperiod" runat="server" CssClass="form-control" SPParameterName="p_period" DataType="DateTime" BindType="Both" Enabled="false"></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
            </div>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Date</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtDate" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
            </div>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
                <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Process</label>
                    <asp:RequiredFieldValidator ID="rfvRvProcess" runat="server" ErrorMessage="*" ControlToValidate="rdRvProcess" Display="Dynamic"></asp:RequiredFieldValidator>
                    <div class="col-sm-5">
                         <cc1:XUIRadioButtonList ID="rdRvProcess" runat="server" SPParameterName="p_rv_process" DataType="String" BindType="UIToDBOnly" RepeatDirection="Horizontal">
                                <asp:ListItem Value="1" Text="Month End" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="2" Text="Year End"></asp:ListItem>
                         </cc1:XUIRadioButtonList>
                    </div>
                </div>                            
              </div>
            </div>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"></div>
                </div>
            </div>
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"></div>
                </div>
            </div>
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"></div>
                </div>
            </div>
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"></div>
                </div>
            </div>
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"></div>
                </div>
            </div>
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group"></div>
                </div>
            </div>
            </ContentTemplate>
                  <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnProcess" EventName="Click" />
                 </Triggers>
          </asp:UpdatePanel> 
    </section>
</asp:Content>

