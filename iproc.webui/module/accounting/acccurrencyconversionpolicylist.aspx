<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="acccurrencyconversionpolicylist.aspx.cs" Inherits="module_accounting_acccurrencyconversionpolicylist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Currency Conversion Policy</span>
        </header>
        <header class="panel-heading tab-bg-dark-navy-blue">
          <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#reval" data-toggle="tab">Conversion</a>
              </li>
              <li class="">
                  <a href="#gain" data-toggle="tab">Unrealised Gain/Loss A/C</a>
              </li>
          </ul>
        </header>
         <div class="panel-body">
            <asp:UpdatePanel ID="updMain" runat="server">
                <ContentTemplate>
                    <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="reval">
                    <div class="row">
                        <div class="col-sm-6">
                            <cc1:XUILinkButton ID="btnAdd" RoleCode="R12000020C" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Add</cc1:XUILinkButton>                            
                        </div>
                        <div class="col-sm-6">
                            <cc1:XUILinkButton ID="btnDelete" RoleCode="R12000020D" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                        </div>
                    </div>  
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group"></div>
                        </div>
                    </div>
                    <div class ="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <label class="col-sm-4">Forex A/C</label>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <label class="col-sm-4">A/C Revalue</label>
                            </div>
                        </div>
                    </div>
                    <%--!!!!!--%>
                    <div class="row">
                        <div class="col-sm-6">
                        <%--TEST--%>    
                        <asp:GridView ID="gvwListAcc" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="ACC_NO" OnPageIndexChanging="gvwListAcc_PageIndexChanging" onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data">
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
                                <asp:BoundField DataField="ACC_NO" HeaderText="A/C No.">
                                    <ItemStyle Width="30%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="ACC_CURR" HeaderText="Curr.">
                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ACC_NAME" HeaderText="A/C Name">
                                    <ItemStyle Width="60%" HorizontalAlign="Left" />
                               </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        </div>
                        <div class="col-sm-6">
                        <asp:GridView ID="gvwListReval" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" DataKeyNames="ACC_NO" OnPageIndexChanging="gvwListReval_PageIndexChanging" EmptyDataText="There is no data">
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
                                <asp:BoundField DataField="ACC_NO" HeaderText="A/C No.">
                                    <ItemStyle Width="30%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="ACC_CURR" HeaderText="Curr.">
                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ACC_NAME" HeaderText="A/C Name">
                                    <ItemStyle Width="60%" HorizontalAlign="Left" />
                               </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        </div>
                    </div>  
                </div>
                <div class="tab-pane" id="gain">
                    <div class="row">
                        <div class="col-sm-8">
                            <cc1:XUILinkButton ID="btnAddClass" RoleCode="R12000020E" runat="server" CssClass="btn btn-primary" OnClick="btnAddClass_Click" CausesValidation="false"><i class="icon-plus"></i>  Add</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDeleteClass" RoleCode="R12000020E" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteClass_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                        </div>
                         <div class="col-sm-4">
                            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchClass" class="input-group">
                                <asp:TextBox ID="txtSearchClass" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchClass" runat="server" CssClass="btn btn-info" OnClick="btnSearchClass_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>   
                            </asp:Panel>
                         </div>
                    </div>
                    <div>
                        <div class="form-group"></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <%--<asp:UpdatePanel ID="updGainLoss" runat="server">
                                <ContentTemplate>--%>
                                    <asp:GridView ID="gvwGainLoss" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                        AllowPaging="true"  DataKeyNames="ID" EmptyDataText="There is no data"  onselectedindexchanged="SelectedIndexChanged">                                           
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
                                                <asp:BoundField DataField="CURRENCY" HeaderText="Curr.">
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ACC_NO" HeaderText="A/C No.">
                                                    <ItemStyle Width="30%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ACC_NAME" HeaderText="A/C Name">
                                                    <ItemStyle Width="60%" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:CommandField ShowSelectButton="true" />    
                                           </Columns>
                                    </asp:GridView>
                                <%--</ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnDeleteClass" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnAddClass" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnSearchClass" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>--%>
                        </div>
                    </div>   
                </div>
            </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

