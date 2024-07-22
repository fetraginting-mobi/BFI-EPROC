<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="financialstatementreport.aspx.cs" Inherits="module_report_financialstatementreport" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Financial Report</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R77700000P" ID="btnPrint" runat="server" CssClass="btn btn-primary" CausesValidation="false" OnClick="btnPrint_Click" ><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    <asp:RegularExpressionValidator ID="revPeriod" runat="server" ControlToValidate="txtPeriod" ErrorMessage="Format Date Invalid !" ValidationExpression= "(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"/>
                        <label class="col-sm-4">Period</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtPeriod" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_period" DataType="String" BindType="Both" placeholder="Period"></cc1:XUITextBox> 
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
                    <asp:RegularExpressionValidator ID="revDate" runat="server" ControlToValidate="txtDate" ErrorMessage="Format Date Invalid !" ValidationExpression= "(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"/>
                        <label class="col-sm-4">Date</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtDate" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_date" DataType="DateTime" Format="dd/MM/yyyy" BindType="Both" placeholder="Date"></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
            </div>
            <div class ="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <div class="row">
                 <div class="col-sm-6">
                     <div class="form-group">
                        <label class="col-sm-4">Printer Option</label>
                        <div class="col-sm-7">
                        <cc1:XUIRadioButtonList  ID="rblPrinter" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="Printer" Text=" Printer" Selected="True"></asp:ListItem>
                            <%--<asp:ListItem Value="Preview" Text = " Preview"></asp:ListItem>--%>
                            <asp:ListItem Value="Excel" Text = " Export To Excel"></asp:ListItem>
                        </cc1:XUIRadioButtonList>
                        </div>
                     </div>
                 </div>
            </div>
            <div class ="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Report Notes</label>
                        <div class="col-sm-7">
                            <cc1:XUITextBox ID="txtReportNotes" runat="server" CssClass="form-control" MaxLength="100" BindType="UIToDBOnly" DataType="String" SPParameterName="p_notes"></cc1:XUITextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
         </div>
         <div class="panel-body">
             <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Report List</label>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Branch List</label>
                    </div>
                </div>
            </div>
            <div class="row">
               <div class="col-sm-6">
                <asp:UpdatePanel ID="updReport" runat="server">
                     <ContentTemplate>
                    <asp:GridView ID="gvwListReport" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" DataKeyNames="CODE,HEADER_1,HEADER_2,HEADER_3,HEADER_4,HEADER_5,HEADER_6,HEADER_7,HEADER_8,HEADER_9,HEADER_10,HEADER_11,HEADER_12,HEADER_13,HEADER_14" EmptyDataText="There is no data">
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
                            <asp:BoundField DataField="CODE" HeaderText="Code">
                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description">
                                <ItemStyle Width="40%" HorizontalAlign="Left" />
                           </asp:BoundField>
                           <asp:BoundField DataField="TITLE" HeaderText="Title">
                                <ItemStyle Width="40%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <%--<asp:CommandField ShowSelectButton="true" />--%>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                    <%--<Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlBank" EventName="SelectedIndexChanged"/>
                        <asp:AsyncPostBackTrigger ControlID="ddlTransaction" EventName="SelectedIndexChanged"/>
                    </Triggers>--%>
                </asp:UpdatePanel>
              </div>
              <div class="col-sm-6">
                <asp:UpdatePanel ID="upd" runat="server">
                     <ContentTemplate>
                    <asp:GridView ID="gvwListBranch" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" DataKeyNames="CODE"  EmptyDataText="There is no data">
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
                            <asp:BoundField DataField="CODE" HeaderText="Code">
                                <ItemStyle Width="100%" HorizontalAlign="Center" />
                            </asp:BoundField>
                           <%-- <asp:CommandField ShowSelectButton="true" />--%>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                    <%--<Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlBank" EventName="SelectedIndexChanged"/>
                        <asp:AsyncPostBackTrigger ControlID="ddlTransaction" EventName="SelectedIndexChanged"/>
                    </Triggers>--%>
                </asp:UpdatePanel>
              </div>
            </div>
        </div>
    </section>
</asp:Content>


