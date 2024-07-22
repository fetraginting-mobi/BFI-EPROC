<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptapreportarandaging.aspx.cs" Inherits="module_report_rptapreportarandaging" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Purchase Order Report List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
                    <asp:LinkButton ID="btnPrintAR" runat="server" CssClass="btn btn-primary" OnClick="btnPrintAR_Click" CausesValidation="false"><i class="icon-print"></i>  Print Report AR</asp:LinkButton>
                    <asp:LinkButton ID="btnPrintAging" runat="server" CssClass="btn btn-primary" OnClick="btnPrintAging_Click" CausesValidation="false"><i class="icon-print"></i>  Print Report Aging</asp:LinkButton>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

