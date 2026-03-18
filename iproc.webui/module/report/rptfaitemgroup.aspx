<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptfaitemgroup.aspx.cs" Inherits="module_report_rptfaitemgroup" Title="" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>FA Item Group Report </span>
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
                        <div class="form-group">
                            <label class="col-sm-3">Branch</label>
                            <div class="col-sm-6">
                                <asp:UpdatePanel ID="UpB" runat="server">
                                    <ContentTemplate>
                                        <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" SPParameterName="p_branch_code" DataType="String" OnSelectedIndexChanged= "ddlLocation_SelectedIndexChanged" AutoPostBack= "true" BindType="UIToDBOnly" ></cc1:XUIDropDownList>
                                        <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label runat="server" id="Category" class="col-sm-3">Category</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlCategory" runat="server" CssClass="form-control" SPParameterName="p_category" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3">Location</label>
                            <div class="col-sm-6">
                                <asp:UpdatePanel ID="updUn" runat="server">
                                    <ContentTemplate>
                                        <cc1:XUIDropDownList ID="ddlLocation" runat="server" CssClass="form-control" SPParameterName="p_location"  DataType="String" BindType="UIToDBOnly"></cc1:XUIDropDownList>
                                    </ContentTemplate>
                                        <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlBranch" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

