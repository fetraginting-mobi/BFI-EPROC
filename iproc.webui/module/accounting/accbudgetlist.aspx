<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accbudgetlist.aspx.cs" Inherits="module_accounting_accbudgetlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Budgeting</span>
        </header>
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">
                 <li class="active">
                     <a href="#budget" id="cbudget" onclick="javascript:fnSetTab('cbudget');" data-toggle="tab">Budget</a>
                 </li>
                 <li class="">
                     <a href="#revision" id="crevision" onclick="javascript:fnSetTab('crevision');" data-toggle="tab">Revision</a>
                 </li>
                 <li class="">
                     <a href="#list" id="clist" onclick="javascript:fnSetTab('clist');" data-toggle="tab">Report</a>
                 </li>
            </ul>
        </header>
         <div class="panel-body">
            <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="budget">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group"></div>
                        </div>
                    </div>
                    <div class ="row">
                        <div class="col-sm-8">
                            <div class="form-group">
                                <cc1:XUILinkButton ID="btnGenerate" RoleCode="R12000060C" runat="server" CssClass="btn btn-primary" OnClick="btnGenerate_Click" ><i class="icon-certificate"></i> Generate</cc1:XUILinkButton>
                                <cc1:XUILinkButton ID="btnSave" RoleCode="R12000060C" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" ><i class="icon-save"></i> Save</cc1:XUILinkButton>
                            </div>
                        </div>  
                        <div class="col-sm-4">
                            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchBudget" class="input-group">
                                <asp:TextBox ID="txtSearchBudget" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchBudget" runat="server" CssClass="btn btn-info" OnClick="btnSearchBudget_Click" ><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>   
                            </asp:Panel>
                        </div>    
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Financial year</label>
                                <asp:RegularExpressionValidator ID="revYear" runat="server" ErrorMessage="Format Invalid !" ControlToValidate="txtYear" ValidationExpression="[0-9]*[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtYear" runat="server" CssClass="form-control" placeholder="Year" Width="70px" MaxLength="4"></asp:TextBox>
                            </div>
                        </div>                                              
                    </div>
                    <%--<div class="row">
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label class="col-sm-3">Financial month</label>
                                <asp:DropDownList ID="ddlMonthBudget" runat="server" CssClass="form-control" Width="150px">
                                    <asp:ListItem Value="1">January</asp:ListItem>
                                    <asp:ListItem Value="2">February</asp:ListItem>
                                    <asp:ListItem Value="3">March</asp:ListItem>
                                    <asp:ListItem Value="4">April</asp:ListItem>
                                    <asp:ListItem Value="5">Mei</asp:ListItem>
                                    <asp:ListItem Value="6">June</asp:ListItem>
                                    <asp:ListItem Value="7">July</asp:ListItem>
                                    <asp:ListItem Value="8">August</asp:ListItem>
                                    <asp:ListItem Value="9">September</asp:ListItem>
                                    <asp:ListItem Value="10">October</asp:ListItem>
                                    <asp:ListItem Value="11">November</asp:ListItem>
                                    <asp:ListItem Value="12">December</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>                        
                    </div>--%>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group"></div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="updBudget" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListBudget" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="false" PageSize="10" DataKeyNames="ID"
                                EmptyDataText="There is no data">
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
                                            <asp:CheckBox runat="server" ID="chbCheckedAll" AutoPostBack="true" OnCheckedChanged="chbCheckedAll_CheckedChanged"/>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chbChecked"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                        <ItemStyle Width="10%"/>
                                    </asp:BoundField>--%>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label runat="server" ID="lblHeaderAccNo" Text="Acc No."></asp:Label>
                                        </HeaderTemplate>
                                        <HeaderStyle Width="10%" />
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAccNo" Text='<%# Eval("ACC_NO") %>' Font-Bold="true"></asp:Label>
                                            </br>
                                            <asp:Label runat="server" ID="lblAccName" Text='<%# Eval("ACC_NAME") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                         <HeaderTemplate>
                                            <span>Month</span>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table cellpadding="0px" cellspacing="0px" width="100%" class="display table table-bordered table-striped">
                                                <tr>
                                                    <td width="5%">
                                                        JAN
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET1","{0:N0}") %>'  style="text-align:right;" ID="txtQtyJan" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyJan" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyJan" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        FEB
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET2","{0:N0}") %>'  style="text-align:right;" ID="txtQtyFeb" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyFeb" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyFeb" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        MAR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET3","{0:N0}") %>'  style="text-align:right;" ID="txtQtyMar" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyMar" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyMar" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        APR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET4","{0:N0}") %>'  style="text-align:right;" ID="txtQtyApr" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyApr" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyApr" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        MAY
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET5","{0:N0}") %>'  style="text-align:right;" ID="txtQtyMay" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyMay" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyMay" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        JUN
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET6","{0:N0}") %>'  style="text-align:right;" ID="txtQtyJun" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyJun" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyJun" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        JUL
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET7","{0:N0}") %>'  style="text-align:right;" ID="txtQtyJul" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyJul" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyJul" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        AUG
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET8","{0:N0}") %>'  style="text-align:right;" ID="txtQtyAug" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyAug" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyAug" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        SEP
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET9","{0:N0}") %>'  style="text-align:right;" ID="txtQtySept" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtySept" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtySept" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        OCT
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET10","{0:N0}") %>'  style="text-align:right;" ID="txtQtyOct" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyOct" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyOct" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        NOV
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET11","{0:N0}") %>'  style="text-align:right;" ID="txtQtyNov" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyNov" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyNov" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        DEC
                                                    </td> 
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET12","{0:N0}") %>'  style="text-align:right;" ID="txtQtyDes" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyDes" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyDes" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>  
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <ItemStyle Width="90%" />
                                    </asp:TemplateField>
                                </Columns>
                                <%--<Columns>
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
                                    <asp:BoundField DataField="ACC_NAME" HeaderText="A/C Name" >
                                        <ItemStyle Width="30%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ACC_CURR" HeaderText="Curr." >
                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LAST_BALANCE" HeaderText="Dec Last Year" DataFormatString="{0:N2}">
                                        <ItemStyle Width="25%" HorizontalAlign="Right" />
                                    </asp:BoundField>  
                                    <asp:TemplateField HeaderText="Budget">
                                    <ItemStyle Width="25%" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <cc1:XUITextBox runat="server" Text='<%# Eval("BUDGET", "{0:N2}") %>' ID="txtBudget" CssClass="form-control" DataType="Number" MaxLength="14" />
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action">
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSaveBudget" runat="server"  CausesValidation="false"  Text="Save" CommandName="save"/>
                                    </ItemTemplate> 
                                    </asp:TemplateField> 
                                </Columns>--%>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnGenerate" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnSearchBudget" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <div class="tab-pane" id="revision">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group"></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Financial year</label>
                                <asp:RegularExpressionValidator ID="revYearRev" runat="server" ErrorMessage="Format Invalid !" ControlToValidate="txtYearRev" ValidationExpression="[0-9]*[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtYearRev" runat="server" CssClass="form-control" placeholder="Year" Width="70px" MaxLength="4"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label class="col-sm-3">Financial month</label>
                                <asp:DropDownList ID="ddlMonthRev" runat="server" CssClass="form-control" Width="150px">
                                    <asp:ListItem Value="1">January</asp:ListItem>
                                    <asp:ListItem Value="2">February</asp:ListItem>
                                    <asp:ListItem Value="3">March</asp:ListItem>
                                    <asp:ListItem Value="4">April</asp:ListItem>
                                    <asp:ListItem Value="5">Mei</asp:ListItem>
                                    <asp:ListItem Value="6">June</asp:ListItem>
                                    <asp:ListItem Value="7">July</asp:ListItem>
                                    <asp:ListItem Value="8">August</asp:ListItem>
                                    <asp:ListItem Value="9">September</asp:ListItem>
                                    <asp:ListItem Value="10">October</asp:ListItem>
                                    <asp:ListItem Value="11">November</asp:ListItem>
                                    <asp:ListItem Value="12">December</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <asp:Panel ID="pnlSearchRev" runat="server" DefaultButton="btnSearchRev" class="input-group">
                                <asp:TextBox ID="txtSearchRev" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchRev" runat="server" CssClass="btn btn-info" OnClick="btnSearchRev_Click" ><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>   
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group"></div>
                        </div>
                    </div> 
                    <asp:UpdatePanel ID="updRev" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListRev" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="false" DataKeyNames="ID, BUDGET" EmptyDataText="There is no data." OnRowCommand="gvwListRev_RowCommand">
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
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ACC_NAME" HeaderText="A/C Name" >
                                        <ItemStyle Width="15%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ACC_CURR" HeaderText="Curr." >
                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BUDGET" HeaderText="Budget" DataFormatString="{0:N2}">
                                        <ItemStyle Width="20%" HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Revision">
                                    <ItemStyle Width="20%" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <cc1:XUITextBox runat="server" Text='<%# Eval("REVISION", "{0:N2}") %>' ID="txtRev" CssClass="form-control" DataType="Number" MaxLength="14" />
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="REVISION_AMOUNT" HeaderText="Revision Amount" DataFormatString="{0:N2}">
                                        <ItemStyle Width="20%" HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Action">
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSaveRev" runat="server"  CausesValidation="false"  Text="Save" CommandName="save"/>
                                    </ItemTemplate> 
                                    </asp:TemplateField> 
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchRev" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <div class="tab-pane" id="list">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group"></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Financial year</label>
                                <asp:RegularExpressionValidator ID="revYearRpt" runat="server" ErrorMessage="Format Invalid !" ControlToValidate="txtYearRpt" ValidationExpression="[0-9]*[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtYearRpt" runat="server" CssClass="form-control" placeholder="Year" Width="70px" MaxLength="4"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Type</label>
                                <div class="col-sm-4">
                                    <asp:RadioButtonList id="rboType" runat="server" RepeatDirection="Vertical" RepeatLayout="Flow">
                                        <asp:ListItem Value="0" Selected="True">All</asp:ListItem>
                                        <asp:ListItem Value="1">Budget</asp:ListItem>
                                        <asp:ListItem Value="2">Revision</asp:ListItem>
                                    </asp:RadioButtonList>  
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-8">
                            <cc1:XUILinkButton ID="btnPrint" runat="server" CssClass="btn btn-primary" CausesValidation="false" OnClick="btnPrint_Click" ><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

