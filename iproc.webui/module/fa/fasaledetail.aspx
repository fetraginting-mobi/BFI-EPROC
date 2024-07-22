<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fasaledetail.aspx.cs" Inherits="module_fa_fasaledetail" %>

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
                    <cc1:XUILinkButton RoleCode="R90000100E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                    <!--ID-->
                        <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                    <!--Barcode-->
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="FA_SALE_CODE" SPParameterName="p_fa_sale_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
                    <!--FA_Asset_ID-->
                         <cc1:XUITextBox ID="txtFaID" runat="server" DBColumnName="FA_ASSET_ID"  DataType="Integer" BindType="DBToUIOnly" Text= "0" style="Display:none;" ></cc1:XUITextBox> 
                         <!--FA_Asset_Type-->
                           <cc1:XUITextBox ID="txtAssetType" runat="server" DBColumnName="ASSET_TYPE"  DataType="String" BindType="DBToUIOnly" Text= "0" style="Display:none;" ></cc1:XUITextBox> 
                    <!--Location-->
                        <cc1:XUITextBox ID="txtLocation" runat="server" DBColumnName="CURRENT_BRANCH" DataType="String" BindType="DBToUIOnly" style="Display:none;" ></cc1:XUITextBox> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">FS No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblFaSaleCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblFSStatus" runat="server" DBColumnName="FS_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Asset Code *</label>
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="lblBarcode" runat="server" DBColumnName="BARCODE" SPParameterName="p_barcode" DataType="String" BindType="Both" ></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtBarcode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="BARCODE" SPParameterName="p_barcode" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:LinkButton ID="btnViewFaAsset" runat="server" CausesValidation="false" Text="Asset Info"/>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6" style="display:none">
                            <div class="form-group">
                                <label class="col-sm-4">Asset Code *</label> 
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtAssetCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ASSET_CODE" SPParameterName="p_code_asset" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAssetCode" runat="server"  DBColumnName="ASSET_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>   
                                    
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Asset Name</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblAssetName" runat="server" DBColumnName="NAME_ASSET" SPParameterName="p_name_asset" DataType="String" BindType="Both" MaxLength= "60" ></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtNameAsset" style="display:none" runat="server"  CssClass="form-control" DBColumnName="NAME_ASSET" SPParameterName="p_name_asset" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Cost Center</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCostCenter" runat="server"  DBColumnName="COST_CENTER" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>    
                               </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Asset Location</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblAssetLocation" runat="server"  DBColumnName="LOCATION" DataType="String" BindType="DBToUIOnly" MaxLength= "60" ></cc1:XUILabel>
                               </div>
                            </div>                            
                        </div> 
                    </div>    
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">Original Value *</label>        
                                <div class="col-sm-5">
                                      <cc1:XUITextBox ID="txtOriginalValue" runat="server"  CssClass="form-control" placeholder="Original Value" DBColumnName="ORIG_PRICE" SPParameterName="p_orig_price" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvOriginalValue" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtOriginalValue" Display="Dynamic"></asp:RequiredFieldValidator>                
                                    <asp:RegularExpressionValidator ID="revOriginalValue" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtOriginalValue" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>    
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">Sale Value *</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtSaleValue" runat="server"  CssClass="form-control" placeholder="Sale Value" DBColumnName="SALE_VALUE" SPParameterName="p_sale_value" MaxLength="18" DataType="Number" BindType="Both" Format="N2" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvSaleValue" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSaleValue" Display="Dynamic"></asp:RequiredFieldValidator>                
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtSaleValue" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>    
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">Net Book Value *</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtNetBookValue" runat="server"  CssClass="form-control" placeholder="Net Book Value" DBColumnName="NET_BOOK_VALUE" SPParameterName="p_net_book_value" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvNetBookValue" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtNetBookValue" Display="Dynamic"></asp:RequiredFieldValidator>                
                                    <asp:RegularExpressionValidator ID="revNetBookValue" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtNetBookValue" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div> 
                         <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">Total Depresiasi *</label>        
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtTotalDepresiasi" runat="server"  CssClass="form-control" placeholder="Total Depresiasi" DBColumnName="TOT_DEPRE" SPParameterName="p_tot_depre" MaxLength="18" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvTotalDepresiasi" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTotalDepresiasi" Display="Dynamic"></asp:RequiredFieldValidator>                
                                    <asp:RegularExpressionValidator ID="revTotalDepresiasi" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTotalDepresiasi" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div> 
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="100" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 100" Display="Dynamic"></asp:RegularExpressionValidator>
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
    <asp:Panel runat="server" ID="pnlDoc">
        <section class="panel">
            <header class="panel-heading">
              <span>FA Sale Document</span>
            </header>
             
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton RoleCode="R50000050E" ID="btnAdd" runat="server" CssClass="btn btn-primary" CausesValidation="false" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="R50000050E" ID="btnSaveDocumentDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDocumentDetail_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton> 
                        </div>
                        <div class="col-sm-4 ">
                            <asp:Panel ID="pnlSearchDocReq" runat="server" DefaultButton="btnSearchDocReq" class="input-group">
                                <asp:TextBox ID="txtSearchDocReq" runat="server" CssClass="form-control" ></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchDocReq" runat="server" CssClass="btn btn-info" OnClick="btnSearchDocReq_Click"><i class="icon-search"></i> Search</asp:LinkButton>
                                </div>
                           </asp:Panel>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                       <%-- <asp:UpdatePanel ID="updDetail" runat="server">
                            <ContentTemplate>--%>
                                <asp:GridView ID="gvwListDocReq" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, FA_CODE, PATHS, FILE, ID"
                                    OnPageIndexChanging="gvwListDocReq_PageIndexChanging" OnRowDataBound="gvwListDocReq_OnRowDataBound" OnRowCommand="gvwListDocReq_RowCommand"
                                    onselectedindexchanged="gvwListDocReq_SelectedIndexChanged" EmptyDataText="There is no data"  AllowSorting="true">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <span>No</span>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="DESCRIPTION" HeaderText="Document">
                                            <ItemStyle Width="40%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="File Name">
                                            <ItemStyle Width="60%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                 <asp:Label runat="server" Text='<%# Eval("PATHS") %>' ID="lblFileName"/>
                                                 <br />
                                                <asp:FileUpload runat="server" ID="fupFilename" />
                                            </ItemTemplate>
                                         </asp:TemplateField>
                                        <asp:TemplateField HeaderText="">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                     <ItemTemplate>
                                        <%--<asp:Label ID="btnPreviewDoc" runat="server">Preview</asp:Label>--%>
                                         <asp:LinkButton ID="btnPreviewDoc" runat="server" CausesValidation="false" Text="Preview"/>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                          <asp:TemplateField HeaderText="">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnDeleteDoc" runat="server" CausesValidation="false" Text="Delete" CommandName="del"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            <%--</ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchDocReq" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>--%>
                    </div>
            </section>
    </asp:Panel>
</asp:Content>

