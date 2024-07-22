<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="famutationreceiptlistlist.aspx.cs" Inherits="module_fa_famutationreceiptlistlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
    <header class="panel-heading">
          <span>FA Mutation Receipt List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R90000085O" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Receive</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click"><i class="icon-remove"></i>  Return</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>
                        <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DataType="String" BindType="None" style="display:none"></cc1:XUITextBox>  
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
                    <label class="col-sm-3">Status</label>
                        <div class="col-sm-7">
                            <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                             <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                             <%--<asp:ListItem Text="NEW" Value="NEW"></asp:ListItem>--%>
                             <asp:ListItem Text="POST" Value="POST"></asp:ListItem>
                             <asp:ListItem Text="PENDING" Value="PENDING"></asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                 <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">From Cost Center</label>
                        <div class="col-sm-7">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>   
            </div>
            <div class="row">
                  <div class="col-sm-6">
                     <div class="form-group">
                     </div>
                </div>   
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">To Location</label>
                        <div class="col-sm-7">
                          <cc1:XUIDropDownList ID="ddlToLocationCode" runat="server" CssClass="form-control" DBColumnName="TO_LOCATION_CODE" SPParameterName="p_to_location_code" BindType="Both" DataType="String" AutoPostBack="true" OnSelectedIndexChanged="ddlToLocationCode_SelectedIndexChanged" ></cc1:XUIDropDownList>
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
                    AllowPaging="true" PageSize="10" DataKeyNames="IR_CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging"
                     
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
                            <asp:BoundField DataField="CODE" HeaderText="FA Mutation No.">
                                <ItemStyle Width="15%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="FROM_COST_CENTER" HeaderText="From Cost Center">
                                <ItemStyle Width="20%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="TO_LOCATION_CODE" HeaderText="To Location">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Receive Date" SortExpression="RECEIVE_DATE">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("RECEIVE_DATE", "{0:dd/MM/yyyy}") %>' ID="txtReceiveDate" Height="35px" Enabled="false" CssClass="form-control default-date-picker date-only number-only"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Remarks Return" SortExpression="REMARK">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("REMARK_UNPOST", "{0:dd/MM/yyyy}") %>' ID="txtRemarkUnpost" Height="35px" TextMode="MultiLine"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                           <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>