<%@ Page Language="C#" Title="" AutoEventWireup="true" MasterPageFile="~/iproc.master" CodeFile="rptassethakgunalist.aspx.cs" Inherits="module_report_rptassethakgunalist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Asset Hak Guna List Report</span>
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
                                <label class="col-sm-3">Type</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddltype" runat="server" OnSelectedIndexChanged= "ddltype_SelectedIndexChanged" CssClass="form-control" SPParameterName="p_type" BindType="Both" DataType="String" AutoPostBack= "true" >
                                     <asp:ListItem Selected Value="CO">Ass Off</asp:ListItem>
                                     <asp:ListItem Value="BT">Per Month</asp:ListItem>
                                    </cc1:XUIDropDownList>  
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Year</label>
                                <asp:RequiredFieldValidator ID="rfvYear" runat="server" ErrorMessage="*" ControlToValidate="txtYear" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtYear" runat="server" CssClass="form-control" placeholder="Year" SPParameterName="p_year" MaxLength="10" DataType="String" BindType="UItoDBOnly"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6" ID="yr2" runat="server">
                            <div class="form-group">
                                <label class="col-sm-3">Year 2</label>
                               <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtYear" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtYear2" runat="server" CssClass="form-control" placeholder="Year" SPParameterName="p_year2" MaxLength="10" DataType="String" BindType="UItoDBOnly"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Cut Off Month</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlMonth" runat="server" CssClass="form-control" SPParameterName="p_cut_off_month" DataType="String" BindType="UIToDBOnly" >
                                        <asp:ListItem Value="01"> Januari </asp:ListItem>
                                        <asp:ListItem Value="02"> Febuari </asp:ListItem>
                                        <asp:ListItem Value="03"> Maret </asp:ListItem>
                                        <asp:ListItem Value="04"> April </asp:ListItem>
                                        <asp:ListItem Value="05"> Mei </asp:ListItem>
                                        <asp:ListItem Value="06"> Juni </asp:ListItem>
                                        <asp:ListItem Value="07"> Juli </asp:ListItem>
                                        <asp:ListItem Value="08"> Agustus </asp:ListItem>
                                        <asp:ListItem Value="09"> September </asp:ListItem>
                                        <asp:ListItem Value="10"> Oktober </asp:ListItem>
                                        <asp:ListItem Value="11"> November </asp:ListItem>
                                        <asp:ListItem Value="12"> Desember </asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6" ID="yr3" runat="server">
                            <div class="form-group">
                                <label class="col-sm-3">Cut Off Month 2</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlMonth2" runat="server" CssClass="form-control" SPParameterName="p_cut_off_month2" DataType="String" BindType="UIToDBOnly" >
                                        <asp:ListItem Value="01"> Januari </asp:ListItem>
                                        <asp:ListItem Value="02"> Febuari </asp:ListItem>
                                        <asp:ListItem Value="03"> Maret </asp:ListItem>
                                        <asp:ListItem Value="04"> April </asp:ListItem>
                                        <asp:ListItem Value="05"> Mei </asp:ListItem>
                                        <asp:ListItem Value="06"> Juni </asp:ListItem>
                                        <asp:ListItem Value="07"> Juli </asp:ListItem>
                                        <asp:ListItem Value="08"> Agustus </asp:ListItem>
                                        <asp:ListItem Value="09"> September </asp:ListItem>
                                        <asp:ListItem Value="10"> Oktober </asp:ListItem>
                                        <asp:ListItem Value="11"> November </asp:ListItem>
                                        <asp:ListItem Value="12"> Desember </asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Branch</label>
                                <div class="col-sm-6">
                                 <asp:UpdatePanel ID="UpB" runat="server">
                                        <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" SPParameterName="p_branch_code" DataType="String" BindType="UIToDBOnly" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                    </ContentTemplate>
                                  </asp:UpdatePanel>
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
                                        <asp:ListItem Value="GRN NO">GRN NO</asp:ListItem>
                                        <asp:ListItem Value="PO NO">PO NO</asp:ListItem>
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
                   <asp:AsyncPostBackTrigger ControlID="btnPrintExcel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
