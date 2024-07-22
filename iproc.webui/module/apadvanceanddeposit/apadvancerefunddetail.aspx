<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apadvancerefunddetail.aspx.cs" Inherits="module_apadvanceanddeposit_apadvancerefunddetail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Advance Registration Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R80000100E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblID" runat="server"  BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text=0 style="display:none;"></cc1:XUILabel>                        
                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" DataType="String" style="display:none;"  DBColumnName="ADVANCE_REFUND_CODE" SPParameterName="p_advance_refund_code" BindType="UIToDBOnly"></cc1:XUILabel>
                    <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-5">Advance Refund No.</label>
                             <div class="col-sm-7">
                               <cc1:XUILabel ID="lblARStatus" runat="server" DBColumnName="AR_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                               <cc1:XUILabel ID="lblAdvanceRefundCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                 </div>
                    <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-5">Refund Amount</label>
                            <div class="col-sm-5">
                                <cc1:XUILabel ID="lblRefundAmount" runat="server" DBColumnName="REFUND_AMOUNT" SPParameterName="p_refund_amount" DataType="Number" Format ="N2" BindType="Both"></cc1:XUILabel>
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
