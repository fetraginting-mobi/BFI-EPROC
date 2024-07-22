<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accclashlist.aspx.cs" Inherits="module_accounting_accclashlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Accumulation Profit/(Loss) Account List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnAddClass" RoleCode="R12000020E" runat="server" CssClass="btn btn-primary" OnClick="btnAddClass_Click" CausesValidation="false"><i class="icon-plus"></i>  Add</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnDeleteClass" RoleCode="R12000020E" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteClass_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                 <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchClass" class="input-group">
                        <asp:TextBox ID="txtSearchClass" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchClass" runat="server" CssClass="btn btn-info" OnClick="btnSearchClass_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>   
                    </asp:Panel>
                 </div>
             </div>
        </div>
         <div class="panel-body">                      
            <div class="row">
            <div class="col-sm-12">
                <asp:UpdatePanel ID="updGainLoss" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvwGainLoss" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                            AllowPaging="true"  DataKeyNames="ID" EmptyDataText="There is no data"  onselectedindexchanged="SelectedIndexChanged">                                           
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
                                    <asp:BoundField DataField="CURRENCY" HeaderText="Curr.">
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ACC_NO" HeaderText="A/C No.">
                                        <ItemStyle Width="30%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ACC_NAME" HeaderText="A/C Name">
                                        <ItemStyle Width="60%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:CommandField ShowSelectButton="true" />    
                               </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnDeleteClass" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnAddClass" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnSearchClass" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>   
        </div>
    </section>
</asp:Content>

