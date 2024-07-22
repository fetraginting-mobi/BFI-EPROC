<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="paymententrylist.aspx.cs" Inherits="module_finance_paymententrylist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
<section class="panel">
        <header class="panel-heading">
            <span>Payment Entry List </span>
        </header>
        <header class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R21200002O" ID="btnProcess" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-save"></i>  Process</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"     class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>                                    
            </div>
        </header>
        <div class="panel-body" style="height:800px;">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Period *</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtFromDueDate" runat="server" placeholder="From Date" CssClass="form-control default-date-picker" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvFromDueDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFromDueDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <label class="col-sm-1">-</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtToDueDate" runat="server" placeholder="To Date" CssClass="form-control default-date-picker" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvToDueDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToDueDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-3">
                            <cc1:XUILinkButton RoleCode="R21200002P" ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="true"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="PR_NO"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data">
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
                                <ItemStyle Width="18%" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DOC_REF_NO" HeaderText="Document No." >
                                <ItemStyle Width="17%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PR_TYPE" HeaderText="Type">
                                <ItemStyle Width="5%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="PR_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblHeaderBankNo" Text="To Payment Bank"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="35%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblBankName" Text='<%# Eval("TO_BANK") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblNo" Text='<%# Eval("TO_BANK_ACCOUNT_NO") %>'></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblName" Text='<%# Eval("TO_BANK_ACCOUNT_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <%-- <asp:BoundField DataField="TO_BANK" HeaderText="Bank Name">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TO_BANK_ACCOUNT_NO" HeaderText="Bank Account No.">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TO_BANK_ACCOUNT_NAME" HeaderText="Bank Account Name">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="ORIG_CURR_CODE" HeaderText="">
                                <ItemStyle Width="0%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ORIG_AMOUNT" HeaderText="Amount"  DataFormatString="{0:N2}">
                                <ItemStyle Width="15%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnProcess" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

