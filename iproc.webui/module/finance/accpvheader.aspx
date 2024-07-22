<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accpvheader.aspx.cs" Inherits="module_finance_accpvheader" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Payment Voucher Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R15000005E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R15000005O" ID="btnPost" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click" CausesValidation="true"><i class="icon-save"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R22000001P" ID="btnPrint" runat="server" CssClass="btn btn-success" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R15000005O" ID="btnReject" runat="server" CssClass="btn btn-danger" OnClick="btnReject_Click" CausesValidation="false"><i class="icon-remove"></i>  Reject</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
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
                            <cc1:XUILabel ID="lblPvNo" runat="server" DBColumnName="PV_NO" SPParameterName="p_pv_no" DataType="String" BindType="Both"></cc1:XUILabel>   
                            <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" SPParameterName="p_status" DataType="String" BindType="Both" style="display:none"></cc1:XUILabel>                        
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Status</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblPvStatus" runat="server"  DBColumnName="PV_STATUS" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel> 
                            <cc1:XUILabel ID="lblTrxCode" runat="server"  DBColumnName="TRX_CODE" DataType="String" BindType="DBToUIOnly" Visible="false"></cc1:XUILabel> 
                        </div>
                    </div>                            
                </div>                             
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Branch *</label>
                        <div class="col-sm-6">
                            <%--<asp:LinkButton ID="btnLookUpBranch" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                            <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <asp:RequiredFieldValidator ID="rfvBranch" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBranchCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            <cc1:XUITextBox ID="txtBranchCode" runat="server" CssClass="form-control" DBColumnName="PV_BRANCH_CODE" SPParameterName="p_pv_branch_code" MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                            <cc1:XUIDropDownList ID="ddlBranchCode" runat="server" CssClass="form-control" DBColumnName="PV_BRANCH_CODE" SPParameterName="p_pv_branch_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                            <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="PV_BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Date *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtPvDate" runat="server" CssClass="form-control default-date-picker" placeholder="PV Date" DBColumnName="PV_DATE" SPParameterName="p_pv_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvPvDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPvDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Bank *</label>
                        <div class="col-sm-6">
                            <asp:LinkButton ID="btnLookUpBank" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                            <cc1:XUILabel ID="lblBank" runat="server" DBColumnName="BANK_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <asp:RequiredFieldValidator ID="rfvBankCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBankCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            <cc1:XUITextBox ID="txtBankCode" runat="server" CssClass="form-control" placeholder="Bank" DBColumnName="BANK_CODE" SPParameterName="p_bank_code" MaxLength="15" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                            <%--<cc1:XUILabel ID="lblBankNo" runat="server" placeholder="Account No" DBColumnName="BANK_ACCOUNT_NO"  MaxLength="50" DataType="String" SPParameterName="p_to_bank_account_no" BindType="Both" style="display:none"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblBankName" runat="server" placeholder="Account Name" DBColumnName="BANK_ACCOUNT_NAME"  MaxLength="50" DataType="String" SPParameterName="p_to_bank_account_name" BindType="Both" style="display:none"></cc1:XUILabel>
                            <cc1:XUIDropDownList ID="dllBankCode" runat="server" CssClass="form-control" DBColumnName="BANK_CODE" SPParameterName="p_bank_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>--%>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Value Date *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtValueDate" runat="server" CssClass="form-control default-date-picker" placeholder="Value Date" DBColumnName="VALUE_DATE" SPParameterName="p_value_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtValueDate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revValueDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtValueDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div> 
             </div>
             <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Bank Account No.</label>
                        <div class="col-sm-6">
                            <cc1:XUILabel ID="lblBankNo" runat="server"  DBColumnName="BANK_ACCOUNT_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Bank Account Name</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblBankName" runat="server"  DBColumnName="BANK_ACCOUNT_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Orig Amount</label>
                        <div class="col-sm-3">
                            <cc1:XUIDropDownList ID="ddlOrigCurrCode" runat="server" CssClass="form-control" DBColumnName="ORIG_CURR_CODE" SPParameterName="p_orig_curr_code" BindType="Both" DataType="String" Enabled="false"></cc1:XUIDropDownList>
                        </div>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtOrigAmount" runat="server" CssClass="form-control" placeholder="Original Amount" DBColumnName="ORIG_AMOUNT" SPParameterName="p_orig_amount" MaxLength="14" DataType="Number" BindType="Both" Format="N2" ></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Exch Rate *</label>    
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtExchRate" runat="server" CssClass="form-control" placeholder="Exch Rate" DBColumnName="EXCH_RATE" SPParameterName="p_exch_rate" MaxLength="10" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvExchRate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtExchRate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revExchRate" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtExchRate" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>     
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
                            <cc1:XUITextBox ID="txtBaseAmount" runat="server" CssClass="form-control" placeholder="Base Amount" SPParameterName="p_base_amount"  DBColumnName="BASE_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="false"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>                                        
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Remarks</label>
                        <div class="col-sm-9">
                            <cc1:XUITextBox ID="txtJmRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                            <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtJmRemarks" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 100" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
            </div>
              </ContentTemplate>
                 <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
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
                                <div class="col-sm-6" runat="server" id="ToBankNameSupplier">
                                    <div class="form-group">
                                        <label class="col-sm-4">To Bank Name</label>
                                        <div class="col-sm-6">
                                             <asp:LinkButton runat="server" ID="btnLookUpToBank" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtToBank" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_BANK" SPParameterName="p_to_bank" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblBankCode" style="display:none" runat="server" DBColumnName="TO_BANK" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                            <cc1:XUITextBox ID="txtBankName" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_BANK_DESC" SPParameterName="p_to_bank_desc" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lbltoBankName"  runat="server"  DBColumnName="TO_BANK_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                            <asp:RequiredFieldValidator ID="rfvToBankSupplier" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToBank" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>                            
                                </div>
                                <div class="col-sm-6" runat="server" id="ToBankNameManual">
                                    <div class="form-group">
                                        <label class="col-sm-4">To Bank Name</label>
                                        <div class="col-sm-6">
                                             <asp:LinkButton runat="server" ID="btnLookUpToBankManual" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtToBankManual" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_BANK" SPParameterName="p_to_bank" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtBankNameManual" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_BANK_DESC" SPParameterName="p_to_bank_desc" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblBankNameManual"  runat="server"  DBColumnName="TO_BANK_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                            <asp:RequiredFieldValidator ID="rfvToBankManual" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToBankManual" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>                            
                                </div>
                                <div class="col-sm-6" runat="server" id="RequestorSupplier">
                                    <div class="form-group">
                                        <label class="col-sm-4">Requestor</label>
                                        <asp:RequiredFieldValidator ID="rfvRequestorSupplier" runat="server" ErrorMessage="*" ControlToValidate="txtRequestor" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtRequestor" runat="server" CssClass="form-control" placeholder="Requestor" DBColumnName="REQUESTOR_CODE" MaxLength="20" DataType="String" BindType="DBToUIOnly" style="display:none;" ></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblRequestor" runat="server"  DBColumnName="REQUESTOR_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        </div>
                                    </div>                            
                                </div>
                                <div class="col-sm-6" runat="server" id="RequestorManual">
                                    <div class="form-group">
                                        <label class="col-sm-4">Requestor</label>
                                        <asp:RequiredFieldValidator ID="rfvRequestorManual" runat="server" ErrorMessage="*" ControlToValidate="txtRequestorManual" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtRequestorManual" runat="server" CssClass="form-control" placeholder="Requestor" DBColumnName="REQUESTOR_NAME" SPParameterName="p_requestor_name" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        </div>
                                    </div>                            
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6" runat="server" id="ToBankAccountNoSupplier">
                                    <div class="form-group">
                                        <label class="col-sm-4">To Bank Account No.</label>
                                        <asp:RequiredFieldValidator ID="rfvToBankAccountNo" runat="server" ErrorMessage="*" ControlToValidate="txtToBankAccountNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtToBankAccountNo" runat="server" CssClass="form-control" placeholder="To Bank Account No." DBColumnName="TO_BANK_ACCOUNT_NO" SPParameterName="p_to_bank_account_no" style="display:none;"  MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblToBankAccountNo" runat="server"  DBColumnName="TO_BANK_ACCOUNT_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        </div>
                                    </div>                            
                                </div>
                                <div class="col-sm-6" runat="server" id="ToBankAccountNoManual">
                                    <div class="form-group">
                                        <label class="col-sm-4">To Bank Account No.</label>
                                        <asp:RequiredFieldValidator ID="rfvToBankAccountNoManual" runat="server" ErrorMessage="*" ControlToValidate="txtToBankAccountNoManual" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtToBankAccountNoManual" runat="server" CssClass="form-control" placeholder="To Bank Account No." DBColumnName="TO_BANK_ACCOUNT_NO" SPParameterName="p_to_bank_account_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        </div>
                                    </div>                            
                                </div>
                                <div class="col-sm-6" runat="server" id="ToBankAccountNameSupplier">
                                    <div class="form-group">
                                        <label class="col-sm-4 ">To Bank Account Name</label>
                                        <asp:RequiredFieldValidator ID="rfvToBankAccountName" runat="server" ErrorMessage="*" ControlToValidate="txtToBankAccountName" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtToBankAccountName" runat="server" CssClass="form-control" placeholder="To Bank Account Name" DBColumnName="TO_BANK_ACCOUNT_NAME" style="display:none;"  SPParameterName="p_to_bank_account_name" DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblToBankAccountName" runat="server" DBColumnName="TO_BANK_ACCOUNT_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        </div>
                                    </div>
                                 </div> 
                                 <div class="col-sm-6" runat="server" id="ToBankAccountNameManual">
                                    <div class="form-group">
                                        <label class="col-sm-4 ">To Bank Account Name</label>
                                        <asp:RequiredFieldValidator ID="rfvToBankAccountNameManual" runat="server" ErrorMessage="*" ControlToValidate="txtToBankAccountNameManual" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtToBankAccountNameManual" runat="server" CssClass="form-control" placeholder="To Bank Account Name" DBColumnName="TO_BANK_ACCOUNT_NAME" SPParameterName="p_to_bank_account_name" MaxLength="30" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        </div>
                                    </div>
                                 </div>               
                            </div>
                        </div>
                    </section>
    <section class="panel">
        <header class="panel-heading">
            <span>Detail List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R15000005E" ID="btnAddDetail" runat="server" CssClass="btn btn-primary" OnClick="btnAddDetail_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R15000005E" ID="btnDeleteDetail" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteDetail_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearchDetail" runat="server" DefaultButton="btnSearchDetail"     class="input-group">
                        <asp:TextBox ID="txtSearchDetail" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchDetail" runat="server" CssClass="btn btn-info" OnClick="btnSearchDetail_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="updDetail" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListDetail" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="false" PageSize="10" DataKeyNames="ID" ShowFooter="true"
                        OnPageIndexChanging="gvwListDetail_PageIndexChanging" OnRowDataBound="gvwListDetail_RowDataBound"
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
                            <asp:BoundField DataField="ACC_NO" HeaderText="ACC No.">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_DESC" HeaderText="Branch">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ACC_NAME" HeaderText="ACC Name">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ORIG_CURRENCY" HeaderText="">
                                <ItemStyle Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ORIG_AMOUNT" HeaderText="Amount" DataFormatString="{0:N2}">
                                <ItemStyle Width="1%"  HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="EXCH_RATE" HeaderText="Exch. Rate" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%"  HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BASE_AMOUNT" HeaderText="Base Amount" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%"  HorizontalAlign="Right" />
                                <FooterStyle Width="10%" HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:BoundField>                            
                            <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                <ItemStyle Width="25%" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchDetail" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteDetail" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnAddDetail" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


