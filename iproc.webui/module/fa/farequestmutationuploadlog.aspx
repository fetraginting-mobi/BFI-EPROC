<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="farequestmutationuploadlog.aspx.cs" Inherits="module_fa_farequestmutationuploadlog" Title="Untitled Page"
    %>
    <%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
            <section class="panel">
                <header class="panel-heading">
                    <span> Review Data Error </span>
                </header>
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger"
                                OnClientClick="window.parent.fnHideGenericScreen(); return false;"
                                CausesValidation="false"><i class="icon-arrow-left"></i> Back</cc1:XUILinkButton>
                        </div>
                        <div class="col-sm-4 ">
                            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                    placeholder="Keywords"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info"
                                        OnClick="btnSearch_Click"><i class="icon-search"></i> Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <asp:UpdatePanel ID="upd" runat="server">
                        <ContentTemplate>
                            <cc1:XUILabel ID="lblStatus" runat="server" DataType="String" style="display:none;">
                            </cc1:XUILabel>
                            <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false"
                                CssClass="display table table-bordered table-striped" AllowPaging="true" PageSize="10"
                                DataKeyNames="row_number" OnPageIndexChanging="gvwList_PageIndexChanging"
                                OnRowDataBound="gvwList_RowDataBound" onselectedindexchanged="SelectedIndexChanged"
                                EmptyDataText="There is no data">
                                <Columns>
                                    <asp:BoundField DataField="row_number" HeaderText="Row">
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BARCODE" HeaderText="Barcode">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="item_name" HeaderText="Asset Name">
                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="process_flag" runat="server"
                                                Text='<%# Eval("process_flag") %>' EnableViewState="false"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ERROR_MESSAGE" HeaderText="Error Message">
                                        <ItemStyle Width="50%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </section>
        </asp:Content>