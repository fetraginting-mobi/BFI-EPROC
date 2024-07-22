<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventoryopnamehistory.aspx.cs" Inherits="module_inventory_inventoryopnamehistory" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span> History Opname </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                 <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                 <cc1:XUILinkButton RoleCode="R60000141O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox> 
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String"  BindType="Both" style="display:none"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="DBToUIOnly"  style="display:none;"></cc1:XUILabel>
                                 <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DataType="Number" Text="100" style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel> 
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
                 <div class="col-sm-5">
                     <div class="form-group">
                         <label class="col-sm-4">Status</label>
                         <div class="col-sm-5">
                          <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                 <ContentTemplate>
                             <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                             <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" DataType="String" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" AutoPostBack= "true" BindType="None" >
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="NEW">NEW</asp:ListItem>
                                <asp:ListItem Value="ONPROGRESS">ONPROGRESS</asp:ListItem>
                                <asp:ListItem Value="POST">POST</asp:ListItem>
                             </cc1:XUIDropDownList>
                              
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
                            <asp:BoundField DataField="CODE" HeaderText="Opname No.">
                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="ENTRY_DATE" HeaderText="Entry Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="LOCATION_NAME" HeaderText="Warehouse">
                                <ItemStyle Width="12%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LOT_NAME" HeaderText="Lot">
                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RAK_NAME" HeaderText="Rack">
                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SLOT_NAME" HeaderText="Slot">
                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="QUANTITY_STOCK" HeaderText="Stock" DataFormatString="{0:N0}">
                                <ItemStyle Width="5%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="UNIT_DESC" HeaderText="UOM">
                                <ItemStyle Width="5%" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="QUANTITY_OPNAME" HeaderText="Quantity Opname" DataFormatString= {0:N2}>
                                <ItemStyle Width="5%" HorizontalAlign = Right/>
                            </asp:BoundField>
                             <asp:BoundField DataField="QUANTITY_DEVIATION" HeaderText="Quantity Deviation" DataFormatString= {0:N2}>
                                <ItemStyle Width="5%" HorizontalAlign = Right/>
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                <ItemStyle Width="5%" HorizontalAlign="Left"  />
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
