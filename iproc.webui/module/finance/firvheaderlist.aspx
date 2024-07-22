<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="firvheaderlist.aspx.cs"
    Inherits="module_finance_firvheaderlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Receipt Voucher List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <%--<asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</asp:LinkButton>--%>
                    <cc1:XUILinkButton RoleCode="R21200003D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"     class="input-group">
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
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-4">Status</label>
                        <div class="col-sm-4">
                            <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="HOLD">HOLD</asp:ListItem>
                                <asp:ListItem Value="POST">POST</asp:ListItem>
                                <asp:ListItem Value="REJECT">REJECT</asp:ListItem>
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
                        AllowPaging="true" PageSize="10" DataKeyNames="RV_NO,RV_STATUS"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                     <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                     <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="RV_NO" HeaderText="Received Voucher No.">
                                <ItemStyle Width="17%" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RV_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%"  HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BANK_NAME" HeaderText="Bank">
                                <ItemStyle Width="25%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                <ItemStyle Width="23%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="CURRENCY_CODE" HeaderText="">
                                <ItemStyle Width="0%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="TOTAL_AMOUNT" HeaderText="Total Amount" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="RV_STATUS" HeaderText="Status">
                                <ItemStyle Width="10%"  HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
