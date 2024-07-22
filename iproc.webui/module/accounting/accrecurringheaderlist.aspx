<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accrecurringheaderlist.aspx.cs" Inherits="module_accounting_accrecurringheaderlist" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
<section class="panel">
        <header class="panel-heading">
          <span>Recurring List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-6">
                    <cc1:XUILinkButton RoleCode="ACC010400C" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="ACC010400D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-6">
                    <div class="col-sm-4">
                    <cc1:XUIDropDownList ID="ddlSearch" runat="server" CssClass="form-control" DataType="String" BindType="None" Width="170px" AutoPostBack="true">
                        <%--<asp:ListItem Value="">All</asp:ListItem>--%>
                        <asp:ListItem Value="RN">Recurring No</asp:ListItem>
                        <asp:ListItem Value="FR">Frequency</asp:ListItem>
                        <asp:ListItem Value="DT">Start Date</asp:ListItem>
                        <asp:ListItem Value="DA">End Date</asp:ListItem>
                        <asp:ListItem Value="DE">Description</asp:ListItem>
                        <asp:ListItem Value="ST">Is Active</asp:ListItem>
                    </cc1:XUIDropDownList>
                    </div>
                    <div class="col-sm-8">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"     class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
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
                        AllowPaging="true" PageSize="10" DataKeyNames="RECURRING_NO"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data" OnSorting="gvwList_Sorting" AllowSorting="true">
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
                            <asp:BoundField DataField="RECURRING_NO" HeaderText="Recurring No." SortExpression="RECURRING_NO">
                                <ItemStyle Width="15%" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FREQUENCY_DESC" HeaderText="Frequency" SortExpression="FREQUENCY_DESC">
                                <ItemStyle Width="20%"  HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="START_DATE" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="START_DATE">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="END_DATE" HeaderText="End Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="END_DATE">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" SortExpression="DESCRIPTION">
                                <ItemStyle Width="25%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="IS_ACTIVE" HeaderText="Is Active" SortExpression="IS_ACTIVE">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

