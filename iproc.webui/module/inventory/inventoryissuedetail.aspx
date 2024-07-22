<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="inventoryissuedetail.aspx.cs" Inherits="module_inventory_inventoryissuedetail" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <script  type="text/javascript">
        function jsDoAfterLookUp()
        {
            __doPostBack('ctl00$cpb$btnRefresh','');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                   <cc1:XUILinkButton RoleCode="R60000090E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate> 
                    <!--ID-->
                        <cc1:XUILabel ID="lblId" runat="server" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0" style="display:none;"></cc1:XUILabel>
                    <!--Barcode-->
                        <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_ii_code" BindType="UIToDBOnly"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Inventory Issue No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblIICode" runat="server" DBColumnName="CODE"  DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblIIStatus" runat="server" DBColumnName="II_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                     <cc1:XUITextBox ID="txtBranch" style="display:none" runat="server"  CssClass="form-control" DBColumnName="BRANCH"  DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item *</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookInventoryIssueItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>        
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
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtQuantity" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="QUANTITY" SPParameterName="p_quantity"  DataType="Number" BindType="Both" Format="N2" MaxLength="8"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuantity" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQuantity" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Inventory Branch</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtInventoryBranch" Enabled ="false" runat="server"  CssClass="form-control" placeholder="Branch" DBColumnName="INVENTORY_BRANCH" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Location *</label>
                                <div class="col-sm-1">
                                    <%--<cc1:XUILabel ID="lblLocation" runat="server"  DBColumnName="DESCRIPTION" SPParameterName="p_location" BindType="Both" DataType="String" ></cc1:XUILabel>--%>
                                    <%--<cc1:XUITextBox ID="txtLocation"  runat="server"  CssClass="form-control" DBColumnName="LOCATION" SPParameterName="p_location" MaxLength="20" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                                    
                                    <asp:LinkButton runat="server" ID="btnLookUpWarehouseCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtWarehouseCode" runat="server" style="display:none"  CssClass="form-control" DBColumnName="LOCATION" SPParameterName="p_location" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtWarehouseName" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--" style="border:0; background:inherit;"></cc1:XUITextBox>  
                                    <asp:RequiredFieldValidator ID="rfvWarehouseCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtWarehouseCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <cc1:XUITextBox ID="txtStorageControl" runat="server" style="display:none"  CssClass="form-control" DBColumnName="STORAGE_CONTROL" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                    <asp:LinkButton runat="server" ID="btnRefresh" class="btn btn-primary" style="display:none"  OnClick="btnRefresh_Click" CausesValidation="false"> </asp:LinkButton> 
                                </div>
                            </div>                            
                        </div>
                    </div>   
                    <div class="row" id="lot" runat="server">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">LOT *</label>
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpLotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtLotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="LOT_CODE" SPParameterName="p_lot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtLotName" runat="server"  CssClass="form-control" DBColumnName="LOT_NAME" SPParameterName="p_lot_name" style="border:0; background:inherit;" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    <asp:RequiredFieldValidator ID="rfvLotCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtLotCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" id="rak" runat="server">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">RACK *</label>
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpRakCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtRakCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="RAK_CODE" SPParameterName="p_rak_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtRakName" runat="server" CssClass="form-control"  DBColumnName="RAK_NAME" SPParameterName="p_rak_name" style="border:0; background:inherit;" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    <asp:RequiredFieldValidator ID="rfvRakCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRakCode" Display="Dynamic"></asp:RequiredFieldValidator> 
                                
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" id="slot" runat="server">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">SLOT *</label>
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpSlotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtSlotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="SLOT_CODE" SPParameterName="p_slot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtSlotName" runat="server"  CssClass="form-control" DBColumnName="SLOT_NAME" SPParameterName="p_slot_name" style="border:0; background:inherit;" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvSlotCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSlotCode" Display="Dynamic"></asp:RequiredFieldValidator>  
                                
                                </div>
                            </div>                            
                        </div>
                    </div> 
                        
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>              
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtItemDescription" runat="server"  CssClass="form-control" placeholder="Description" DBColumnName="ITEM_DESCRIPTION" SPParameterName="p_item_description" DataType="String"  BindType="Both" TextMode="MultiLine" MaxLength="100" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvItemDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemDescription" Display="Dynamic"></asp:RequiredFieldValidator> 
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
