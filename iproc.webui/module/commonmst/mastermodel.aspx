<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastermodel.aspx.cs" Inherits="module_commonmst_mastermodel" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Model Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000115E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
       <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Code</label>
                            <div class="col-sm-9">
                                <cc1:XUILabel ID="lblCode" runat="server"  DBColumnName="CODE" SPParameterName="p_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <%--<div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Merk</label>
                             <div class="col-sm-9">
                             <cc1:XUIDropDownList ID="ddlMerk" runat="server" CssClass="form-control" DBColumnName="MERK_CODE" SPParameterName="p_merk_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>--%>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Merk</label>
                            <div class="col-sm-9">
                                <asp:LinkButton runat="server" ID="btnLookUpMerk" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtMerk" style="display:none" runat="server" CssClass="form-control" DBColumnName="MERK_CODE" SPParameterName="p_merk_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblMerk" runat="server"  DBColumnName="MERK_CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblMerkName" runat="server"  DBColumnName="MERK_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                
                                <%--<asp:RequiredFieldValidator ID="rfvMerk" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMerk" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                   <%-- <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Type</label>
                             <div class="col-sm-9">
                             <cc1:XUIDropDownList ID="XUIDropDownList1" runat="server" CssClass="form-control" DBColumnName="MERK_CODE" SPParameterName="p_merk_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>--%>
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Type</label>
                            <div class="col-sm-9">
                                <asp:LinkButton runat="server" ID="btnLookUpType" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtType" style="display:none" runat="server" CssClass="form-control" DBColumnName="TYPE_CODE" SPParameterName="p_type_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblType" runat="server"  DBColumnName="TYPE_CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblTypeName" runat="server"  DBColumnName="TYPE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <%--<asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtType" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Model Name *</label>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtTypeName" runat="server" CssClass="form-control" placeholder="Model Name" DBColumnName="MODEL_NAME" SPParameterName="p_type_name" MaxLength="100" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvTypeName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTypeName" Display="Dynamic"></asp:RequiredFieldValidator>
                               <%-- <asp:RegularExpressionValidator ID="revTypeName" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTypeName" ValidationExpression="^([\sA-Za-z0-9]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Active</label>
                            <div class="col-sm-9">
                                <cc1:XUICheckBox ID="cbxIsActive" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" runat="server" Checked="true" />
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

