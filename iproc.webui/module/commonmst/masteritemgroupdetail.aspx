<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masteritemgroupdetail.aspx.cs" Inherits="module_commonmst_masteritemgroupdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Item Group Link A/C Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000120E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
             <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text= "0" style="display:none"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblCategory" style="display:none" runat="server" DBColumnName="GROUP_CATEGORY_TYPE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Category Code</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblCategoryCode" runat="server" DBColumnName="CATEGORY_CODE" SPParameterName="p_category_code" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Currency Code *</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlCurrency" runat="server" CssClass="form-control" placeholder="Currency" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                    </div> 
                    <div class="row" runat="server" id="FaAsset">
                        <div class="col-sm-6">
                             <div class="form-group">
                                    <label class="col-sm-4">Fixed Asset ACC No. *</label>
                                    <div class="col-sm-7">
                                        <asp:LinkButton runat="server" ID="btnLookUpACCAssetPO" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtACCAssetPO" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_ASSET_PO" SPParameterName="p_acc_asset_po" DataType="String" BindType="Both"></cc1:XUITextBox>
                                         <cc1:XUITextBox ID="txtPADAssetPO" style="display:none" runat="server" CssClass="form-control" DBColumnName="PAD_ASSET_NO" SPParameterName="p_pad_asset_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblNoAssetPO" runat="server" DBColumnName="ACC_ASSET_PO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> -
                                        <cc1:XUILabel ID="lblNameAssetPO"  runat="server"  DBColumnName="NAME_ASSET_PO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        <asp:RequiredFieldValidator ID="rfvACCAssetPO" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtACCAssetPO" Display="Dynamic"></asp:RequiredFieldValidator>
                                  </div>
                               </div>                            
                         </div>
                    </div>           
                    <div class="row"  runat="server" id="Inventory">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Inventory ACC No. *</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpACCNoINV" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtACCNoINV" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_NO_INV" SPParameterName="p_acc_no_inv" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUITextBox ID="txtPADINV" style="display:none" runat="server" CssClass="form-control" DBColumnName="PAD_INVENTORY_NO" SPParameterName="p_pad_inv_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblNoINV" runat="server" DBColumnName="ACC_NO_INV" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> -
                                    <cc1:XUILabel ID="lblNameNoINV"  runat="server"  DBColumnName="NAME_NO_INV" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvACCNoINV" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtACCNoINV" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" runat="server" id="Expanse">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Expense ACC No. *</label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpACCExpensePO"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtACCExpensePO" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_EXPENSE_PO" SPParameterName="p_acc_expense_po" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUITextBox ID="txtPADExpensePO" style="display:none" runat="server" CssClass="form-control" DBColumnName="PAD_EXPENSE_NO" SPParameterName="p_pad_expense_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblNoExpensePO"  runat="server" style="display:none"  DBColumnName="ACC_EXPENSE_PO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNameExpensePO"  runat="server"  DBColumnName="NAME_EXPENSE_PO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvACCExpensePO" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtACCExpensePO" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div> 
                    <%--(+)gustian 09/11/2022 Enhance Prepaid --%>
                   <%-- start--%>
                    <div class="row" runat="server" id="Expese2">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Allocation Expense No. </label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookupAllocExpenseNo"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtAllocExpenseAccNo" style="display:none"  runat="server" CssClass="form-control" DBColumnName="ACC_ALLOC_EXPENSE_NO" SPParameterName="p_alloc_expense_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUITextBox ID="txtPADAllocExpenseAccName" style="display:none"  runat="server" CssClass="form-control" DBColumnName="ALLOC_PAD_EXPENSE_NO" SPParameterName="p_alloc_pad_expense_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblNoAllocExpenseAccNo"  runat="server" style="display:none"  DBColumnName="ACC_ALLOC_EXPENSE_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNameAllocExpenseAccName"  runat="server"  DBColumnName="name_alloc_expense_po" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                      <%--<asp:RequiredFieldValidator ID="" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAllocExpenseAccNo" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <%----end--%>
                     <div class="row" runat="server" id="FaAssetInprogress">
                        <div class="col-sm-6">
                             <div class="form-group">
                                    <label class="col-sm-4">In Progress Asset ACC No. *</label>
                                    <div class="col-sm-7">
                                        <asp:LinkButton runat="server" ID="btnLookUpACCAssetinprogressPO" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtACCAssetinprogressPO" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_ASSET_INPROGRESS_PO" SPParameterName="p_acc_asset_inprogress_po" DataType="String" BindType="Both"></cc1:XUITextBox>
                                         <cc1:XUITextBox ID="txtPADAssetinprogressPO" style="display:none" runat="server" CssClass="form-control" DBColumnName="acc_asset_inprogress_po" SPParameterName="p_pad_asset_inprogress_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblNoAssetinprogressPO" runat="server" DBColumnName="ACC_ASSET_INPROGRESS_PO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> -
                                        <cc1:XUILabel ID="lblNameAssetinprogressPO"  runat="server"  DBColumnName="NAME_ASSET_INPROGRESS_PO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtACCAssetinprogressPO" Display="Dynamic"></asp:RequiredFieldValidator>
                                  </div>
                               </div>                            
                         </div>
                    </div>           
                    <div class="row" runat="server" id="COGS" >
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">COGS ACC No. *</label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpACCCOGS"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtACCCOGS" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_NO_COGS" SPParameterName="p_acc_no_cogs" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblNoACCCOGS"  runat="server" DBColumnName="ACC_NO_COGS" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> -
                                    <cc1:XUILabel ID="lblNameACCCOGS"  runat="server"  DBColumnName="NAME_NO_COGS" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvACCCOGS" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtACCCOGS" Display="Dynamic"></asp:RequiredFieldValidator>
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





