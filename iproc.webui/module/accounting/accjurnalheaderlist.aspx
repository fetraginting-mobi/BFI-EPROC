<%@ Page Title="" Language="C#" Culture="id-ID" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accjurnalheaderlist.aspx.cs" Inherits="module_accounting_accjurnalheaderlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>General Journal Transaction List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <asp:LinkButton ID="btnPost" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click" CausesValidation="true"><i class="icon-save" ></i>  Post</asp:LinkButton>
                    <asp:LinkButton ID="btnUnPost" runat="server" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnUnPost_Click"><i class="icon-remove"></i>  Un-Post</asp:LinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                       <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
         <div class="panel-body" style="height:950px">
             <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Status</label>
                        <div class="col-sm-4">
                            <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="HOLD">HOLD</asp:ListItem>
                                <asp:ListItem Value="POST">POST</asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Type</label>
                        <div class="col-sm-4">
                            <cc1:XUIDropDownList ID="ddlType" runat="server" CssClass="form-control" SPParameterName="p_type" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddltype_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="RV">Receipt Voucher</asp:ListItem>
                                <asp:ListItem Value="PV">Payment Voucher</asp:ListItem>
                                <asp:ListItem Value="JM">Jurnal Memorial</asp:ListItem>
                                <asp:ListItem Value="JV">Jurnal Voucher</asp:ListItem>
                                <%--<asp:ListItem Value="AUDIT">AUDIT</asp:ListItem>--%>
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
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Branch</label>
                        <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Period</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtFromDueDate" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_from_due_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                        <label class="col-sm-1">-</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtToDueDate" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_to_due_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
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
                        AllowPaging="true" PageSize="10" DataKeyNames="VOUCHER_NO"
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
                            <%--<asp:BoundField DataField="BRANCH" HeaderText="Branch">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="VOUCHER_NO" HeaderText="Voucher No.">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REFF_NO" HeaderText="Reff No.">
                                <ItemStyle Width="15%"  HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description">
                                <ItemStyle Width="25%"  HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VALUE_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="15%"  HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BALANCE" HeaderText="Balance" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="STATUS" HeaderText="Status">
                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                   <%-- <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />--%>
                   <%-- <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
