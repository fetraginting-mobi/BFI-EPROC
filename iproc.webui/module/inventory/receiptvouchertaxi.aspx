<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="receiptvouchertaxi.aspx.cs" Inherits="module_inventory_receiptvouchertaxi" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Receipt Voucher Taxi Info</span>
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
           <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Voucher Code</label>
                        <asp:RequiredFieldValidator ID="rfvVoucherCode" runat="server" ErrorMessage="*" ControlToValidate="txtVoucherCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtVoucherCode" runat="server" CssClass="form-control"  placeholder="Voucher Code" SPParameterName="p_voucher_code" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Start</label>
                        <asp:RequiredFieldValidator ID="rfvStart" runat="server" ErrorMessage="*" ControlToValidate="txtStart" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtStart" runat="server" CssClass="form-control"  placeholder="Start" SPParameterName="p_start" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
            </div>
           <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">End</label>
                        <asp:RequiredFieldValidator ID="rfvEnd" runat="server" ErrorMessage="*" ControlToValidate="txtEnd" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtEnd" runat="server" CssClass="form-control "  placeholder="End" SPParameterName="p_end" MaxLength="50" DataType="Integer" BindType="Both" ></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
            </div>
             <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Voucher Date</label>
                        <asp:RequiredFieldValidator ID="rfvFirstDate" runat="server" ErrorMessage="*" ControlToValidate="txtFirstDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtFirstDate" runat="server" CssClass="form-control default-date-picker"  placeholder="Date" SPParameterName="p_voucher_date" MaxLength="50" DataType="DateTime" BindType="Both" format="dd/MM/yyyy"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
            </div>
    </section>
</asp:Content>

