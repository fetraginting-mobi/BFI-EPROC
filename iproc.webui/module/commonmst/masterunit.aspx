<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="masterunit.aspx.cs" Inherits="module_commonmst_masterunit" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>UOM Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000070E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
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
                                <cc1:XUITextBox ID="txtUnitCode" runat="server" CssClass="form-control" placeholder="Unit Code" DBColumnName="UNIT_CODE" SPParameterName="p_unit_code" MaxLength="10" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvUnitCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                <%--<asp:RegularExpressionValidator ID="revUnitCode" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtUnitCode" ValidationExpression="^[a-zA-Z0-9]+$" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Description *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtUnitDesc" runat="server" CssClass="form-control" placeholder="Unit Name" DBColumnName="UNIT_DESC" SPParameterName="p_unit_desc" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>
                             <%--<asp:RegularExpressionValidator ID="revUnitDesc" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtUnitDesc" ValidationExpression="^([\sA-Za-z0-9]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>--%>
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
