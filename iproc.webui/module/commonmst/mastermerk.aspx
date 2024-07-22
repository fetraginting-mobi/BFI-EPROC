<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="mastermerk.aspx.cs" Inherits="module_commonmst_mastermerk" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Merk Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000100E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
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
                                <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" SPParameterName="p_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Name *</label>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtMerkName" runat="server" CssClass="form-control" placeholder="Merk Name" DBColumnName="MERK_NAME" SPParameterName="p_merk_name" MaxLength="100" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvMerkName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMerkName" Display="Dynamic"></asp:RequiredFieldValidator>
                                <%--<asp:RegularExpressionValidator ID="revMerkName" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMerkName" ValidationExpression="^([\sA-Za-z0-9]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>--%>
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
