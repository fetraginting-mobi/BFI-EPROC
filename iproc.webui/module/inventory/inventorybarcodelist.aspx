<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventorybarcodelist.aspx.cs" Inherits="module_inventory_inventorybarcodelist" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section class="panel">
        <header class="panel-heading">
          <span> Inventory Barcode List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                    <%--<cc1:XUILinkButton RoleCode="" ID="btnGenBarcode" runat="server" CssClass="btn btn-primary" OnClick="btnGenBarcode_Click"><i class="icon-plus"></i>  Generate Barcode All</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnGenBarcodeSelected" runat="server" CssClass="btn btn-primary" OnClick="btnGenBarcodeSelected_Click"><i class="icon-plus"></i>  Generate Barcode Selected</cc1:XUILinkButton>--%>
                    <cc1:XUILinkButton RoleCode="R60000130P" ID="btnPrintAll" runat="server" CssClass="btn btn-primary" OnClick="btnPrintAll_Click"><i class="icon-plus"></i>  Print Barcode</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R60000130P" ID="btnPrintSelected" runat="server" CssClass="btn btn-primary" OnClick="btnPrintSelected_Click"><i class="icon-plus"></i>  Print Barcode Selected</cc1:XUILinkButton>
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
             <div class="col-sm-6">
                     <div class="form-group">
                         <label class="col-sm-3">Branch</label>
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
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Location</label>
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
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Period</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtFromDate" runat="server" CssClass="form-control default-date-picker-all" SPParameterName="p_from_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                        <label class="col-sm-1">-</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtToDate" runat="server" CssClass="form-control default-date-picker-all" SPParameterName="p_to_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
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
                    AllowPaging="true" PageSize="1000" DataKeyNames="BARCODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" EmptyDataText="There is no data">
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
                            <asp:BoundField DataField="BARCODE" HeaderText="Barcode">
                                <ItemStyle Width="10%" HorizontalAlign = Center/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_CODE" HeaderText="Code">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="TRX_DATE" HeaderText="Trx Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="20%"  HorizontalAlign = Center />
                            </asp:BoundField>
                             <asp:BoundField DataField="BRANCH_DESC" HeaderText="Branch">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LOCATION_DESC" HeaderText="Location">
                                <ItemStyle Width="20%" HorizontalAlign = Center />
                            </asp:BoundField>
                            <asp:BoundField DataField="LOT_DESC" HeaderText="Lot">
                                <ItemStyle Width="10%" HorizontalAlign = Center />
                            </asp:BoundField>
                            <asp:BoundField DataField="RAK_DESC" HeaderText="Rak">
                                <ItemStyle Width="10%" HorizontalAlign = Center />
                            </asp:BoundField>
                            <asp:BoundField DataField="SLOT_DESC" HeaderText="Slot">
                                <ItemStyle Width="10%" HorizontalAlign = Center />
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

