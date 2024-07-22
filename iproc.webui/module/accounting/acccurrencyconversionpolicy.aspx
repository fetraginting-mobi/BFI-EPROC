<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="acccurrencyconversionpolicy.aspx.cs" Inherits="module_accounting_acccurrencyconversionpolicy" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>Gain/Loss A/C</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R12000020E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
      <div class="panel-body form-horizontal">
      <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="row" style="display:none">
                <div class="col-sm-6">
                    <div class="col-sm-12">
                        <cc1:XUILabel ID="lblID" runat="server" DataType="String" SPParameterName="p_id" DBColumnName="ID" BindType="Both" ></cc1:XUILabel>
                    </div>
                </div>
            </div>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Currency</label>
                        <div class="col-sm-4">
                            <cc1:XUIDropDownList ID="ddlCurrency" runat="server" CssClass="form-control" DBColumnName="CURRENCY" SPParameterName="p_currency" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                        </div>
                    </div>                            
                </div>
             </div>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Chart Of Account</label>
                        <div class="col-sm-8">
                            <asp:LinkButton runat="server" ID="btnLookUpAccChart" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                            <asp:RequiredFieldValidator ID="rfvtxtAccNo" runat="server" ErrorMessage="*" ControlToValidate="txtAccNo" Display="Dynamic"></asp:RequiredFieldValidator>
                            <cc1:XUITextBox ID="txtAccNo" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ACC_NO" SPParameterName="p_acc_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID = "lblAccNo" runat="server" DBColumnName="ACC_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblAccName" runat="server" DBColumnName="ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
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

