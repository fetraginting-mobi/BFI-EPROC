<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apinvoiceregistrationdetail.aspx.cs" Inherits="module_apinvoice_apinvoiceregistrationdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>List Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R80000010E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                     <!--ID-->
                     <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                      <cc1:XUILabel ID="lblIdTarget" runat="server" DataType="Integer" BindType="None" Text= "0" style="Display:none;" ></cc1:XUILabel>
                     <!--Barcode-->
                     <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="INVOICE_CODE" SPParameterName="p_invoice_code" style="Display:none;" DataType="String" BindType="UIToDBOnly"  ></cc1:XUILabel>
                      <cc1:XUILabel ID="lblBranch" runat="server" style="Display:none;" DataType="String" BindType="None"  ></cc1:XUILabel>
                     <cc1:XUITextBox ID="txtCodeBarcode" runat="server" CssClass="form-control" placeholder="No" style="Display:none;"  MaxLength="15" DataType="String" BindType="None"></cc1:XUITextBox>    
                     <!--Barcode PO-->
                     <cc1:XUITextBox ID="txtPocode" runat="server" CssClass="form-control" placeholder="No" DBColumnName="PO_CODE" style="Display:none;"  MaxLength="15" DataType="String" BindType="DBToUIOnly" Format="N2"></cc1:XUITextBox>    
                     <cc1:XUITextBox ID="lblType" runat="server" DBColumnName="TYPE" DataType="String" BindType="DBToUIOnly" style="Display:none;"></cc1:XUITextBox>
                     <cc1:XUITextBox ID="XUITextBox1" runat="server" DBColumnName="TYPE" DataType="String" BindType="DBToUIOnly" style="Display:none;"></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Code.</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblIRStatus" runat="server" DBColumnName="IR_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblInvoiceNo" runat="server" DBColumnName="INVOICE_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lbladditionalamount" runat="server" DBColumnName="ADDITIONAL_AMOUNT" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Doc Reff No. *</label> 
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpAcceptNo" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                         
                                    <cc1:XUITextBox ID="txtAcceptNo" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ACCEPT_CODE" SPParameterName="p_accept_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAcceptDesc" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>      
                                    <asp:RequiredFieldValidator ID="rfvAcceptNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAcceptNo" Display="Dynamic"></asp:RequiredFieldValidator>  
                                </div>
                            </div>                            
                        </div>
                       <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <asp:UpdatePanel ID="updDiv" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE"  SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="revddlDivision" runat="server" ControlToValidate="ddlDivision"
                                                 ErrorMessage="Value Required!" InitialValue="-"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                       <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item</label> 
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblItemCode" runat="server" DBColumnName="ITEM_CODE" DataType="String" SPParameterName="p_item_code" BindType="Both" Text="--"></cc1:XUILabel> 
                                        - 
                                    <cc1:XUILabel ID="lblItemName" runat="server" DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>      
                                    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                    <div class="col-sm-6">
                                        <asp:UpdatePanel ID="updDep" runat="server">
                                            <ContentTemplate>
                                                <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                       <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlDivision" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                     </asp:UpdatePanel> 
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
                                <label class="col-sm-4">Sub Department</label>
                            <div class="col-sm-6">
                               <asp:UpdatePanel ID="updSub" runat="server">
                                 <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlSubDepartment" runat="server" CssClass="form-control" DBColumnName="SUB_DEPARTMENT_CODE" SPParameterName="p_sub_department_code" OnSelectedIndexChanged= "ddlSubDepartment_SelectedIndexChanged" AutoPostBack="true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvddlSubDepartment" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                 </ContentTemplate>
                                 <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="ddlDepartment" EventName="SelectedIndexChanged" />
                                 </Triggers>
                               </asp:UpdatePanel>
                            </div>
                         </div>                            
                       </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Currency</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlCurrency" runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" BindType="Both" DataType="String" Enabled = "false" ></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                           <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Units</label>
                                <div class="col-sm-6">
                                    <asp:UpdatePanel ID="updUn" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlUnits" runat="server" CssClass="form-control" DBColumnName="UNITS_CODE" SPParameterName="p_units_code"  DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="rfvddlUnits" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUnits" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                           <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlSubDepartment" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12" style="display:none">
                            <div class="form-group">
                                <label class="col-sm-2">Remaining Amount</label>     
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtRemainingAmount" runat="server" CssClass="form-control" placeholder="Purchase Amount" DBColumnName="REMAINING_AMOUNT" SPParameterName="p_remaining_amount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" style="Display:none;"></cc1:XUITextBox>    
                                    <cc1:XUILabel ID="lblRemaingAmount" runat="server" DBColumnName="REMAINING_AMOUNT" SPParameterName="p_remaining_amount" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>      
                                </div>
                            </div>                            
                        </div>                               
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Tax Scheme *</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlTaxType" Enabled="false"  runat="server" CssClass="form-control" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>    
                                  <%--  <cc1:XUIDropDownList ID="ddlTaxType"  runat="server" CssClass="form-control" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList> --%>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" InitialValue="0" ControlToValidate="ddlTaxType" Display="Dynamic"></asp:RequiredFieldValidator>  
                                </div>
                            </div>
                       </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Purchase Amount *</label>
                                <%--<asp:RequiredFieldValidator ID="rfvPurchaseAmount" runat="server" ErrorMessage="*" ControlToValidate="txtPurchaseAmount" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revPurchaseAmount" runat="server" ErrorMessage="*" ControlToValidate="txtPurchaseAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         --%>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtPurchaseAmount" runat="server"  CssClass="form-control" placeholder="Purchase Amount" DBColumnName="PURCHASE_AMOUNT" SPParameterName="p_purchase_amount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled = "false"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvPurchaseAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPurchaseAmount" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    <asp:RegularExpressionValidator ID="revPurchaseAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPurchaseAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                </div>
                            </div>
                       </div>
                      
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">VAT Amount</label>
                            <div class="col-sm-6">
                                <cc1:XUITextBox ID="txtPPNTax" runat="server"  CssClass="form-control" placeholder="PPN Tax" DBColumnName="PPN_TAX" SPParameterName="p_ppn_tax" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total Amount *</label>
                                <%--<asp:RequiredFieldValidator ID="rfvPurchaseAmount" runat="server" ErrorMessage="*" ControlToValidate="txtPurchaseAmount" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revPurchaseAmount" runat="server" ErrorMessage="*" ControlToValidate="txtPurchaseAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         --%>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtTotalAmount" runat="server"  CssClass="form-control" placeholder="Purchase Amount" DBColumnName="TOTAL_AMOUNT" SPParameterName="p_total_amount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled = "false"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTotalAmount" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTotalAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                </div>
                            </div>
                       </div>
                    
                </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Discount</label>
                                <asp:RequiredFieldValidator ID="rfvDiscount" runat="server" ErrorMessage="*" ControlToValidate="txtDiscount" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revDiscount" runat="server" ErrorMessage="*" ControlToValidate="txtDiscount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         
                                <div class="col-sm-6">
                                    <%--<cc1:XUITextBox ID="txtDiscount" runat="server"  CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT" SPParameterName="p_discount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>--%>
                                    <cc1:XUITextBox ID="txtDiscount" runat="server" CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT" SPParameterName="p_discount" MaxLength="18" DataType="Number" Format="N2" BindType="Both"  Text="0.00"  ></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Discount Additional</label>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtDiscountaditional" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtDiscountaditional" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>--%>         
                                <div class="col-sm-6">
                                    <%--<cc1:XUITextBox ID="txtDiscount" runat="server"  CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT" SPParameterName="p_discount" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>--%>
                                    <cc1:XUITextBox ID="txtDiscountaditional" runat="server" CssClass="form-control" DBColumnName="DISCOUNT_ADDITIONAL" SPParameterName="p_discount_additional" placeholder="Discount"  MaxLength="18" DataType="Number" Format="N2" BindType="Both"  Text="0.00"  ></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <div class="row">
                        <div class="col-sm-12" style="display:none">
                            <div class="form-group">
                                <label class="col-sm-2">Shipping Fee</label>
                                <%-- <asp:RequiredFieldValidator ID="rfvShippingFee" runat="server" ErrorMessage="*" ControlToValidate="txtShippingFee" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revShippingFee" runat="server" ErrorMessage="*" ControlToValidate="txtShippingFee" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         --%>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtShippingFee" runat="server" CssClass="form-control" placeholder="Shipping Fee" DBColumnName="SHIPPING_FEE" SPParameterName="p_shipping_fee" MaxLength="18" DataType="Number" Format="N2" BindType="Both"  Text="0.00" style="display:none" ></cc1:XUITextBox>
                                </div>
                            </div>   
                        </div>                         
                    </div>
                    <div class="row"> 
                        <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Witholding Tax</label>
                                    <div class="col-sm-6">
                                        <cc1:XUITextBox ID="txtPPHTax" runat="server"  CssClass="form-control" placeholder="PPH Tax" DBColumnName="PPH_TAX" SPParameterName="p_pph_tax" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" TextMode="MultiLine" DataType="String" BindType="Both"></cc1:XUITextBox>
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

