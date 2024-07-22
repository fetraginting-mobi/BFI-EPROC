<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="module_dashboard_default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            <!-- load ascx yg posisinya di kiri (sesuai dengan user id)-->
                            <div runat="server" id="CtrlL"></div>
                        </div>
                        <div class="col-sm-6">
                            <!-- load ascx yg posisinya di kanan (sesuai dengan user id)-->
                            <div runat="server" id="CtrlR"></div>
                            <h6>
                                iProc V.1.00 Last Published By Fajar at 08 Apr 14:39:00
                            </h6>
                            
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
