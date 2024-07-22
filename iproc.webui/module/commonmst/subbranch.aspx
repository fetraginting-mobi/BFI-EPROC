<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="subbranch.aspx.cs" Inherits="module_commonmst_subbranch" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server"> 
    <section class="panel">
        <header class="panel-heading">
          <span>Sub Branch Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R90000010E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
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
                                <label class="col-sm-3">Code *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="CODE" SPParameterName="p_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>   
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Name *</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtName" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>   
                    </div>  
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Address *</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" DBColumnName="ADDRESS" SPParameterName="p_address" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtAddress" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAddress" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">District *</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtDistrict" runat="server" CssClass="form-control" placeholder="District" DBColumnName="DISTRICT" SPParameterName="p_district" MaxLength="400" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="revDistrict" ControlToValidate="txtAddress" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDistrict" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Sub District *</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtSubDistrict" runat="server" CssClass="form-control" placeholder="Sub District" DBColumnName="SUBDISTRICT" SPParameterName="p_subdistrict" MaxLength="400" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="refSubDistrict" ControlToValidate="txtSubDistrict" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvSubDistrict" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSubDistrict" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Code Area. *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtCodeArea" runat="server" CssClass="form-control" placeholder="Code Area" DBColumnName="CODE_AREA" SPParameterName="p_code_area" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revCodeArea" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPhoneNo" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvCodeArea" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPhoneNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>      
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Phone No. *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPhoneNo" runat="server" CssClass="form-control" placeholder="Phone No" DBColumnName="TELP" SPParameterName="p_telp" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPhoneNo" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvPhoneNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPhoneNo" Display="Dynamic"></asp:RequiredFieldValidator>
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

