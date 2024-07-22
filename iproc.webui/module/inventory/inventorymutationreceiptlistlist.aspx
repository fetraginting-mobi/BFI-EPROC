<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventorymutationreceiptlistlist.aspx.cs" Inherits="module_inventory_inventorymutationreceiptlistlist" %>


<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
    <header class="panel-heading">
          <span>Inventory Mutation Receipt List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R60000115E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i> Receive</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
      
        	<div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Branch</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Status</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlStatus" Width="200px" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Selected Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="SENT">SENT</asp:ListItem>
                                <asp:ListItem Value="RECEIVED">RECEIVED</asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div> 
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="CODE_BARCODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There Is No Data">
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
                              <asp:BoundField DataField="MUTATION_NO" HeaderText="Mutation No.">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FROM_BRANCH" HeaderText="From Branch">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="TO_LOCATION" HeaderText="To Location">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_DESCRIPTION" HeaderText="Remarks">
                                <ItemStyle Width="25%"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Receive Date" SortExpression="RECEIVE_DATE">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Enabled = "false" Text='<%# Eval("RECEIVE_DATE", "{0:dd/MM/yyyy}") %>' ID="txtReceiveDate" Height="35px" CssClass="form-control default-date-picker-all date-only number-only"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="STATUS" HeaderText="Status">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                           <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <%--<asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


