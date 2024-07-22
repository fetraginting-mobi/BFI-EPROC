<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventoryrequestheaderlist.aspx.cs" Inherits="module_inventory_inventoryrequestheaderlist" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Inventory Request List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                   <cc1:XUILinkButton RoleCode="R60000080C" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus" ></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R60000080D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-4">Status</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged"></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>    
                <div class="col-sm-5">
                    <div class="form-group">
                    <label class="col-sm-2">Branch</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                            <div class="form-group">
                                <label class="col-sm-4">Action</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlFlagAction" runat="server" CssClass="form-control" DBColumnName="FLAG_ACTION" SPParameterName="p_flag_action" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlFlagAction_SelectedIndexChanged">
                                    <asp:ListItem Value="ALL">ALL </asp:ListItem>
                                    <asp:ListItem Value="ISSUE"> ISSUE </asp:ListItem>
                                    <asp:ListItem Value="MUTATION"> MUTATION </asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvFlagAction" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlFlagAction" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
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
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                            <asp:BoundField DataField="CODE" HeaderText="Inventory Request No.">
                                <ItemStyle Width="25%" HorizontalAlign="Center"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQUEST_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_NAME" HeaderText="Branch">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="DIVISION_NAME" HeaderText="Division">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="DEPARTMENT_NAME" HeaderText="Department">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="EMP_NAME" HeaderText="Requestor">
                                <ItemStyle Width="30%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                <ItemStyle Width="5%" HorizontalAlign="Center" />
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
