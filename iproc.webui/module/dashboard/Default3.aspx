<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="module_dashboard_Default3" Title="Untitled Page" %>

<%@ Register src="../../widget/ui/odstockaging.ascx" tagname="odstockaging" tagprefix="uc1" %>
<%@ Register src="../../widget/ui/odstockap.ascx" tagname="odstockap" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            
                            <uc1:odstockaging ID="odstockaging" runat="server" />
                            
                        </div>
                        <div class="col-sm-6">
                            
                            <uc2:odstockap ID="odstockap" runat="server" />
                            
                        </div>
                    </div>
                    
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </section>
    
    <script src="../../widget/js/odstockaging.js"></script>
    <script src="../../widget/js/odstockap.js"></script>
</asp:Content>

