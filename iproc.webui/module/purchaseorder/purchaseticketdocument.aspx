<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchaseticketdocument.aspx.cs" Inherits="module_purchaseorder_purchaseticketdocument" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Document Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R60000142E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                   
                    <%--<asp:LinkButton ID="btnReloadLocation" runat="server" OnClick="btnReloadLocation_Click" CausesValidation="false" Text="Reload" style="display:none"></asp:LinkButton>--%>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
           
                    <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text=0></cc1:XUILabel>
                    <cc1:XUILabel ID="lblCode" runat="server"  DBColumnName="BARCODE" SPParameterName="p_barcode" DataType="String" BindType="UIToDBOnly" MaxLength="14"  style = "Display:none;"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblIdDetail" runat="server" Visible="false" BindType="Both" DBColumnName="ID_DETAIL" SPParameterName="p_id_detail" DataType="Integer" Text=0></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Trx Code.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblTrxCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                   </div>
                                </div>
                            </div>                            
                        </div>
                    
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Document Name *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtDocumentName" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="GENERAL_DOC_CODE" MaxLength="50" SPParameterName="p_general_doc_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDocumentName" Display="Dynamic"></asp:RequiredFieldValidator> 
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


