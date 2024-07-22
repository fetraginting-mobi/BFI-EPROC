<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="supplierselectiondetaillist.aspx.cs" Inherits="module_purchaseorder_supplierselectiondetaillist" %>
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
                    <cc1:XUILinkButton RoleCode="R50000060C" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" style="display:none;" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="R50000060E" ID="btnSaveDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDetail_Click" style="display:none;"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000060D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" style="display:none;" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                        AllowPaging="true" PageSize="10" DataKeyNames="SELECTION_CODE,ITEM_CODE,SUPPLIER_CODE,PQ_CODE,BRANCH_CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        OnRowDataBound="gvwList_OnRowDataBound"
                        onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There is no data" Width="100%" >
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
                            <asp:BoundField DataField="BRANCH_DESC" HeaderText="Branch">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>                             
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                <ItemStyle Width="15%"/>
                            </asp:BoundField> 
                            <asp:BoundField DataField="QUANTITY" HeaderText="Qty" DataFormatString="{0:N2}">
                                <ItemStyle Width="5%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Supplier">
                                    <ItemStyle Width="20%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:DropDownList runat="server" ID="ddlSupplier" CssClass="form-control" AutoPostBack="true"  OnSelectedIndexChanged="ddlSupplier_SelectedIndexChanged"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                    <ItemStyle Width="12%" />
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("AMOUNT","{0:N2}") %>'  ID="txtAmount" CssClass="form-control" DataFormatString ="{0:N2}" Enabled ="false"  />
                                    </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total Amount" >
                                    <ItemStyle Width="13%"/>
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("TOTAL_AMOUNT","{0:N2}") %>' ID="txtTotalAmount"  CssClass="form-control" Enabled ="false"  />
                                    </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="RATING" HeaderText="Rating" >
                                <ItemStyle Width="5%" HorizontalAlign="Right"/>
                            </asp:BoundField>--%>
                            <asp:TemplateField HeaderText="Rating" >
                                    <ItemStyle Width="5%" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("RATING","{0:N2}") %>' ID="txtRating" CssClass="form-control" Enabled ="false"  />
                                    </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Supplier History">
                                    <ItemStyle Width="0%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSupplierHistory"  runat="server" CausesValidation="false" Text="Supplier History"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:TemplateField HeaderText="Item History">
                                    <ItemStyle Width="0%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnItemHistory"  runat="server" CausesValidation="false" Text="Item History"/>
                                    </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                <ItemStyle Width="15%"/>
                            </asp:BoundField> 
                             <asp:TemplateField HeaderText="View Document Request">
                                    <ItemStyle Width="5%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnViewDocument" runat="server" CausesValidation="false" Text="View Document Request"/>
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
       
    </asp:Panel>
        </div>
    </section>
</asp:Content>

