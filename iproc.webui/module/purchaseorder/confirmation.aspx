<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="confirmation.aspx.cs" Inherits="module_purchaseorder_confirmation" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>Confirmation Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R50000070E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                     <%--ID APPROVEL--%>
                    <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None" style="display:none;"></cc1:XUILabel>
                    <div class="row">
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUILabel>
                        <cc1:XUITextBox ID="txtCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUITextBox>
                        <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String"  BindType="Both" style="display:none;" Text="001"></cc1:XUILabel>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PO No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                                    <cc1:XUILabel ID="lblFlagProcess" runat="server" DBColumnName="FLAG_PROCESS" DataType="String" BindType="DBToUIOnly" style="display:none;"  ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagDesc" runat="server"  DBColumnName="TRANS_FLAG_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                </div>
                            </div>                             
                        </div>                        
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Confirm Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtConfirmationDate" runat="server" CssClass="form-control default-date-picker" placeholder="Confirm Date" DBColumnName="CONFIRMATION_DATE" SPParameterName="p_confirmation_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvConfirmationDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtConfirmationDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revConfirmationDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtConfirmationDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Process</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblProcess" runat="server"  DBColumnName="PROCESS" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtOrderDate" runat="server" CssClass="form-control default-date-picker" placeholder="Order Date" DBColumnName="ORDER_DATE" SPParameterName="p_order_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvOrderDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtOrderDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtOrderDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                             
                        </div>    
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Supplier *</label> 
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpSupplier" class="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtSupplierCode" runat="server"  CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" DataType="String" MaxLength="18" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtSupplier"  runat="server" DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"  Enabled="false" Width="200px" style="border:0px; background:inherit"></cc1:XUITextBox> 
                                    <asp:RequiredFieldValidator ID="rfvSupplier" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplier" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                             
                        </div>
                    </div>  
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Order Type</label>
                                <div class="col-sm-8">
                                    <cc1:XUIRadioButtonList ID="rblOrderType" runat="server"  DBColumnName="ORDER_TYPE" SPParameterName="p_order_type" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" >
                                        <asp:ListItem Value="PO" Selected="True">PO&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="SPK">SPK&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="CNT">Contract</asp:ListItem>
                                    </cc1:XUIRadioButtonList>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Currency</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlCurrency"  runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                                </div>
                            </div>                             
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                             <div class="form-group">
                                <label class="col-sm-4">Tax</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlTaxType"  runat="server" CssClass="form-control" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PPN</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPPN" runat="server" CssClass="form-control" placeholder="PPN" DBColumnName="PPN" SPParameterName="p_ppn" MaxLength="15" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                       <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Discount</label>       
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtDiscount" runat="server" CssClass="form-control" placeholder="Discount" DBColumnName="DISCOUNT" SPParameterName="p_discount" MaxLength="15" DataType="Number" Format="N2" BindType="Both" Text="0" Enabled="false" ></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revDiscount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDiscount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                </div>
                            </div>                            
                       </div>
                       <div class="col-sm-6">
                           <div class="form-group">
                                <label class="col-sm-4">PPH</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPPH" runat="server" CssClass="form-control" placeholder="PPH" DBColumnName="PPH" SPParameterName="p_pph" MaxLength="15" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Fee Amount</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTotalFee" runat="server" CssClass="form-control" placeholder="Fee Amount" DBColumnName="TOTAL_FEE" SPParameterName="p_total_fee" MaxLength="15" DataType="Number" Format="N2" BindType="Both" Text="0" Enabled="false" ></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revTotalFee" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTotalFee" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator> 
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total Amount</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTotalAmount" runat="server" CssClass="form-control" placeholder="Total Amount" DBColumnName="TOTAL_AMOUNT" SPParameterName="p_total_amount" MaxLength="15" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                       <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Payment Type</label>
                                <div class="col-sm-8">
                                    <cc1:XUIRadioButtonList ID="rblPaymentType" runat="server"  DBColumnName="TYPE" SPParameterName="p_type" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" >
                                        <asp:ListItem Value="CSH" Selected="True">CASH&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="TRF">TRANSFER&nbsp&nbsp</asp:ListItem>
                                    </cc1:XUIRadioButtonList>
                                </div>
                            </div>
                        </div>                      
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created </label>
                                <div class="col-sm-">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Modified </label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "EMP_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName= "MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div>                                        
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click"/>
                </Triggers>
           </asp:UpdatePanel>
        </div>
    </section>
    
    <asp:Panel runat="server" ID="pnlDetail">
    <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">       
              <li class="active">
                  <a href="#itemlist" id="poitemlist" onclick="javascript:fnSetTab('poitemlist');" data-toggle="tab" style="padding-bottom:28px">
                      Item List 
                  </a>
              </li>
              
              <li class="">
                  <a href="#TOP" id="poTOP" onclick="javascript:fnSetTab('poTOP');" data-toggle="tab" style="padding-bottom:28px">
                      Term of Payment
                  </a>
              </li> 
              <li class="">
                  <a href="#feeList" id="pofeelist" onclick="javascript:fnSetTab('pofeelist');" data-toggle="tab" style="padding-bottom:28px">
                      Fee
                  </a>
              </li>
          </ul>
        </header>    
        
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
               <div class="tab-pane active" id="itemlist">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8">
                            </div>
                            <div class="col-sm-4 ">
                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="upd" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID,CURRENCY_CODE"
                                    OnRowDataBound="gvwList_OnRowDataBound" ShowFooter="true" 
                                    OnPageIndexChanging="gvwList_PageIndexChanging" 
                                    onselectedindexchanged="gvwList_SelectedIndexChanged"  EmptyDataText="There is no data" Width="100%" >
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate> 
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                        <HeaderTemplate>
                                              <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                        </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                            <ItemStyle Width="35%"/>  
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ORDER_QUANTITY" HeaderText="Order Qty" DataFormatString= {0:N2} >
                                            <ItemStyle Width="10%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UNIT_DESC" HeaderText="UOM">
                                            <ItemStyle Width="15%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UNIT_PRICE" HeaderText="Unit Price" DataFormatString= {0:N2}>
                                            <ItemStyle Width="20%" HorizontalAlign="Right" />
                                            <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="True" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SUBTOTAL" HeaderText="Sub Total" DataFormatString= {0:N2}>
                                            <ItemStyle Width="20%" HorizontalAlign="Right" />
                                            <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="True" />
                                        </asp:BoundField>
                                        <%--<asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
               <div class="tab-pane" id="TOP">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                            </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchTOP" runat="server" DefaultButton="btnSearchTOP" class="input-group">
                                       <asp:TextBox ID="txtSearchTOP" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchTOP" runat="server" CssClass="btn btn-info" OnClick="btnSearchTOP_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                       </div>
                                   </asp:Panel>
                             </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updTOP" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListTOP" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID, TRX_CODE"
                                    OnPageIndexChanging="gvwListTOP_PageIndexChanging" 
                                    onselectedindexchanged="gvwListTOP_SelectedIndexChanged" EmptyDataText="There Is No Data">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate> 
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                 <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TRX_CODE_NAME" HeaderText="Trx Code" >
                                            <ItemStyle Width="40%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PERCENTAGE" HeaderText="Percentage" DataFormatString="{0:N6}">
                                            <ItemStyle Width="30%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="AMOUNT" HeaderText="Amount"  DataFormatString="{0:N2}">
                                            <ItemStyle Width="30%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <%--<asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchTOP" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
               <div class="tab-pane" id="feeList">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                            </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchFee" runat="server" DefaultButton="btnSearchFee" class="input-group">
                                       <asp:TextBox ID="txtSearchFee" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchFee" runat="server" CssClass="btn btn-info" OnClick="btnSearchFee_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                       </div>
                                   </asp:Panel>
                             </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updFee" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListFee" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                    OnPageIndexChanging="gvwListFee_PageIndexChanging" OnRowDataBound="gvwListFee_RowDataBound"
                                    EmptyDataText="There Is No Data">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate> 
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                 <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TRX_NAME" HeaderText="Transaction Type" >
                                            <ItemStyle Width="30%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Currency">
                                          <ItemStyle Width="20%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlCurrencyCode" CssClass="form-control">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Charged To">
                                          <ItemStyle Width="25%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlChargedTo" CssClass="form-control">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                          <ItemStyle Width="25%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtAmountFee" CssClass="form-control"/>
                                                <asp:RegularExpressionValidator ID="revAmountFee" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmountFee" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                                <asp:RequiredFieldValidator ID="rfvAmountFee" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmountFee" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                       <%-- <asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchFee" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </asp:Panel>    
</asp:Content>