<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fireceivedrequest.aspx.cs" Inherits="module_finance_fireceivedrequest" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>Receipt Request Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R21200001E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="" ID="btnBack" runat="server" CssClass="btn btn-danger" OnClick="btnBack_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
              <ContentTemplate>
                  <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">No.</label>
                        <div class="col-sm-5">
                            <cc1:XUILabel ID="lblRRNo" runat="server" DBColumnName="RR_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Date</label>
                         <div class="col-sm-3">
                            <cc1:XUILabel ID="lblDate" runat="server" DBColumnName="RR_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
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
                           <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control" DBColumnName="RR_BRANCH_CODE"  MaxLength="20" DataType="String" SPParameterName="p_rr_branch_code" BindType="Both" style="display:none"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Request Type </label>
                        <div class="col-sm-3">
                            <cc1:XUILabel ID="lblPrType" runat="server" DBColumnName="RR_TYPE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
           </div>
                  <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Bank *</label>                       
                        <div class="col-sm-5">
                            <asp:LinkButton ID="btnLookUpBankCode" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                            <cc1:XUILabel ID="lblBank" runat="server" DBColumnName="BANK_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtBankCode" runat="server" CssClass="form-control" placeholder="Bank" DBColumnName="TO_BANK" SPParameterName="p_to_bank" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                            
                            <asp:RequiredFieldValidator ID="rfvBank" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBankCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
           </div>
                  <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">To Bank Account No.</label>
                        <div class="col-sm-5">
                          <cc1:XUITextBox ID="txtBankNo" runat="server" placeholder="Account No" CssClass="form-control" DBColumnName="TO_BANK_ACCOUNT_NO"  MaxLength="20" DataType="String" SPParameterName="p_to_bank_account_no" BindType="Both" style="border:0px; background:inherit" ></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">To Bank Account Name</label>
                        <div class="col-sm-7">
                            <cc1:XUITextBox ID="txtBankName" runat="server" placeholder="Account Name" CssClass="form-control" DBColumnName="TO_BANK_ACCOUNT_NAME" MaxLength="30" DataType="String" SPParameterName="p_to_bank_account_name" BindType="Both" style="border:0px; background:inherit" ></cc1:XUITextBox>
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
             </ContentTemplate>
                 <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnBack" EventName="Click" />
                </Triggers>   
              </asp:UpdatePanel>
        </div> 
    </section>
</asp:Content>

