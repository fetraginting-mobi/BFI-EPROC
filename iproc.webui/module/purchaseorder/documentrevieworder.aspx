<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="documentrevieworder.aspx.cs" Inherits="module_purchaseorder_documentrevieworder" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section class="panel">
        <header class="panel-heading">
          <span> Document History List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                <cc1:XUILabel ID="lblSupplierCode" runat="server" DBColumnName="SUPPLIER_CODE" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                <button CssClass="btn btn-danger" class="icon-remove" onclick="parent.fnHideGenericScreen();">Close</button>
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
               <%-- <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Location</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlLocation" runat="server" CssClass="form-control" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged"></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>--%>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                     <asp:GridView ID="gvwListDocReq" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, PR_CODE, PATHS, FILE, ID"
                        OnPageIndexChanging="gvwListDocReq_PageIndexChanging" OnRowDataBound="gvwListDocReq_OnRowDataBound" 
                         EmptyDataText="There is no data"  AllowSorting="true">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Document">
                                <ItemStyle Width="40%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="File Name">
                                <ItemStyle Width="90%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                     <asp:Label runat="server" Text='<%# Eval("PATHS") %>' ID="lblFileName"/>
                                     <br />
                                    <asp:FileUpload runat="server" Visible="false" ID="fupFilename" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%--<asp:Label ID="btnPreviewDoc" runat="server">Preview</asp:Label>--%>
                                     <asp:LinkButton ID="btnPreviewDoc" runat="server" CausesValidation="false" Text="Preview"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                               <asp:TemplateField HeaderText="">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDeleteDoc" runat="server" CausesValidation="false" Text="Delete" Visible="false" CommandName="del"/>
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

