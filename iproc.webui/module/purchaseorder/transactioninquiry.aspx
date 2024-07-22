<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="transactioninquiry.aspx.cs" Inherits="module_purchaseorder_transactioninquiry" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Transaction Search</span>
        </header>               
        <div class="panel-body">
            <div class="row">
                  <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4">Branch</label>
                        <div class="col-sm-8">
                          <cc1:XUIDropDownList ID="ddlBranch" Width="250px" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                          <cc1:XUITextBox ID="txtempcode" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
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
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4">From Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtFromDate" runat="server" Width="250px" CssClass="form-control default-date-picker-all" DBColumnName="REQUEST_DATE" SPParameterName="p_from_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
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
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4">To Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtToDate" runat="server" Width="250px" CssClass="form-control default-date-picker-all" DBColumnName="REQUEST_DATE" SPParameterName="p_to_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" OnTextChanged="txtToDateChanged" AutoPostBack="true"></cc1:XUITextBox>
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
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4">Trx Menu</label>
                        <div class="col-sm-4">
                            <cc1:XUIDropDownList ID="ddlTrxMenu" Width="250px" runat="server" CssClass="form-control" DataType="String" BindType="Both" AutoPostBack="true" OnTextChanged="ddlTrxMenu_TextChanged"></cc1:XUIDropDownList>
                        </div>
                    </div>                            
                </div>
            </div>
        </div>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-6">
                </div>
                 <div class="col-sm-2">
                   <%-- <div class="form-group">
                        <div class="col-sm-8">
                          <cc1:XUIDropDownList ID="ddlTransaction" runat="server" Width="200px" CssClass="form-control" DBColumnName="" SPParameterName="" DataType="String" BindType="Both">
                          <asp:ListItem Value="TR" Text="Transaction No"></asp:ListItem>
                          <asp:ListItem Value="EM" Text="Employee Name"></asp:ListItem>
                          <asp:ListItem Value="AM" Text="Transaction Amount"></asp:ListItem>
                          <asp:ListItem Value="RF" Text="References No"></asp:ListItem>
                          <asp:ListItem Value="NT" Text="Notes"></asp:ListItem> 
                          <asp:ListItem Value="SS" Text="Status"></asp:ListItem>                          
                          </cc1:XUIDropDownList>
                        </div>
                    </div>--%>
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
        <header class="panel-heading">
        <span>Transaction Inquiry</span>
        </header>
 
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="CODE_BARCODE, CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" OnRowDataBound="gvwList_OnRowDataBound"
                          EmptyDataText="There is no data" Width="100%">
                        <Columns>
                             <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>              
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Branch">
                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CODE" HeaderText="Transaction No">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                            </asp:BoundField>
                             <asp:BoundField DataField="CODE_BARCODE" HeaderText="CODE" Visible="false">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQUEST_DATE" HeaderText="Value Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="EMP_NAME" HeaderText="Employee Name" >
                                <ItemStyle Width="10%" HorizontalAlign="left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="TRX_AMOUNT" HeaderText="Transaction Amount" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%" HorizontalAlign="left"/>
                            </asp:BoundField>
                              <asp:BoundField DataField="REFERENCES_NO" HeaderText="References No" >
                                <ItemStyle Width="10%" HorizontalAlign="left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REMARKS" HeaderText="Notes">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LEVEL_APPROVAL" HeaderText="Approval">
                                <ItemStyle Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_CODE" HeaderText="Status">
                                <ItemStyle Width="5%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                           <%-- <asp:CommandField ShowSelectButton="true" />--%>
                             <asp:TemplateField>
                                <ItemTemplate>
                                    <%--<asp:LinkButton ID="btnViewInfo" runat="server" CssClass="btn btn-success" CausesValidation="false" ToolTip="View Information"><i class="icon-eye-open"></i></asp:LinkButton>--%>
                                    <asp:LinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></asp:LinkButton>
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


