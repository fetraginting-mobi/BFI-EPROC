<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masteruploaddefinitioncolumn.aspx.cs" Inherits="module_upload_masteruploaddefinitioncolumn" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Upload Definition Column Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R04000008E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <div class="row">
                <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text="0" style="display:none"></cc1:XUILabel>
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Code</label>
                        <div class="col-sm-5">
                            <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" SPParameterName="p_code" DataType="String" BindType="Both"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Description</label>
                        <div class="col-sm-5">
                            <cc1:XUILabel ID="lblDesc" runat="server" DBColumnName="DESCRIPTION" SPParameterName="p_description" DataType="String" BindType="Both"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Field On Excel *</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtFOE" runat="server" CssClass="form-control" placeholder="Field On Excel" DBColumnName="FIELD_ON_EXCEL" SPParameterName="p_field_on_excel" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvFOE" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFOE" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">DB Parameter *</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtFOB" runat="server" CssClass="form-control" placeholder="DB Parameter" DBColumnName="PARAMETER" SPParameterName="p_parameter" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvFOB" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFOB" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>  
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Data Type *</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtDataType" runat="server" CssClass="form-control" placeholder="Data Type" DBColumnName="DATATYPE" SPParameterName="p_datatype" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvDataType" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDataType" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>            
            </div>                
        </div>
    </section>
</asp:Content>
