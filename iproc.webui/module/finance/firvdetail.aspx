<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="firvdetail.aspx.cs"
    Inherits="module_finance_firvdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Detail Info</span>
        </header>
         <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R21200003E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <i id="iconCancel" runat="server" class="icon-remove btn btn-danger">&nbsp<cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn-danger" OnClick="btnCancel_Click" CausesValidation="false">  Cancel</cc1:XUILinkButton></i>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
              <ContentTemplate>
                     <div class="row" style="display:none">
                <div class="col-sm-6">
                    <div class="col-sm-12">
                        <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer"  BindType="Both" Text="0"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblRvNo" runat="server" DBColumnName="RV_NO" SPParameterName="p_rv_no" DataType="String" BindType="Both" Text="------"></cc1:XUILabel>
                    </div>
                </div>
            </div>
                     <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Reff No.</label>
                        <asp:RequiredFieldValidator ID="rfvtxtReffNo" runat="server" ErrorMessage="*" ControlToValidate="txtReffNo" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-6">
                            <cc1:XUITextBox ID="txtReffNo" runat="server" CssClass="form-control" placeholder="Reff" DBColumnName="REFF_NO" SPParameterName="p_reff_no" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Receipt Voucher Type </label>
                        <asp:RequiredFieldValidator ID="rfvtxtRvType" runat="server" ErrorMessage="*" ControlToValidate="txtRvType" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtRvType" runat="server" CssClass="form-control default-date-picker" placeholder="RV Type" DBColumnName="RV_TYPE" SPParameterName="p_rv_type" DataType="String" BindType="Both"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>  
            </div> 
                     <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">From Bank</label>
                        <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlFromBank" runat="server" CssClass="form-control" DBColumnName="FROM_BANK" SPParameterName="p_from_bank"  DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                        </div>
                    </div>                            
                </div>
            </div>
                     <div class="row"> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">From Bank Account No.</label>
                            <asp:RequiredFieldValidator ID="rfvtxtFromBankAccountNo" runat="server" ErrorMessage="*" ControlToValidate="txtFromBankAccountNo" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-6">
                           <cc1:XUITextBox ID="txtFromBankAccountNo" runat="server" CssClass="form-control" placeholder="From Bank Account No." DBColumnName="FROM_BANK_ACCOUNT_NO" SPParameterName="p_from_bank_account_no" DataType="String" BindType="Both" MaxLength="20" ></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">From Bank Account Name</label>
                            <asp:RequiredFieldValidator ID="rfvtxtFromBankAccountName" runat="server" ErrorMessage="*" ControlToValidate="txtFromBankAccountName" Display="Dynamic" ></asp:RequiredFieldValidator>
                        <div class="col-sm-6">
                            <cc1:XUITextBox ID="txtFromBankAccountName" runat="server" CssClass="form-control" placeholder="From Bank Account Name" MaxLength="40" DBColumnName="FROM_BANK_ACCOUNT_NAME" SPParameterName="p_from_bank_account_name" DataType="String" BindType="Both" Width="350px"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
           </div>
                     <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Amount</label>                        
                        <div class="col-sm-3">
                            <cc1:XUIDropDownList ID="ddlOrigCurrCode" runat="server" CssClass="form-control" DBColumnName="ORIG_CURR_CODE" SPParameterName="p_orig_curr_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                        </div>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtOrigAmount" runat="server" CssClass="form-control" placeholder="Amount" DBColumnName="ORIG_AMOUNT" SPParameterName="p_orig_amount" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvtxtOrigAmount" runat="server" ErrorMessage="*" ControlToValidate="txtOrigAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>    
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Exch Rate</label>
                            <asp:RequiredFieldValidator ID="rfvtxtExchRate" runat="server" ErrorMessage="*" ControlToValidate="txtExchRate" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-5">
                           <cc1:XUITextBox ID="txtExchRate" runat="server" CssClass="form-control" placeholder="Exch Rate" DBColumnName="EXCH_RATE" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>                 
           </div> 
                     <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Base Amount</label>
                        <div class="col-sm-3">
                            <cc1:XUIDropDownList ID="ddlBaseCurrCode" runat="server" CssClass="form-control" DBColumnName="BASE_CURR_CODE" SPParameterName="p_base_curr_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                        </div>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtBaseAmount" runat="server" CssClass="form-control" DBColumnName="BASE_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="false"></cc1:XUITextBox>
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
