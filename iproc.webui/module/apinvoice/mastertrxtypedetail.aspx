<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastertrxtypedetail.aspx.cs"
    Inherits="module_apinvoice_mastertrxtypedetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Trx Type Detail Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000200E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
             <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Code</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblTrxCode" runat="server" DBColumnName="TRX_CODE" SPParameterName="p_trx_code" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtTrxCode" runat="server" CssClass="form-control" DBColumnName="TRX_CODE" SPParameterName="p_trx_code" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Currency Code *</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlCurrency" runat="server" CssClass="form-control" placeholder="Currency" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <%--<div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">ACC No *</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlCurrency2" runat="server" CssClass="form-control" placeholder="Currency" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                    </div>--%>
                    <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">ACC No. *</label>
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookUpACCNo" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtACCNo" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_NO" SPParameterName="p_acc_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblACCNo" runat="server"  style="display:none" DBColumnName="ACC_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblACCName"  runat="server"  DBColumnName="ACC_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
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
