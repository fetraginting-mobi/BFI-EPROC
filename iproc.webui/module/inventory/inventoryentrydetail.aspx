<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventoryentrydetail.aspx.cs" Inherits="module_inventory_inventoryentrydetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R07000005E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">Inventory Entry No.</label>
                                <div class="col-sm-5">
                                    <!--ID-->
                                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                                    <!--Barcode-->
                                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="INVENTORY_ENTRY_CODE" SPParameterName="p_inventory_entry_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
                                    <!--Status Flag-->
                                    <cc1:XUILabel ID="lblIEStatus" runat="server" DBColumnName="IE_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblIECode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>
                        </div>                            
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Item *</label>    
                                <div class="col-sm-5">
                                    <asp:LinkButton runat="server" ID="btnLookUpInventoryEntryItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton> 
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemCode" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Quantity *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtQuantity" runat="server" CssClass="form-control" placeholder="Quantity" DBColumnName="QUANTITY" SPParameterName="p_quantity" DataType="Number" BindType="Both" Format="N0" MaxLength="8"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuantity" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQuantity" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                                <div class="col-sm-4">                                    
                                    <cc1:XUIDropDownList ID="ddlUnitID" runat="server" CssClass="form-control" DBColumnName="UNIT_ID" SPParameterName="p_unit_id" DataType="Integer" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>  
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Unit Price *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtUnitPrice" runat="server" CssClass="form-control" placeholder="Unit Price" DBColumnName="UNIT_PRICE" SPParameterName="p_unit_price" DataType="Number" BindType="Both" Format="N2" MaxLength="14"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitPrice" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtUnitPrice" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>  
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Last Location</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlLastLocation" runat="server" CssClass="form-control" DBColumnName="LAST_LOCATION" SPParameterName="p_last_location" BindType="Both" DataType="String" MaxLength="50" ></cc1:XUIDropDownList>--%>
                                
                                    <asp:LinkButton runat="server" ID="btnLookUpWarehouseCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtWarehouseCode" runat="server" style="display:none"  CssClass="form-control" DBColumnName="LAST_LOCATION" SPParameterName="p_last_location" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblWarehouseCode" runat="server"  DBColumnName="LOCATION_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                    <asp:RequiredFieldValidator ID="rfvWarehouseCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtWarehouseCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Last LOT</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlLastLot" runat="server" CssClass="form-control" DBColumnName="LAST_LOT" SPParameterName="p_last_lot" BindType="Both" DataType="String" MaxLength="50" ></cc1:XUIDropDownList>--%>
                                
                                    <asp:LinkButton runat="server" ID="btnLookUpLotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtLotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="LAST_LOT" SPParameterName="p_last_lot" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtLotName" runat="server" style="display:none"  DBColumnName="LOT_NAME" SPParameterName="p_lot_name" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    <cc1:XUILabel ID="lblLotName" runat="server" DBColumnName="LOT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Last RAK</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlLastRak" runat="server" CssClass="form-control" DBColumnName="LAST_RAK" SPParameterName="p_last_rak" BindType="Both" DataType="String" MaxLength="50" ></cc1:XUIDropDownList>--%>
                                
                                     <asp:LinkButton runat="server" ID="btnLookUpRakCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtRakCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="LAST_RAK" SPParameterName="p_last_rak" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtRakName" runat="server" style="display:none"  DBColumnName="RAK_NAME" SPParameterName="p_rak_name" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    <cc1:XUILabel ID="lblRakName" runat="server"  DBColumnName="RAK_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Last SLOT</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlLastSlot" runat="server" CssClass="form-control" DBColumnName="LAST_SLOT" SPParameterName="p_last_slot" BindType="Both" DataType="String" MaxLength="50" ></cc1:XUIDropDownList>--%>
                                
                                    <asp:LinkButton runat="server" ID="btnLookUpSlotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtSlotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="LAST_SLOT" SPParameterName="p_last_slot" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtSlotName" runat="server" style="display:none"  DBColumnName="SLOT_NAME" SPParameterName="p_slot_name" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblSlotName" runat="server"  DBColumnName="SLOT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,50}$" ErrorMessage="Exceed maximum length 50" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

