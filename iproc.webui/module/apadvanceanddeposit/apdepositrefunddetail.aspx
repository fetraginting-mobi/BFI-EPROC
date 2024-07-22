<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apdepositrefunddetail.aspx.cs" Inherits="module_apadvanceanddeposit_apdepositrefunddetail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Deposit Registration Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
          <cc1:XUILabel ID="lblID" runat="server"  BindType="Both" style="display:none;" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text=0></cc1:XUILabel>                        
          <cc1:XUILabel ID="lblCodeBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_deposit_refund_code" DBColumnName="DEPOSIT_REFUND_CODE" BindType="UIToDBOnly"></cc1:XUILabel>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-5">Deposit Refund No.</label>
                       <div class="col-sm-7">
                            <cc1:XUILabel ID="lblDRStatus" runat="server" DBColumnName="DR_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblDepositRefundCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-5">Deposit Registration No.</label>
                        <div class="col-sm-7">
                           <asp:LinkButton runat="server" ID="btnLookUpARCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                   
                            <asp:RequiredFieldValidator ID="rfvDepositCode" runat="server" ErrorMessage="*" ControlToValidate="txtDepositCode" Display="Dynamic"></asp:RequiredFieldValidator>                        
                            <cc1:XUITextBox ID="txtDepositCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="DEPOSIT_CODE" SPParameterName="p_deposit_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                           <cc1:XUILabel ID="lblDRCode"  runat="server"  DBColumnName="DR_CODE" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-5">Refund Amount</label>
                            <asp:RequiredFieldValidator ID="rfvRefundAmount" runat="server" ErrorMessage="*" ControlToValidate="txtRefundAmount" Display="Dynamic"></asp:RequiredFieldValidator> 
                            <asp:RegularExpressionValidator ID="revRefundAmount" runat="server" ErrorMessage="*" ControlToValidate="txtRefundAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtRefundAmount" runat="server" CssClass="form-control" placeholder="Refund Amount" DBColumnName="REFUND_AMOUNT" SPParameterName="p_refund_amount" DataType="Number" Format ="N2" BindType="Both" ></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
            </div>
        </div>
    </section>
</asp:Content>
