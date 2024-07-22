<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptfaaccounting.aspx.cs" Inherits="module_report_rptfaaccounting" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Cash Flow Asset Report</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
                    <asp:LinkButton ID="btnPrintPDF" runat="server" CssClass="btn btn-primary" OnClick="btnPrintPDF_Click" CausesValidation="True"><i class="icon-print"></i>  Print PDF</asp:LinkButton>
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
                            <label class="col-sm-3">Report Type</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlReportType" runat="server" CssClass="form-control" DataType="String" BindType="UItoDBOnly" OnSelectedIndexChanged= "ddlReportType_SelectedIndexChanged"  AutoPostBack= "true" >
                                        <asp:ListItem Value="CP">Cashflow Perolehan</asp:ListItem>
                                        <asp:ListItem Value="AP">Akumulasi Penyusutan</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-3">Report Type 2</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlReportType2" runat="server" CssClass="form-control" DataType="String" BindType="UItoDBOnly" OnSelectedIndexChanged= "ddlReportType2_SelectedIndexChanged"  AutoPostBack= "true">
                                        <asp:ListItem Value="SM">Summary</asp:ListItem>
                                        <asp:ListItem Value="SF">Summary Fiscal</asp:ListItem>
                                        <asp:ListItem Value="DT">Detail</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div> 
                        <div class="row" ID="upd3" runat="server">
                            <div class="col-sm-6">
                                <div class="form-group">
                                <label class="col-sm-3">Report Type 3</label>
                                    <div class="col-sm-6">
                                        <cc1:XUIDropDownList ID="ddlReportType3" runat="server" CssClass="form-control" DataType="String" BindType="UItoDBOnly">
                                            <asp:ListItem Value="AD">Addition</asp:ListItem>
                                            <asp:ListItem Value="DE">Deduction</asp:ListItem>
                                            <asp:ListItem Value="AF">Addition Fiscal</asp:ListItem>
                                            <asp:ListItem Value="RA">Reklas AIP</asp:ListItem>
                                            <asp:ListItem Value="DF">Deduction Fiscal</asp:ListItem>
                                        </cc1:XUIDropDownList>
                                    </div>
                                </div>
                            </div>
                        </div> 
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Periode</label>
                                <asp:RequiredFieldValidator ID="rfvtxtPeriode" runat="server" ErrorMessage="*" ControlToValidate="txtPeriode" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtPeriode" runat="server" CssClass="form-control default-date-picker-all" placeholder="To Date" SPParameterName="p_periode" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <%--<Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnPrintPDF" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnPrintExcel" EventName="Click" />
                </Triggers>--%>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


