<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="refundinventoryamortizationheaderlist.aspx.cs" Inherits="module_inventory_refundinventoryamortizationheaderlist" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
    <header class="panel-heading">
          <span>Refund Inventory Amortization List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R90000153C" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R90000153D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Status</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlStatus" runat="server" Width="200px" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="NEW">NEW</asp:ListItem>
                                <asp:ListItem Value="ONPROGRESS">ONPROGRESS</asp:ListItem>
                                <asp:ListItem Value="CANCEL">CANCEL</asp:ListItem>
                                <asp:ListItem Value="REJECTED">REJECTED</asp:ListItem>
                                <asp:ListItem Value="POST">POST</asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>  
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Branch</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div> 
            </div>
            <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Paid Status</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlPaidStatus" runat="server" Width="200px" CssClass="form-control" SPParameterName="p_paid_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlPaidStatus_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="PAID">PAID</asp:ListItem>
                                <asp:ListItem Value="UNPAID">UNPAID</asp:ListItem>
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
                              <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblHeader" Text="Code/Barcode"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="10%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCode" Text='<%# Eval("CODE") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblBarcode" Text='<%# Eval("CODE_BARCODE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="reference_code" HeaderText="Inventory Amortization No.">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_NAME" HeaderText="Branch">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="refund_date" HeaderText="Refund Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="5%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="START_CONTRACT_DATE" HeaderText="Start Contract Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="5%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="END_CONTRACT_DATE" HeaderText="End Contract Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="5%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                <ItemStyle Width="25%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="STATUS" HeaderText="Refund Status">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="PAID_STATUS" HeaderText="Refund Paid Status">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                           <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

