<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="setting.aspx.cs" Inherits="setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Widget List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <asp:LinkButton runat="server" ID="btnSubscriptionWidget" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</asp:LinkButton>
                    <asp:LinkButton ID="btnDeleteSubscribeWidget" runat="server" CssClass="btn btn-danger" onclick="btnDeleteSubscribeWidget_OnClick"><i class="icon-trash"></i>  Delete</asp:LinkButton> 
                </div>
                <div class="col-sm-4">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearchWidget" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchWidget" runat="server" CssClass="btn btn-info" OnClick="btnSearchWidget_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListWidget" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="WIDGET_CODE"
                        OnPageIndexChanging="gvwListWidget_PageIndexChanging" 
                        onselectedindexchanged="gvwListWidget_SelectedIndexChanged" EmptyDataText="There Is No Data">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox runat="server" ID="chbWidgetCheckedAll" AutoPostBack="true" OnCheckedChanged="chbWidgetCheckedAll_CheckedChanged"/>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chbWidgetChecked"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="WIDGET_DESC" HeaderText="Widget">
                                <ItemStyle Width="90%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ORIENTATION" HeaderText="Orientation">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchWidget" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteSubscribeWidget" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    
    <section class="panel">
        <header class="panel-heading">
          <span>Notification List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                        <!-- Subscription pop up here-->
                        <asp:LinkButton runat="server" ID="btnSubscriptionNotifi" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</asp:LinkButton>
                        <asp:LinkButton ID="btnDeleteSubscribeNotifi" runat="server" 
                             CssClass="btn btn-danger" onclick="btnDeleteSubscribeNotifi_OnClick"><i class="icon-trash"></i>  Delete</asp:LinkButton>                                      
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <asp:TextBox ID="txtSearchNotif" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                            <div class="input-group-btn">
                                <asp:LinkButton ID="btnSearchNotif" runat="server" CssClass="btn btn-info" OnClick="btnSearchNotif_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <asp:UpdatePanel ID="updNotifi" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvwListNotifi" runat="server" 
                            AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                            AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListNotifi_PageIndexChanging"
                            DataKeyNames="NOTIFI_CODE" EmptyDataText="There is no data">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox runat="server" ID="chbNotifiCheckedAll" AutoPostBack="true" OnCheckedChanged="chbWidgetCheckedAll_CheckedChanged"/>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chbNotifiChecked"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="NOTIFI_DESC" HeaderText="Notification">
                                    <ItemStyle Width="40%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NOTIFI_MESSAGE" HeaderText="Message">
                                    <ItemStyle Width="60%" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSearchNotif" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnDeleteSubscribeNotifi" EventName="Click" />
                    </Triggers>                            
                </asp:UpdatePanel>
            </div>  
    </section>
</asp:Content>