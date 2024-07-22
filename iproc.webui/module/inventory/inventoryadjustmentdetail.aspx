<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventoryadjustmentdetail.aspx.cs" Inherits="module_inventory_inventoryadjustmentdetail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
    <script  type="text/javascript">
        function jsDoAfterLookUp()
        {
            __doPostBack('ctl00$cpb$btnRefresh','');
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R60000120E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                <%--ID--%>
                    <cc1:XUILabel ID="lblId" runat="server" style="display:none;" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0"></cc1:XUILabel>
                <%--Code Barcode--%>
                    <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_ia_code" DBColumnName="IA_CODE" BindType="UIToDBOnly"></cc1:XUILabel>
                      <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Inventory Adjustment No.</label>
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="lblIACode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblIAStatus" runat="server" DBColumnName="IA_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Location</label>
                                <div class="col-sm-1">
                                    <%--<cc1:XUILabel ID="lblLocation" runat="server"  DBColumnName="DESCRIPTION" SPParameterName="p_location_code" BindType="Both" DataType="String" ></cc1:XUILabel>--%>
                                    <%--<cc1:XUITextBox ID="txtLocation"  runat="server"  CssClass="form-control" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code" MaxLength="20" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                                
                                    <asp:LinkButton runat="server" ID="btnLookUpWarehouseCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtWarehouseCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblWarehouseCode" style="display:none" runat="server" DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                    <asp:RequiredFieldValidator ID="rfvWarehouseCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtWarehouseCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:LinkButton runat="server" ID="btnRefresh" class="btn btn-primary" style="display:none"  OnClick="btnRefresh_Click" CausesValidation="false"> </asp:LinkButton> 
                                </div>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtWarehouseName" runat="server" DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" style="border:0; background:inherit;" TextMode="MultiLine"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item Code</label>
                                <div class="col-sm-4">
                                <cc1:XUILabel ID="lblItemsCode" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            </div>
                        </div>
                    </div>
                  </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item *</label>
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpInventoryAdjustmentItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>    
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemCode" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblItemName" style="display:none" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>     
                                </div>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" style="border:0; background:inherit;" TextMode="MultiLine"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6" id="tableLot" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">Lot</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblLot" runat="server"  DBColumnName="LOT_NAME" SPParameterName="p_lot_code" BindType="Both" DataType="String" ></cc1:XUILabel>--%>
                                    <%--<cc1:XUITextBox ID="txtLot"  runat="server"  CssClass="form-control" DBColumnName="LOT_CODE" SPParameterName="p_lot_code" MaxLength="20" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                                    
                                    <asp:LinkButton runat="server" ID="btnLookUpLotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtLotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="LOT_CODE" SPParameterName="p_lot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtLotName" runat="server" DBColumnName="LOT_NAME" SPParameterName="p_lot_name" DataType="String" BindType="Both" style="border:0; background:inherit;"></cc1:XUITextBox>  
                                    <cc1:XUILabel ID="lblLotName" style="display:none" runat="server" DBColumnName="LOT_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel> 
                                </div>
                                <div class="col-sm-4">
                                
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Adjustment Type</label>
                                <div class="col-sm-4">
                                    <cc1:XUIRadioButtonList ID="rbDebetOrKredet" runat="server" DBColumnName="DEBET_OR_CREDET" SPParameterName="p_debet_or_credet" BindType="Both" DataType="String"  RepeatDirection="Horizontal" >
                                        <asp:ListItem Value="D" Selected="True"> Plus </asp:ListItem>
                                        <asp:ListItem Value="C"> Minus </asp:ListItem>
                                    </cc1:XUIRadioButtonList>
                                </div>
                            </div> 
                        </div>
                        <div class="col-sm-6" id="tableRack" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">Rack</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblRak" runat="server"  DBColumnName="RAK_NAME" SPParameterName="p_rak_code" BindType="Both" DataType="String" ></cc1:XUILabel>--%>
                                    <%--<cc1:XUITextBox ID="txtRak"  runat="server"  CssClass="form-control" DBColumnName="RAK_CODE" SPParameterName="p_rak_code" MaxLength="20" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                                    
                                    <asp:LinkButton runat="server" ID="btnLookUpRakCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtRakCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="RAK_CODE" SPParameterName="p_rak_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtRakName" runat="server" DBColumnName="RAK_NAME" SPParameterName="p_rak_name" DataType="String" BindType="Both" style="border:0; background:inherit;"></cc1:XUITextBox>  
                                    <cc1:XUILabel ID="lblRakName" style="display:none" runat="server"  DBColumnName="RAK_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>  
                                    
                                </div>
                            </div>                            
                        </div>              
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Quantity *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtTotalAdjustment" runat="server" CssClass="form-control" placeholder="Quantity" DBColumnName="TOTAL_ADJUSTMENT" SPParameterName="p_total_adjustment" MaxLength="8" DataType="Number" BindType="Both" format="N0"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvTotalAdjustment" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTotalAdjustment" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revTotalAdjustment" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTotalAdjustment" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div> 
                        </div>
                        <div class="col-sm-6" id="tableSlot" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">Slot</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblSlot" runat="server"  DBColumnName="SLOT_NAME" SPParameterName="p_slot_code" BindType="Both" DataType="String" ></cc1:XUILabel>--%>
                                    <%--<cc1:XUITextBox ID="txtSlot"  runat="server"  CssClass="form-control" DBColumnName="SLOT_CODE" SPParameterName="p_slot_code" MaxLength="20" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                                
                                    <asp:LinkButton runat="server" ID="btnLookUpSlotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtSlotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="SLOT_CODE" SPParameterName="p_slot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtSlotName" runat="server"  DBColumnName="SLOT_NAME" SPParameterName="p_slot_name" DataType="String" BindType="Both"  style="border:0; background:inherit;"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblSlotName" style="display:none" runat="server"  DBColumnName="SLOT_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>  
                                
                                </div>
                            </div>                            
                        </div>              
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" TextMode="MultiLine" Height="58px" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvInput" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
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
