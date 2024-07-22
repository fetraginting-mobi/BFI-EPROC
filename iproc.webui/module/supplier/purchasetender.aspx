<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchasetender.aspx.cs" Inherits="module_supplier_purchasetender" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
    <script  type="text/javascript">
        function jsDoAfterLookUp()
        {
            __doPostBack('ctl00$cpb$ddlDivision','');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Tender Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R14000091E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <%--<cc1:XUILinkButton ID="btnPost" RoleCode="R14000091O" runat="server" CssClass="btn btn-success" ><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>--%>
                    <cc1:XUILinkButton RoleCode="R14000091E" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
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
                                <cc1:XUITextBox ID="txtSupplierCode" runat="server" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" DataType="String"  Enabled="false" BindType="Both" style="border:0; background:inherit;"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblSupplierName" runat="server" DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Request Tender No. *</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpRequestTenderNo" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                        
                                    <cc1:XUITextBox ID="txtRequestTenderNo" style="display:none" runat="server" CssClass="form-control" DBColumnName="REQUEST_TENDER_NO" SPParameterName="p_request_tender_no" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtRequestTenderCode"  runat="server"  DBColumnName="CODE" DataType="String" Enabled="false" BindType="DBToUIOnly" Text="--" style="border:0; background:inherit;"></cc1:XUITextBox>                          
                                    <asp:RequiredFieldValidator ID="rfvPurchaseOrderCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRequestTenderNo" Display="Dynamic"></asp:RequiredFieldValidator>  
                                </div>
                            </div>                            
                        </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Tender Date *</label>                              
                            <div class="col-sm-3">
                                <cc1:XUITextBox ID="txtTenderDate" runat="server"  CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="TENDER_DATE" SPParameterName="p_tender_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" style="border:0; background:inherit;"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvTenderDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTenderDate" Display="Dynamic"></asp:RequiredFieldValidator>  
                            </div>
                                <asp:RegularExpressionValidator ID="revTenderDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtTenderDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>                            
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Item</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtItemCode" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="Both" Text="-" AutoPostBack="true" OnTextChanged="txtItemCode_TextChanged" SPParameterName="p_item_code" style="display:none;" ></cc1:XUITextBox>
                                <cc1:XUITextBox ID="txtItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String"  Enabled="false" BindType="DBToUIOnly" Text="--" style="border:0; background:inherit;"></cc1:XUITextBox>
                                <%--<asp:RequiredFieldValidator ID="rfvMerk" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMerk" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Expired Date *</label>                              
                            <div class="col-sm-3">
                                <cc1:XUITextBox ID="txtExpiredDate" runat="server"  CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="EXP_DATE" SPParameterName="p_exp_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" style="border:0; background:inherit;"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvExpiredDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtExpiredDate" Display="Dynamic"></asp:RequiredFieldValidator>  
                            </div>
                                <asp:RegularExpressionValidator ID="revExpiredDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtExpiredDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Currency *</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlCurrencyCode" runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvCurrencyCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlCurrencyCode" Display="Dynamic"></asp:RequiredFieldValidator>  
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Tax</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlTaxId" runat="server" CssClass="form-control" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Warranty *</label>
                            <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtWarrantyMonth" runat="server"  CssClass="form-control" Width="40px" DBColumnName="WARRANTY_MONTH" DataType="String" BindType="Both" Text="0" SPParameterName="p_warranty_month"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvWarrantyMonth" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtWarrantyMonth" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                            <div class="col-sm-5">
                                Month
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Warranty Part * </label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtWarrantyPart" runat="server" CssClass="form-control" Width="40px" DBColumnName="WARRANTY_PART_MONTH" SPParameterName="p_warranty_part_month" BindType="Both" DataType="String"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvWarrantyPart" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtWarrantyPart" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                                <div class="col-sm-5">
                                    Month
                                </div>
                        </div>                            
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Request Quantity</label>
                                <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtRequestQuantity" runat="server" CssClass="form-control" Width="80px" DBColumnName="REQUEST_QUANTITY" SPParameterName="p_request_quantity" BindType="Both" DataType="Number" style="border:0; background:inherit;"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">UOM</label>
                                <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlUnitId" runat="server" CssClass="form-control" DBColumnName="UNIT_CODE" SPParameterName="p_unit_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    
                 </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Quotation Quantity *</label>      
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtQotationQuantity" runat="server" CssClass="form-control" placeholder="Quotation Quantity" Width="80px" DBColumnName="QUOTATION_QUANTITY" SPParameterName="p_quotation_quantity" MaxLength="20" DataType="Number" Format="N0" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvQotationQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQotationQuantity" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Amount *</label>       
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Amount" DBColumnName="AMOUNT" SPParameterName="p_amount" MaxLength="20" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="revAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmount" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Remarks</label>
                               <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" DBColumnName="REMARKS" SPParameterName="p_remarks" BindType="Both" DataType="String" TextMode="MultiLine"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Discount Amount *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtDiscountAmount" runat="server" CssClass="form-control" placeholder="Disc. Amount" DBColumnName="DISCOUNT_AMOUNT" SPParameterName="p_discount_amount" MaxLength="20" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revDiscountAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDiscountAmount" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                    <asp:RequiredFieldValidator ID="rfvDiscountAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDiscountAmount" Display="Dynamic"></asp:RequiredFieldValidator>
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

