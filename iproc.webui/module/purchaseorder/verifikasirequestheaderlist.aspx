<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="verifikasirequestheaderlist.aspx.cs" Inherits="module_purchaseorder_verifikasirequestheaderlist" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Verification Purchase Request List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
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
                    <label class="col-sm-3">Branch</label>
                        <div class="col-sm-8">
                          <cc1:XUIDropDownList ID="ddlBranch" Width="200px" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                           <cc1:XUITextBox ID="txtempcode" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                        </div>
                    </div>
                </div>
                <%--(+) Ari 13-07-2022 ket : enhancement 2022, filter by date--%>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4" style="padding-left:50px; width:150px">From Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtFromDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="REQUEST_DATE" SPParameterName="p_from_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
                 <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4" style="width:100px">To Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtToDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="REQUEST_DATE" SPParameterName="p_to_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" OnTextChanged="txtToDateChanged" AutoPostBack="true"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Owner</label>
                        <div class="col-sm-8">
                          <cc1:XUIDropDownList ID="ddlOwner" Width="200px" runat="server" CssClass="form-control" DBColumnName="OWNER_CODE" SPParameterName="p_owner" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlOwner_SelectedIndexChanged" ></cc1:XUIDropDownList>
                           <cc1:XUITextBox ID="XUITextBox1" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
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
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data" Width="100%">
                        <Columns>
                             <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>              
                            <asp:BoundField DataField="CODE" HeaderText="IR No.">
                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Branch">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQUEST_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="REQUIREMENT_TYPE" HeaderText="Type" >
                                <ItemStyle Width="10%" HorizontalAlign="left"/>
                            </asp:BoundField>
                          
                            <asp:BoundField DataField="DEPARTEMENT_NAME" HeaderText="Department" >
                                <ItemStyle Width="10%" HorizontalAlign="left"/>
                            </asp:BoundField>
                              <asp:BoundField DataField="UNITS_NAME" HeaderText="Unit" >
                                <ItemStyle Width="10%" HorizontalAlign="left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="EMP_NAME" HeaderText="Requestor">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OWNER_NAME" HeaderText="Owner Asset">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
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


