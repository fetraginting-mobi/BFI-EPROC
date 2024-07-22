<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="documentretrievalheaderlist.aspx.cs" Inherits="module_inventory_documentretrievalheaderlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
    <header class="panel-heading">
          <span>Document Retrieval List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                <%--    <cc1:XUILinkButton RoleCode="" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" ><i class="icon-save"></i>  Save</cc1:XUILinkButton>--%>
                     <cc1:XUILinkButton ID="btnProcess" RoleCode="R60000144O" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-adv-table"></i>Process</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R60000144D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" style="Display:none;"><i class="icon-trash" style="Display:none;"></i>  Delete</cc1:XUILinkButton>
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
        <div class="panel-body">
          <div class="row">
               
                <div class="col-sm-5">
                    <div class="form-group">
                    <label class="col-sm-2">Branch</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Document Category</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlDocumentType" runat="server" CssClass="form-control" DBColumnName="DOCUMENT_CATEGORY" SPParameterName="p_document_type" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlDocumentType_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="PRIVATE">PRIVATE</asp:ListItem>
                                <asp:ListItem Value="OFFICE">OFFICE</asp:ListItem>
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
                    AllowPaging="true" PageSize="10" DataKeyNames="CODE_BARCODE,CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging"  OnRowDataBound="gvwList_RowDataBound"
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There Is No Data">
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
                             <asp:BoundField DataField="CODE" HeaderText="Code Barcode">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRX_DATE" HeaderText="Receive Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="8%" />
                            </asp:BoundField>
                              <asp:BoundField DataField="DOCUMENT_NAME" HeaderText="Document Name">
                                <ItemStyle Width="10%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DOCUMENT_NO" HeaderText="No Resi">
                                <ItemStyle Width="7%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DOCUMENT_CATEGORY" HeaderText="Document Category">
                                <ItemStyle Width="7%"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="RECEIVE_LOCATION" HeaderText="Receive location">
                                <ItemStyle Width="8%"/>
                            </asp:BoundField>
                             
                            <asp:TemplateField HeaderText="Document Status">
                              <ItemStyle Width="15%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                  <asp:DropDownList runat="server" ID="ddlDocumentStatus" CssClass="form-control input-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlDocumentStatus_SelectedIndexChanged">
                                        <asp:ListItem Selected Text="-=Select=-" Value="0"></asp:ListItem>
                                        <asp:ListItem  Text="TAKEN" Value="TKN"></asp:ListItem>
                                        <asp:ListItem Text="LOST AND FOUND" Value="LAF"></asp:ListItem>
                                        <asp:ListItem Text="MUTATION" Value="MTT"></asp:ListItem>
                                    </asp:DropDownList> 
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Moved Location">
                              <ItemStyle Width="18%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlMovedLocation" CssClass="form-control input-sm">
                                    </asp:DropDownList> 
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Confirm Date" SortExpression="RECEIVE_DATE">
                                <ItemStyle Width="11%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("CONFIRM_DATE", "{0:dd/MM/yyyy}") %>' ID="txtReceiveDate" Height="35px" CssClass="form-control default-date-picker date-only number-only"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="PENGIRIM" HeaderText="Shipper">
                                <ItemStyle Width="7%"/>
                            </asp:BoundField>
                              <asp:CommandField ShowSelectButton="true" />
                          
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <%--<asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

