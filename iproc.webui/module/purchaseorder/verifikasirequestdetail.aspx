<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="verifikasirequestdetail.aspx.cs" Inherits="module_purchaseorder_verifikasirequestdetail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R50000020E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_pr_code" BindType="UIToDBOnly"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">IR No.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblPRCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblPRStatus" runat="server" DBColumnName="PR_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item</label>
                                <div class="col-sm-5">                           
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Quantity</label>
						        <div class="col-sm-3">
                                    <cc1:XUILabel ID="lblQuantity" runat="server" DBColumnName="QUANTITY" SPParameterName="p_quantity" DataType="Number" BindType="Both" Format="N0"></cc1:XUILabel>
                                </div>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Approve Quantity</label>        
						        <div class="col-sm-3">
                                     <cc1:XUITextBox ID="txtApproveQuantity" runat="server" CssClass="form-control" placeholder="Quantity" DBColumnName="APPROVE_QUANTITY" SPParameterName="p_approve_quantity" DataType="Number" BindType="Both" Format="N0" MaxLength="8"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvApproveQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtApproveQuantity" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                    <asp:RegularExpressionValidator ID="revApproveQuantity" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtApproveQuantity" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator> 
                                </div>
                                <cc1:XUILabel ID="lblUnitID" runat="server" DBColumnName="UNIT_ID" SPParameterName="p_unit_id" DataType="String" BindType="Both"></cc1:XUILabel>
                            </div>
                        </div> 
                    </div>   
                    <div class="row">  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Specification</label>
                                <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblSpecification" runat="server" DBColumnName="SPECIFICATION" SPParameterName="p_specification" MaxLength="50" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Description</label>                               
                                <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblDescription" runat="server"  DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUILabel>
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

