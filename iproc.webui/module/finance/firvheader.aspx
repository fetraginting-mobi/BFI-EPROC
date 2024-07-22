<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="firvheader.aspx.cs"
    Inherits="module_finance_firvheader" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Receipt Voucher Info</span>
        </header>
         <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R21200003P" ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R21200003E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R21200003O" ID="btnPost" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click" CausesValidation="true"><i class="icon-save"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R21200003O" ID="btnReject" runat="server" CssClass="btn btn-danger" OnClick="btnReject_Click" CausesValidation="false"><i class="icon-remove"></i>  Reject</cc1:XUILinkButton>
                    <i id="iconCancel" runat="server" class="icon-remove btn btn-danger">&nbsp<cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn-danger" OnClick="btnCancel_Click" CausesValidation="false">  Cancel</cc1:XUILinkButton></i>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
              <ContentTemplate>
                 <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3 ">No.</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblRvNo" runat="server" DBColumnName="RV_NO" SPParameterName="p_rv_no" DataType="String" BindType="Both"></cc1:XUILabel>                          
                        </div>
                    </div>
                </div>
               <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Status</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblRvStatus" runat="server"  DBColumnName="RV_STATUS" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel> 
                        </div>
                    </div>                            
                </div>                             
             </div>
                 <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Branch</label>
                        <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlBranchCode" runat="server" CssClass="form-control" DBColumnName="RV_BRANCH_CODE" SPParameterName="p_rv_branch_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                            <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="RV_BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                         </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Date *</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtRvDate" runat="server" CssClass="form-control default-date-picker" placeholder="RV Date" DBColumnName="RV_DATE" SPParameterName="p_rv_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvRvDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRvDate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revRvDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtRvDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
             </div>
                 <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Receive To Bank</label>
                        <div class="col-sm-6">
                            <%--<cc1:XUIDropDownList ID="ddlBranchBank" runat="server" CssClass="form-control" DBColumnName="BANK_NAME" SPParameterName="p_bank" MaxLength="20" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                            <asp:LinkButton ID="btnLookUpBank" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                            <asp:RequiredFieldValidator ID="rfvBank" runat="server" ErrorMessage="*" ControlToValidate="txtBankCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            <cc1:XUILabel ID="lblBank" runat="server" DBColumnName="BANK_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtBankCode" runat="server" CssClass="form-control" placeholder="Bank" DBColumnName="BANK_CODE" SPParameterName="p_bank_code" MaxLength="15" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblBankNo" runat="server" placeholder="Account No" DBColumnName="BANK_ACCOUNT_NO"  MaxLength="50" DataType="String" SPParameterName="p_to_bank_account_no" BindType="Both" style="display:none"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblBankName" runat="server" placeholder="Account Name" DBColumnName="BANK_ACCOUNT_NAME"  MaxLength="50" DataType="String" SPParameterName="p_to_bank_account_name" BindType="Both" style="display:none"></cc1:XUILabel>

                        </div>
                    </div>                            
                </div>
                <%--<div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Total</label>
                        <div class="col-sm-3">                        
                            <cc1:XUILabel ID="lblCurrencyCode" runat="server" DBColumnName="CURRENCY_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                        <div class="col-sm-5">                        
                            <cc1:XUILabel ID="lblTotal" runat="server" DBColumnName="TOTAL_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>--%>
             </div>
             <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Orig Amount</label>
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
                        <label class="col-sm-3">Exch Rate</label>
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
                        <label class="col-sm-3">Base Amount</label>
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
                    <label class="col-sm-3">Remarks</label>
                    <div class="col-sm-9">
                        <cc1:XUITextBox ID="txtRvRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRvRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
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
        </div>
    </section>
    <section class="panel">
        <header class="panel-heading">
          <span>Detail List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <%--<asp:LinkButton ID="btnAddDetail" runat="server" CssClass="btn btn-primary" OnClick="btnAddDetail_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</asp:LinkButton>--%>
                    <%--<asp:LinkButton ID="btnDeleteDetail" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteDetail_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</asp:LinkButton>--%>
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
                        AllowPaging="true" PageSize="10" DataKeyNames="ID, REFF_NO"
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
                                
                                <asp:BoundField DataField="REFF_NO" HeaderText="Reff No.">
                                    <ItemStyle Width="30%" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="REFF_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                    <ItemStyle Width="20%" HorizontalAlign="Center"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="RV_TYPE" HeaderText="Type">
                                    <ItemStyle Width="20%" HorizontalAlign="Center" />
                                </asp:BoundField>
                               <%-- <asp:BoundField DataField="FROM_BANK" HeaderText="Bank Name">
                                    <ItemStyle Width="15%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FROM_BANK_ACCOUNT_NO" HeaderText="Bank Account No">
                                    <ItemStyle Width="15%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FROM_BANK_ACCOUNT_NAME" HeaderText="Bank Account Name">
                                    <ItemStyle Width="20%" />
                                </asp:BoundField>--%>
                                <asp:BoundField DataField="ORIG_CURR_CODE" HeaderText="">
                                    <ItemStyle Width="0%" HorizontalAlign="Center"/>
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
