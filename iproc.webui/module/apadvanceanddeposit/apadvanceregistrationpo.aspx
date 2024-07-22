<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apadvanceregistrationpo.aspx.cs" Inherits="module_apadvanceanddeposit_apadvanceregistrationpo" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>PO/SPK Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R80000040E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                     <cc1:XUILabel ID="lblId" runat="server" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0" style="display:none;"></cc1:XUILabel>
                     <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_ar_no" BindType="UIToDBOnly"></cc1:XUILabel>
                     <cc1:XUITextBox ID="txtSupplierCode" runat="server" style="display:none;" CssClass="form-control" placeholder="Remarks" SPParameterName="p_supplier_code" BindType="UIToDBOnly" DataType="String"></cc1:XUITextBox>
                     
                     
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Advance Request No.</label>
                                <div class="col-sm-8">
                                     <cc1:XUILabel ID="lblIICode" runat="server" DBColumnName="CODE"  DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                     <cc1:XUILabel ID="lblIIStatus" runat="server" DBColumnName="AR_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                     </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PO/SPK No.</label>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpPurchaseOrderCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                      
                                     <cc1:XUITextBox ID="txtPurchaseOrderCode" runat="server"  CssClass="form-control" DBColumnName="PO_NO" SPParameterName="p_po_no" DataType="String" MaxLength="14" BindType="Both" style="display:none"></cc1:XUITextBox> 
                                     <cc1:XUITextBox ID="txtPOCode"  runat="server"  DBColumnName="PO_CODE" DataType="String" BindType="DBToUIOnly" Text="--" Enabled="false" Width="200px" style="border:0px; background:inherit"></cc1:XUITextBox>                         
                                     <asp:RequiredFieldValidator ID="rfvPurchaseOrderCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPurchaseOrderCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PO/SPK Amount</label>
                                <div class="col-sm-6">
                                     
                                    <cc1:XUITextBox ID="txtPoAmount"  runat="server"  DBColumnName="PO_AMOUNT" SPParameterName="p_po_amount" DataType="Number" Format="N2" BindType="Both" Text="0" Enabled="false" Width="200px" style="border:0px; background:inherit"></cc1:XUITextBox> 
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>              
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtDescription" runat="server"  CssClass="form-control" placeholder="Remarks" DBColumnName="DESCRIPTION" SPParameterName="p_description" DataType="String" MaxLength="4000"  BindType="Both" TextMode="MultiLine" ></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,4000}$" ErrorMessage="Exceed maximum length 4000" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Amount *</label>             
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtAmount" runat="server"  CssClass="form-control" placeholder="Amount" DBColumnName="AMOUNT" SPParameterName="p_amount" DataType="Number" BindType="Both" Text="0" Format="N2" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmount" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
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

