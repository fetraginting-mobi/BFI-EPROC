<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masteritemlist.aspx.cs" Inherits="module_commonmst_masteritemlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Item List</span>
        </header>
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#faasset" id="asset"  onclick="javascript:fnSetTab('asset');"  data-toggle="tab">
                     FA Asset
                  </a>
              </li>
             <li class="">
                  <a href="#inv" id="inven"  onclick="javascript:fnSetTab('inven');" data-toggle="tab">
                     Inventory
                  </a>
              </li>
              <li class="">
                  <a href="#invcons" id="invcon"  onclick="javascript:fnSetTab('invcon');" data-toggle="tab">
                     Inventory Consumtive
                  </a>
              </li>
              <li class="">
                  <a href="#exp" id="expense"  onclick="javascript:fnSetTab('expense');" data-toggle="tab">
                     Expense
                  </a>
              </li>
          </ul>
        </header>
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="faasset">
                    <header class="panel-heading">
                        <span></span>
                    </header>
                
                    <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8">
                            <cc1:XUILinkButton ID="btnAddFA" RoleCode="R30000130C" runat="server" CssClass="btn btn-primary" OnClick="btnAddFA_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDeleteFA" RoleCode="R30000130D" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteFA_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnCopyFA" RoleCode="R30000130C" runat="server" CssClass="btn btn-primary" OnClick="btnCopyFA_Click"><i class="icon-plus"></i>  Copy</cc1:XUILinkButton>
                        </div>
                        <div class="col-sm-4"> 
                            <asp:Panel ID="pnlSearchFA" runat="server" DefaultButton="btnSearchFA" class="input-group">      
                                <asp:TextBox ID="txtSearchFA" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchFA" runat="server" CssClass="btn btn-info" OnClick="btnSearchFA_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="upd" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListFA" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ITEM_CODE"
                                    OnPageIndexChanging="gvwListFA_PageIndexChanging" 
                                    onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                                        <asp:BoundField DataField="ITEM_CODE" HeaderText="Code">
                                            <ItemStyle Width="10%"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Name">
                                            <ItemStyle Width="20%"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DESCRIPTION" HeaderText="Group">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="OWNER" HeaderText="Owner">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UNIT_DESC" HeaderText="UOM">
                                            <ItemStyle Width="20%"   />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="STATUS" HeaderText="Status">
                                           <ItemStyle Width="10%" />
                                        </asp:BoundField> 
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchFA" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteFA" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                
                <div class="tab-pane" id="inv">
                    <header class="panel-heading">
                        <span></span>
                    </header>
                
                    <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8">
                            <cc1:XUILinkButton ID="btnAddInv" RoleCode="R30000130C" runat="server" CssClass="btn btn-primary" OnClick="btnAddInv_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDeleteInv" RoleCode="R30000130D" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteInv_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnCopyInv" RoleCode="R30000130D" runat="server" CssClass="btn btn-primary" OnClick="btnCopyInv_Click"><i class="icon-plus"></i>  Copy</cc1:XUILinkButton>
                        </div>
                        <div class="col-sm-4"> 
                            <asp:Panel ID="pnlSearchInv" runat="server" DefaultButton="btnSearchInv" class="input-group">      
                                <asp:TextBox ID="txtSearchInv" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchInv" runat="server" CssClass="btn btn-info" OnClick="btnSearchInv_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updInv" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListInv" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ITEM_CODE"
                                    OnPageIndexChanging="gvwListInv_PageIndexChanging" 
                                    onselectedindexchanged="gvwListInv_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                                        <asp:BoundField DataField="ITEM_CODE" HeaderText="Code">
                                            <ItemStyle Width="10%"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Name">
                                            <ItemStyle Width="20%"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DESCRIPTION" HeaderText="Group">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="OWNER" HeaderText="Owner">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UNIT_DESC" HeaderText="UOM">
                                            <ItemStyle Width="20%"   />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="STATUS" HeaderText="Status">
                                           <ItemStyle Width="10%" />
                                        </asp:BoundField> 
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchInv" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteInv" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="tab-pane" id="invcons">
                    <header class="panel-heading">
                        <span></span>
                    </header>
                
                    <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8">
                            <cc1:XUILinkButton ID="btnAddInvCons" RoleCode="R30000130C" runat="server" CssClass="btn btn-primary" OnClick="btnAddInvCons_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDeleteInvCons" RoleCode="R30000130D" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteInvCons_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnCopyInvCons" RoleCode="R30000130C" runat="server" CssClass="btn btn-primary" OnClick="btnCopyInvCons_Click"><i class="icon-plus"></i>  Copy</cc1:XUILinkButton>
                            
                        </div>
                        <div class="col-sm-4"> 
                            <asp:Panel ID="pnlSearchInvCons" runat="server" DefaultButton="btnSearchInvCons" class="input-group">      
                                <asp:TextBox ID="txtSearchInvCons" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchInvCons" runat="server" CssClass="btn btn-info" OnClick="btnSearchInvCons_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updInvCons" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListInvCons" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ITEM_CODE"
                                    OnPageIndexChanging="gvwListInvCons_PageIndexChanging" 
                                    onselectedindexchanged="gvwListInvCons_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                                        <asp:BoundField DataField="ITEM_CODE" HeaderText="Code">
                                            <ItemStyle Width="10%"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Name">
                                            <ItemStyle Width="20%"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DESCRIPTION" HeaderText="Group">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="OWNER" HeaderText="Owner">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UNIT_DESC" HeaderText="UOM">
                                            <ItemStyle Width="20%"   />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="STATUS" HeaderText="Status">
                                           <ItemStyle Width="10%" />
                                        </asp:BoundField> 
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchInvCons" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteInvCOns" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="tab-pane" id="exp">
                    <header class="panel-heading">
                        <span></span>
                    </header>
                
                    <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8">
                            <cc1:XUILinkButton ID="btnAddExp" RoleCode="R30000130C" runat="server" CssClass="btn btn-primary" OnClick="btnAddExp_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDeleteExp" RoleCode="R30000130D" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteExp_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnCopyExp" RoleCode="R30000130D" runat="server" CssClass="btn btn-primary" OnClick="btnCopyExp_Click"><i class="icon-plus"></i>  Copy</cc1:XUILinkButton>
                            
                        </div>
                        <div class="col-sm-4"> 
                            <asp:Panel ID="pnlSearchExp" runat="server" DefaultButton="btnSearchExp" class="input-group">      
                                <asp:TextBox ID="txtSearchExp" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchExp" runat="server" CssClass="btn btn-info" OnClick="btnSearchExp_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updExp" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListExp" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ITEM_CODE"
                                    OnPageIndexChanging="gvwListExp_PageIndexChanging" 
                                    onselectedindexchanged="gvwListExp_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                                        <asp:BoundField DataField="ITEM_CODE" HeaderText="Code">
                                            <ItemStyle Width="10%"  />
                                        </asp:BoundField>
                                       <asp:BoundField DataField="ITEM_NAME" HeaderText="Name">
                                            <ItemStyle Width="20%"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DESCRIPTION" HeaderText="Group">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="OWNER" HeaderText="Owner">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UNIT_DESC" HeaderText="UOM">
                                            <ItemStyle Width="20%"   />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="STATUS" HeaderText="Status">
                                           <ItemStyle Width="10%" />
                                        </asp:BoundField> 
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchExp" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteExp" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>  
        </div>
            
    </section>
</asp:Content>
