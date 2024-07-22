<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accrecurringdetail.aspx.cs" Inherits="module_accounting_accrecurringdetail" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
<header class="panel-heading">
            <div class="row">
                <div class="col-sm-11">
                <span>Recurring Info</span>
                </div>
                <div class="col-sm-1"> 
                    <asp:Label ID="lblLocked" runat="server" Visible="false" CssClass="icon-lock icon-2x"></asp:Label>
                </div>
            </div>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="ACC010400U" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <%--<asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>--%>
                    <asp:LinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
         <asp:UpdatePanel ID="updMain" runat="server">
             <ContentTemplate>
                 <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">COA No</label>
                                <asp:RequiredFieldValidator ID="rfvCoaNo" runat="server" ErrorMessage="*" ControlToValidate="txtACCNo" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-9">
                                <div class="input-group"> 
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" SPParameterName="p_code" DataType="String" BindType="Both" style="display:none"></cc1:XUILabel>                          
                                    <asp:LinkButton ID="btnLookupCOA" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                                    <cc1:XUITextBox ID="txtACCNo" runat="server" CssClass="form-control" DBColumnName="NO_COA" SPParameterName="p_no_coa" MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtACCName" CssClass="form-control" runat="server" DBColumnName="ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                </div> 
                            </div>
                        </div>                            
                    </div>
                 </div>
                 
                 <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Amount</label>
                            <div class="col-sm-8">
                                <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="*" ControlToValidate="txtAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                                <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control decimal-only non-negative" DBColumnName="AMOUNT" SPParameterName="p_amount" MaxLength="500" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>                             
                 </div>
                 
                 <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Description</label>
                            <asp:RegularExpressionValidator runat="server" ID="valtxtDesc" ControlToValidate="txtDesc" ValidationExpression="^[\s\S]{0,500}$" ErrorMessage="Exceed maximum length" Display="Dynamic"></asp:RegularExpressionValidator>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtDesc"  runat="server" CssClass="form-control" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="500" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
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

