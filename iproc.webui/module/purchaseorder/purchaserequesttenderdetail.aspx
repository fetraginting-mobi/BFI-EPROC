<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchaserequesttenderdetail.aspx.cs" Inherits="module_purchaseorder_purchaserequesttenderdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section class="panel">
        <header class="panel-heading">
          <span>Tender Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <%--code barcode--%>
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUILabel>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Code</label>
                            <div class="col-sm-7">
                                <cc1:XUILabel ID="lblTenderCode" runat="server" DBColumnName="CODE" SPParameterName="p_code" DataType="String" BindType="Both"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblTransFlagCode" runat="server"  DBColumnName="TRANS_FLAG_CODE" DataType="String" BindType="DBToUIOnly" style="display:none;" Text="--"></cc1:XUILabel> 
                                <cc1:XUILabel ID="lblTransFlagDesc" runat="server"  DBColumnName="TRANS_FLAG_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Supplier </label>
                            <div class="col-sm-7">
                                <cc1:XUILabel ID="lblSupplierCode" runat="server" DBColumnName="SUPPLIER_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblSupplierName" runat="server" DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Tender Date</label>                              
                            <div class="col-sm-3">
                                <cc1:XUILabel ID="lblTenderDate" runat="server"  placeholder="Date" DBColumnName="TENDER_DATE" MaxLength="10" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>  
                            </div>
                        </div>                            
                    </div>
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Expired Date</label>                              
                            <div class="col-sm-3">
                                <cc1:XUILabel ID="lblExpiredDate" runat="server"  placeholder="Date" DBColumnName="EXP_DATE" MaxLength="10" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Request Tender No.</label>
                                <div class="col-sm-8">                   
                                    <cc1:XUITextBox ID="txtRequestTenderNo" style="display:none" runat="server" CssClass="form-control" DBColumnName="REQUEST_TENDER_NO" SPParameterName="p_request_tender_no" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtRequestTenderCode"  runat="server"  DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="border:0; background:inherit;"></cc1:XUITextBox>                          
                                </div>
                            </div>                            
                        </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Item</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtItemCode" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="Both" Text="-" SPParameterName="p_item_code" style="display:none;" ></cc1:XUITextBox>
                                <cc1:XUITextBox ID="txtItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--" style="border:0; background:inherit;"></cc1:XUITextBox>
                                <%--<asp:RequiredFieldValidator ID="rfvMerk" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMerk" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Currency</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlCurrencyCode" runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" BindType="DBToUIOnly" Enabled="false" DataType="String"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Tax</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlTaxId" runat="server" CssClass="form-control" DBColumnName="TAX_CODE" BindType="DBToUIOnly" Enabled="false" DataType="String"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Warranty</label>
                            <div class="col-sm-2">
                                <cc1:XUILabel ID="lblWarrantyMonth" runat="server"  Width="40px" DBColumnName="WARRANTY_MONTH" DataType="String" BindType="DBToUIOnly" Text="0"></cc1:XUILabel>
                            </div>
                            <div class="col-sm-5">
                                Month
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Warranty Part</label>
                            <div class="col-sm-2">
                                <cc1:XUILabel ID="lblWarrantyPart" runat="server" Width="40px" DBColumnName="WARRANTY_PART_MONTH" BindType="DBToUIOnly" DataType="String"></cc1:XUILabel>
                            </div>
                            <div class="col-sm-5">Month</div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Request Quantity</label>
                                <div class="col-sm-7">
                                <cc1:XUILabel ID="lblRequestQuantity" runat="server" Width="80px" DBColumnName="REQUEST_QUANTITY" BindType="DBToUIOnly" DataType="Number" ></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">UOM</label>
                                <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlUnitId" runat="server" CssClass="form-control" DBColumnName="UNIT_CODE" BindType="DBToUIOnly" Enabled="false" DataType="String" ></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    
                 </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Quotation Quantity</label>      
                            <div class="col-sm-7">
                                <cc1:XUILabel ID="lblQotationQuantity" runat="server" placeholder="Quotation Quantity" Width="80px" DBColumnName="QUOTATION_QUANTITY" MaxLength="20" DataType="Number" Format="N0" BindType="DBToUIOnly" ></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Amount</label>       
                            <div class="col-sm-7">
                                <cc1:XUILabel ID="txtAmount" runat="server" placeholder="Amount" DBColumnName="AMOUNT" MaxLength="20" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                                
                            </div>
                        </div>                            
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Remarks</label>
                               <div class="col-sm-7">
                                <cc1:XUILabel ID="lblRemarks" runat="server" DBColumnName="REMARKS" BindType="DBToUIOnly" DataType="String" ></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Discount Amount</label>
                                <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblDiscountAmount" runat="server" placeholder="Disc. Amount" DBColumnName="DISCOUNT_AMOUNT" MaxLength="20" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

