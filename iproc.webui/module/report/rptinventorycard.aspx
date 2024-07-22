<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptinventorycard.aspx.cs" Inherits="module_report_rptinventorycard" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Inventory Card Report</span>
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
                             <div class="col-sm-5">
                              <asp:UpdatePanel ID="UpB" runat="server">
                                 <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" SPParameterName="p_branch_code" DataType="String" AutoPostBack= "true" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" BindType="UIToDBOnly" ></cc1:XUIDropDownList>
                                 </ContentTemplate>
                               </asp:UpdatePanel>
                             </div>
                         </div>                             
                     </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Location</label>
                                <div class="col-sm-5">
                                    <asp:UpdatePanel ID="updDep" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlLocation" runat="server" CssClass="form-control" SPParameterName="p_location_code"   DataType="String" BindType="UIToDBOnly"></cc1:XUIDropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlBranch" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel> 
                                </div>
                            </div>
                        </div>
                     </div>
                      
                </ContentTemplate>
              <%--  <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                </Triggers>--%>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

