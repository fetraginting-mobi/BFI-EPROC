<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="appaymentrequestheaderlist.aspx.cs" Inherits="module_apinvoice_appaymentrequestheaderlist" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Payment Request List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <%--<asp:LinkButton ID="btnAddAPPaymentReqHeader" runat="server" CssClass="btn btn-primary" OnClick="btnAddAPPaymentReqHeader_Click" ><i class="icon-plus"></i>  Create</asp:LinkButton>--%>
                    <%--<asp:LinkButton ID="btnDeleteAPPaymentReqHeader" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteAPPaymentReqHeader_Click" ><i class="icon-trash"></i>  Delete</asp:LinkButton>--%>
                </div>
                <div class="col-sm-4"> 
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">     
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
        <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Status</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlStatus" Width="200px" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="NEW">NEW</asp:ListItem>
                                <asp:ListItem Value="POST">POST</asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Branch</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" Width="200px" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <%--(+) Ari 13-07-2022 ket : enhancement 2022, filter by date--%>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4" style="padding-left:50px; width:150px">From Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtFromDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="PAYMENT_DATE" SPParameterName="p_from_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
                 <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4" style="width:100px">To Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtToDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="PAYMENT_DATE" SPParameterName="p_to_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" OnTextChanged="txtToDateChanged" AutoPostBack="true"></cc1:XUITextBox>
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
                    AllowPaging="true" PageSize="10" DataKeyNames="CODE_BARCODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                                    <asp:Label runat="server" ID="lblHeader" Text="Code/Barcode"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="10%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCode" Text='<%# Eval("CODE") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblBarcode" Text='<%# Eval("CODE_BARCODE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblInvoice" Text="Invoice Code/Barcode"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="10%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCode" Text='<%# Eval("INVOICE_CODE") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblBarcode" Text='<%# Eval("INVOICE_CODE_BARCODE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                           
                            <asp:BoundField DataField="PAYMENT_DATE" HeaderText="Date"  DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SUPPLIER_NAME" HeaderText="Requestor">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PAYMENT_AMOUNT" HeaderText="Payment Amount" DataFormatString= {0:N2}>
                                <ItemStyle Width="20%" HorizontalAlign="Right" />
                            </asp:BoundField>
                             <asp:BoundField DataField="OWNER_NAME" HeaderText="Owner Asset">
                                <ItemStyle Width="10%" HorizontalAlign="Center"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                <ItemStyle Width="10%" HorizontalAlign="Center"  />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <%--<asp:AsyncPostBackTrigger ControlID="btnDeleteAPPaymentReqHeader" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section> 
</asp:Content>

