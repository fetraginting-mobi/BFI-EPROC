<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="sysdimension.aspx.cs" Inherits="module_commonmst_sysdimension" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <div class="row">
                <div class="col-sm-11">
                    <span>Dimension  Info</span>
                </div>
               <%-- <div class="col-sm-1"> (+) 2015/12/14 - 08:40- Adi - [for checking and creating lock]
                    <asp:Label ID="lblLocked" runat="server" Visible="false" CssClass="icon-lock icon-2x"></asp:Label>
                </div>--%>
            </div>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R40000050E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <div class="col-sm-2">
                            <label>Code *</label>
                        </div>
                        <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control" DBColumnName="CODE" SPParameterName="p_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
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
                            <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <div class="col-sm-2">
                            <label>Type</label>
                        </div>
                        <div class="col-sm-3">
                            <cc1:XUIRadioButtonList ID="rblType" runat="server" BindType="Both" DataType="String"
                                DBColumnName="TYPE" SPParameterName="p_type" RepeatDirection="Horizontal" 
                                onselectedindexchanged="rblType_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="T" Selected="True">Table &nbsp&nbsp</asp:ListItem>
                                <asp:ListItem Value="F">Function</asp:ListItem>
                            </cc1:XUIRadioButtonList>
                        </div>
                    </div>                            
                </div>
            </div>
            <asp:Panel ID="pnlTable" runat="server">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label>Table Name *</label>
                            </div>
                            <div class="col-sm-3">
                                <cc1:XUITextBox ID="txtTableName" runat="server" CssClass="form-control" DBColumnName="TABLE_NAME" SPParameterName="p_table_name" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvTableName" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtTableName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label>Column Name *</label>
                            </div>
                            <div class="col-sm-3">
                                <cc1:XUITextBox ID="txtColumnName" runat="server" CssClass="form-control" DBColumnName="COLUMN_NAME" SPParameterName="p_column_name" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvColumnName" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtColumnName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label>Primary Column *</label>
                            </div>
                            <div class="col-sm-3">
                                <cc1:XUITextBox ID="txtPrimaryColumn" runat="server" CssClass="form-control" DBColumnName="PRIMARY_COLUMN" SPParameterName="p_primary_column" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvPrimaryColumn" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtPrimaryColumn" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlFunction" runat="server">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label>Function *</label>                            
                            </div>
                            <div class="col-sm-5">
                                <cc1:XUITextBox ID="txtFunction" runat="server" CssClass="form-control" DBColumnName="FUNCTION_NAME" SPParameterName="p_function_name" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvFunction" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtFunction" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
            </asp:Panel>
            </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
        </asp:UpdatePanel>                
        </div>              
    </section>
    <section class="panel">
        <header class="panel-heading">
          <span>Dimension Value List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-6">
                   <cc1:XUILinkButton RoleCode="" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                   <cc1:XUILinkButton RoleCode="" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-6">
                <div class="col-sm-4">
                    <%--<cc1:XUIDropDownList ID="ddlSearch" runat="server" CssClass="form-control" DataType="String" BindType="None" Width="170px">
                        <asp:ListItem Value="CO">Code</asp:ListItem>
                        <asp:ListItem Value="DE">Description</asp:ListItem>
                        <asp:ListItem Value="TP">Type</asp:ListItem>
                    </cc1:XUIDropDownList>--%>
                    </div>
                    <div class="col-sm-8">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There is no data" >
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
                                    <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click(this)" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="VALUE" HeaderText="Value" SortExpression="VALUE">
                                <ItemStyle Width="40%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" SortExpression="DESCRIPTION">
                                <ItemStyle Width="60%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
