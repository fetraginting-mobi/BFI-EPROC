<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptapoverduereport.aspx.cs" Inherits="module_report_rptapoverduereport" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>AP Overdue List Report</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
                    <asp:LinkButton ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</asp:LinkButton>
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
                                <label class="col-sm-3">Branch</label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="ddlBranch" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" SPParameterName="p_branch_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>  
                                </div>
                            </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">From Date</label>
                                <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ErrorMessage="*" ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtStartDate" runat="server" CssClass="form-control default-date-picker" placeholder="From Date" SPParameterName="p_start_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">To Date</label>
                                <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ErrorMessage="*" ControlToValidate="txtEndDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtEndDate" runat="server" CssClass="form-control default-date-picker" placeholder="To Date" SPParameterName="p_end_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="form-group">
                                <label class="col-sm-2">Aging</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtAging" runat="server"  CssClass="form-control" placeholder="Keywords" SPParameterName="p_aging" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>                                    
                            </div>
                        </div>
                    </div> 
                                       
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="form-group">
                                <label class="col-sm-2">Search By</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlSearchBy" Width="200px" runat="server" CssClass="form-control" SPParameterName="p_search_code" DataType="String" BindType="Both">
                                        <asp:ListItem Value="INVOICE_NO">Branch</asp:ListItem>
                                        <asp:ListItem Value="CREDITOR_NAME">Supplier</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtKeywords" runat="server"  CssClass="form-control" placeholder="Keywords" SPParameterName="p_search_desc" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>                                    
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


