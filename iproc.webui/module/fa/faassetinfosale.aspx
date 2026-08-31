<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="faassetinfosale.aspx.cs" Inherits="module_fa_faassetinfosale" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>FA Asset Info</span>
        </header>
            <div class="panel-heading">
                <div class="row">
                    <div class="col-sm-12">
                        <button  ID="btnbtnclose" runat="server" CssClass="btn btn-danger" class="icon-remove" onclick="parent.fnHideGenericScreen();">Close</button>
                        <cc1:XUILinkButton RoleCode="R90000060E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" style = "Display:none;"><i class="icon-save" style = "Display:none;"></i>  Save</cc1:XUILinkButton>
                        <cc1:XUILinkButton RoleCode="IPR040200U" ID="btnGenerate" runat="server" CssClass="btn btn-primary" ValidationGroup="Header" OnClick="btnGenerate_Click" style = "Display:none;"><i class="icon-save" style = "Display:none;"></i>  Generate</cc1:XUILinkButton>
                        <%--<cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false" ><i class="icon-remove" style = "Display:none;"></i>  Cancel</cc1:XUILinkButton>--%>
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
                            <div class="col-sm-6">
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
                                        <cc1:XUILabel ID="lblCostCenter" runat="server" DBColumnName="BRANCH_CODE" DataType="string" BindType="DBToUIOnly"></cc1:XUILabel> - 
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
                                    <label class="col-sm-4 ">FA Parent</label>
                                    <div class="col-sm-8">
                                        <asp:LinkButton runat="server" ID="btnLookUpFAParent" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtFAParent" style="display:none" runat="server" CssClass="form-control" DBColumnName="FA_PARENT_CODE" SPParameterName="p_fa_parent_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblFAParent" runat="server"  DBColumnName="FA_PARENT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                       
                                    </div>
                                 </div>                        
                             </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Grouping Asset Name</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="XUILabel1" runat="server" DBColumnName="grouping_asset_name"  DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
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
                                        <cc1:XUITextBox ID="txtSupplierID" style="display:none" runat="server" CssClass="form-control" DBColumnName="PIC_CODE" SPParameterName="p_pic_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblSupplierName" runat="server"  DBColumnName="EMP_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                       
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
                                        <cc1:XUILabel ID="txtCategoryBook" runat="server" DBColumnName="CAT_CODE_BOOK" DataType="String" BindType="DBToUIOnly" MaxLength="10"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">FA Depreciation Category Fiscal Code</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblCatCodeFiscal" runat="server" DBColumnName="CAT_CODE_FISCAL"  DataType="String" BindType="DBToUIOnly" MaxLength="10"></cc1:XUILabel>
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
                            
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" /><%--
                        <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />--%>
                    </Triggers>
                </asp:UpdatePanel>
            </div>
    </section>
 </asp:Content>

