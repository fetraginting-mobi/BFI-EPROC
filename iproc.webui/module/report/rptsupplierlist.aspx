<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptsupplierlist.aspx.cs" Inherits="module_report_rptsupplierlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Supplier List Report</span>
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
        <div class="panel-body form-horizontal" style="height:350px">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
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
                                <label class="col-sm-3">Creditor Type *</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlCreditorTypeCode" runat="server" CssClass="form-control" DBColumnName="CREDITOR_TYPE" SPParameterName="p_creditor_type" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                     
                                     <asp:RequiredFieldValidator ID="rfvCreditorTypeCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlCreditorTypeCode" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>  
                        
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-3">Supplier Type</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlSupplierType" runat="server" CssClass="form-control" SPParameterName="p_supplier_type" DataType="String" BindType="UItoDBOnly">
                                        <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                        <asp:ListItem Value="I">BARANG</asp:ListItem>
                                        <asp:ListItem Value="B">JASA</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Supplier</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlSupplier" runat="server" CssClass="form-control" SPParameterName="p_supplier_code" BindType="UItoDBOnly" DataType="String" ></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                        
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-3">Status</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="UItoDBOnly">
                                        <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                        <asp:ListItem Value="VALID">VALID</asp:ListItem>
                                        <asp:ListItem Value="IN-VALID">INVALID</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-3">Rating</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlRating" runat="server" CssClass="form-control" SPParameterName="p_raiting" DataType="String" BindType="UItoDBOnly">
                                        <asp:ListItem Value="10">ALL</asp:ListItem>
                                        <asp:ListItem Value="0">0</asp:ListItem>
                                        <asp:ListItem Value="1">1</asp:ListItem>
                                        <asp:ListItem Value="2">2</asp:ListItem>
                                        <asp:ListItem Value="3">3</asp:ListItem>
                                        <asp:ListItem Value="4">4</asp:ListItem>
                                        <asp:ListItem Value="5">5</asp:ListItem>
                                    </cc1:XUIDropDownList>
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
