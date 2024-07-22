<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptgoodreceiptnotesummary.aspx.cs" Inherits="module_report_rptgoodreceiptnotesummary" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Good Receipt Note Summary Report</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
                    <asp:LinkButton ID="btnPrintPDF" runat="server" CssClass="btn btn-primary" OnClick="btnPrintPDF_Click" CausesValidation="true"><i class="icon-print"></i>  Print PDF</asp:LinkButton>
                    <asp:LinkButton ID="btnPrintExcel" runat="server" CssClass="btn btn-primary" OnClick="btnPrintExcel_Click" CausesValidation="true"><i class="icon-print"></i>  Print Excel</asp:LinkButton>
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
                                <label class="col-sm-3">Date</label>
                                <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ErrorMessage="*" ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtStartDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="From Date" SPParameterName="p_start_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">To Date</label>
                                <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ErrorMessage="*" ControlToValidate="txtEndDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtEndDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="To Date" SPParameterName="p_end_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format = "dd/MM/yyyy"></cc1:XUITextBox>
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
                                    <cc1:XUILabel ID="lblbranch" runat="server" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                    </ContentTemplate>
                                  </asp:UpdatePanel>
                                </div>
                             </div>
                         </div>  
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-3">Category Type</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlCategory" runat="server" CssClass="form-control" SPParameterName="p_category" DataType="String" BindType="UItoDBOnly">
                                        <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                        <asp:ListItem Value="GOODS">BARANG</asp:ListItem>
                                        <asp:ListItem Value="SERVICES">JASA</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Supplier</label>
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                               <label class="col-sm-3">Jenis Item</label>
                               <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlJenisItem" runat="server" CssClass="form-control" SPParameterName="p_supplier_location" BindType="Both" DataType="String" >
                                        <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                        <asp:ListItem Value="FA">FIXED ASSET</asp:ListItem>
                                        <asp:ListItem Value="IC">INVENTORY CONSUMTIVE</asp:ListItem>
                                        <asp:ListItem Value="ET">EXPENSE</asp:ListItem>
                                    </cc1:XUIDropDownList>
                               </div>      
                           </div>                  
                       </div>
                    </div> 
                    <div class="row">
                        <%--<div class="col-sm-6">
                        <div class="form-group">
                           <label class="col-sm-3">Location Warehouse</label>
                           <div class="col-sm-6">
                              <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                  <ContentTemplate>
                                      <cc1:XUIDropDownList ID="ddlLocationName" runat="server" CssClass="form-control" SPParameterName="p_location_name"  DataType="String" BindType="UIToDBOnly"></cc1:XUIDropDownList>
                                  </ContentTemplate>
                                  <Triggers>
                                      <asp:AsyncPostBackTrigger ControlID="ddlBranch" EventName="SelectedIndexChanged" />
                                  </Triggers>
                              </asp:UpdatePanel>
                           </div>
                           </div>                        
                        </div>--%>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <asp:RequiredFieldValidator ID="rfvddlStatus" runat="server" ErrorMessage="*" ControlToValidate="ddlStatus" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" BindType="Both" DataType="String" ></cc1:XUIDropDownList>  
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
