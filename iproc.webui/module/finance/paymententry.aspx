<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="paymententry.aspx.cs" Inherits="module_finance_paymententry" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
<section class="panel">
        <header class="panel-heading">
            <span>Payment Entry Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R08000002O" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnBack" runat="server" CssClass="btn btn-danger" OnClick="btnBack_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <section class="panel form-horizontal">
                    <div class="panel-body">
                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                         <ContentTemplate>
                             <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">No.</label>
                                    <div class="col-sm-5">
                                        <cc1:XUILabel ID="lblPrNo" runat="server" DBColumnName="PR_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Date</label>
                                     <div class="col-sm-3">
                                        <cc1:XUILabel ID="lblDate" runat="server" DBColumnName="PR_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                                     </div>
                                </div>                            
                            </div>   
                      </div> 
                             <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Branch</label>
                                <div class="col-sm-5">
                                   <cc1:XUILabel ID="lblBranchCode" runat="server" DBColumnName="NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                   
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Request Type </label>
                                <div class="col-sm-3">
                                    <cc1:XUILabel ID="lblPrType" runat="server" DBColumnName="PR_TYPE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                      </div>
                      </ContentTemplate>
                          <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnBack" EventName="Click" />
                          </Triggers>   
                    </asp:UpdatePanel>
                    </div>
                </section>
                <section class="panel form-horizontal">
                    <header class="panel-heading">
                      <span>Payment Instruction</span>
                    </header>
                    <div class="panel-body">                         
                         <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Bank</label>
                                    <div class="col-sm-5">
                                        <%--<cc1:XUILabel ID="lblBank" runat="server" DBColumnName="TO_BANK" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>--%>
                                        <asp:LinkButton runat="server" ID="btnLookUpBank" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtBankCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_BANK" SPParameterName="p_to_bank" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblBankCode" style="display:none" runat="server" DBColumnName="TO_BANK" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                        <cc1:XUITextBox ID="txtBankName" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_BANK_DESC" SPParameterName="p_to_bank_desc" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblBankName"  runat="server"  DBColumnName="TO_BANK_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBankCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Requestor </label>
                                    <div class="col-sm-5">
                                       <cc1:XUILabel ID="lblRequsetor"  runat="server" DBColumnName="REQUESTOR_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                      <cc1:XUITextBox ID="txtRequestor" style="display:none" runat="server" DBColumnName="REQUESTOR_CODE"  SPParameterName="p_requestor_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                       
                                    </div>
                                </div>                            
                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">To Bank Account No.</label>
                                    <div class="col-sm-5">
                                      <%-- <cc1:XUITextBox ID="lblToBankAccountNo" runat="server" DBColumnName="TO_BANK_ACCOUNT_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>--%>
                                       <cc1:XUITextBox ID="txtToBankAccountNo" style="border:0; background:inherit" runat="server" DBColumnName="TO_BANK_ACCOUNT_NO"   SPParameterName="p_to_bank_account_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div> 
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">To Bank Account Name</label>
                                    <div class="col-sm-8">
                                        <%--<cc1:XUITextBox ID="lblToBankAccountName" runat="server" DBColumnName="TO_BANK_ACCOUNT_NAME"  DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>--%>
                                        <cc1:XUITextBox ID="txtToBankAccountName" style="border:0; background:inherit" runat="server" DBColumnName="TO_BANK_ACCOUNT_NAME"  SPParameterName="p_to_bank_account_name" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>   
                        </div> 
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Amount</label>
                                    <div class="col-sm-3">
                                        <cc1:XUILabel ID="lblOrigCurrCode" runat="server" DBColumnName="ORIG_CURR_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>
                                    <div class="col-sm-5">
                                        <cc1:XUILabel ID="lblOrigAmount" runat="server" DBColumnName="ORIG_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div> 
                             <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Voucher No.</label>
                                    <div class="col-sm-5">
                                        <cc1:XUILabel ID="lblVoucherNo" runat="server" DBColumnName="VOUCHER_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>                
                        </div>                          
                        <div class="row" style="display:none">
                             <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Base Amount</label>
                                    <div class="col-sm-3">
                                        <cc1:XUILabel ID="lblBaseCurrCode" runat="server" DBColumnName="BASE_CURR_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtBaseAmount" runat="server" DBColumnName="BASE_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Exch Rate</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtExchRate" runat="server" DBColumnName="EXCH_RATE" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>                                             
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Remarks</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblRemarks" runat="server" DBColumnName="REMARKS" DataType="String" BindType="DBToUIOnly" TextMode="MultiLine"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>   
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Document Reference No.</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblDocRefNo" runat="server" DBColumnName="DOC_REF_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>                                 
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </section>
</asp:Content>

