<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterlocationitem.aspx.cs" Inherits="module_commonmst_masterlocationitem" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R60000040E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
       <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <cc1:XUILabel ID="lblId" runat="server"  CssClass="form-control" placeholder="Id" DBColumnName="ID" SPParameterName="p_id" MaxLength="5" DataType="Integer" BindType="Both" Visible="false" Text="0"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Warehouse Code</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtWarehouseCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="WAREHOUSE_CODE" SPParameterName="p_warehouse_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblWarehouseCode" runat="server" DBColumnName="WAREHOUSE_NAME"  MaxLength="10" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel> 
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Lot Code</label>
                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="*" ControlToValidate="txtLotCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-5">
                                <asp:LinkButton runat="server" ID="btnLookUpLotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                <cc1:XUITextBox ID="txtLotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="LOT_CODE" SPParameterName="p_lot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblLotCode" runat="server"  DBColumnName="LOT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                <asp:RequiredFieldValidator ID="rfvLotCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtLotCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Rak Code</label>
                            <asp:RequiredFieldValidator ID="rfvRakCode" runat="server" ErrorMessage="*" ControlToValidate="txtRakCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-5">
                                <asp:LinkButton runat="server" ID="btnLookUpRakCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                <cc1:XUITextBox ID="txtRakCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="RAK_CODE" SPParameterName="p_rak_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblRakCode" runat="server"  DBColumnName="RAK_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Slot Code</label>
                            <asp:RequiredFieldValidator ID="rfvSlotCode" runat="server" ErrorMessage="*" ControlToValidate="txtSlotCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-5">
                                <%--<cc1:XUITextBox ID="txtSlotCode" runat="server" CssClass="form-control" placeholder="Slot Code" DBColumnName="SLOT_CODE" SPParameterName="p_slot_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>--%>
                                <asp:LinkButton runat="server" ID="btnLookUpSlotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                <cc1:XUITextBox ID="txtSlotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="SLOT_CODE" SPParameterName="p_slot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblSlotCode" runat="server"  DBColumnName="SLOT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                               
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Item Code</label>
                            <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="*" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-5">
                                <asp:LinkButton runat="server" ID="btnLookUpInventoryRequestItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                           
                                <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblItemCode" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Minimum Qty *</label>  
					        <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtMinumQuantity" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="MINIMUM_QTY" SPParameterName="p_minimum_qty" DataType="Number" BindType="Both" MaxLength="8"></cc1:XUITextBox>  
                                <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMinumQuantity" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMinumQuantity" ValidationExpression="[0-9 ./()+]*[0-9 ./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>  
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Maximum Qty *</label>  
					        <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtMaximumQTY" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="MAXIMUM_QTY" SPParameterName="p_maximum_qty" DataType="Number" Format="N2" BindType="Both" MaxLength="8"></cc1:XUITextBox>  
                                <asp:RequiredFieldValidator ID="rfvMaximumQty" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMaximumQTY" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revMaximumQty" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMaximumQTY" ValidationExpression="[0-9 ./()+]*[0-9 ./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>  
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Reorder Qty *</label>  
					        <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtReorder" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="REORDER_QTY" SPParameterName="p_reorder_qty" DataType="Number" Format="N2" BindType="Both" MaxLength="8"></cc1:XUITextBox>  
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReorder" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtReorder" ValidationExpression="[0-9 ./()+]*[0-9 ./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>  
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

