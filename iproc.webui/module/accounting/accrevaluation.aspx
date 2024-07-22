<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accrevaluation.aspx.cs" Inherits="module_accounting_accrevaluation" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Revaluation Process</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnProcess" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-certificate"></i>  Calculate</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnApproved" runat="server" CssClass="btn btn-primary" OnClick="btnApproved_Click" CausesValidation="false"><i class="icon-level-up"></i>  Approved</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-3">
                            <label >Acc. Period</label>
                        </div>
                        <div class="col-sm-6">
                            <div class="input-group">
                                <asp:TextBox ID="txtYearPeriod" runat="server" CssClass="form-control" placeholder="Year" MaxLength="4" Width="70"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvYearPeriod" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtYearPeriod" Display="Dynamic"></asp:RequiredFieldValidator>
                                 <asp:DropDownList ID="ddlMonthPeriod" runat="server" CssClass="form-control" placeholder="Month" MaxLength="2" Width="70"></asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="rfvMonthPeriod" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlMonthPeriod" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-3">
                            <label>Reval. Date</label>
                        </div>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtRevalDate" runat="server" CssClass="form-control default-date-picker" SPParameterName="p_reval_date" DataType="DateTime" BindType="UIToDBOnly" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-3">
                            <label>Reval Rate</label>
                        </div>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtRevalRate" runat="server" CssClass="form-control" SPParameterName="p_reval_rate" DataType="Number" Format="N2" BindType="UIToDBOnly"></cc1:XUITextBox> 
                        </div>
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="ACC_NO"
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
                                 <asp:BoundField DataField="ACC_NO" HeaderText="Account No" >
                                    <ItemStyle Width="20%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="ACC_NAME" HeaderText="Account Name">
                                    <ItemStyle Width="25%" HorizontalAlign="Center" />
                                </asp:BoundField> 
                                <asp:BoundField DataField="ACC_CURR" HeaderText="Curr">
                                    <ItemStyle Width="5%" HorizontalAlign="Center" />
                                </asp:BoundField> 
                                  <asp:BoundField DataField="BALANCE_FOREX_TB" HeaderText="Balance Forex" DataFormatString="{0:N2}">
                                    <ItemStyle Width="15%" HorizontalAlign="Right" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="BALANCE_BASE_TB" HeaderText="Prior" DataFormatString="{0:N2}">
                                    <ItemStyle Width="15%" HorizontalAlign="Right" />
                                </asp:BoundField> 
                                <asp:BoundField DataField="BALANCE_REVAL" HeaderText="After" DataFormatString="{0:N2}">
                                    <ItemStyle Width="10%" HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="REVAL_AMOUNT" HeaderText="Gain/Loss" DataFormatString="{0:N2}">
                                    <ItemStyle Width="10%" HorizontalAlign="Right" />
                                </asp:BoundField> 
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
          </asp:UpdatePanel>
         </div>
    </section>
</asp:Content>

