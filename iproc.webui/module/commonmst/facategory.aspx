<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="facategory.aspx.cs" Inherits="module_commonmst_facategory" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>FA Category Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R90000020E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="R90000020E" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>        
                <cc1:XUILabel ID="lblCategoryID" runat="server" DBColumnName="FA_CATEGORYID" SPParameterName="p_fa_categoryid" DataType="Integer" BindType="Both"  Text= "0" style =  "Display:none;"></cc1:XUILabel>           
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Category Code *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtCategoryCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="CAT_CODE" SPParameterName="p_cat_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCategoryCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCategoryCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>   
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Category Name *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder="Name" DBColumnName="CAT_NAME" SPParameterName="p_cat_name" MaxLength="40" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCategoryName" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>   
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Depreciation ACC No. *</label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpAccDepre" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtAccDepre" style="display:none" runat="server" CssClass="form-control" placeholder="Acc Depre" DBColumnName="ACC_DEPR" SPParameterName="p_acc_depr" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAccDepre" style="display:none"  runat="server"  DBColumnName="NO_ACC_DEPR" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNameAccDepre"  runat="server"  DBColumnName="NAME_ACC_DEPR" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvtxtAccDepre" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccDepre" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>  
                        </div>  
                        <div class="col-sm-6">
                            <div class="form-group">
                                    <label class="col-sm-4">Profit Loss ACC No. *</label>
                                    <div class="col-sm-7">
                                        <asp:LinkButton runat="server" ID="btnLookUpAccPL"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtAccPL" runat="server" style="display:none" CssClass="form-control" placeholder="Acc PL" DBColumnName="ACC_PL" SPParameterName="p_acc_pl" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblAccPL" style="display:none"  runat="server"  DBColumnName="NO_ACC_PL" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        <cc1:XUILabel ID="lblNameAccPL"  runat="server"  DBColumnName="NAME_ACC_PL" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        <asp:RequiredFieldValidator ID="rfvtxtAccPL" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccPL" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>                            
                            </div>                           
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Accumulation Depre. ACC No. *</label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpAkumulasi"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtAkul" runat="server" style="display:none"  CssClass="form-control" placeholder="Acc Accumulation" DBColumnName="ACC_ACCUMULATION" SPParameterName="p_acc_accumulation" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAkul" style="display:none"  runat="server"  DBColumnName="NO_ACC_AKUMUL" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblAkumulasi"  runat="server"  DBColumnName="NAME_ACC_AKUMUL" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccPL" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>   
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Last Calculated Date</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtLastCal" runat="server" CssClass="form-control default-date-picker" placeholder="Last Calculated" DBColumnName="LAST_CAL" SPParameterName="p_last_cal" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Asset Amount Treshold</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtAssetAmountTreshold" runat="server" CssClass="form-control" placeholder="Asset Amount Treshold" DBColumnName="ASSET_AMOUNT_TRESHOLD" SPParameterName="p_asset_amount_treshold" DataType="Number" BindType="Both" MaxLength="18" Format="N2"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Depreciation Amount Treshold</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtDepreciationAmounttreshold" runat="server" CssClass="form-control" placeholder="Depre Amount Treshold" DBColumnName="DEPRE_AMOUNT_TRESHOLD" SPParameterName="p_depre_amount_treshold" DataType="Number" BindType="Both" MaxLength="18" Format="N2"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>   
                    </div>
                    <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total Net Book Value</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtTotalValue" runat="server" CssClass="form-control" placeholder="Total Value" DBColumnName="TOT_VALUE" SPParameterName="p_tot_value" DataType="Number" BindType="Both" MaxLength="18" Format="N2"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total Accumulation Depreciation</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtTotalDepre" runat="server" CssClass="form-control" placeholder="Total Depresiasi" DBColumnName="TOT_DEPRE" SPParameterName="p_tot_depre" DataType="Number" BindType="Both" MaxLength="18" Format="N2"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>   
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total Asset Value</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtTotalAsset" runat="server" CssClass="form-control" placeholder="Total Asset" DBColumnName="TOT_ASSET" SPParameterName="p_tot_asset" DataType="Number" BindType="Both" MaxLength="18" Format="N2"></cc1:XUITextBox> 
                                </div>  
                             </div>
                        </div>  
                        <div class="col-sm-6" style="display:none">
                            <div class="form-group">
                                <label class="col-sm-4 ">Is Use Operating Lease</label>
                                <div class="col-sm-7">
                                    <cc1:XUICheckBox ID="chbFlagGrossUp" runat="server" DBColumnName="IS_USE_OPPERATING_LIST_FLAG" SPParameterName="p_is_use_opperating_list_flag" MaxLength="1" DataType="String" BindType="Both"></cc1:XUICheckBox>                           
                                </div>
                            </div>                            
                        </div>   
                      <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Type</label>
                                    <div class="col-sm-7">
                                        <cc1:XUIDropDownList ID="ddlAssetType" runat="server" CssClass="form-control" placeholder="Asset Type" DBColumnName="ASSET_TYPE" SPParameterName="p_asset_type" MaxLength="10" DataType="String" BindType="Both" Width="250px"></cc1:XUIDropDownList>
                                    </div>
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
    </div>
</asp:Content>