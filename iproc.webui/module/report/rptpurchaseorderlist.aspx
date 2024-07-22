<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptpurchaseorderlist.aspx.cs" Inherits="module_report_rptpurchaseorderlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Purchase Order List Report</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
                    <asp:LinkButton ID="btnPrintPDF" runat="server" CssClass="btn btn-primary" OnClick="btnPrintPDF_Click" CausesValidation="false"><i class="icon-print"></i>  Print PDF</asp:LinkButton>
                    <asp:LinkButton ID="btnPrintExcel" runat="server" CssClass="btn btn-primary" OnClick="btnPrintExcel_Click" CausesValidation="false"><i class="icon-print"></i>  Print Excel</asp:LinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal" style="height:400px">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">From Date</label>
                                <asp:RequiredFieldValidator ID="rfvtxtStartDate" runat="server" ErrorMessage="*" ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtStartDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="From Date" SPParameterName="p_start_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">To Date</label>
                                <asp:RequiredFieldValidator ID="rfvtxtEndDate" runat="server" ErrorMessage="*" ControlToValidate="txtEndDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtEndDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="To Date" SPParameterName="p_end_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Branch</label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="ddlBranch" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" SPParameterName="p_branch_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>  
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Creditor Type</label>
                                <asp:RequiredFieldValidator ID="rfvddlCreditor" runat="server" ErrorMessage="*" ControlToValidate="ddlCreditor" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlCreditor" runat="server" CssClass="form-control" SPParameterName="p_creditor_type" BindType="Both" DataType="String" >
                                        <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                        <asp:ListItem Value="EX BRG">EXTERNAL BARANG</asp:ListItem>
                                        <asp:ListItem Value="EXJS">EXTERNAL JASA</asp:ListItem>
                                        <asp:ListItem Value="INTBRG">INTERNAL BARANG</asp:ListItem>
                                    </cc1:XUIDropDownList>  
                                </div>
                            </div>
                        </div>
                     </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <asp:RequiredFieldValidator ID="rfvddlStatus" runat="server" ErrorMessage="*" ControlToValidate="ddlStatus" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" BindType="Both" DataType="String" ></cc1:XUIDropDownList>  
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-3">Order Type</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlOrder" runat="server" CssClass="form-control" SPParameterName="p_order_type" DataType="String" BindType="UItoDBOnly">
                                        <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                        <asp:ListItem Value="PO">PO</asp:ListItem>
                                        <asp:ListItem Value="SPK">SPK</asp:ListItem>
                                        <asp:ListItem Value="CONTRACT">CONTRACT</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="form-group">
                                <label class="col-sm-2">Search By</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlSearchBy" Width="200px" runat="server" CssClass="form-control" SPParameterName="p_search_by" DataType="String" BindType="Both">
                                        <asp:ListItem Value="SUPPLIER NAME">SUPPLIER NAME</asp:ListItem>
                                        <asp:ListItem Value="ITEM NAME">ITEM NAME</asp:ListItem>
                                        <asp:ListItem Value="PO CODE">PO CODE</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtKeywords" runat="server"  CssClass="form-control" placeholder="Keywords" SPParameterName="p_keywords" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>                                    
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnPrintPDF" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnPrintExcel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


