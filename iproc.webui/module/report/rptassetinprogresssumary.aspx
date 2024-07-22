<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptassetinprogresssumary.aspx.cs" Inherits="module_report_rptassetinprogresssumary" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Cash Flow Asset Inprogress Summary</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
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
                                <label class="col-sm-3">Type</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddltype" runat="server" CssClass="form-control" SPParameterName="p_status" BindType="Both" DataType="String" >
                                     <asp:ListItem Selected Value="CO">Cut Off</asp:ListItem>
                                     <asp:ListItem Value="BT">Between</asp:ListItem>
                                    </cc1:XUIDropDownList>  
                                </div>
                            </div>
                        </div>
                    </div>
                 <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Branch</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" SPParameterName="p_branch_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>  
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




