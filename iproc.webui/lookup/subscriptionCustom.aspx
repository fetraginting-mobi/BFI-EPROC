<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="subscriptionCustom.aspx.cs" Inherits="lookup_subscriptionCustom" Title="Subscription Lookup" %>

<%-- Ganti ID ContentPlaceHolderID di bawah ini sesuai dengan yang ada di iproc.master --%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpb" runat="Server">
    <style>
        .table-responsive { overflow-x: auto; }
        .grid-header { background-color: #f9f9f9; font-weight: bold; }
        .panel-body { padding: 15px; }
    </style>

    <section class="panel">
        <div class="panel-body">
            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchSource" class="input-group">
                <asp:TextBox ID="txtSearchSource" runat="server" CssClass="form-control" placeholder="Search Source..."></asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSearchSource" runat="server" CssClass="btn btn-info" OnClick="btnSearchSource_Click" CausesValidation="false">
                        <i class="icon-search"></i> Search
                    </asp:LinkButton>
                </div>
            </asp:Panel>

            <div class="row" style="margin-top:10px;">
                <div class="col-sm-12 table-responsive">
                    <asp:UpdatePanel ID="updSource" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListSource" runat="server" AutoGenerateColumns="true" 
                                CssClass="table table-bordered table-striped" AllowPaging="true" PageSize="5"
                                OnPageIndexChanging="gvwListSource_PageIndexChanging" 
                                OnRowDataBound="gvwListSource_RowDataBound" EmptyDataText="No data">
                                <HeaderStyle CssClass="grid-header" />
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchSource" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Add</asp:LinkButton>
                    <asp:LinkButton ID="btnRemove" runat="server" CssClass="btn btn-primary" OnClick="btnRemove_Click" CausesValidation="false"><i class="icon-minus"></i>  Remove</asp:LinkButton>
                </div>
            </div>

            <asp:Panel ID="Panel2" runat="server" DefaultButton="btnSearchTarget" class="input-group">
                <asp:TextBox ID="txtSearchTarget" runat="server" CssClass="form-control" placeholder="Search Target..."></asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSearchTarget" runat="server" CssClass="btn btn-info" OnClick="btnSearchTarget_Click" CausesValidation="false">
                        <i class="icon-search"></i> Search
                    </asp:LinkButton>
                </div>
            </asp:Panel>

            <div class="row" style="margin-top:10px;">
                <div class="col-sm-12 table-responsive">
                    <asp:UpdatePanel ID="updTarget" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListTarget" runat="server" AutoGenerateColumns="true" 
                                CssClass="table table-bordered table-striped" AllowPaging="true" PageSize="5"
                                OnPageIndexChanging="gvwListTarget_PageIndexChanging" 
                                OnRowDataBound="gvwListTarget_RowDataBound" EmptyDataText="No data">
                                <HeaderStyle CssClass="grid-header" />
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchTarget" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </section>
</asp:Content>