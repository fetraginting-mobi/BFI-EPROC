<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="faitemgrouplist.aspx.cs" Inherits="module_fa_fagrouplist"%>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
<style>
    .grid-auto {
        table-layout: auto !important;
        width: 100% !important;
    }

    .grid-auto th,
    .grid-auto td {
        white-space: nowrap;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>FA Grouping Asset List</span>
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
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Status</label>
                        <div class="col-sm-2">
                            <cc1:XUIDropDownList ID="ddlStatus" Width="150px" runat="server" CssClass="form-control"  SPParameterName="p_status"  BindType="Both" DataType="String" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                         <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                        <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Not Active" Value="0"></asp:ListItem>
                           </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Cost Center</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlCostCenter" runat="server" Width="200px" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListFaItemGroup" runat="server" CssClass="display table table-bordered table-striped grid-auto" AutoGenerateColumns="false"
                        AllowPaging="true" PageSize="10" DataKeyNames="ASSET_GROUP_CODE" onselectedindexchanged="gvwList_SelectedIndexChanged" Width="100%">
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
                                    <asp:Label runat="server" ID="lblHeader" Text="Asset Group Code"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblGroupCode" Text='<%# Eval("ASSET_GROUP_CODE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblAssetGroupName" Text="Asset Group Name"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblAssetGroupName" Text='<%# Eval("ASSET_GROUP_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CRE_DATE" HeaderText="Date">
                                <ItemStyle HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="COST_CENTER" HeaderText="Cost Center">
                                <ItemStyle HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="LOCATION" HeaderText="Location">
                                <ItemStyle HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="TOTAL_ASSET" HeaderText="Total Asset">
                                <ItemStyle HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="STATUS" HeaderText="Status">
                                <ItemStyle HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="MOD_DATE" HeaderText="Modified Date">
                                <ItemStyle HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="MOD_BY" HeaderText="Modified By">
                                <ItemStyle HorizontalAlign="Left"  />
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

