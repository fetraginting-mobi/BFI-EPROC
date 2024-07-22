<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterposition.aspx.cs"
    Inherits="module_commonmst_masterposition" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
           <div class="row">
                <div class="col-sm-11">
                    <span>Position Info</span>
                </div>
                <div class="col-sm-1">
                    <asp:Label ID="lblLocked" runat="server" Visible="false" CssClass="icon-lock icon-2x"></asp:Label>
                </div>
            </div>

        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <%--<asp:LinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>--%>
                    <asp:LinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>	     
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <div class="col-sm-2">
                            <label>Code *</label>
                            </div>    
                        <div class="col-sm-3">
                          <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control code-only" DBColumnName="CODE" SPParameterName="p_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                          <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                          
                        </div>
                    </div>                            
                </div>
            </div>         
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <div class="col-sm-2">
                            <label>Description *</label>
                            </div>    
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control " DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both" TextMode="MultiLine" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="valDescription" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,50}$" ErrorMessage="Format Invalid!" ToolTip="Please enter a maximum of 50 characters" Display="Dynamic"></asp:RegularExpressionValidator>
                        
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
               <div class="col-sm-12">
                   <div class="form-group">
                        <label class="col-sm-2">Active</label>
                        <div class="col-sm-4">
                            <cc1:XUICheckBox ID="chbIsActive" runat="server" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" Checked="true"></cc1:XUICheckBox>
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
