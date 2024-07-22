<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masteruploaddefinition.aspx.cs" Inherits="module_upload_masteruploaddefinition" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Upload Definition Info</span>
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
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Code *</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="CODE" SPParameterName="p_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">SP Name *</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtSPName" runat="server" CssClass="form-control" placeholder="SP Name" DBColumnName="SP_NAME" SPParameterName="p_sp_name" MaxLength="200" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvSPName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSPName" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Description *</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>                  
        </div>
    </section>
    
    <section class="panel">
        <header class="panel-heading">
          <span>Upload Definition Column</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnAddDefinitionColumn" RoleCode="R04000008E" runat="server" CssClass="btn btn-primary" OnClick="btnAddDefinitionColumn_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnDeleteDefinitionColumn" RoleCode="R04000008E" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteDefinitionColumn_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">
                     <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                  </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="updDefinitionColumn" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListDefinitionColumn" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwListDefinitionColumn_PageIndexChanging" 
                        onselectedindexchanged="gvwListDefinitionColumn_SelectedIndexChanged" EmptyDataText="There is no data">
                        <Columns>
                             <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox runat="server" ID="chbCheckedAll" AutoPostBack="true" OnCheckedChanged="chbCheckedAll_CheckedChanged"/>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chbChecked"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="FIELD_ON_EXCEL" HeaderText="Field On Excel">
                                <ItemStyle Width="40%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PARAMETER" HeaderText="DB Parameter">
                                <ItemStyle Width="40%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DATATYPE" HeaderText="Data Type">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteDefinitionColumn" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
