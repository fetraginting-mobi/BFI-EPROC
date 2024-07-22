<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="supplierselection.aspx.cs"
    Inherits="module_purchaseorder_supplierselection" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Supplier Selection</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R50000060E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R50000060O" runat="server" CssClass="btn btn-success" ><i class="icon-envelope"></i>   Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">PQ No. *</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpPQCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtPQCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="PQ_CODE" SPParameterName="p_pq_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblPQCode" runat="server" DBColumnName="PQ_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtID"  runat="server" CssClass="form-control" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text="0" style="display:none"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvPQCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPQCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <div class="col-sm-2">
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName= "IS_WINNER_STATUS" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
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
                                <label class="col-sm-3">Quantity *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtQuantity" runat="server" CssClass="form-control" placeholder="Quantity" DBColumnName="WINNER_QUANTITY" SPParameterName="p_winner_quantity" DataType="Number" Format = "N0" BindType="Both" MaxLength="8"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuantity" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQuantity" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Amount *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Amount" DBColumnName="WINNER_AMOUNT" SPParameterName="p_winner_amount" DataType="Number" Format = "N2" BindType="Both" MaxLength="14"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmount" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
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
                    <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
