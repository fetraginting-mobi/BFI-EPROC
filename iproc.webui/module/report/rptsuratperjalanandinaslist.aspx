<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptsuratperjalanandinaslist.aspx.cs" Inherits="module_report_rptsuratperjalanandinaslist" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>AP Advance Registration List Report</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
                    <asp:LinkButton ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</asp:LinkButton>
                </div>
            </div>
        </div>
         <div class="panel-body form-horizontal" Style ="height:350px">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">From Date</label>
                            <asp:RequiredFieldValidator ID="rfvFromDate" runat="server" ErrorMessage="*" ControlToValidate="txtFromDate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtFromDate" runat="server" CssClass="form-control default-date-picker" placeholder="From Date" SPParameterName="p_from_date" MaxLength="10" DataType="DateTime" BindType="UIToDBOnly" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">To Date</label>
                        <asp:RequiredFieldValidator ID="rfvToDate" runat="server" ErrorMessage="*" ControlToValidate="txtToDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtToDate" runat="server" CssClass="form-control default-date-picker" placeholder="To Date"  SPParameterName="p_to_date" MaxLength="10" DataType="DateTime" BindType="UIToDBOnly" Format="dd/MM/yyyy" ></cc1:XUITextBox>
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

