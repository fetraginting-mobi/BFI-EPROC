<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accjurnalheader.aspx.cs" Inherits="module_accounting_accjurnalheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>General Journal Transaction Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <%--<cc1:XUILinkButton RoleCode="" ID="btnBackToCashier" runat="server" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnBackToCashier_Click"><i class="icon-remove"></i>  Back to Cashier</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnBackToJM" runat="server" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnBackToJM_Click"><i class="icon-remove"></i>  Back to Journal Memorial</cc1:XUILinkButton>
                    --%>
                    <cc1:XUILinkButton RoleCode="" ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print PDF</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnPrintExcel" runat="server" CssClass="btn btn-primary" OnClick="btnPrintExcel_Click" CausesValidation="false"><i class="icon-print"></i>  Print Excel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton> 
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Branch</label>
                                <div class="col-sm-6">
                                    <asp:LinkButton ID="btnLookUpBranch" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                                    <cc1:XUITextBox ID="txtId" runat="server" CssClass="form-control" placeholder="Bank" DBColumnName="ID" SPParameterName="p_id" MaxLength="15" DataType="Integer" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtBranchCode" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                   <%-- <cc1:XUIDropDownList ID="ddlBranchCode" runat="server" CssClass="form-control" DBColumnName="RV_BRANCH_CODE" SPParameterName="p_rv_branch_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>--%>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Value Date</label>
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="txtValueDate" runat="server" placeholder="Value Date" DBColumnName="VALUE_DATE" SPParameterName="p_value_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Voucher No.</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblVoucherNo" runat="server" placeholder="Bank" DBColumnName="VOUCHER_NO" SPParameterName="p_voucher_no" MaxLength="15" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                 </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Date</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblDate" runat="server" placeholder="Debet Amount" DBColumnName="TRX_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>  
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Reff No.</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblReffNo" runat="server" DBColumnName="REFF_NO" SPParameterName="p_reff_no" BindType="DBToUIOnly" DataType="String" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Reff Type</label>
                                    <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblReffType" runat="server" placeholder="Reff Type" DBColumnName="REFF_TYPE" SPParameterName="p_reff_type" MaxLength="50" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                     </div> 
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Description</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblDescription" runat="server" DBColumnName="DESCRIPTION" SPParameterName="p_description" BindType="DBToUIOnly" DataType="String" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" BindType="DBToUIOnly" DataType="String" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                     </div>
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    
    <section class="panel">
        <header class="panel-heading">
            <span>General Journal Detail Transaction List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
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
                        AllowPaging="true" PageSize="100" DataKeyNames="ID" OnRowDataBound="gvwList_OnRowDataBound" ShowFooter="true"
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
                                    <asp:Label runat="server" ID="lblHeaderAccNo" Text="Acc No."></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="10%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblAccNo" Text='<%# Eval("ACC_NO") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblAccName" Text='<%# Eval("ACC_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblDivisi" Text="Div/Dept"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="10%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblDivisi" Text='<%# Eval("DIVISI") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblDepartment" Text='<%# Eval("DEPARTMENT") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" SortExpression="DESCRIPTION">
                                <ItemStyle Width="15%" HorizontalAlign="Left"/>
                                <ItemTemplate>
                                        <cc1:XUITextBox runat="server" ID="txtDescription" Text='<%# Eval("DESCRIPTION") %>' CssClass="form-control" MaxLength="350" DataType="String" BindType="DBToUIOnly" TextMode="MultiLine"></cc1:XUITextBox>
                                    <%--<asp:TextBox runat="server" Text='<%# Eval("INTERIM_INTEREST", "{0:N2}") %>' ID="txtInterimInterest" CssClass="form-control" style="text-align:right" MaxLength="20"/></asp:TextBox>--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ORIG_CURRENCY" HeaderText="">
                                <ItemStyle Width="0%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ORIG_AMOUNT_DB" HeaderText="Debit" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                             <asp:BoundField DataField="ORIG_AMOUNT_CR" HeaderText="Credit" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="EXCH_RATE" HeaderText="Rate" DataFormatString="{0:N2}">
                                <ItemStyle Width="5%"  HorizontalAlign="Right" />
                                <FooterStyle Width="5%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BASE_AMOUNT_DB" HeaderText="Base Amount (D)" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BASE_AMOUNT_CR" HeaderText="Base Amount (C)" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


