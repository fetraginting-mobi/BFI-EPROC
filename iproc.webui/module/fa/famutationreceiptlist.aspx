<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="famutationreceiptlist.aspx.cs" Inherits="module_fa_famutationreceiptlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
    <header class="panel-heading">
          <span>FA Mutation Receipt List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R90000085E" runat="server" CssClass="btn btn-primary" style="display:none" OnClick="btnSave_Click"><i class="icon-save"></i> </cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>
                        <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DataType="String" BindType="None" style="display:none"></cc1:XUITextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
        	<div class="row">
        	  
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
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
                            <asp:BoundField DataField="CODE" HeaderText="FA Mutation No.">
                                <ItemStyle Width="15%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="FROM_COST_CENTER" HeaderText="From Cost Center">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="TO_LOCATION_CODE" HeaderText="To Location">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            
                            <asp:BoundField DataField="ITEM_CODE" HeaderText="Asset Code">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Asset Name">
                                <ItemStyle Width="20%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_DESCRIPTION" HeaderText="Description">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Receive Date" SortExpression="RECEIVE_DATE">
                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("RECEIVE_DATE", "{0:dd/MM/yyyy}") %>' ID="txtReceiveDate" Height="35px" Enabled="false" CssClass="form-control default-date-picker date-only number-only"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                           <asp:CommandField ShowSelectButton="true" />
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



