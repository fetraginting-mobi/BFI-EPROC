<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="faitemgrouplist.aspx.cs" Inherits="module_fa_fagrouplist"%>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>Asset Grouping</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R30000120C" ID="btnAddFaGroup" runat="server" CssClass="btn btn-primary" onclick="btnAddFaGroup_Click"><i class="icon-plus"></i>Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R30000120D" ID="btnDeleteFaGroup" runat="server" CssClass="btn btn-danger" onclick="btnDeleteFaGroup_Click"><i class="icon-trash"></i>Delete</cc1:XUILinkButton>

                </div>
                <div class="col-sm-4"> 
                    <asp:Panel ID="pnlFaGroupSearch" runat="server" DefaultButton="btnFaGroupSearch" class="input-group">      
                        <asp:TextBox ID="txtFaGroupSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnFaGroupSearch" runat="server" CssClass="btn btn-info" OnClick="btnFaGroupSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListFaItemGroup" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="FA_ITEM_GROUP_CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                                <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblHeader" Text="Group Code"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblGroupCode" Text='<%# Eval("FA_ITEM_GROUP_CODE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="BRANCH_NAME" HeaderText="Branch Code">
                                <ItemStyle Width="25%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="LOCATION_NAME" HeaderText="Location">
                                <ItemStyle Width="25%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnFaGroupSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

