<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accrvheader.aspx.cs" Inherits="module_finance_accrvheader" Title="Untitled Page" %>

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
                    <cc1:XUILinkButton RoleCode="R15000006E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R15000006O" ID="btnPost" runat="server" CssClass="btn btn-success"  CausesValidation="true"><i class="icon-save" ></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R15000006P" ID="btnPrint" runat="server" CssClass="btn btn-success" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R15000006O" ID="btnViewJurnal" runat="server" CssClass="btn btn-success" OnClick="btnViewJurnal_Click" CausesValidation="false"><i class="icon-ticket"></i>  View-Jurnal</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R15000006O" ID="btnReject" runat="server" CssClass="btn btn-danger"><i class="icon-remove"></i>  Reject</cc1:XUILinkButton>
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
                            <cc1:XUILabel ID="lblRvNo" runat="server" DBColumnName="RV_NO" SPParameterName="p_rv_no" DataType="String" BindType="Both"></cc1:XUILabel>                          
                            <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>                          
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Status</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblRvStatus" runat="server"  DBColumnName="RV_STATUS" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel> 
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
                            <asp:RequiredFieldValidator ID="rfvBranch" runat="server" ErrorMessage="*" ControlToValidate="txtBranchCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtBranchCode" runat="server" CssClass="form-control" DBColumnName="RV_BRANCH_CODE" SPParameterName="p_rv_branch_code" MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                            <cc1:XUIDropDownList ID="ddlBranchCode" runat="server" CssClass="form-control" DBColumnName="RV_BRANCH_CODE" SPParameterName="p_rv_branch_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                            <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="RV_BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Date *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtRvDate" runat="server" CssClass="form-control default-date-picker" placeholder="RV Date" DBColumnName="RV_DATE" SPParameterName="p_rv_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvRvDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRvDate" Display="Dynamic"></asp:RequiredFieldValidator>
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
                            <cc1:XUITextBox ID="txtBankCode" runat="server" CssClass="form-control" placeholder="Bank" DBColumnName="BANK_CODE" SPParameterName="p_bank_code" MaxLength="15" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                            
                           
                            <%--<cc1:XUIDropDownList ID="dllBankCode" runat="server" CssClass="form-control" DBColumnName="BANK_CODE" SPParameterName="p_bank_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>--%>
                            <asp:RequiredFieldValidator ID="rfvBankCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBankCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Value Date *</label>
                        <asp:RequiredFieldValidator ID="rfvValueDate" runat="server" ErrorMessage="*" ControlToValidate="txtValueDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtValueDate" runat="server" CssClass="form-control default-date-picker" placeholder="Value Date" DBColumnName="VALUE_DATE" SPParameterName="p_value_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div> 
             </div>
              <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3 ">Bank Account No.</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblBankNo" runat="server" placeholder="Account No" DBColumnName="BANK_ACCOUNT_NO"  MaxLength="50" DataType="String" SPParameterName="p_to_bank_account_no" BindType="Both" ></cc1:XUILabel>
                        </div>
                    </div>
                </div>
                 <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3 ">Bank Account Name</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblBankName" runat="server" placeholder="Account Name" DBColumnName="BANK_ACCOUNT_NAME"  MaxLength="50" DataType="String" SPParameterName="p_to_bank_account_name" BindType="Both" ></cc1:XUILabel>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Orig Amount</label>
                        <div class="col-sm-3">
                            <cc1:XUIDropDownList ID="ddlOrigCurrCode" runat="server" CssClass="form-control" DBColumnName="ORIG_CURR_CODE" SPParameterName="p_orig_curr_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                        </div>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtOrigAmount" runat="server" CssClass="form-control" placeholder="Original Amount" DBColumnName="ORIG_AMOUNT" SPParameterName="p_orig_amount" MaxLength="15" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Exch Rate *</label>
                            <asp:RequiredFieldValidator ID="rfvExchRate" runat="server" ErrorMessage="*" ControlToValidate="txtExchRate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revExchRate" runat="server" ErrorMessage="Format Invalid !" ControlToValidate="txtExchRate" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtExchRate" runat="server" CssClass="form-control" placeholder="Exch Rate" DBColumnName="EXCH_RATE" SPParameterName="p_exch_rate" MaxLength="9" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div> 
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Base Amount</label>
                        <div class="col-sm-3">
                            <cc1:XUIDropDownList ID="ddlBaseCurrCode" runat="server" CssClass="form-control" DBColumnName="BASE_CURR_CODE" SPParameterName="p_base_curr_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                        </div>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtBaseAmount" runat="server" CssClass="form-control" placeholder="Debet Amount" DBColumnName="BASE_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="false"></cc1:XUITextBox>
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
                    <asp:AsyncPostBackTrigger ControlID="btnViewJurnal" EventName="Click" />
                </Triggers>   
              </asp:UpdatePanel>
        </div>
    </section>
    
    <section class="panel">
        <header class="panel-heading">
            <span>Detail List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R22000002C" ID="btnAddDetail" runat="server" CssClass="btn btn-primary" OnClick="btnAddDetail_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R22000002D" ID="btnDeleteDetail" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteDetail_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                                <ItemStyle Width="5%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ACC_NAME" HeaderText="ACC Name">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ORIG_CURRENCY" HeaderText="">
                                <ItemStyle Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ORIG_AMOUNT" HeaderText="Amount" DataFormatString="{0:N2}">
                                <ItemStyle Width="20%"  HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="EXCH_RATE" HeaderText="Exch. Rate" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%"  HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BASE_AMOUNT" HeaderText="Base Amount" DataFormatString="{0:N2}">
                                <ItemStyle Width="20%"  HorizontalAlign="Right" />
                                <FooterStyle Width="20%" HorizontalAlign="Right" Font-Bold="true"/>
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
                    <asp:AsyncPostBackTrigger ControlID="btnAddDetail" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteDetail" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


