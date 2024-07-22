<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchasequotationreviewheaderlistheader.aspx.cs" Inherits="module_purchaseorder_purchasequotationreviewheaderlistheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <asp:Panel runat="server" ID="pnlQuotation">
        <section class="panel">
        <header class="panel-heading">
          <span> Item List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R50000045C" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" style="display:none;" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                   
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click"  CausesValidation="false"><i class="icon-cancel"></i> Back</cc1:XUILinkButton>
                   
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID_LIST,PQR_CODE,PR_CODE,ITEM_CODE,UNIT_CODE,ID"
                        OnPageIndexChanging="gvwList_PageIndexChanging" OnRowDataBound="gvwList_RowDataBound"
                        onselectedindexchanged="gvwList_SelectedIndexChanged"  EmptyDataText="There is no data" Width="100%" >
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
                            <asp:BoundField DataField="PR_DESC" HeaderText="IR No.">
                                <ItemStyle Width="20%"/>  
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Branch">
                                <ItemStyle Width="15%"/>  
                            </asp:BoundField>
                            <%-- <asp:TemplateField>
                                <ItemStyle Width="5%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnLookUpSupplierID" class="btn btn-primary input-sm" data-toogle="modal" runat="server"  style="display:none;" ><i class="icon-table"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                           <%-- <asp:TemplateField HeaderText="Supplier">
                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtSupplierCode" runat="server" style="display:none;"></asp:TextBox>
                                    <asp:Label ID="lblSupplierName" runat="server" ></asp:Label>   
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                <ItemStyle Width="15%"/>  
                            </asp:BoundField>
                             <asp:BoundField DataField="QUANTITY" HeaderText="Qty" DataFormatString="{0:N2}">
                                <ItemStyle Width="5%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="UNIT_DESC" HeaderText="UOM">
                                <ItemStyle Width="5%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="CURRENCY_CODE" HeaderText="Curr">
                                <ItemStyle Width="5%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="UNIT_PRICE" HeaderText="Latest Unit Price" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="TOTAL" HeaderText="Total" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%"/>  
                            </asp:BoundField>
                            <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                <ItemStyle Width="15%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
              <%--  <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                </Triggers>--%>
            </asp:UpdatePanel>
        </div>
    </section>
       
    </asp:Panel>
        </div>
    </section>
</asp:Content>
