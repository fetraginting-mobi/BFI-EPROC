<%@ Page Language="C#" Culture="id-ID" AutoEventWireup="true" MasterPageFile="~/iproc.master" CodeFile="eodmanual.aspx.cs" Inherits="module_accounting_eodmanual" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>End Off Day / End Off Month Manual</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <div class="input-group">
                        <cc1:XUILinkButton RoleCode="R37200005O" ID="btnProcess" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="true"><i class="icon-certificate"></i>  Process</cc1:XUILinkButton>         
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-2">Type</label>
                        <div class="col-sm-4">
                            <cc1:XUIRadioButtonList ID="rbType" runat="server" BindType="None" RepeatDirection="Horizontal">
                                <asp:ListItem Value="EOD" Text="EOD&nbsp&nbsp"></asp:ListItem>
                                <asp:ListItem Value="EOM" Text="EOM"></asp:ListItem>
                            </cc1:XUIRadioButtonList> 
                        </div>                                                
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-2">Date</label>
                            <asp:RequiredFieldValidator ID="rfvDate" runat="server" ErrorMessage="*" ControlToValidate="txtDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtDate" runat="server" CssClass="form-control default-date-picker" placeholder="EOD Date" SPParameterName="p_eod_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>                            
                </div>
            </div>
    </section>
</asp:Content>


