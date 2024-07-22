<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accgeneralledger.aspx.cs" Inherits="module_accounting_accgeneralledger" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>General Ledger</span>
        </header>
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">
                 <li class="active">
                     <a href="#trial" id="ctrial" onclick="javascript:fnSetTab('ctrial');" data-toggle="tab">Trial Balance</a>
                 </li>
                 <li class="">
                     <a href="#account" id="caccount" onclick="javascript:fnSetTab('caccount');" data-toggle="tab">Transaction by Account</a>
                 </li>
                 <li class="">
                     <a href="#voucher" id="cvoucher" onclick="javascript:fnSetTab('cvoucher');" data-toggle="tab">Transaction by Voucher</a>
                 </li>
                 <%--<li class="">
                     <a href="#report" id="creport" onclick="javascript:fnSetTab('creport');" data-toggle="tab">Report General Ledger</a>
                 </li>--%>
            </ul>
        </header>
        <div class="panel-body">
            <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="trial" style="height:380px">
                    <section class="panel">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-sm-12">
                                    <cc1:XUILinkButton ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click"  CausesValidation="false"><i class="icon-print" ></i>  Print</cc1:XUILinkButton>
                                    <cc1:XUILinkButton ID="btnPrintExcel" runat="server" CssClass="btn btn-primary" OnClick="btnPrintExcel_Click"  CausesValidation="false" ><i class="icon-print"></i>  Print Excel</cc1:XUILinkButton>
                                </div>
                            </div>                            
                         </div>                    
                         <div class="panel-body form-horizontal"> 
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label class="col-sm-2">Accounting Date</label>
                                        <cc1:XUITextBox ID="txtDate" runat="server" CssClass="form-control default-date-picker" placeholder="Date" Width="100px"></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">                         
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
                                            <ItemStyle Width="20%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DESCRIPTION" HeaderText="Branch">
                                            <ItemStyle Width="80%" HorizontalAlign="Left" />
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
                    </section>
                </div> <%--end div trial--%>
                <div class="tab-pane" id="account">
                    <section class="panel">
                    <div class="panel-body form-horizontal">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Chart Of Account</label>
                                    <div class="col-sm-8">
                                        <asp:LinkButton runat="server" ID="btnLookUpAccChart" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <asp:RequiredFieldValidator ID="rfvtxtAccNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccNo" Display="Dynamic" ValidationGroup="Acc" ></asp:RequiredFieldValidator>
                                        <%--<cc1:XUILabel ID="lblAccNo" runat="server" DataType="String" BindType="None" Text="-"></cc1:XUILabel>--%>
                                        <cc1:XUITextBox ID="txtAccNo" runat="server" DBColumnName="ACC_NO" SPParameterName="p_acc_no" MaxLength="20" DataType="String" BindType="Both" Width="100px" style="border:0px;background-color:inherit" Enabled="false"></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtAccName" runat="server" DataType="String" BindType="DBToUIOnly" Width="180px" style="border:0px;background-color:inherit" Enabled="false"></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Currency</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblCurr" runat="server" DataType="String" BindType="UIToDBOnly"></cc1:XUILabel>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <asp:UpdatePanel ID="updDb" runat="server">
                                <ContentTemplate>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="col-sm-4">Total Mutasi Debit</label>
                                            <div class="col-sm-8">
                                                <cc1:XUILabel ID="lblDebit" runat="server" DataType="Number" Format="N2" BindType="UIToDBOnly" Text="-"></cc1:XUILabel>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="col-sm-4">Opening Balance</label>
                                            <div class="col-sm-8">
                                                <cc1:XUILabel ID="lblOpening" runat="server" DataType="Number" Format="N2" BindType="UIToDBOnly" Text="-"></cc1:XUILabel>
                                            </div>
                                        </div>    
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnSearchByAcc" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnPrintExcel" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <div class="row">
                            <asp:UpdatePanel ID="updCr" runat="server">
                                <ContentTemplate>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="col-sm-4">Total Mutasi Credit</label>
                                            <div class="col-sm-8">
                                                <cc1:XUILabel ID="lblCredit" runat="server" DataType="Number" Format="N2" BindType="UIToDBOnly" Text="-"></cc1:XUILabel>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Closing Balance</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblClosing" runat="server" DataType="Number" Format="N2" BindType="UIToDBOnly" Text="-"></cc1:XUILabel>
                                    </div>
                                </div>    
                            </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnSearchByAcc" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>        
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Accounting Period</label>
                                    <div class="col-sm-3">
                                        <cc1:XUIDropDownList ID="ddlAccPeriod" runat="server" DataType="String" CssClass="form-control"></cc1:XUIDropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </section>
                    <section class="panel">
                        <header class="panel-heading">
                            <%--<span>Detail List </span>--%>
                        </header>
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group">
                                        <cc1:XUILinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" ValidationGroup="Acc" OnClick="btnRefresh_Click"><i class="icon-certificate" ></i>  Refresh</cc1:XUILinkButton>
                                        <cc1:XUILinkButton ID="btnPrintByAcc" runat="server" CssClass="btn btn-primary" ValidationGroup="Acc" OnClick="btnPrintByAcc_Click" ><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchByAcc" class="input-group">
                                        <asp:TextBox ID="txtSearchByAcc" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchByAcc" runat="server" CssClass="btn btn-info" ValidationGroup="Acc" ><i class="icon-search"></i>  Search</asp:LinkButton>
                                        </div>   
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel ID="updByAcc" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gvwListAcc" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                        AllowPaging="false" PageSize="10" DataKeyNames="VOUCHER"
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
                                            <asp:BoundField DataField="VOUCHER" HeaderText="Voucher">
                                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TRX_DATE" HeaderText="Trx. Date" DataFormatString="{0:dd/MM/yyyy}">
                                                <ItemStyle Width="7%" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ACC_NO" HeaderText="A/C No">
                                                <ItemStyle Width="8%" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="KEPADA" HeaderText="Voucher Description">
                                                <ItemStyle Width="30%" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LINE_DESC" HeaderText="Trx. Description">
                                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DEBIT" HeaderText="Debit" DataFormatString="{0:N2}">
                                                <ItemStyle Width="10%" HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CREDIT" HeaderText="Credit" DataFormatString="{0:N2}">
                                                <ItemStyle Width="10%" HorizontalAlign="Right" />
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnSearchByAcc" EventName="Click" />
                                </Triggers> 
                            </asp:UpdatePanel>    
                        </div>
                    </section>
                </div> <%--end div account--%>
                <div class="tab-pane" id="voucher" style="height:380px">
                    <section class="panel">
                        <div class="panel-heading">
                            <div class="row">                        
                                <div class="col-sm-6">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <asp:LinkButton ID="btnPrintAll" runat="server" CssClass="btn btn-primary" OnClick="btnPrintAll_Click"><i class="icon-print"></i> Print</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body form-horizontal">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Chart Of Account</label>
                                        <div class="col-sm-8">
                                            <%--<cc1:XUILabel ID="lblCoaNo" runat="server" DataType="String" BindType="None" Text="-"></cc1:XUILabel>--%>
                                            <asp:LinkButton runat="server" ID="btnLookUpCOA" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtCoaNo" runat="server"  DBColumnName="ACC_NO" SPParameterName="p_acc_no" MaxLength="20" DataType="String" BindType="Both" Width="100px" style="border:0px;background-color:inherit" Enabled="false"></cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtCoaName" runat="server" DataType="String" BindType="DBToUIOnly" Width="500px" style="border:0px;background-color:inherit" Enabled="false"></cc1:XUITextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Currency</label>
                                        <div class="col-sm-4">
                                            <cc1:XUILabel ID="lblCoaCurr" runat="server" DataType="String" BindType="UIToDBOnly"></cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Period</label>
                                        <div class="col-sm-3">
                                            <cc1:XUITextBox ID="txtFromDate" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_from_date" DataType="DateTime" BindType="UIToDBOnly" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                                        </div>
                                        <label class="col-sm-1">-</label>
                                        <div class="col-sm-3">
                                            <cc1:XUITextBox ID="txtToDate" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_to_date" DataType="DateTime" BindType="UIToDBOnly" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                        </div>
                                    </div>                            
                                </div>                                
                            </div>
                            <div class="row">                        
                                 <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Voucher Type</label>
                                        <div class="col-sm-4">
                                            <cc1:XUIDropDownList ID="ddlType" runat="server" CssClass="form-control" SPParameterName="p_type" DataType="String" BindType="Both">
                                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                                <asp:ListItem Value="RV">Receipt Voucher</asp:ListItem>
                                                <asp:ListItem Value="PV">Payment Voucher</asp:ListItem>
                                                <asp:ListItem Value="JM">Jurnal Memorial</asp:ListItem>
                                                <asp:ListItem Value="JV">Jurnal Voucher</asp:ListItem>
                                            </cc1:XUIDropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Voucher</label>
                                        <div class="col-sm-6">
                                            <asp:Panel ID="pnlSearchVoucher" runat="server" DefaultButton="btnSearchVoucher" class="input-group">
                                                <cc1:XUITextBox ID="txtVoucher" runat="server" DataType="String" BindType="UIToDBOnly" SPParameterName="p_voucher" CssClass="form-control" placeholder="Voucher No." ></cc1:XUITextBox>
                                                <div class="input-group-btn">
                                                    <asp:LinkButton ID="btnSearchVoucher" runat="server" CssClass="btn btn-info" OnClick="btnSearchVoucher_Click"><i class="icon-search"></i> Search</asp:LinkButton>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </div>
                            </div>  
                         </div>                          
                     </section>
                     <section class="panel">
                        <asp:UpdatePanel ID="pnlVoucher" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListVoucher" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="false" PageSize="10" DataKeyNames="VOUCHER_NO" OnRowCommand="gvwListVoucher_RowCommand"
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
                                        <asp:BoundField DataField="VOUCHER_NO" HeaderText="Voucher">
                                            <ItemStyle Width="15%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TRX_DATE" HeaderText="Trx. Date" DataFormatString="{0:dd/MM/yyyy}">
                                            <ItemStyle Width="7%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACC_NO" HeaderText="A/C No">
                                            <ItemStyle Width="8%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="KEPADA" HeaderText="Voucher Description">
                                            <ItemStyle Width="30%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LINE_DESC" HeaderText="Trx. Description">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DEBIT" HeaderText="Debit" DataFormatString="{0:N2}">
                                            <ItemStyle Width="10%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CREDIT" HeaderText="Credit" DataFormatString="{0:N2}">
                                            <ItemStyle Width="10%" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemStyle Width="20%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnSavePrint" runat="server" CausesValidation="false"  Text="Print" CommandName="print"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchVoucher" EventName="Click" />
                            </Triggers> 
                         </asp:UpdatePanel>  
                     </section>  
                </div>
                    
            </div> <%--end div voucher--%>
                <%--<div class="tab-pane" id="report">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Period</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtFromDt" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_from_date" DataType="DateTime" BindType="UIToDBOnly" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                                </div>
                                <label class="col-sm-1">-</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtToDt" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_to_date" DataType="DateTime" BindType="UIToDBOnly" Format="dd/MM/yyyy"></cc1:XUITextBox>
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
                </div>--%> <%--end div report--%>
        </div>
    </section>
</asp:Content>
