<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="supplierselectiondetail.aspx.cs" Inherits="module_purchaseorder_supplierselectiondetail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R50000060E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblBarcode" style="display:none"  runat="server" DataType="String" DBColumnName="SELECTION_CODE" SPParameterName="p_selection_code" BindType="Both"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">SS No.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblSSCode" runat="server" DBColumnName="CODE" DataType="String" SPParameterName="p_code" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>   
                                    <cc1:XUITextBox ID="txtSSCode" style="display:none"   runat="server"  CssClass="form-control" DBColumnName="SELECTION_CODE" SPParameterName="p_selection_code" MaxLength="14" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblPQStatus"  runat="server" DBColumnName="PQ_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtPQCode" style="display:none"   runat="server"  CssClass="form-control" DBColumnName="PQ_CODE" SPParameterName="p_pq_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblPQCode" style="display:none"  runat="server" DBColumnName="PQ_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                    <cc1:XUITextBox ID="txtID"  runat="server" CssClass="form-control" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text="0" style="display:none"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                   <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Item *</label>
                                <div class="col-sm-8">    
                                    <asp:LinkButton runat="server" ID="btnLookUpItemCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                      
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>  
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Supplier *</label> 
                                <div class="col-sm-6">   
                                    <asp:LinkButton runat="server" ID="btnLookUpSupplierID" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>  
                                    <cc1:XUITextBox ID="txtSupplierID" style="display:none" runat="server" CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" MaxLength="20" DataType="string" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblSupplierName" runat="server"  DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                    <asp:RequiredFieldValidator ID="rfvSupplierID" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplierID" Display="Dynamic"></asp:RequiredFieldValidator>                     
                                </div>               
                            </div>
                        </div>                         
                    </div>  
                    <div class="row">   
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">PQ Quantity </label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtQuantity" style="display:none" runat="server" CssClass="form-control"  placeholder="PQ Quantity" DBColumnName="PQ_QUANTITY" SPParameterName="p_pq_quantity" DataType="Number" Format = "N0" BindType="Both" MaxLength="8"  ></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblQuantity" runat="server"  DBColumnName="PQ_QUANTITY"  DataType="Number" Format = "N0" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">PQ Amount</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtAmount" style="display:none" runat="server" CssClass="form-control"  placeholder="PQ Amount" DBColumnName="PQ_AMOUNT" SPParameterName="p_pq_amount" DataType="Number" Format = "N2" BindType="Both" MaxLength="14" ></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblAmount" runat="server"  DBColumnName="PQ_AMOUNT"  DataType="Number" Format = "N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div> <div class="row">   
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Quantity *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtQuantityOri" runat="server" CssClass="form-control" placeholder="Quantity" DBColumnName="QUANTITY" SPParameterName="p_quantity" DataType="Number" Format = "N0" BindType="Both" MaxLength="8"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuantityOri" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQuantityOri" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Amount *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtAmountOri" runat="server" CssClass="form-control" placeholder="Amount" DBColumnName="AMOUNT" SPParameterName="p_amount" DataType="Number" Format = "N2" BindType="Both" MaxLength="14"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmountOri" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmountOri" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="row">   
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Remaining Quantity </label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtRemainingQuantity" style="display:none" runat="server" CssClass="form-control"  placeholder="Remaining Quantity" DBColumnName="REMAINING_QUANTITY" SPParameterName="p_remaining_quantity" DataType="Number" Format = "N0" BindType="Both" MaxLength="8"  ></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblRemainingQuantity" runat="server"  DBColumnName="REMAINING_QUANTITY"  DataType="Number" Format = "N0" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                     </div>
                    <div class="row">  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Remarks *</label>                               
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server"  CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDRemarks" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator> 
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

