<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="glopeningbalance.aspx.cs" Inherits="module_accounting_glopeningbalance" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>GL Opening Balance</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R37100002O" ID="btnProcess" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-certificate"></i> Calculate </cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R37100002O" ID="btnGenerate" runat="server" CssClass="btn btn-primary" OnClick="btnGenerate_Click" CausesValidation="false"><i class="icon-certificate"></i> Generate GL A/C</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="false"><i class="icon-save"></i> Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click"  CausesValidation="false"><i class="icon-print" ></i>  Print</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Period</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtperiod" runat="server" CssClass="form-control" SPParameterName="p_period" DataType="DateTime" BindType="Both" Enabled="false"></cc1:XUITextBox> 
                                </div>
                               
                            </div>                            
                        </div>
                    </div>                        
                </ContentTemplate>
                  <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnProcess" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnGenerate" EventName="Click" />
                 </Triggers>
            </asp:UpdatePanel>                    
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group"></div>
            </div>
        </div>
        <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                AllowPaging="false" PageSize="10" DataKeyNames="ACC_NO, ACC_PERIOD, BASE_CURRENCY, ACC_TYPE" ShowFooter="true"
                OnPageIndexChanging="gvwList_PageIndexChanging" EmptyDataText="There is no data" OnRowDataBound="gvwList_RowDataBound" >
               <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <span>No</span>
                        </HeaderTemplate> 
                    <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ACC_NO" HeaderText="A/C No.">
                        <ItemStyle Width="15%" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ACC_NAME" HeaderText="A/C Name">
                        <ItemStyle Width="25%" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ACC_CURR" HeaderText="Curr.">
                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ACC_TYPE_NAME" HeaderText="A/C Type">
                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Balance in Base Curr.">
                    <ItemStyle Width="20%" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <cc1:XUITextBox runat="server" Text='<%# Eval("BALANCE_BASE", "{0:N2}") %>' ID="txtBalanceBase" CssClass="form-control" DataType="Number" />
                    </ItemTemplate>
                    <FooterStyle Width="20%" HorizontalAlign="Right" Font-Bold="true"/>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Balance in Forex">
                    <ItemStyle Width="20%" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <cc1:XUITextBox runat="server" Text='<%# Eval("BALANCE_FOREX", "{0:N2}") %>' ID="txtBalanceForex" CssClass="form-control" DataType="Number" />
                    </ItemTemplate>
                    <FooterStyle Width="20%" HorizontalAlign="Right" Font-Bold="true"/>
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="Action">
                    <ItemStyle Width="20%" HorizontalAlign="Left" />
                    <ItemTemplate>
                        <asp:LinkButton ID="btnSaveBalance" runat="server"  CausesValidation="false"  Text="Save" CommandName="save"/>
                    </ItemTemplate>
                    </asp:TemplateField>--%>        
                </Columns>
            </asp:GridView>
        </div>
    </section>
</asp:Content>
