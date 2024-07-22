<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventorymutationdetail.aspx.cs" Inherits="module_inventory_inventorymutationdetail" %>

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
                    <cc1:XUILinkButton RoleCode="R60000110E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
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
                                <label class="col-sm-2">Inventory Mutation No.</label>
                                <div class="col-sm-10">
                                    <!--ID-->
                                    <cc1:XUILabel ID="lblID" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0" style= "display:none;"></cc1:XUILabel>
                                    <!--Barcode-->
                                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" Visible="false" BindType="Both" DBColumnName="IM_CODE" SPParameterName="p_im_code" DataType="String" Text="0" style= "display:none;"></cc1:XUILabel>
                                    <!--Location-->
                                    <cc1:XUITextBox ID="txtLocation" runat="server" DBColumnName="LOCATION_CODE" DataType="String" BindType="DBToUIOnly" style= "display:none;" ></cc1:XUITextBox> 
                                    <cc1:XUITextBox ID="txtLot" runat="server" DBColumnName="LOT_CODE" DataType="String" BindType="DBToUIOnly" style= "display:none;" ></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtRak" runat="server" DBColumnName="RAK_CODE" DataType="String" BindType="DBToUIOnly" style= "display:none;" ></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtSlot" runat="server" DBColumnName="SLOT_CODE" DataType="String" BindType="DBToUIOnly"  style= "display:none;" ></cc1:XUITextBox>  
                                    <!--BranchCode-->
                                    

                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String"  BindType="DBToUIOnly"></cc1:XUILabel>
                                    
                                    <cc1:XUILabel ID="lblIMStatus" runat="server" DBColumnName="IM_STATUS" DataType="String" style= "display:none;"  BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Item Code </label>
                           <div class="col-sm-5">
                         <cc1:XUILabel ID="lblItemCodes" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                            </div>
                           </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Item *</label>
                                <div class="col-sm-5">
                                    <asp:LinkButton runat="server" ID="btnLookUpInventoryMutationItem" Enabled="false" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>        
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
                                    <cc1:XUITextBox ID="txtQuantity" runat="server" CssClass="form-control" placeholder="Quantity" DBColumnName="QUANTITY" SPParameterName="p_quantity" DataType="Number" BindType="Both" Format ="N0" MaxLength="8"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtOnhandQty" runat="server" CssClass="form-control" placeholder="ONHAND_QTY" DBColumnName="ONHAND_QTY" SPParameterName="p_onhand_qty" DataType="Number" BindType="Both" MaxLength="8" Format ="N0" style= "display:none;"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuantity" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQuantity" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class = "row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From Branch</label>
                                <div class="col-sm-6">
                                 <asp:UpdatePanel ID="UpB" runat="server">
                                        <ContentTemplate>
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                   <cc1:XUITextBox ID="txtFromBranchCode" Enabled="false" runat="server"  CssClass="form-control" DBColumnName="FROM_BRANCH_CODE" style= "display:none;" SPParameterName="p_to_branch_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUITextBox ID="txtFromBranchDesc" Enabled="false" runat="server" DBColumnName="BRANCH_DESC"  CssClass="form-control" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                    </ContentTemplate>
                                  </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To Branch</label>
                                <div class="col-sm-6">
                                 <asp:UpdatePanel ID="UpC" runat="server">
                                        <ContentTemplate>
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlToBranch" runat="server" CssClass="form-control" DBColumnName="TO_BRANCH_CODE" SPParameterName="p_to_branch_code" DataType="String"  AutoPostBack= "true" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblToBranch" runat="server"  DBColumnName="TO_BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                    </ContentTemplate>
                                  </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From Location *</label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnFromLocation" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtFromLocationCode" runat="server" style="display:none"  CssClass="form-control" DBColumnName="FROM_LOCATION_CODE" SPParameterName="p_from_location_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblFromLocationName" runat="server"  DBColumnName="FROM_LOCATION_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                    <asp:RequiredFieldValidator ID="rfvFromLocationCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFromLocationCode" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To Location *</label>
                                <div class="col-sm-5">  
                                     <asp:LinkButton runat="server" ID="btnToLocation" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtToLocationCode" runat="server" style="display:none"  CssClass="form-control" DBColumnName="TO_LOCATION_CODE" SPParameterName="p_to_location_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblToLocationName" runat="server"  DBColumnName="TO_LOCATION_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                    <asp:RequiredFieldValidator ID="rfvToLocationCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToLocationCode" Display="Dynamic"></asp:RequiredFieldValidator>                                             
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From LOT</label>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpFromLotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtFromLotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="FROM_LOT_CODE" SPParameterName="p_from_lot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtFromLotName" runat="server" style="display:none"  DBColumnName="FROM_LOT_NAME" SPParameterName="p_from_lot_name" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    <cc1:XUILabel ID="lblFromLotName" runat="server" DBColumnName="FROM_LOT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFromLotCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To LOT </label>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpToLotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtToLotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_LOT_CODE" SPParameterName="p_to_lot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtToLotName" runat="server" style="display:none"  DBColumnName="TO_LOT_NAME" SPParameterName="p_to_lot_name" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    <cc1:XUILabel ID="lblToLotName" runat="server" DBColumnName="TO_LOT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                   <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToLotCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From RACK </label>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpFromRakCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtFromRakCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="FROM_RAK_CODE" SPParameterName="p_from_rak_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtFromRakName" runat="server" style="display:none"  DBColumnName="FROM_RAK_NAME" SPParameterName="p_from_rak_name" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    <cc1:XUILabel ID="lblFromRakName" runat="server"  DBColumnName="FROM_RAK_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                     <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFromRakCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To RACK </label>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpToRakCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtToRakCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_RAK_CODE" SPParameterName="p_to_rak_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtToRakName" runat="server" style="display:none"  DBColumnName="TO_RAK_NAME" SPParameterName="p_to_rak_name" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>  
                                    <cc1:XUILabel ID="lblToRakName" runat="server"  DBColumnName="TO_RAK_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToRakCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From SLOT </label>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpFromSlotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtFromSlotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="FROM_SLOT_CODE" SPParameterName="p_from_slot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtFromSlotName" runat="server" style="display:none"  DBColumnName="FROM_SLOT_NAME" SPParameterName="p_from_slot_name" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblFromSlotName" runat="server"  DBColumnName="FROM_SLOT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFromSlotCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To SLOT </label>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpToSlotCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtToSlotCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_SLOT_CODE" SPParameterName="p_to_slot_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtToSlotName" runat="server" style="display:none"  DBColumnName="TO_SLOT_NAME" SPParameterName="p_to_slot_name" DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblToSlotName" runat="server"  DBColumnName="TO_SLOT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                   <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToSlotCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvOrder" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator>
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
