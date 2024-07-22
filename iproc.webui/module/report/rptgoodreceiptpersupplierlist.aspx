<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptgoodreceiptpersupplierlist.aspx.cs" Inherits="module_report_rptgoodreceiptpersupplierlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Good Receipt Per Supplier List Report</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
                    <asp:LinkButton ID="btnPrintPDF" runat="server" CssClass="btn btn-primary" OnClick="btnPrintPDF_Click" CausesValidation="false"><i class="icon-print"></i>  Print PDF</asp:LinkButton>
                    <asp:LinkButton ID="btnPrintExcel" runat="server" CssClass="btn btn-primary" OnClick="btnPrintExcel_Click" CausesValidation="false"><i class="icon-print"></i>  Print Excel</asp:LinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>Back</cc1:XUILinkButton>
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
                                <label class="col-sm-3">Supplier</label> 
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpSupplier" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>   
                                    <asp:RequiredFieldValidator ID="rfvSupplier" runat="server" ErrorMessage="*" ControlToValidate="txtSupplier" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <cc1:XUITextBox ID="txtSupplier" style="display:none" runat="server"  CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" MaxLength="18" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblSupplier" runat="server" DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
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




