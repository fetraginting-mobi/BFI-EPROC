<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="historyperalatankerjalist.aspx.cs" Inherits="module_fa_historyperalatankerjalist" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>History Request/Return Peralatan Kerja List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>   
        </div>                   
        <div class="panel-body">
            <div class="row">
                  <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Status</label>
                        <div class="col-sm-8">
                          <cc1:XUIDropDownList ID="ddlStatus" Width="200px" runat="server" CssClass="form-control" DataType="String" BindType="Both" AutoPostBack="true" OnTextChanged="ddlStatus_TextChanged">
                            <asp:ListItem Text="ALL"></asp:ListItem>
                          </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Branch</label>
                        <div class="col-sm-8">
                          <cc1:XUIDropDownList ID="ddlBranch" Width="250px" runat="server" CssClass="form-control" DataType="String" BindType="Both" AutoPostBack="true" OnTextChanged="ddlBranch_TextChanged">
                            <asp:ListItem Text="ALL"></asp:ListItem>
                          </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" OnRowDataBound="gvwList_OnRowDataBound" EmptyDataText="There is no data" Width="100%">
                        <Columns>
                             <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>              
                            <asp:BoundField DataField="CODE" HeaderText="Request / Return No" >
                                <ItemStyle Width="30%" HorizontalAlign="left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="STAFF" HeaderText="Staff">
                                <ItemStyle Width="30%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="STATUS" HeaderText="Status">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <%--<asp:LinkButton ID="btnViewInfo" runat="server" CssClass="btn btn-success" CausesValidation="false" ToolTip="View Information"><i class="icon-eye-open"></i></asp:LinkButton>--%>
                                    <asp:LinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="History"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <%-- <asp:CommandField ShowSelectButton="true" />--%>
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


