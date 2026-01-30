<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masteritemdocument.aspx.cs" Inherits="module_commonmst_masteritemdocument" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R50000010E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton> 
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
                    <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text=0></cc1:XUILabel>
                    <cc1:XUILabel ID="lblCodeBarcode" runat="server"  DBColumnName="CODE" SPParameterName="p_code" DataType="String" BindType="UIToDBOnly" MaxLength="14"  style = "Display:none;"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly" style = "Display:none;"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Item Code.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="PR_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                                    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Item Name</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblName" runat="server" DBColumnName="PR_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                                    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Remark</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtremark" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="GENERAL_DOC_CODE" MaxLength="50" SPParameterName="p_general_doc_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">File Name *</label>
                                <div class="col-sm-5">
                                <cc1:XUILabel ID="lblFILE" runat="server" DBColumnName="FILE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <asp:FileUpload ID="fupFilename" runat="server"></asp:FileUpload>
                                <asp:RequiredFieldValidator ID="revlblFile" runat="server" ErrorMessage="Required Field!" ControlToValidate="fupFilename" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>                            
                            </div>
                        </div>
                    </div>
        </div>
    </section>
</asp:Content>
