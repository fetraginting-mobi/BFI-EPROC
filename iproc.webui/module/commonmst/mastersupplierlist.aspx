<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastersupplierlist.aspx.cs" Inherits="module_commonmst_mastersupplierlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Supplier List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R30000150C" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R30000150D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                    <label class="col-sm-2">Branch</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-2">Creditor Type *</label>
                    <div class="col-sm-5">
                        <cc1:XUIDropDownList ID="ddlCreditorTypeCode" runat="server" CssClass="form-control" DBColumnName="CREDITOR_TYPE" SPParameterName="p_creditor_type" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlCreditorTypeCode_SelectedIndexChanged">
                              
                              <%--<asp:ListItem Value="0">-=Select=-</asp:ListItem>
                              <asp:ListItem Text="CREDITOR STAFF" Value="SOF"></asp:ListItem>
                              <asp:ListItem Text="CREDITOR SUPPLIER GOODS" Value="SPL"></asp:ListItem> 
                              <asp:ListItem Text="CREDITOR SUPPLIER SERVICE" Value="SPS"></asp:ListItem> --%>
                            
                        </cc1:XUIDropDownList>
                         
                         <asp:RequiredFieldValidator ID="rfvCreditorTypeCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlCreditorTypeCode" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                    </div>
                </div>                            
            </div>  
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-2">Supplier Status</label>
                    <div class="col-sm-5">
                        <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" DBColumnName="CREDITOR_TYPE" SPParameterName="p_creditor_type" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                              
                              <asp:ListItem Value="ALL">ALL</asp:ListItem>
                              <asp:ListItem Text="VALID" Value="VALID"></asp:ListItem>
                              <asp:ListItem Text="IN-VALID" Value="IN-VALID"></asp:ListItem> 
                            
                        </cc1:XUIDropDownList>
                         
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlCreditorTypeCode" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                    </div>
                </div>                            
            </div>                
              </div>
              <div class="row">
         <div class="col-sm-6">
                    <div class="form-group">
                    </div>
          </div>
       </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="SUPPLIER_CODE"
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
                            <asp:BoundField DataField="SUPPLIER_CODE" HeaderText="Code">
                                <ItemStyle Width="10%" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_DESC" HeaderText="Branch Name">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="SUPPLIER_NAME" HeaderText="Name">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TYPE" HeaderText="Creditor Type">
                                <ItemStyle Width="12%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ADDRESS_1" HeaderText="Address">
                                <ItemStyle Width="28%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="PHONE" HeaderText="Phone">
                                <ItemStyle Width="10%" Wrap="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="STATUS" HeaderText="Status">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
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


