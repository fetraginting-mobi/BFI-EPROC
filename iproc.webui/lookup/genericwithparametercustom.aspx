<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="genericwithparametercustom.aspx.cs" Inherits="lookup_genericwithparametercustom" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">

    <section class="panel">
        <div class="panel-body">

            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" CssClass="input-group">
                <asp:TextBox ID="txtSearch" runat="server"
                    CssClass="form-control"
                    placeholder="Keywords">
                </asp:TextBox>

                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSearch" runat="server"
                        CssClass="btn btn-info"
                        OnClick="btnSearch_Click"
                        CausesValidation="false">
                        <i class="icon-search"></i> Search
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnClear" runat="server"
                        CssClass="btn btn-danger"
                        OnClick="btnClear_Click"
                        CausesValidation="false">
                        <i class="icon-trash"></i> Reset
                    </asp:LinkButton>
                </div>
            </asp:Panel>

            <div class="row" style="margin-top:10px;">
                <div class="col-sm-12 table-responsive">

                    <asp:UpdatePanel ID="upd" runat="server">
                        <ContentTemplate>

                            <asp:GridView ID="gvwList" runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table table-bordered table-striped"
                                AllowPaging="true"
                                PageSize="5"
                                OnPageIndexChanging="gvwList_PageIndexChanging"
                                OnSelectedIndexChanged="gvwList_SelectedIndexChanged"
                                EmptyDataText="There is no data">

                                <Columns>
                                </Columns>

                                <HeaderStyle CssClass="grid-header" />

                            </asp:GridView>

                        </ContentTemplate>

                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnClear" EventName="Click" />
                        </Triggers>

                    </asp:UpdatePanel>

                </div>
            </div>

        </div>
    </section>

</asp:Content>

