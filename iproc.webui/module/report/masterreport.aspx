<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterreport.aspx.cs" Inherits="module_report_masterreport" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Report Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R04000007E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text="0" style="display:none;"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Name</label>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="*" ControlToValidate="txtName" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name" DBColumnName="NAME" SPParameterName="p_name" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Table</label>
                                <asp:RequiredFieldValidator ID="rfvTable" runat="server" ErrorMessage="*" ControlToValidate="txtTable" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTable" runat="server" CssClass="form-control" placeholder="Table Name" DBColumnName="TABLE_NAME" SPParameterName="p_table_name" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>   
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">SP</label>
                                <asp:RequiredFieldValidator ID="rfvSP" runat="server" ErrorMessage="*" ControlToValidate="txtSP" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtSP" runat="server" CssClass="form-control" placeholder="SP Name" DBColumnName="SP_NAME" SPParameterName="p_sp_name" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">File</label>
                                <asp:RequiredFieldValidator ID="rfvFileName" runat="server" ErrorMessage="*" ControlToValidate="txtFileName" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtFileName" runat="server" CssClass="form-control" placeholder="File Name" DBColumnName="FILE_NAME" SPParameterName="p_file_name" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>  
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Report</label>
                                <asp:RequiredFieldValidator ID="rfvReport" runat="server" ErrorMessage="*" ControlToValidate="txtReport" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtReport" runat="server" CssClass="form-control" placeholder="Report Name" DBColumnName="RPT_NAME" SPParameterName="p_rpt_name" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                            <label class="col-sm-2">Flag Code</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlFlag" runat="server" CssClass="form-control" SPParameterName="p_flag_code" DataType="String" BindType="UItoDBOnly">
                                        <asp:ListItem Value="INV">INVENTORY</asp:ListItem>
                                        <asp:ListItem Value="FA">FIXED ASSET</asp:ListItem>
                                        <asp:ListItem Value="GRN">GOOD RECEIPT NOTE</asp:ListItem>
                                        <asp:ListItem Value="AP">ACCOUNT PAYABLE</asp:ListItem>
                                        <asp:ListItem Value="PO">PURCHASE ORDER</asp:ListItem>
                                        <asp:ListItem Value="PR">PROMOTION</asp:ListItem>
                                    </cc1:XUIDropDownList>
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
