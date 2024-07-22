<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fareconmigrasilist.aspx.cs" Inherits="module_fa_fareconmigrasilist" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span> FA Reconsiliation Migration Asset List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
            <div class="row">
           <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Status</label>
                        <div class="col-sm-5">
                             <cc1:XUIDropDownList ID="ddlStatus" runat="server" Width="200px" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="AVAILABLE">AVAILABLE</asp:ListItem>
                                <asp:ListItem Value="SOLD">SOLD</asp:ListItem>
                                <asp:ListItem Value="DISPOSED">DISPOSED</asp:ListItem>
                                <asp:ListItem Value="INPROGRESS">INPROGRESS</asp:ListItem>
                                <asp:ListItem Value="SALE-INPROGRESS">SALE INPROGRESS</asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Cost Center</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Period</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtFromDate" runat="server" CssClass="form-control default-date-picker-all" SPParameterName="p_from_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                        <label class="col-sm-1">-</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtToDate" runat="server" CssClass="form-control default-date-picker-all" SPParameterName="p_to_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
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
                                <ItemStyle Width="15%" HorizontalAlign="center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="AST_NAME" HeaderText="Aset Name">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CAT_NAME" HeaderText="Category">
                                <ItemStyle Width="20%" />
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
                             <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_CODE" HeaderText="Status">
                                <ItemStyle Width="5%"  HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Existence" Visible = "false">
                              <ItemStyle Width="0%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                  <asp:DropDownList Visible="false" runat="server" ID="ddlDocumentStatus" CssClass="form-control input-sm" >
                                        <asp:ListItem Selected Text="-=Select=-" Value="0"></asp:ListItem>
                                        <asp:ListItem  Text="OK" Value="OK"></asp:ListItem>
                                        <asp:ListItem Text="NOT OK" Value="NOT"></asp:ListItem>
                                    </asp:DropDownList> 
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:CommandField ShowSelectButton="true" />
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

