<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fireceivedrequestlist.aspx.cs" Inherits="module_finance_fireceivedrequestlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>Receipt Request List </span>
        </header>
        <header class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R21200001O" ID="btnProcess" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-save"></i>  Process</cc1:XUILinkButton>
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
        <div class="panel-body form-horizontal">
        </div>
        </header>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="RR_NO"
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
                        <asp:BoundField DataField="RR_NO" HeaderText="Receipt Request No.">
                            <ItemStyle Width="13%" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RR_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle Width="8%" HorizontalAlign="Center"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="RR_TYPE" HeaderText="Type">
                            <ItemStyle Width="5%" HorizontalAlign="Center"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="TO_BANK" HeaderText="Bank Name">
                            <ItemStyle Width="16%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TO_BANK_ACCOUNT_NO" HeaderText="Bank Account No.">
                            <ItemStyle Width="20%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TO_BANK_ACCOUNT_NAME" HeaderText="Bank Account Name">
                            <ItemStyle Width="20%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ORIG_CURR_CODE" HeaderText="">
                            <ItemStyle Width="5%" HorizontalAlign="Center"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="ORIG_AMOUNT" HeaderText="Amount"  DataFormatString="{0:N2}">
                            <ItemStyle Width="15%" HorizontalAlign="Right"/>
                        </asp:BoundField>
                        <asp:CommandField ShowSelectButton="true" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnProcess" EventName="Click" />
            </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

