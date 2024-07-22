<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterlookupcolumn.aspx.cs" Inherits="module_commonmst_masterlookupcolumn" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section class="panel">
        <header class="panel-heading">
          <span>Lookup Column Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R20000060E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>                    
                    <asp:Panel ID="pnlLookupColumn" runat="server">   
                    <cc1:XUILabel ID="lblId" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text="0" style="display:none"></cc1:XUILabel>              
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                            <label class="col-sm-2">Lookup Code</label>                                
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblLookupCode" runat="server" DBColumnName="LOOKUP_CODE" SPParameterName="p_lookup_code" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <asp:Panel ID="pnlLookupDesc" runat="server">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-2">Description</label>                                
                                    <div class="col-sm-4">
                                        <cc1:XUILabel ID="lblLookupDesc" runat="server"  DBColumnName="DESCRIPTION" SPParameterName="p_description" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Order No *</label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtOrderNo" runat="server" CssClass="form-control" placeholder="Order No" DBColumnName="ORDER_NO" SPParameterName="p_order_no" MaxLength="10" DataType="Integer" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvOrderNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtOrderNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Field Name *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtFieldName" runat="server" CssClass="form-control" placeholder="Field Name" DBColumnName="FIELD_NAME" SPParameterName="p_field_name" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvFieldName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFieldName" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Header Name *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtHeaderName" runat="server" CssClass="form-control" placeholder="Header Name" DBColumnName="HEADER_NAME" SPParameterName="p_header_name" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvHeaderName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtHeaderName" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Width (%) *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtWidthPct" runat="server" CssClass="form-control" placeholder="Width (%)" DBColumnName="WIDTH_PCT" SPParameterName="p_width_pct" MaxLength="10" DataType="Integer" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvWidthPct" runat="server" ErrorMessage="Requied Field!" ControlToValidate="txtWidthPct" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Alignment</label>
                                <div class="col-sm-4">
                                    <cc1:XUIDropDownList ID="ddlAlign" runat="server" CssClass="form-control" DBColumnName="ALIGNMENT" SPParameterName="p_alignment" MaxLength="10" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Format</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtFormat" runat="server" CssClass="form-control" placeholder="Format" DBColumnName="FORMAT" SPParameterName="p_format" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Is Visible</label>                                
                                <div class="col-sm-4">
                                    <cc1:XUICheckBox ID="chbVisible" runat="server" DBColumnName="IS_VISIBLE" SPParameterName="p_is_visible" MaxLength="10" DataType="String" BindType="Both"></cc1:XUICheckBox>                                    
                                </div>
                            </div>                            
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Is Datakey</label>                                
                                <div class="col-sm-4">
                                    <cc1:XUICheckBox ID="chbDatakey" runat="server" DBColumnName="IS_DATAKEY" SPParameterName="p_is_datakey" MaxLength="10" DataType="String" BindType="Both"></cc1:XUICheckBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                  </asp:Panel>                                             
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>