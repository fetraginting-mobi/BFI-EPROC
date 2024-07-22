<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptjournalassetlist.aspx.cs" Inherits="module_report_rptjournalassetlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Journal Asset List Report</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
                    <asp:LinkButton ID="btnPrintExcel" runat="server" CssClass="btn btn-primary" OnClick="btnPrintExcel_Click" CausesValidation="false"><i class="icon-print"></i>  Print Excel</asp:LinkButton>
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
                                <label class="col-sm-3">From Date</label>
                                <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ErrorMessage="*" ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtStartDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="From Date" SPParameterName="p_start_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">To Date</label>
                                <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ErrorMessage="*" ControlToValidate="txtEndDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtEndDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="To Date" SPParameterName="p_end_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Branch</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" SPParameterName="p_branch_code" DataType="String"  BindType="UIToDBOnly" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>   
                                </div>
                             </div>
                         </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Transaction ID</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlTransactionCode" runat="server" CssClass="form-control" SPParameterName="p_transaction_code" DataType="String" BindType="UItoDBOnly">
                                        <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                        <asp:ListItem Value="DEPR">DEPR</asp:ListItem>
                                        <asp:ListItem Value="WROF">WROF</asp:ListItem>
                                        <asp:ListItem Value="NASS">NASS</asp:ListItem>
                                        <asp:ListItem Value="NAIP">NAIP</asp:ListItem>
                                        <asp:ListItem Value="UAIP">UAIP</asp:ListItem>
                                        <asp:ListItem Value="RAIP">RAIP</asp:ListItem>
                                        <asp:ListItem Value="DISP">DISP</asp:ListItem>
                                        <asp:ListItem Value="MOVC">MOVC</asp:ListItem>
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
                                <cc1:XUIDropDownList ID="ddlStatus" runat="server" Width="200px" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="POST">POST</asp:ListItem>
                                <asp:ListItem Value="INPROGRESS">INPROGRESS</asp:ListItem>
                               
                            </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                   <asp:AsyncPostBackTrigger ControlID="btnPrintExcel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

