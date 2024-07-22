<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventorycardlist.aspx.cs" Inherits="module_inventory_inventorycardlist" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span> Inventory Card List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                 <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
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
                    <label class="col-sm-4">Location</label>
                        <div class="col-sm-8">
                         <asp:UpdatePanel ID="updDep" runat="server">
                            <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlLocation" runat="server" CssClass="form-control" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlLocation_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlBranch" EventName="SelectedIndexChanged" />
                            </Triggers>
                         </asp:UpdatePanel> 
                        </div>
                    </div>
                   </div>
                   <div class="col-sm-5">
                     <div class="form-group">
                         <label class="col-sm-2">Branch</label>
                         <div class="col-sm-5">
                          <asp:UpdatePanel ID="UpB" runat="server">
                                 <ContentTemplate>
                             <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                             <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" AutoPostBack= "true" BindType="Both" ></cc1:XUIDropDownList>
                             <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                             </ContentTemplate>
                           </asp:UpdatePanel>
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
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data">
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
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                <ItemStyle Width="25%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BRANCH_DESC" HeaderText="Branch">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LOCATION_DESC" HeaderText="Location">
                                <ItemStyle Width="20%" HorizontalAlign = Center />
                            </asp:BoundField>
                            <asp:BoundField DataField="LOT_NAME" HeaderText="Lot">
                                <ItemStyle Width="10%" HorizontalAlign = Center />
                            </asp:BoundField>
                            <asp:BoundField DataField="RAK_NAME" HeaderText="Rak">
                                <ItemStyle Width="10%" HorizontalAlign = Center />
                            </asp:BoundField>
                            <asp:BoundField DataField="SLOT_NAME" HeaderText="Slot">
                                <ItemStyle Width="10%" HorizontalAlign = Center />
                            </asp:BoundField>
                             <asp:BoundField DataField="ONHAND_QTY" HeaderText="On Hand Quantity" DataFormatString= {0:N2}>
                                <ItemStyle Width="5%" HorizontalAlign = Right/>
                            </asp:BoundField>
                            <asp:BoundField DataField="HPP_AMOUNT" HeaderText="Hpp Amount" DataFormatString= {0:N2}>
                                <ItemStyle Width="5%" HorizontalAlign = Right/>
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

