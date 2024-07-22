<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventoryopnamehistoryheader.aspx.cs" Inherits="module_inventory_inventoryopnamehistoryheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span> Inventory Opname </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                   <cc1:XUILinkButton RoleCode="R60000141O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" ><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                 <cc1:XUILabel ID="lblBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUILabel>
                 <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None" style="display:none" ></cc1:XUILabel>
                 <cc1:XUILabel ID="lblCodeBarcode" runat="server" CssClass="form-control" DataType="String" BindType="None" style="display:none" ></cc1:XUILabel>
                 <cc1:XUILabel ID="lblTransFlag" runat="server" CssClass="form-control" DataType="String" BindType="None" style="display:none" ></cc1:XUILabel>   
                </div>
                <div class="col-sm-4 ">
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
                <div class="col-sm-5">
                    <div class="form-group">
                    </div>
                   </div>
                   <div class="col-sm-5">
                     <div class="form-group">
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
                      EmptyDataText="There is no data">
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
                            <asp:BoundField DataField="CODE" HeaderText="Code">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                <ItemStyle Width="30%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BRANCH" HeaderText="Branch">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LOCATION" HeaderText="Location">
                                <ItemStyle Width="20%" HorizontalAlign = Center />
                            </asp:BoundField>
                             <asp:BoundField DataField="QUANTITY_STOCK" HeaderText="Quantity Stock" DataFormatString= {0:N2}>
                                <ItemStyle Width="10%" HorizontalAlign = Right/>
                            </asp:BoundField>
                             <asp:BoundField DataField="QUANTITY_OPNAME" HeaderText="Quantity Opname" DataFormatString= {0:N2}>
                                <ItemStyle Width="10%" HorizontalAlign = Right/>
                            </asp:BoundField>
                             <asp:BoundField DataField="QUANTITY_DEVIATION" HeaderText="Quantity Deviation" DataFormatString= {0:N2}>
                                <ItemStyle Width="10%" HorizontalAlign = Right/>
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

