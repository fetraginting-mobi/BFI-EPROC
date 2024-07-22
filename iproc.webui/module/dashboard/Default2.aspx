<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="module_dashboard_Default2" Title="Untitled Page" %>

<%@ Register src="../../widget/ui/purchasebymonth.ascx" tagname="purchasebymonth" tagprefix="uc1" %>
<%@ Register src="../../widget/ui/purchasebytype.ascx" tagname="purchasebytype" tagprefix="uc2" %>
<%@ Register src="../../widget/ui/purchasebyquarter.ascx" tagname="purchasebyquarter" tagprefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-8">
                            <uc1:purchasebymonth ID="purchasebymonth1" runat="server" />
                        </div>
                        <div class="col-sm-4">
                            <uc4:purchasebyquarter ID="purchasebyquarter1" runat="server" />
                        </div>
                    </div>
                    
                     <div class="row">
                        <div class="col-sm-12">
                            
                            <uc2:purchasebytype ID="purchasebytype1" runat="server" />
                            
                        </div>
                        <%--<div class="col-sm-6">
                            
                            <uc3:salesbypurposeloan ID="salesbypurposeloan1" runat="server" />
                            
                        </div>--%>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </section>
    
    <script src="../../widget/js/purchasebymonth.js"></script>
    <script src="../../widget/js/purchasebyquarter.js"></script>
    <script src="../../widget/js/purchasebytype.js"></script>
    <%--<script src="../../widget/js/salesbyquarter.js"></script>--%>
    
</asp:Content>



