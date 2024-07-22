<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchaseorderdetail.aspx.cs" Inherits="module_purchaseorder_purchaseorderdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
    <script  type="text/javascript">
        function jsDoAfterLookUp()
        {
            __doPostBack('ctl00$cpb$txtItemCode','');
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
                    <cc1:XUILinkButton RoleCode="R50000070E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  cancel</cc1:XUILinkButton>
                       <cc1:XUILinkButton ID="btnCancelAp" style = "Display:none;" Visible="false" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancelApp_Click" CausesValidation="false"><i class="icon-remove"></i>  cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
             
               
                    <%--ID--%>
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text= "0" style = "Display:none;" ></cc1:XUILabel>
                    <%--Barcode--%>
                    <cc1:XUILabel ID="lblBarcode" runat="server"  DBColumnName="PO_BARCODE" SPParameterName="p_po_code" DataType="String" BindType="UIToDBOnly" MaxLength="14"  style = "Display:none;"></cc1:XUILabel>
                    <%--Currency--%>
                    <cc1:XUILabel ID="lblCurrencyUI" runat="server" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both" style = "Display:none;"></cc1:XUILabel>
                    <%--Status Flag--%>
                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly" style = "Display:none;" ></cc1:XUILabel>
                    <cc1:XUITextBox ID="txtEntry" style="display:none;"  runat="server"  CssClass="form-control" DBColumnName="ENTRY" SPParameterName="p_entry" DataType="String"  BindType="Both"></cc1:XUITextBox>
                    <cc1:XUILabel ID="lblEntry" runat="server" DBColumnName="ENTRY_DESC" DataType="String" style = "Display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                    <cc1:XUITextBox ID="txtUnit" runat="server" CssClass="form-control"  DBColumnName="UNITS_CODE" DataType="String" BindType="DBToUIOnly" style = "Display:none;"></cc1:XUITextBox> 
                     <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="DBToUIOnly" style = "Display:none;"></cc1:XUITextBox> 
                      <cc1:XUITextBox ID="txtSupplier" runat="server" CssClass="form-control"  DataType="String" BindType="None"  style = "Display:none;"></cc1:XUITextBox>                     
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">PO No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblPurchaseOrderCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" MaxLength="14" ></cc1:XUILabel>
                                </div>
                            </div>      
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4 ">Branch</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="BRANCH_DESC"  DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel> --%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">PQ No.</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpPurchaseQuotation" class="btn btn-primary" Enabled ="false" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtPQCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="PQ_CODE" SPParameterName="p_pq_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblPQCode" runat="server" DBColumnName="PQ_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPQCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
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
                            <label class="col-sm-4">Item *</label>
                                <div class="col-sm-8">    
                                    <asp:LinkButton runat="server" ID="btnLookUpItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table" ></i></asp:LinkButton>                       
                                    <cc1:XUITextBox ID="txtItemCode" runat="server" style="display:none;"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both" AutoPostBack="true" OnTextChanged="txtItemCode_TextChanged"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"  TextMode="MultiLine"  style="border:0; background:inherit;"></cc1:XUITextBox>   
                                                  
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>   
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
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
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
                                <label class="col-sm-4">Requestor</label> 
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpRequestoro"  class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtRequestorCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="REQUESTOR" SPParameterName="p_requestor" DataType="String" Enabled= "false" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblRequestorName" runat="server"  DBColumnName="REQUESTOR_DESC" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                   <%-- <asp:RequiredFieldValidator ID="rfvRequestorName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRequestorCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>                            
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
                                <label class="col-sm-4 ">Currency</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblCurrency" runat="server" DBColumnName="currency_description" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
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
                        <div class="col-sm-6" ID="PRD" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">Period</label>     
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <cc1:XUITextBox ID="txtPeriod" runat="server" CssClass="form-control" placeholder="PERIOD (month)" DBColumnName="PERIOD" SPParameterName="p_period" DataType="Integer" BindType="Both" MaxLength="3" Width="100px" Enabled = "false"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblPeriod" runat="server">&nbsp&nbsp Month</cc1:XUILabel> 
                                        <asp:RegularExpressionValidator ID="revPeriod" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPeriod" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>    
                                    </div>
                                </div>
                            </div>      
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Unit Price *</label>         
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtUnitPrice" runat="server" CssClass="form-control" placeholder="Unit Price" DBColumnName="UNIT_PRICE" SPParameterName="p_unit_price" DataType="Number" BindType="Both" MaxLength="18" Format="N2"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvUnitPrice" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitPrice" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="refUnitPrice" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtUnitPrice" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>      
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Order Qty *</label>       
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtOrderQuantity" runat="server" CssClass="form-control" placeholder="Order Quantity" DBColumnName="ORDER_QUANTITY" SPParameterName="p_order_quantity" DataType="Number" BindType="Both" MaxLength="20" Format="N2"  ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvOrderQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtOrderQuantity" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="refOrderQuantity" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtOrderQuantity" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                </div>
                                <div class="col-sm-4">
                                    <cc1:XUIDropDownList ID="ddlUnit" runat="server" CssClass="form-control" DBColumnName="UNIT_CODE" SPParameterName="p_unit_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUnit" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>      
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Additional Amount</label>         
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtAdditionalAmount" runat="server" CssClass="form-control" placeholder="Unit Price" DBColumnName="ADDITIONAL_AMOUNT" SPParameterName="p_additional_amount" DataType="Number" BindType="Both" MaxLength="18" Format="N2"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAdditionalAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>      
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6" ID="PST" style="display:none;"  runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">Start Rent Date</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtStartRent" runat="server" CssClass="form-control default-date-picker" placeholder="Start Rent Date" DBColumnName="START_RENT_DATE" SPParameterName="p_start_rent_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    
                                </div>         
                            </div>
                        </div>
                        <div class="col-sm-6" ID="DRF"  runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">Start Rent From</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtDueRentFrom" runat="server" CssClass="form-control default-date-picker" placeholder="Due Rent From" DBColumnName="RENT_FROM_DATE" SPParameterName="p_rent_from_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    
                                </div>         
                            </div>
                        </div>
                         <div class="col-sm-6" ID="DRT" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">End Rent To </label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtDueRentTo" runat="server" CssClass="form-control default-date-picker" placeholder="Due Rent To" DBColumnName="RENT_TO_DATE" SPParameterName="p_rent_to_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                   
                                </div>         
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                             <div class="form-group">
                                <label class="col-sm-4">Tax *</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlTaxType"  runat="server" CssClass="form-control" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>    
                                </div>
                                 <asp:RequiredFieldValidator ID="rfvTaxType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlTaxType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>                            
                        </div>
                       <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">FA Barcode No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblfabarcode" runat="server" DBColumnName="BARCODE_MAINTENANCE" DataType="String" BindType="DBToUIOnly" MaxLength="14" ></cc1:XUILabel>
                                </div>
                            </div>      
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PPN Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPPN" runat="server" CssClass="form-control" placeholder="PPN" DBColumnName="PPN_AMOUNT" SPParameterName="p_ppn_amount" MaxLength="15" DataType="Number" Text=0 BindType="Both" Format="N2"></cc1:XUITextBox>    
                                </div>
                            </div>                            
                        </div>
                       <div class="col-sm-6">
                           <div class="form-group">
                                <label class="col-sm-4">PPH Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPPH" runat="server" CssClass="form-control" placeholder="PPH" DBColumnName="PPH_AMOUNT" SPParameterName="p_pph_amount" MaxLength="15" DataType="Number" Text=0 BindType="Both" Format="N2"></cc1:XUITextBox>    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Delivery Duration </label>        
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <cc1:XUITextBox ID="txtDeliveryDuration" runat="server" CssClass="form-control" placeholder="Delivery " DBColumnName="DELIVERY_DURATION" SPParameterName="p_delivery_duration" DataType="Integer" BindType="Both" MaxLength="3" Width="100px" Text=0></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblMonth" runat="server">&nbsp&nbsp Days</cc1:XUILabel> 
                                       <%-- <asp:RequiredFieldValidator ID="rfvDeliveryDuration" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDeliveryDuration" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                        <asp:RegularExpressionValidator ID="refDeliveryDuration" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDeliveryDuration" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator> 
                                    </div>
                                </div>
                            </div>      
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Guarantee </label>     
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <cc1:XUITextBox ID="txtGuarantee" runat="server" CssClass="form-control" placeholder="Guarantee (month)" DBColumnName="GUARANTEE" SPParameterName="p_guarantee" DataType="Integer" BindType="Both" MaxLength="3" Width="100px" Text=0></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblGuarantee" runat="server">&nbsp&nbsp Month</cc1:XUILabel> 
                                      
                                        <asp:RegularExpressionValidator ID="revguarantee" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtGuarantee" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>    
                                    </div>
                                </div>
                            </div>      
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4"> </label>      
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <cc1:XUITextBox ID="txtCreditDuration" runat="server" CssClass="form-control" placeholder="Credit Duration (Month)" DBColumnName="CREDIT_DURATION" SPParameterName="p_credit_duration" DataType="Integer"  style = "Display:none;" BindType="Both" MaxLength="3" Width="100px" Text=0></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblMonthCredit" runat="server">&nbsp&nbsp Month</cc1:XUILabel> 
                                        <%--<asp:RequiredFieldValidator ID="rfvCreditDuration" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCreditDuration" Display="Dynamic"></asp:RequiredFieldValidator>  --%>
                                      <%--  <asp:RegularExpressionValidator ID="refCreditDuration" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtCreditDuration" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator> --%>
                                    </div>
                                </div>
                            </div>      
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Guarantee Part</label>         
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <cc1:XUITextBox ID="txtGuaranteeDuration" runat="server" CssClass="form-control" placeholder="Guarantee Duration (month)" DBColumnName="GUARANTEE_DURATION" SPParameterName="p_guarantee_duration" DataType="Integer" BindType="Both" MaxLength="3" Width="100px" Text=0></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblMonthGuaranteeDuration" runat="server">&nbsp&nbsp Month</cc1:XUILabel> 
                                       
                                        <asp:RegularExpressionValidator ID="refGuaranteeDuration" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtGuaranteeDuration" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>      
                        </div>
                        
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Description *</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" DataType="String" BindType="Both" MaxLength="4000" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6" style = "Display:none;">
                            <div class="form-group">
                                <label class="col-sm-4">Amortization Start Date </label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtAmortizationStartDate" runat="server" CssClass="form-control default-date-picker" placeholder="Amortization Start Date" DBColumnName="AMORTIZATION_DATE" SPParameterName="p_amortization_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                </div>         
                            </div>
                        </div>
                    </div>
                    <div class="row">  
                        <div class="col-sm-12">
                            <div class="form-group">
                            </div>                            
                        </div>
                         <%--(+) Ari 30-12-2022 ket : enhancement 2022, jika group role multiplebranch dapat akses pilih branch--%>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Is Multiplebranch</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblMultiplebranch" runat="server" DBColumnName="MULTIPLEBRANCH" BindType="DBToUIOnly" DataType="String"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                    </div> 
             
        </div>
    </section>
</asp:Content>
