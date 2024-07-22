<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventoryopnamelist.aspx.cs" Inherits="module_inventory_inventoryopnamelist" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span> Inventory Opname List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                
                 <cc1:XUILinkButton ID="btnGenerate" RoleCode="R60000141O" runat="server" CssClass="btn btn-primary" OnClick="btnGenerate_Click" CausesValidation="false"><i class="icon-adv-table"></i>Generate</cc1:XUILinkButton>
                 <cc1:XUILinkButton RoleCode="R60000141O" ID="btnSave" runat="server" CssClass="btn btn-primary"  OnClick="btnSave_Click" CausesValidation="true" ><i class="icon-save" ></i>  Save</cc1:XUILinkButton>
                 <cc1:XUILinkButton RoleCode="R60000141O" ID="btnProcess" runat="server" CssClass="btn btn-primary"   OnClick="btnProcess_Click" CausesValidation="true" style="Display:none;"><i class="icon-adv-table" style="Display:none;"></i>  Process</cc1:XUILinkButton>
                 <cc1:XUILinkButton RoleCode="R60000141O" ID="btnApprovalTiered" Visible="false" runat="server" CssClass="btn btn-success"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                 <cc1:XUILinkButton ID="btnPost" RoleCode="R60000141O" runat="server" CssClass="btn btn-success" ><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>

                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox> 
                           <asp:TextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="UIToDBOnly" style="display:none" ></asp:TextBox> 
                             <cc1:XUILabel ID="lblBranch" runat="server" SPParameterName="p_branch_code" DataType="String"  style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel>
                          
                          
                          <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                   </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-heading">
            <div class="row">
                <asp:UpdatePanel ID ="updRakDDL" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" CssClass="form-control"  DataType="String" BindType="DBToUIOnly" style="display:none"  ></cc1:XUILabel>
                    <cc1:XUILabel ID="lblCode" runat="server" CssClass="form-control" DataType="String" BindType="DBToUIOnly" style="display:none"  ></cc1:XUILabel>
                     <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control"  DBColumnName="OBJECT_AMOUNT" DataType="Number" style="display:none;" format="N2" BindType="None"  ></asp:TextBox> 
                    <cc1:XUILabel ID="lblTransFlag" runat="server" style="display:none;" CssClass="form-control" DataType="String" BindType="None"  ></cc1:XUILabel>
                      <div class="col-sm-1">
                            Branch:
                        </div>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="ddlBranch"  runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></asp:DropDownList>
                        </div>
                        <div class="col-sm-1">
                            Location:
                        </div>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="ddlLocation"  runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged" ></asp:DropDownList>
                        </div>
                        <div class="col-sm-1">
                            Lot :
                        </div>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="ddlLot"  runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlLot_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="col-sm-1" >
                            Rack :
                        </div>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="ddlRak"  runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlRak_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="col-sm-1">
                            Slot :
                        </div>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="ddlSlot"  runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlSlot_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                           <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="View Approval History"></cc1:XUILinkButton>
                               </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="false" PageSize="300" DataKeyNames="CODE_BARCODE,ITEM_CODE,LOCATION_CODE,LOT_CODE,RAK_CODE,SLOT_CODE,QUANTITY_STOCK,TRANS_FLAG_DESC"
                        OnPageIndexChanging="gvwList_PageIndexChanging" OnRowDataBound="gvwList_RowDataBound"
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
                            <asp:TemplateField HeaderText="Qty">
                              <ItemStyle Width="5%" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtQty" runat="server" Width="50" CssClass="form-control"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revQty" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQty" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="QUANTITY_DEVIATION" HeaderText="Deviation" DataFormatString="{0:N0}">
                                <ItemStyle Width="5%" HorizontalAlign="Left"  />
                            </asp:BoundField> 
                             <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                <ItemStyle Width="5%" HorizontalAlign="Left"  />
                            </asp:BoundField>                            
                            <%--<asp:CommandField ShowSelectButton="true" />--%>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnGenerate" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                    <%--<asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

