<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fadepreciationdatelist.aspx.cs"
    Inherits="module_fa_fadepreciationdatelist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span> FA Depreciation Date List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                 <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R90000110E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="false"><i class="icon-adv-table"></i>Save</cc1:XUILinkButton>
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
                
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Cost Center</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
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
                    AllowPaging="true" PageSize="10" DataKeyNames="ID,BARCODE,ASSET_TYPE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" OnRowDataBound="gvwList_RowDataBound"
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
                            <asp:BoundField DataField="BARCODE" HeaderText="Asset Code">
                                <ItemStyle Width="10%" HorizontalAlign="center"/>
                            </asp:BoundField>
                        <%--    <asp:BoundField DataField="AST_CODE" HeaderText="Code">
                                <ItemStyle Width="10%" HorizontalAlign="center" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="AST_NAME" HeaderText="Aset Name">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CAT_NAME" HeaderText="Category">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DATE_PURC" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="INITIAL" HeaderText="Initial Cost Center">
                                <ItemStyle Width="5%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_NAME" HeaderText="Cost Center">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CURRENT_BRANCH" HeaderText="Location">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_CODE" HeaderText="Status">
                                <ItemStyle Width="5%"  HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Periode Komersil">
                              <ItemStyle Width="15%" HorizontalAlign="Center" />
                                <ItemTemplate>
                                  <cc1:XUITextBox runat="server" ID="txtPeriod" CssClass="form-control default-date-picker input-sm"  ></cc1:XUITextBox> 
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Periode Fiskal">
                              <ItemStyle Width="15%" HorizontalAlign="Center" />
                                <ItemTemplate>
                                  <cc1:XUITextBox runat="server" ID="txtPeriodFiscal" CssClass="form-control default-date-picker input-sm" ></cc1:XUITextBox> 
                                </ItemTemplate>
                            </asp:TemplateField>
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
