<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="goodreceiptnotedetail.aspx.cs" Inherits="module_purchaseorder_goodreceiptnotedetail" %>

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
                    <cc1:XUILinkButton RoleCode="R50000080E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnLookupStock" RoleCode="R50000080E" class="btn btn-primary" data-toogle="modal" runat="server" ><i class="icon-file"></i>  View</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton> 
                    <%--<asp:LinkButton ID="btnReloadLocation" runat="server" OnClick="btnReloadLocation_Click" CausesValidation="false" Text="Reload" style="display:none"></asp:LinkButton>--%>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text=0></cc1:XUILabel>
                    <cc1:XUILabel ID="lblBarcode" runat="server"  DBColumnName="GRN_CODE" SPParameterName="p_grn_code" DataType="String" BindType="UIToDBOnly" MaxLength="14"  style = "Display:none;"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly" style = "Display:none;"></cc1:XUILabel>
                    <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">GRN No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="lblPO" runat="server" CssClass="form-control" placeholder="PO" DBColumnName="PO_CODE" DataType="String" BindType="DBToUIOnly" style="display:none" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Type</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblType"  runat="server"  DBColumnName="TYPE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>   
                                </div>
                            </div>                            
                        </div>
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Merk</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblMerk"  runat="server"  DBColumnName="MERK" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>   
                                </div>
                            </div>                            
                        </div>
                    </div>
                        <div class="row">
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Model</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblModel"  runat="server"  DBColumnName="MODEL" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>   
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row">
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemName"  runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblJenisItem" style="display:none" runat="server"  DBColumnName="JENIS_ITEM" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                     <cc1:XUILabel ID="lblCategoryItem" style="display:none" runat="server"  DBColumnName="CATEGORY_TYPE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                        
                                </div>
                            </div>                            
                        </div>
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item type</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblJenisItem1"  runat="server"  DBColumnName="JENIS_ITEM1" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Unit</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlUnitID" runat="server" CssClass="form-control" DBColumnName="UNIT_CODE" SPParameterName="p_unit_code" BindType="Both" DataType="String" Enabled="false" ></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                  <cc1:XUITextBox ID="txtBranchCode" runat="server" DBColumnName="BRANCH_CODE" DataType="String" style="display:none" BindType="DBToUIOnly"></cc1:XUITextBox> 
                                  </div>
                            </div>                             
                        </div>
                    </div>  
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Unit Price</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtUnitPrice" runat="server" CssClass="form-control" placeholder="Unit Price" DBColumnName="UNIT_PRICE" SPParameterName="p_unit_price" DataType="Number" Format ="N2" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblUnitPrice" runat="server" DBColumnName="UNIT_PRICE" DataType="Number" Format ="N2" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtUnitPriceBruto" runat="server" CssClass="form-control" placeholder="Unit Price Bruto" DBColumnName="UNIT_PRICE_BRUTO" SPParameterName="p_unit_price_bruto" DataType="Number" Format ="N2" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblUnitPriceBruto" runat="server" DBColumnName="UNIT_PRICE_BRUTO" DataType="Number" Format ="N2" BindType="DBToUIOnly"  style="display:none"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblDivision" runat="server" DBColumnName="DEPARTEMENT_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>    
                                
                                </div>
                            </div>                             
                        </div> 
                         
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblDepartement" runat="server" DBColumnName="DIVISION_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                        
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PO Quantity</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtPOQuantity" runat="server" CssClass="form-control" placeholder="PO Quantity" DBColumnName="PO_QUANTITY" SPParameterName="p_po_quantity" style="display:none" DataType="Number" Format ="N2" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblPOQuantity" runat="server" DBColumnName="PO_QUANTITY" DataType="Number"  BindType="DBToUIOnly"  Format="N2"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Sub Department</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblSubDepartment" runat="server" DBColumnName="SUB_DEPARTMENT_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                        
                      </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Receive Quantity *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtReceiveQuantity" runat="server" CssClass="form-control" placeholder="Receive Quantity" DBColumnName="RECEIVE_QUANTITY" SPParameterName="p_receive_quantity" DataType="Number" BindType="Both" Format="N2" MaxLength="8"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvReceiveQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReceiveQuantity" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtReceiveQuantity" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">units</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblUnits" runat="server" DBColumnName="units_name" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                       
                        
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total Amount</label>
                                <asp:RegularExpressionValidator ID="revTotalAmount" runat="server" ErrorMessage="*" ControlToValidate="txtTotalAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtTotalAmount" runat="server" CssClass="form-control" placeholder="Total Amount" DBColumnName="TOTAL_AMOUNT" SPParameterName="p_total_amount" DataType="Number" Format ="N2" BindType="Both" ></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtTotalAmountBruto" runat="server" CssClass="form-control" placeholder="Total Amount" DBColumnName="TOTAL_AMOUNT_BRUTO" SPParameterName="p_total_amount_bruto" DataType="Number" Format ="N2" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">No Resi</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtNoResi" runat="server" CssClass="form-control" placeholder="No Resi" DBColumnName="NO_RESI" SPParameterName="p_no_resi" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>
                            
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Location *</label>
                                <div class="col-sm-1" id="lookupWarehouse" runat="server">
                                    <%--<cc1:XUILabel ID="lblLocation" runat="server"  DBColumnName="DESCRIPTION" SPParameterName="p_location" BindType="Both" DataType="String" ></cc1:XUILabel>--%>
                                    <%--<cc1:XUITextBox ID="txtLocation"  runat="server"  CssClass="form-control" DBColumnName="LOCATION" SPParameterName="p_location" MaxLength="20" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                                    
                                    <asp:LinkButton runat="server" ID="btnLookUpWarehouseCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtWarehouseCode" runat="server"  CssClass="form-control" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code" style="display:none;" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtWarehouseName" runat="server"  DBColumnName="LOCATION_DESC" DataType="String" BindType="DBToUIOnly" Text="--" style="border:0; background:inherit;" ></cc1:XUITextBox>  <%----%>
                                    <cc1:XUITextBox ID="txtStorageControl" runat="server" style="display:none"  CssClass="form-control" DBColumnName="STORAGE_CONTROL" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                    <asp:LinkButton runat="server" ID="btnRefresh" class="btn btn-primary" style="display:none"  OnClick="btnRefresh_Click" CausesValidation="false"> </asp:LinkButton> 
                                    <asp:RequiredFieldValidator ID="rvfWarehouse" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTotalAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remaining Quantity</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtRemaining" runat="server" CssClass="form-control" placeholder="Remaining Quantity" DBColumnName="REMAINING_QUANTITY" SPParameterName="p_remaining_quantity" style="display:none" DataType="Number" Format ="N2" BindType="Both" ></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblRemaining" runat="server" DBColumnName="REMAINING_QUANTITY" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>   
                    </div> 
                     <div class="row"> 
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Shipper</label> 
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpShipper" class="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    </div>
                                     <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtTrxCode" runat="server"  CssClass="form-control" DBColumnName="SHIPPER" SPParameterName="p_shipper_code" DataType="String" MaxLength="18" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDescription"  runat="server" DBColumnName="SHIPPER" DataType="String" BindType="DBToUIOnly" Text="--"  Enabled="false" Width="200px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplier" Display="Dynamic"></asp:RequiredFieldValidator> --%>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Shipper Amount</label>
                                <asp:RegularExpressionValidator ID="revShipperAmount" runat="server" ErrorMessage="*" ControlToValidate="txtTotalAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtShipperAmount" runat="server" CssClass="form-control" placeholder="Total Amount" DBColumnName="SHIPPER_AMOUNT" SPParameterName="p_shipper_amount" DataType="Number" Format ="N2" BindType="Both" ></cc1:XUITextBox>
                                    
                                </div>
                            </div>                            
                        </div> 
                       </div> 
                     <div class="row">
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Descriptions *</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvRemarks" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div> 
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Asset Barcode</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblfabarcode"  runat="server"  DBColumnName="FA" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>   
                                </div>
                            </div>                            
                        </div>
                      </div>
                    <div class="row" id="lot" runat="server">
                        <div class="col-sm-6" id="TableLot" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">LOT</label>
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpLotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-4">
                                    <asp:RequiredFieldValidator ID="rfvLotCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtLotCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <cc1:XUITextBox ID="txtLotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="LOT_CODE" SPParameterName="p_lot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtLotName" runat="server"  CssClass="form-control" DBColumnName="LOT_NAME" SPParameterName="p_lot_name" style="border:0; background:inherit;" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" id="rak" runat="server">
                        <div class="col-sm-6" id="TableRak" runat="server">
                            <div class="form-group" >
                                <label class="col-sm-4">RACK</label>
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpRakCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-4">
                                <asp:RequiredFieldValidator ID="rfvRakCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRakCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <cc1:XUITextBox ID="txtRakCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="RAK_CODE" SPParameterName="p_rak_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtRakName" runat="server" CssClass="form-control"  DBColumnName="RAK_NAME" SPParameterName="p_rak_name" style="border:0; background:inherit;" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" id="slot" runat="server">
                        <div class="col-sm-6">
                            <div class="form-group" id="TableSlot" runat="server">
                                <label class="col-sm-4">SLOT</label>
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpSlotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-4">
                                <asp:RequiredFieldValidator ID="rfvSlotCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSlotCode" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    <cc1:XUITextBox ID="txtSlotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="SLOT_CODE" SPParameterName="p_slot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtSlotName" runat="server"  CssClass="form-control" DBColumnName="SLOT_NAME" SPParameterName="p_slot_name" style="border:0; background:inherit;" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                    
                                
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
