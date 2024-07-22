<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchasetenderlist.aspx.cs" Inherits="module_supplier_purchasetenderlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item List</span>
        </header>
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#request" id="idrequest"  onclick="javascript:fnSetTab('idrequest');"  data-toggle="tab">
                     Request Tender
                  </a>
              </li>
             <li class="">
                  <a href="#tender" id="idtender"  onclick="javascript:fnSetTab('idtender');" data-toggle="tab">
                     Tender
                  </a>
              </li>
              <li class="">
                  <a href="#winner" id="idwinner"  onclick="javascript:fnSetTab('idwinner');" data-toggle="tab">
                     Winner
                  </a>
              </li>
              <li class="">
                  <a href="#history" id="idhistory"  onclick="javascript:fnSetTab('idhistory');" data-toggle="tab">
                     History
                  </a>
              </li>
          </ul>
        </header>
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="request">
                    <header class="panel-heading">
                        <span></span>
                    </header>
                
                    <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8">
                            
                        </div>
                        <div class="col-sm-4"> 
                            <asp:Panel ID="pnlSearchRequest" runat="server" DefaultButton="btnSearchRequest" class="input-group">      
                                <asp:TextBox ID="txtSearchRequest" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchRequest" runat="server" CssClass="btn btn-info" OnClick="btnSearchRequest_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="upd" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListRequest" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ITEM_CODE"
                                    OnPageIndexChanging="gvwListRequest_PageIndexChanging" 
                                    EmptyDataText="There Is No Data" Width="100%">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate> 
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CODE" HeaderText="Request Tender Code">
                                            <ItemStyle Width="20%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Name">
                                            <ItemStyle Width="40%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="REQUEST_TENDER_DATE" HeaderText="Request Date" DataFormatString="{0:dd/MM/yyyy}">
                                            <ItemStyle Width="15%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EXP_DATE" HeaderText="Expired Date" DataFormatString="{0:dd/MM/yyyy}">
                                            <ItemStyle Width="15%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="QUANTITY" HeaderText="Quantity" DataFormatString="{0:N0}">
                                            <ItemStyle Width="10%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchRequest" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="tab-pane" id="tender">
                    <header class="panel-heading">
                        <span></span>
                    </header>
                
                    <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8">
                            <cc1:XUILinkButton ID="btnAddTender" RoleCode="R14000091C" runat="server" CssClass="btn btn-primary" OnClick="btnAddTender_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDeleteTender" RoleCode="R14000091D" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteTender_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                        </div>
                        <div class="col-sm-4"> 
                            <asp:Panel ID="pnlSearchTender" runat="server" DefaultButton="btnSearchTender" class="input-group">      
                                <asp:TextBox ID="txtSearchTender" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchTender" runat="server" CssClass="btn btn-info" OnClick="btnSearchTender_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updTender" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListTender" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="CODE_BARCODE, ITEM_CODE"
                                    OnPageIndexChanging="gvwListTender_PageIndexChanging" 
                                    onselectedindexchanged="gvwListTender_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                                        <asp:BoundField DataField="CODE" HeaderText="Tender Code">
                                            <ItemStyle Width="15%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Name">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CURRENCY_CODE" HeaderText="Currency">
                                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="QUOTATION_QUANTITY" HeaderText="Quantity" DataFormatString="{0:N0}">
                                            <ItemStyle Width="5%" HorizontalAlign="Right"  />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="AMOUNT" HeaderText="Amount" DataFormatString="{0:N2}">
                                            <ItemStyle Width="15%" HorizontalAlign="Right"  />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="DISCOUNT_AMOUNT" HeaderText="Discount" DataFormatString="{0:N2}">
                                            <ItemStyle Width="15%" HorizontalAlign="Right"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                            <ItemStyle Width="25%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchTender" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteTender" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="tab-pane" id="winner">
                    <header class="panel-heading">
                        <span></span>
                    </header>
                
                    <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8">
                            
                        </div>
                        <div class="col-sm-4"> 
                            <asp:Panel ID="pnlSearchWinner" runat="server" DefaultButton="btnSearchWinner" class="input-group">      
                                <asp:TextBox ID="txtSearchWinner" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchWinner" runat="server" CssClass="btn btn-info" OnClick="btnSearchWinner_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updWinner" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListWinner" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="CODE_BARCODE, ITEM_CODE"
                                    OnPageIndexChanging="gvwListWinner_PageIndexChanging" 
                                    onselectedindexchanged="gvwListWinner_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate> 
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CODE" HeaderText="Tender Code">
                                            <ItemStyle Width="15%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Name">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CURRENCY_CODE" HeaderText="Currency">
                                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="QUOTATION_QUANTITY" HeaderText="Quantity" DataFormatString="{0:N0}">
                                            <ItemStyle Width="5%" HorizontalAlign="Right"  />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="AMOUNT" HeaderText="Amount" DataFormatString="{0:N2}">
                                            <ItemStyle Width="15%" HorizontalAlign="Right"  />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="DISCOUNT_AMOUNT" HeaderText="Discount" DataFormatString="{0:N2}">
                                            <ItemStyle Width="15%" HorizontalAlign="Right"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                            <ItemStyle Width="25%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchWinner" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="tab-pane" id="history">
                    <header class="panel-heading">
                        <span></span>
                    </header>
                
                    <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8">
                            
                        </div>
                        <div class="col-sm-4"> 
                            <asp:Panel ID="pnlSearchHistory" runat="server" DefaultButton="btnSearchHistory" class="input-group">      
                                <asp:TextBox ID="txtSearchHistory" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchHistory" runat="server" CssClass="btn btn-info" OnClick="btnSearchHistory_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updHistory" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListHistory" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="CODE_BARCODE, ITEM_CODE"
                                    OnPageIndexChanging="gvwListHistory_PageIndexChanging" 
                                    onselectedindexchanged="gvwListHistory_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate> 
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CODE" HeaderText="Tender Code">
                                            <ItemStyle Width="15%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Name">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CURRENCY_CODE" HeaderText="Currency">
                                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="QUOTATION_QUANTITY" HeaderText="Quantity" DataFormatString="{0:N0}">
                                            <ItemStyle Width="5%" HorizontalAlign="Right"  />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="AMOUNT" HeaderText="Amount" DataFormatString="{0:N2}">
                                            <ItemStyle Width="15%" HorizontalAlign="Right"  />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="DISCOUNT_AMOUNT" HeaderText="Discount" DataFormatString="{0:N2}">
                                            <ItemStyle Width="15%" HorizontalAlign="Right"  />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                            <ItemStyle Width="25%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchHistory" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>  
        </div>
            
    </section>
</asp:Content>

