<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterupload.aspx.cs" Inherits="module_upload_masterupload" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Select Data Upload</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R13000001E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Process</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-3">Code</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" SPParameterName="p_code" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <label class="col-sm-3">SP Name</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblSPName" runat="server" DBColumnName="SP_NAME" SPParameterName="p_sp_name" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>                
                <div class="col-sm-5">
                    <div class="form-group">
                        <label class="col-sm-3">Description</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblDescription" runat="server" DBColumnName="DESCRIPTION" SPParameterName="p_description" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-8">
                    <div class="input-group">
                        <asp:FileUpload ID="fup" runat="server"></asp:FileUpload>
                    </div>                            
                </div>
            </div>              
        </div>
    </section>
</asp:Content>

