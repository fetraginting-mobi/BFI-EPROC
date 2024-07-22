<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="faassetmaintenanceservice.aspx.cs" Inherits="module_fa_faassetmaintenanceservice" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>FA Asset Maintenance Service</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R90000120C" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">ID </label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="txtId" runat="server" style="display:none"  CssClass="form-control" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both"></cc1:XUILabel>                  
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">ID Header</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblIDHeader" runat="server" DBColumnName="ID_HEADER" SPParameterName="p_id_header" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Aset Code</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblBarcode" runat="server" DBColumnName="BARCODE" SPParameterName="p_barcode" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-3">
                                <label>Service *</label>
                                    <asp:RequiredFieldValidator ID="rfvService" runat="server" ErrorMessage="*" ToolTip="Please fill this field." ControlToValidate="txtServiceCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-sm-6">
                                    <div class="input-group">
                                        <asp:LinkButton ID="btnLookUpService" runat="server" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtServiceCode" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtServiceDesc" CssClass="form-control" runat="server" DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblServiceDesc" runat="server" DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                    </div> 
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                      <div class="col-sm-6" style="display:none;">
                            <div class="form-group">
                                <label class="col-sm-3">Receipt No</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Receipt No" DBColumnName="RECEIPT_NO" SPParameterName="p_receipt_no" MaxLength="400" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    
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

