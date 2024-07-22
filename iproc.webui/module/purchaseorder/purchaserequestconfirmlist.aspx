<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchaserequestconfirmlist.aspx.cs" Inherits="module_purchaseorder_purchaserequestconfirmlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Purchase Confirm List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-6">
                    <cc1:XUILinkButton RoleCode="IPR020800U" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                </div>
                <div class="col-sm-6">
                 <div class="col-sm-4">
                 </div>
                    <div class="col-sm-8">
                      <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" ></asp:TextBox>  
                            <div class="input-group-btn">
                                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search" ></i>  Search</asp:LinkButton>
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
                        AllowPaging="true" PageSize="10" DataKeyNames="ID" AllowSorting="true"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        EmptyDataText="There is no data" Width="100%" >
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
                            <asp:BoundField DataField="ITEM_CODE" HeaderText="Procurment Request No." SortExpression="ITEM_CODE">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="ITEM_GROUP_NAME" HeaderText="Item Group Name" SortExpression="ITEM_GROUP_NAME">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>                                 
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name" SortExpression="ITEM_NAME">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField> 
                            <asp:BoundField DataField="QUANTITY" HeaderText="Quantity" DataFormatString="{0:N0}" SortExpression="QUANTITY">
                                <ItemStyle Width="10%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ON_ACTION" HeaderText="Action" SortExpression="ON_ACTION">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Confirm Date" SortExpression="CONFIRM_DATE">
                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("CONFIRM_DATE", "{0:dd/MM/yyyy}") %>' ID="txtConfirmDate" Height="35px" CssClass="form-control default-date-picker date-only number-only"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="AGING" HeaderText="Aging" SortExpression="AGING">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="STATUS" HeaderText="Status" SortExpression="STATUS">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


