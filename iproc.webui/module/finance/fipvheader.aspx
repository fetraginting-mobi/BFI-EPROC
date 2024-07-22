<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fipvheader.aspx.cs" Inherits="module_finance_fipvheader" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
<section class="panel">
        <header class="panel-heading">
          <span>Payment Voucher Info</span>
        </header>
         <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R21200004E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R21200004O" ID="btnPost" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click" CausesValidation="true"><i class="icon-save"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R21200004O" ID="btnReject" runat="server" CssClass="btn btn-success" OnClick="btnReject_Click" CausesValidation="true" Style="display:none"><i class="icon-save"></i>  Reject</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R21200004P" ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                    <i id="iconCancel" runat="server" class="icon-remove btn btn-danger">&nbsp<cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn-danger" OnClick="btnCancel_Click" CausesValidation="false">  Cancel</cc1:XUILinkButton></i>
                </div>
            </div>
        </div>
        <asp:Panel ID="pnlAllTab" runat="server">
            <div class="row">
                <div class="col-sm-12">
                    <section class="panel form-horizontal">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                      <ContentTemplate>
                        <div class="panel-body">
                             
                         <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">No.</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblPvNo" runat="server" DBColumnName="PV_NO" SPParameterName="p_pv_no" DataType="String" BindType="Both"></cc1:XUILabel>                          
                                    </div>
                                </div>
                            </div>
                           <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Status</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblPvStatus" runat="server"  DBColumnName="PV_STATUS" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel> 
                                    </div>
                                </div>                            
                            </div>                             
                         </div>
                         <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Branch</label>
                                    <div class="col-sm-6">
                                        <cc1:XUIDropDownList ID="ddlBranchCode" runat="server" CssClass="form-control" 
                                            DBColumnName="PV_BRANCH_CODE" SPParameterName="p_pv_branch_code" 
                                            BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                         <cc1:XUITextBox ID="txtBranchCode" runat="server" CssClass="form-control" placeholder="PV Date" DBColumnName="PV_BRANCH_CODE" SPParameterName="p_pv_branch_code" MaxLength="10" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Date</label>
                                    <asp:RequiredFieldValidator ID="rfvPvDate" runat="server" ErrorMessage="*" ControlToValidate="txtPvDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="col-sm-3">
                                        <cc1:XUITextBox ID="txtPvDate" runat="server" CssClass="form-control default-date-picker" placeholder="PV Date" DBColumnName="PV_DATE" SPParameterName="p_pv_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>
                         </div>
                         <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Payment From Bank</label>
                                    <div class="col-sm-6">                        
                                        <asp:LinkButton ID="btnLookUpBank" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                                        <asp:RequiredFieldValidator ID="rfvBank" runat="server" ErrorMessage="*" ControlToValidate="txtBankCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <cc1:XUILabel ID="lblBank" runat="server" DBColumnName="BANK_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        <cc1:XUITextBox ID="txtBankCode" runat="server" CssClass="form-control" placeholder="Bank" DBColumnName="BANK_CODE" SPParameterName="p_bank_code" MaxLength="15" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblBankNo" runat="server" placeholder="Account No" DBColumnName="BANK_ACCOUNT_NO"  MaxLength="50" DataType="String" SPParameterName="p_to_bank_account_no" BindType="Both" style="display:none"></cc1:XUILabel>
                                        <cc1:XUILabel ID="lblBankName" runat="server" placeholder="Account Name" DBColumnName="BANK_ACCOUNT_NAME"  MaxLength="50" DataType="String" SPParameterName="p_to_bank_account_name" BindType="Both" style="display:none"></cc1:XUILabel>

                                        <%--<cc1:XUIDropDownList ID="ddlBranchBank" runat="server" CssClass="form-control" DBColumnName="BANK_NAME" SPParameterName="p_bank" MaxLength="20" DataType="Integer" BindType="Both" OnSelectedIndexChanged="ddlBranchBank_SelectedIndexChanged" AutoPostBack="true"></cc1:XUIDropDownList>--%>
                                    </div>
                                </div>                            
                            </div> 
                            <%--<div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Total</label>
                                    <div class="col-sm-3">                        
                                        <cc1:XUILabel ID="lblCurrencyCode" runat="server" DBColumnName="CURRENCY_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    </div>
                                    <div class="col-sm-5">                        
                                        <cc1:XUILabel ID="lblTotal" runat="server" DBColumnName="TOTAL_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>    --%>         
                         </div>
                         <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Orig Amount</label>
                                    <div class="col-sm-3">
                                        <cc1:XUITextBox ID="txtorigCurrCode" runat="server" CssClass="form-control" DBColumnName="ORIG_CURR_CODE" SPParameterName="p_orig_curr_code" DataType="String" BindType="Both" Enabled="false" ></cc1:XUITextBox>
                                    </div>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtOrigAmount" runat="server" CssClass="form-control" placeholder="Original Amount" DBColumnName="ORIG_AMOUNT" SPParameterName="p_orig_amount" MaxLength="14" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>
                                        
                                    </div>
                                 </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Exch Rate</label>
                                        <asp:RequiredFieldValidator ID="rfvExchRate" runat="server" ErrorMessage="*" ControlToValidate="txtExchRate" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revExchRate" runat="server" ErrorMessage="Doesn't Minus!" ControlToValidate="txtExchRate" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtExchRate" runat="server" CssClass="form-control" placeholder="Exch Rate" DBColumnName="EXCH_RATE" SPParameterName="p_exch_rate" MaxLength="10" DataType="Number" BindType="Both" Format="N2" ></cc1:XUITextBox>
                                        
                                    </div>
                                </div>                            
                            </div>   
                         </div>                          
                         <div class="row">
                             <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Base Amount</label>
                                    <div class="col-sm-3">
                                        <cc1:XUITextBox ID="txtBaseCurr" runat="server" CssClass="form-control" DBColumnName="BASE_CURR_CODE" SPParameterName="p_base_curr_code" DataType="String" BindType="Both" Enabled="false"></cc1:XUITextBox>
                                    </div>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtBaseAmount" runat="server" CssClass="form-control" placeholder="Base Amount" DBColumnName="BASE_AMOUNT" SPParameterName="p_base_amount" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>                                        
                         </div>
                         <div class="row">                          
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Remarks</label>
                                    <div class="col-sm-8">
                                        <cc1:XUITextBox ID="txtJmRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine" Enabled="false"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>                                        
                         </div>
                       </div>
                      </ContentTemplate>
                         <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                         </Triggers>   
                     </asp:UpdatePanel>
                    </section>
                    <section class="panel form-horizontal">
                        <header class="panel-heading">
                          <span>Payment Instruction</span>
                        </header>
                        <div class="panel-body">                         
                             <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">To Bank Name</label>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtToBank" runat="server" CssClass="form-control" DBColumnName="TO_BANK" SPParameterName="p_to_bank" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        </div>
                                    </div>                            
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">To Bank Account No.</label>
                                        <asp:RequiredFieldValidator ID="rfvToBankAccountNo" runat="server" ErrorMessage="*" ControlToValidate="txtToBankAccountNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtToBankAccountNo" runat="server" CssClass="form-control" placeholder="To Bank Account No." DBColumnName="TO_BANK_ACCOUNT_NO" SPParameterName="p_to_bank_account_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        </div>
                                    </div>                            
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4 ">To Bank Account Name</label>
                                        <asp:RequiredFieldValidator ID="rfvToBankAccountName" runat="server" ErrorMessage="*" ControlToValidate="txtToBankAccountName" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtToBankAccountName" runat="server" CssClass="form-control" placeholder="To Bank Account Name" DBColumnName="TO_BANK_ACCOUNT_NAME" SPParameterName="p_to_bank_account_name" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        </div>
                                    </div>
                                 </div>                
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </asp:Panel>
    </section>
    <section class="panel">
        <header class="panel-heading">
          <span>Detail List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R21200004E" ID="btnDeleteDetail" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteDetail_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearchDetail" runat="server" DefaultButton="btnSearchDetail"     class="input-group">
                        <asp:TextBox ID="txtSearchDetail" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchDetail" runat="server" CssClass="btn btn-info" OnClick="btnSearchDetail_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="updDetail" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListDetail" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="ID, PR_NO"
                        OnPageIndexChanging="gvwListDetail_PageIndexChanging" 
                        onselectedindexchanged="gvwListDetail_SelectedIndexChanged" EmptyDataText="There is no data">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                     <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                     <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                                <asp:BoundField DataField="PR_NO" HeaderText="Payment Request No.">
                                    <ItemStyle Width="40%" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PR_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                    <ItemStyle Width="15%" HorizontalAlign="Center"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="PR_TYPE" HeaderText="Type">
                                    <ItemStyle Width="15%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ORIG_AMOUNT" HeaderText="Amount"  DataFormatString="{0:N2}">
                                    <ItemStyle Width="30%" HorizontalAlign="Right"/>
                                </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchDetail" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

