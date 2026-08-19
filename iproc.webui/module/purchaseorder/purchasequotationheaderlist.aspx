<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchasequotationheaderlist.aspx.cs" Inherits="module_purchaseorder_purchasequotationheaderlist" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span> Purchase Quotation List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                  <%-- <cc1:XUILinkButton RoleCode="R06000004C" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>--%>
                    <cc1:XUILinkButton RoleCode="R50000050D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                        <div class="col-sm-5">
                             <cc1:XUIDropDownList ID="ddlStatus" Width="200px" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged"></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Branch</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" Width="200px" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <%--(+) Ari 13-07-2022 ket : enhancement 2022, filter by date--%>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4" style="padding-left:50px; width:150px">From Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtFromDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="QUOTATION_DATE" SPParameterName="p_from_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
                 <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4" style="width:100px">To Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtToDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="QUOTATION_DATE" SPParameterName="p_to_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" OnTextChanged="txtToDateChanged" AutoPostBack="true"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group"></div>
                    </div>
               </div>
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Owner</label>
                        <div class="col-sm-8">
                          <cc1:XUIDropDownList ID="ddlOwner" Width="200px" runat="server" CssClass="form-control" DBColumnName="OWNER_CODE" SPParameterName="p_owner" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlOwner_SelectedIndexChanged" ></cc1:XUIDropDownList>
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
                    AllowPaging="true" PageSize="10" DataKeyNames="CODE_BARCODE"
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
                            <asp:BoundField DataField="CODE" HeaderText="Purchase Quotation No.">
                                <ItemStyle Width="20%" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_NAME" HeaderText="Branch">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="QUOTATION_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="20%" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="EXP_DATE" HeaderText="Expired Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="15%" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OWNER_NAME" HeaderText="Owner Asset">
                                <ItemStyle Width="15%" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                <ItemStyle Width="10%" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                  <%--  <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
