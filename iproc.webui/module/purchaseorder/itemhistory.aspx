<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="itemhistory.aspx.cs" Inherits="module_purchaseorder_itemhistory" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">

    <section class="panel">
        <header class="panel-heading">
          <span> Item History List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                <cc1:XUILabel ID="lblSupplierCode" runat="server" DBColumnName="SUPPLIER_CODE" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                <button CssClass="btn btn-danger" class="icon-remove" onclick="parent.fnHideGenericScreen();">Close</button>
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
               <%-- <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Location</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlLocation" runat="server" CssClass="form-control" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged"></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>--%>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames=""
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
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="UNIT_PRICE" HeaderText="Unit Price" DataFormatString="{0:N2}">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="SUPPLIER_NAME" HeaderText="Supplier Name">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                              <asp:BoundField DataField="DESCRIPTION" HeaderText="Branch">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="ORDER_DATE" HeaderText="Order Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="20%" HorizontalAlign="Center" />
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


