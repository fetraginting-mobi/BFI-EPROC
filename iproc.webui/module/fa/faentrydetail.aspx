<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="faentrydetail.aspx.cs" Inherits="module_fa_faentrydetail" Title="Untitled Page" %>

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
                    <cc1:XUILinkButton RoleCode="R90000070E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
             <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate> 
                    <!--ID-->
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                    <!--Barcode-->
                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="FA_ENTRY_CODE" SPParameterName="p_fa_entry_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel> 
                    
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">FA Entry No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblFECode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblFEStatus" runat="server" DBColumnName="FE_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>  
                      <div class="col-sm-6" visible = "false">
                            <div class="form-group">
                                <label class="col-sm-4" visible = "false">Asset Code</label>
                                <div class="col-sm-5" visible = "false">
                                    <cc1:XUILabel ID="txtBarcode" runat="server" DBColumnName="BARCODE" SPParameterName="p_barcode" MaxLength="20" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Purchase Date *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPurchaseDate" runat="server" CssClass="form-control default-date-picker" placeholder="Purchase Date" DBColumnName="PURCHASE_DATE" SPParameterName="p_purchase_date" MaxLength="10" DataType="DateTime" BindType="Both" Format ="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvOrder" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPurchaseDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtPurchaseDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">   
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Asset Name *</label>    
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpInventoryEntryItem" class="btn btn-primary input-sm" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton> 
                                </div>
                               <div class="col-sm-5">   
                                    <cc1:XUITextBox ID="txtItemName" runat="server"  DBColumnName="ITEM_NAME" SPParameterName="p_item_name" Enabled="false" CssClass="form-control" DataType="String" BindType="Both" TextMode="MultiLine" Text="--"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtItemCode" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="Both" SPParameterName="p_item_code" CssClass="form-control" style="Display:none;"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvItemName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemName" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Category</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlCategory" runat="server" CssClass="form-control" DBColumnName="FA_CATEGORY_CODE" SPParameterName="p_fa_category_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Price *</label>      
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtCostPrice"  Enabled ="false" runat="server" CssClass="form-control" placeholder="Price" DBColumnName="COST_PRICE" SPParameterName="p_cost_price" DataType="Number" MaxLength="14" BindType="Both" Text="0.00" Format = "N2"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCostPrice" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCostPrice" Display="Dynamic"></asp:RequiredFieldValidator>         
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtCostPrice" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>   
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6"> 
                          <div class="form-group">
                                <label class="col-sm-4 ">Owner</label>
                                <div class="col-sm-4">
                                   <cc1:XUILabel ID="lblOwner" runat="server" DBColumnName="OWNER" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div> 
                          </div>   
                      <%--  <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Cost Center</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlfaLocationCode" runat="server" CssClass="form-control" DBColumnName="FA_LOCATION" SPParameterName="p_fa_location"  Enabled="false" BindType="Both" DataType="String" ></cc1:XUIDropDownList>                                               
                                </div>
                            </div>                            
                        </div>--%>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">FA Depre Category Commercial</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlDepreCategoryBook" runat="server" CssClass="form-control" DBColumnName="FA_DEPRE_CATEGORY_BOOK_CODE" SPParameterName="p_fa_depre_category_book_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">FA Depre Category Fiscal</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlDepreCategoryFiscal" runat="server" CssClass="form-control" DBColumnName="FA_DEPRE_CATEGORY_FISCAL_CODE" SPParameterName="p_fa_depre_category_fiscal_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4"></label>        
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtTotalDepreKormesil" runat="server" CssClass="form-control" style="Display:none;" placeholder="Total Depreciation Commercial" DBColumnName="TOTAL_DEPRE_KORMESIL" SPParameterName="p_total_depre_kormesil" DataType="Number" MaxLength="14" BindType="Both" Format = "N2" text="0.00"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvTotalDepreKormesil" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTotalDepreKormesil" Display="Dynamic"></asp:RequiredFieldValidator>         
                                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTotalDepreKormesil" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator> --%>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4"></label>    
                                <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtTotalDepreFiscal" runat="server" CssClass="form-control" style="Display:none;" placeholder="Total Depreciation Fiscal" DBColumnName="TOTAL_DEPRE_FISCAL" SPParameterName="p_total_depre_fiscal" DataType="Number" MaxLength="14" BindType="Both" Format = "N2" text="0.00"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvTotalDepreFiscal" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTotalDepreFiscal" Display="Dynamic"></asp:RequiredFieldValidator>         
                               <%-- <asp:RegularExpressionValidator ID="revTotalDepreFiscal" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTotalDepreFiscal" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>--%>     
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4"></label>       
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtNetBookValueKormesil" runat="server" CssClass="form-control" style="Display:none;" placeholder="Net Book Value Commercial" DBColumnName="NET_BOOK_VALUE_KORMERSIL" SPParameterName="p_net_book_value_kormesil" DataType="Number" MaxLength="14" BindType="Both" Format = "N2" text="0.00"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvNetBookValueKormesil" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtNetBookValueKormesil" Display="Dynamic"></asp:RequiredFieldValidator>         
                                   <%-- <asp:RegularExpressionValidator ID="revNetBookValueKormesil" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtNetBookValueKormesil" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  --%>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4"></label>     
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtNetBookValueFiscal" runat="server" style="Display:none;" CssClass="form-control" placeholder="Net Book Value Fiscal" DBColumnName="NET_BOOK_VALUE_FISCAL" SPParameterName="p_net_book_value_fiscal" DataType="Number" MaxLength="14" BindType="Both" Format = "N2" text="0.00"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rvfNetBookValueFiscal" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtNetBookValueFiscal" Display="Dynamic"></asp:RequiredFieldValidator>         
                                  <%--  <asp:RegularExpressionValidator ID="revNetBookValueFiscal" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtNetBookValueFiscal" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>    --%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Object Info *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtObjectInfo" runat="server" CssClass="form-control" placeholder="Ooject Info" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="100" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtObjectInfo" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator2" ControlToValidate="txtObjectInfo" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 100" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Remarks</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both"  TextMode="MultiLine" MaxLength="400"></cc1:XUITextBox>
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

