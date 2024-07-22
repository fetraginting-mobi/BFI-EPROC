<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="faasset.aspx.cs"
    Inherits="module_commonmst_faasset" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>FA Asset Info</span>
        </header>
            <div class="panel-heading">
                <div class="row">
                    <div class="col-sm-12">
                        <cc1:XUILinkButton RoleCode="R90000060E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                        <cc1:XUILinkButton RoleCode="R90000060E" ID="btnGenerate" runat="server" CssClass="btn btn-primary" ValidationGroup="Header" OnClick="btnGenerate_Click"><i class="icon-save"></i>  Generate</cc1:XUILinkButton>
                        <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    </div>
                </div>
            </div>
            <div class="panel-body form-horizontal">
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row">
                              <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Asset Code</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lbNobarcode" runat="server"  DBColumnName="BARCODE" SPParameterName="p_barcode" DataType="String" BindType="Both" MaxLength="50" style = "Display:none;"></cc1:XUILabel>
                                        <cc1:XUILabel ID="lblBarcode" runat="server"  DBColumnName="BARCODE" SPParameterName="p_barcode" DataType="String" BindType="Both" MaxLength="50" ></cc1:XUILabel>
                                        <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style = "Display:none;"></cc1:XUILabel>
                                        <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div> 
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Status</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_CODE" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div> 
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Asset Name</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblAssetName" runat="server"  DBColumnName="AST_NAME"  DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-8">
                                         <asp:Image runat="server" ID="imgBarcode" /> <%--ImageUrl="../../temp/qrcodes/1000000555.png" --%>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">
                              <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Old Barcode</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblOldBarcode" runat="server"  DBColumnName="OLD_BARCODE" SPParameterName="p_barcode" DataType="String" BindType="DBToUIOnly" MaxLength="50"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                               <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Po Code</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblPoCode" runat="server"  DBColumnName="CODE"  DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">
                              <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Requestor</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblRequestor" runat="server" DBColumnName="EMP_NAME" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Supplier</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblSupplier" runat="server" DBColumnName="SUPPLIER_NAME" BindType="DBToUIOnly" DataType="String" ></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div>  
                        <div class="row">  
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Purchase Date</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblDatePurc" runat="server"  DBColumnName="DATE_PURC" SPParameterName="p_date_purc" MaxLength="10" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Asset Type</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblAssetType" runat="server"  DBColumnName="ASSET_TYPE_DESC" MaxLength="50" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        <cc1:XUILabel ID="lblAsset" runat="server"  DBColumnName="ASSET_TYPE" MaxLength="50" DataType="String" BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                             <div class="col-sm-6">
                                <div class="form-group" style = "Display:none;">
                                    <label class="col-sm-4 ">Barcode</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="txtAstCode"  runat="server" placeholder="Ast Code" DBColumnName="AST_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        <cc1:XUITextBox ID="lblAstCode" style = "Display:none;" runat="server" CssClass="form-control" placeholder="Asset Code" DBColumnName="AST_CODE" SPParameterName="p_ast_code" DataType="String" BindType="Both" MaxLength="20"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div> 
                        </div> 
                         <div class="row">  
                            <div class="col-sm-6">
                                <div class="form-group" ID="disdate" runat="server">
                                    <label class="col-sm-4 ">Disposal Date</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblDisposalDate" runat="server"  DBColumnName="DISPOSAL_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6" ID="saldate" runat="server">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Sale Date</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblSaleDate" runat="server"  DBColumnName="SALE_DATE"  DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                             <div class="col-sm-6" >
                                <div class="form-group">
                                   <%-- <label class="col-sm-4 ">Sale Value</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblSaleValue"  runat="server"  DBColumnName="SALE_VALUE" DataType="Number" Format="N2" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>--%>
                                </div>                            
                            </div> 
                        </div> 
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Price</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblCostPrice" runat="server" DBColumnName="COST_PRICE" DataType="Number" BindType="DBToUIOnly" Format = "N2"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Original Price</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblOrigPrice" runat="server"  DBColumnName="ORIG_PRICE"  DataType="Number" BindType="DBToUIOnly" Format = "N2"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>   
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Sale Date</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblDateSold" runat="server" DBColumnName="SALE_DATE" MaxLength="20" DataType="DateTime" BindType="DBToUIOnly" Format= "dd/MM/yyyy"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>  
                            <div class="col-sm-6"  ID="salue" runat="server">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Sale Value</label>
                                    <div class="col-sm-8">
                                     <cc1:XUILabel ID="lblSalevalue" runat="server" DBColumnName="SALE_VALUE" DataType="Number" BindType="DBToUIOnly" Format = "N2"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                        </div>
                        <div class="row">  
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Cost Center</label>
                                    <div class="col-sm-8">
                                        <%--<cc1:XUILabel ID="lblCostCenter" runat="server" DBColumnName="BRANCH_CODE" DataType="string" BindType="DBToUIOnly"></cc1:XUILabel> ---%> 
                                        <cc1:XUILabel ID="lblCostCenterName" runat="server" DBColumnName="BRANCH_NAME" DataType="string" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Location</label>
                                    <div class="col-sm-8">
                                        <%--<cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="CURRENT_BRANCH" DataType="string" BindType="DBToUIOnly"></cc1:XUILabel>--%>
                                       <asp:LinkButton runat="server" ID="btnLookUpLocation" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtLocation" style="display:none" runat="server" CssClass="form-control" DBColumnName="CURRENT_BRANCH" SPParameterName="p_current_branch" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblLocation" runat="server"  DBColumnName="LOC_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                                    </div>
                                </div>                            
                            </div> 
                             
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4"></label>
                                    <div class="col-sm-8">
                                        <asp:LinkButton runat="server" style="display:none"  ID="btnLookUpFAParent" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtFAParent"  style="display:none" runat="server" CssClass="form-control" DBColumnName="FA_PARENT_CODE" SPParameterName="p_fa_parent_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblFAParent" style="display:none" runat="server"  DBColumnName="FA_PARENT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                       
                                    </div>
                                 </div>                            
                             </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-8">
                                      
                                    </div>
                                 </div>                            
                             </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">PIC</label>
                                    <div class="col-sm-8">
                                        <asp:LinkButton runat="server" ID="btnLookUpUserRequest" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtSupplierID" runat="server" style="display:none" CssClass="form-control" DBColumnName="PIC_CODE" SPParameterName="p_pic_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblSupplierName" runat="server" DBColumnName="EMP_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                       
                                    </div>
                                 </div>                            
                             </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Residual Value</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtResidualValue" runat="server" CssClass="form-control" placeholder="Residual Value" DBColumnName="RESIDUAL_VALUE" SPParameterName="p_residual_value" DataType="Number" BindType="Both" MaxLength="18" Format="N2"></cc1:XUITextBox>
                                        <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtResidualValue" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    </div>
                                </div>                            
                            </div>
                        </div>   
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Category Code</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblCatCode" runat="server" DBColumnName="CAT_CODE"  MaxLength="10" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel> 
                                    </div>
                                 </div>                            
                            </div> 
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Category Name</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblCatName" runat="server"  DBColumnName="CAT_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">FA Depreciation Category Commercial</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="txtCategoryBook" runat="server" DBColumnName="CAT_CODE_BOOK" SPParameterName="p_cat_code_book" DataType="String" BindType="Both" MaxLength="10"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">FA Depreciation Category Fiscal Code</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblCatCodeFiscal" runat="server" DBColumnName="CAT_CODE_FISCAL" SPParameterName="p_cat_code_fiscal" DataType="String" BindType="Both" MaxLength="10"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div> 
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Net Book Value Commercial</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblNetBookValue" runat="server"  DBColumnName="NET_BOOK_VALUE"  DataType="Number" BindType="DBToUIOnly" MaxLength="18" Format="N2" ></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Net Book Value Fiscal</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblNetBookValueFiscal" runat="server" DBColumnName="NET_BOOK_VALUE_FISCAL" DataType="Number" BindType="DBToUIOnly" MaxLength="18" Format="N2" ></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div> 
                        <div class="row">
                             <div class="col-sm-6">
                                 <div class="form-group">
                                    <label class="col-sm-4 ">Total Depreciation Commercial</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblTotDepre" runat="server"  DBColumnName="TOT_DEPRE"  DataType="Number" BindType="DBToUIOnly" MaxLength="20" Format="N2"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Total Depreciation Fiscal</label>
                                    <div class="col-sm-8">
                                         <cc1:XUILabel ID="lblTotDepreFiscal" runat="server"  DBColumnName="TOT_DEPRE_FISCAL" DataType="Number" BindType="DBToUIOnly" MaxLength="18" Format="N2" ></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div>   
                        <div class="row">
                             <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Depreciation Commercial Period</label>
                                    <div class="col-sm-8">
                                         <cc1:XUILabel ID="lblDepresiasiPeriod" runat="server" DBColumnName="DEPRE_PERIOD"  DataType="String" BindType="DBToUIOnly" MaxLength="18" Format="N2"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Depreciation Period Fiscal</label>
                                    <div class="col-sm-8">
                                         <cc1:XUILabel ID="lblDeprePeriodFiscal" runat="server"  DBColumnName="DEPRE_PERIOD_FISCAL"  DataType="String" BindType="DBToUIOnly" MaxLength="18" Format="N2"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>   
                        </div> 
                        <div class="row">
                             <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Total Amount Maintenance</label>
                                    <div class="col-sm-8">
                                         <cc1:XUILabel ID="lblmaintenance" runat="server" DBColumnName="maintenance"  DataType="Number" BindType="DBToUIOnly" MaxLength="18" Format="N2"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Object Info</label>
                                    <div class="col-sm-8">
                                        <cc1:XUITextBox ID="txtObjectInfo" runat="server" CssClass="form-control" placeholder="Object Info" DBColumnName="OBJECT_INFO" SPParameterName="p_object_info" DataType="String" BindType="Both" MaxLength="4000" TextMode="MultiLine"></cc1:XUITextBox>
                                    </div>
                                 </div>                            
                             </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Remarks</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblRemarks" runat="server" DBColumnName="REMARKS" DataType="String" BindType="DBToUIOnly" MaxLength="200" TextMode="MultiLine"></cc1:XUILabel>
                                    </div>
                                 </div>                            
                             </div>
                        </div>
                         <div class="row">
                            <div class="col-sm-6">                           
                             </div>
                             
                              <div class="col-sm-6" id="Used" runat="server">  
                                <div class="form-group">
                                    <label class="col-sm-4 ">Used by</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblUsedby" runat="server" DBColumnName="USED_BY" DataType="String" BindType="DBToUIOnly" MaxLength="200" TextMode="MultiLine"></cc1:XUILabel>
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
    <section class="panel">
            <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                <ul class="nav nav-tabs nav-justified">
                    <li class="active">
                        <a href="#AssetSpecific" id="assetspec" onclick="javascript:fnSetTab('assetspec');" style="padding-bottom:28px" data-toggle="tab">
                      Specific Info
                  </a>
                    </li>
                     <li class="">
                        <a href="#Insurance" id="insuranc" onclick="javascript:fnSetTab('insuranc');" style="padding-bottom:28px" data-toggle="tab">
                            Insurance 
                        </a>
                    </li>
                    <li class="">
                        <a href="#History" id="hist" onclick="javascript:fnSetTab('hist');" style="padding-bottom:28px" data-toggle="tab">
                            History Location
                        </a>
                    </li>
                    <li class="">
                        <a href="#Depreciation" id="Desc" onclick="javascript:fnSetTab('Desc');" style="padding-bottom:28px" data-toggle="tab">
                            History Depreciation
                        </a>
                    </li>
                     <li class="">
                        <a href="#Maintenance" id="Main" onclick="javascript:fnSetTab('main');" style="padding-bottom:28px" data-toggle="tab">
                            History Maintenance
                        </a>
                    </li>
                    <li class="">
                        <a href="#comdepre" id="com" onclick="javascript:fnSetTab('com');" style="padding-bottom:28px" data-toggle="tab">
                            Depre Commercial
                        </a>
                    </li>
                    <li class="">
                        <a href="#comfis" id="fis" onclick="javascript:fnSetTab('fis');" style="padding-bottom:28px" data-toggle="tab">
                           Depre Fiscal
                        </a>
                    </li><li class="">
                        <a href="#adjhis" id="adj" onclick="javascript:fnSetTab('adj');" style="padding-bottom:28px" data-toggle="tab">
                           History Adjust
                        </a>
                    </li>
                </ul>
            </header>
        
        <div class="panel-body">
             <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="AssetSpecific">
                            <section class="panel">
                                <asp:Panel ID="updAssetInfo" runat="server">
                                    <div class="panel-body">
                                        <asp:PlaceHolder runat="server" ID="pnlPlaceholder"></asp:PlaceHolder>
                                    </div>
                                </asp:Panel>
                            </section>
                        </div>
        <div class="tab-pane" id="Insurance">
        <header class="panel-heading">
          <span></span>
        </header>
       <div class="panel-heading">
                <div class="row">
                    <div class="col-sm-8">
                        <cc1:XUILinkButton ID="btnAddInsurance" RoleCode="R90000060E" runat="server" CssClass="btn btn-primary" style = "Display:none;" OnClick="btnAddInsurance_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                        <cc1:XUILinkButton ID="btnDeleteInsurance" RoleCode="R90000060E" runat="server" CssClass="btn btn-danger" style = "Display:none;" OnClick="btnDeleteInsurance_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                    </div>
                <div class="col-sm-4">
                  <asp:Panel ID="pnlSearchInsurance" runat="server" DefaultButton="btnSearchInsurance" class="input-group">       
                        <asp:TextBox ID="txtSearchInsurance" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                        <asp:LinkButton ID="btnSearchInsurance" runat="server" CssClass="btn btn-info" OnClick="btnSearchInsurance_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                   </asp:Panel>
                </div>
            </div>
         </div>
          <div class="panel-body">
            <asp:UpdatePanel ID="updInsurance" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListInsurance" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwListInsurance_PageIndexChanging" 
                        onselectedindexchanged="gvwListInsurance_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                            <%-- <asp:BoundField DataField="AST_CODE" HeaderText="Aset Code" >
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="POLICY_INSURANCE_NO" HeaderText="Insurance No." >
                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="POLICY_INSURANCE_COMPANY" HeaderText="Insurance Company" >
                                <ItemStyle Width="25%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="POLICY_START_DATE" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="POLICY_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="POLICY_PREMIUM" HeaderText="Premium" DataFormatString="{0:N2}" >
                                <ItemStyle Width="20%" HorizontalAlign="Right" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchInsurance" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteInsurance" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        </div>
       
        <div class="tab-pane" id="History">
        <div class="row">
                    <div class="col-sm-8">
                    </div>
                <div class="col-sm-4">
                  <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                </div>
                    </asp:Panel>
                </div>
            </div>
       <div class="panel-body"> 
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                   <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
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
                            <asp:BoundField DataField="DOC_REFF_NO" HeaderText="Doc Reff No.">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DOC_REFF_TYPE" HeaderText="Doc Reff Type">
                                <ItemStyle Width="15%" HorizontalAlign="Left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="AST_CODE" HeaderText="Asset">
                                <ItemStyle Width="15%" HorizontalAlign="Left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="FROM_LOCATION_CODE" HeaderText="From">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TO_LOCATION_CODE" HeaderText="To">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        </div>
        
      <div class="tab-pane" id="Depreciation">
        <div class="row">
                    <div class="col-sm-8">
                    </div>
                <div class="col-sm-4">
                  <asp:Panel ID="pnlSearchDesp" runat="server" DefaultButton="btnSearchDesp" class="input-group">
                    <asp:TextBox ID="txtSearchDesp" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSearchDesp" runat="server" CssClass="btn btn-info" OnClick="btnSearchDesp_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                </div>
                    </asp:Panel>
                </div>
            </div>
       <div class="panel-body"> 
            <asp:UpdatePanel ID="updDesp" runat="server">
                <ContentTemplate>
                   <asp:GridView ID="gvwListDesp" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="false" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwListDesp_PageIndexChanging" 
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
                            <asp:BoundField DataField="AST_CODE" HeaderText="Asset Name">
                                <ItemStyle Width="15%" HorizontalAlign="Left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DEPRECIATION_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="DEPRECIATION_VALUE_BOOK" HeaderText="Depreciation Value Commercial" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DEPRECIATION_VALUE_RESIDUAL" HeaderText="Book Value Commercial"  DataFormatString="{0:N2}">
                                <ItemStyle Width="20%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DEPRECIATION_VALUE_FISCAL_BOOK" HeaderText="Depreciation Value Fiscal" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DEPRECIATION_VALUE_RESIDUAL_FISCAL" HeaderText="Book Value Fiscal"  DataFormatString="{0:N2}">
                                <ItemStyle Width="20%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                          <%--  <asp:BoundField DataField="DEPRECIATION_VALUE_FISCAL_BOOK" HeaderText="Book Value Fiscal"  DataFormatString="{0:N2}">
                                <ItemStyle Width="20%" HorizontalAlign="Right"/>
                            </asp:BoundField>--%>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchDesp" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        </div>
        <div class="tab-pane" id="Maintenance">
        <div class="row">
                    <div class="col-sm-8">
                    </div>
                <div class="col-sm-4">
                  <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch" class="input-group">
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                <div class="input-group-btn">
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" OnClick="btnSearchMain_Click" CausesValidation ="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                </div>
                    </asp:Panel>
                </div>
            </div>
       <div class="panel-body"> 
            <asp:UpdatePanel ID="Updmnt" runat="server">
                <ContentTemplate>
                   <asp:GridView ID="gvwListMain" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID" 
                    OnRowDataBound="gvwListMain_OnRowDataBound" ShowFooter="false" 
                        OnPageIndexChanging="gvwListMain_PageIndexChanging" 
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
                            <asp:BoundField DataField="REQUESTOR_NAME" HeaderText="Requestor">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="TRX_DATE" HeaderText="Transaction Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="AMOUNT" HeaderText="Amount" DataFormatString="{0:N}">
                                <ItemStyle Width="10%" HorizontalAlign="Left"/>
                                 <FooterStyle Width="10%" HorizontalAlign="Right" Font-Bold="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VENDOR_BY" HeaderText="Vendor By">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                              <asp:BoundField DataField="LAST_KM" HeaderText="Last Kilometer" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="RECEIPT_NO" HeaderText="Receipt No">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                              <asp:BoundField DataField="Service" HeaderText="Service">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                           
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
               <%-- <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchMain" EventName="Click" />
                </Triggers>--%>
            </asp:UpdatePanel>
        </div>
        </div>
        
        <div class="tab-pane" id="comdepre">
        <div class="row">
                    <div class="col-sm-8">
                    </div>
                <div class="col-sm-4">
                  <asp:Panel ID="Panel2" runat="server" DefaultButton="btnSearchcom" class="input-group">
                    <asp:TextBox ID="txtSearchDepcom" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSearchcom" runat="server" CssClass="btn btn-info" OnClick="btnSearchcom_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                </div>
                    </asp:Panel>
                </div>
            </div>
       <div class="panel-body"> 
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                   <asp:GridView ID="gvwcomdep" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwListComdep_PageIndexChanging" 
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
                            <asp:BoundField DataField="DEPRE_DATE" HeaderText="Depretiation Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="25%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DEPRE_RATE_COM" DataFormatString="{0:N2}" HeaderText="Depre Rate Comercial">
                                <ItemStyle Width="25%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                           <asp:BoundField DataField="DEPRE_VALUE_COM" DataFormatString="{0:N2}" HeaderText="Depre Value Comercial">
                                <ItemStyle Width="25%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                              <asp:BoundField DataField="NET_BOOK_VALUE_COM" DataFormatString="{0:N2}" HeaderText="Net Book Value Comercial">
                                <ItemStyle Width="25%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                         
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
               <%-- <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchMain" EventName="Click" />
                </Triggers> --%>
            </asp:UpdatePanel>
        </div>
        </div>
        
        <div class="tab-pane" id="comfis">
        <div class="row">
                    <div class="col-sm-8">
                    </div>
                <div class="col-sm-4">
                  <asp:Panel ID="Panel3" runat="server" DefaultButton="btnSearchcomfis" class="input-group">
                    <asp:TextBox ID="txtSearchDepfis" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSearchcomfis" runat="server" CssClass="btn btn-info" OnClick="btnSearchcomfis_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                </div>
                    </asp:Panel>
                </div>
            </div>
       <div class="panel-body"> 
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                   <asp:GridView ID="gvwcomfis" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwListComfis_PageIndexChanging" 
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
                            <asp:BoundField DataField="DEPRE_DATE" HeaderText="Depretiation Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="25%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DEPRE_RATE_FIS" DataFormatString="{0:N2}" HeaderText="Depre Rate Fiscal">
                                <ItemStyle Width="25%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                           <asp:BoundField DataField="DEPRE_VALUE_FIS" DataFormatString="{0:N2}" HeaderText="Depre Value fiscal">
                                <ItemStyle Width="25%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                              <asp:BoundField DataField="NET_BOOK_VALUE_FIS" DataFormatString="{0:N2}" HeaderText="Net Book Value Fiscal">
                                <ItemStyle Width="25%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                         
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <%--<Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchMain" EventName="Click" />
                </Triggers>--%>
            </asp:UpdatePanel>
        </div>
        </div>
        
        <div class="tab-pane" id="adjhis">
        <div class="row">
                    <div class="col-sm-8">
                    </div>
                <div class="col-sm-4">
                  <asp:Panel ID="Panel4" runat="server" DefaultButton="btnSearchcomfis" class="input-group">
                    <asp:TextBox ID="txtSearchadjhis" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSearchadjhis" runat="server" CssClass="btn btn-info" OnClick="btnSearchadjhis_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                </div>
                    </asp:Panel>
                </div>
            </div>
       <div class="panel-body"> 
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                   <asp:GridView ID="gvwadjhis" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="FA_ADJUST_CODE"
                        OnPageIndexChanging="gvwListadjhis_PageIndexChanging" 
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
                            <asp:BoundField DataField="FA_ADJUST_CODE" HeaderText="Fa Adjust Code">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Trx Description">
                                <ItemStyle Width="30%" HorizontalAlign="Left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="AST_CODE" HeaderText="Asset">
                                <ItemStyle Width="15%" HorizontalAlign="Left"/>
                            </asp:BoundField>
                           
                             <asp:BoundField DataField="AMOUNT_FEE" HeaderText="Amount" DataFormatString="{0:N2}">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="ADJUST_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                         
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <%--<Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchMain" EventName="Click" />
                </Triggers>--%>
            </asp:UpdatePanel>
        </div>
        </div>
        
        </div>
        </div>
    </section>
</asp:Content>
