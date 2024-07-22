<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterusermain.aspx.cs" Inherits="module_user_masterusermain" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>User</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Back</asp:LinkButton>
                    <asp:LinkButton ID="btnActive" runat="server" CssClass="btn btn-primary" OnClick="btnActive_Click"><i class="icon-save"></i>  Re-Active</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
             <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">User ID</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12"> 
                            <div class="form-group">
                                <label class="col-sm-2">User Name</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblName" runat="server" DBColumnName="EMP_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Status</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblIsActive" runat="server" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" style="display:none"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
             </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnActive" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>   
       
    <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
          <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#group" data-toggle="tab">
                      Group
                  </a>
              </li>
              <li class="">
                  <a href="#loginlog" data-toggle="tab">
                      Login Log
                  </a>
              </li>
              <li class="">
                  <a href="#activitylog" data-toggle="tab">
                      Activity Log
                  </a>
              </li>
          </ul>
        </header>
        <div class="panel-body">
            <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="group">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <asp:LinkButton ID="btnAddGroup" runat="server" CssClass="btn btn-primary" OnClick="btnAddGroup_Click"><i class="icon-plus"></i>  Create</asp:LinkButton>
                                <asp:LinkButton ID="btnDeleteGroup" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteGroup_Click"><i class="icon-trash"></i>  Delete</asp:LinkButton>
                            </div>                                    
                        </div>
                    </div>                            
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updGroup" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListGroup" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="UID, GROUP_CODE" OnPageIndexChanging="gvwListGroup_PageIndexChanging" onselectedindexchanged="gvwListGroup_SelectedIndexChanged" EmptyDataText="There is no data">
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
                                        <asp:BoundField DataField="NAME" HeaderText="Group">
                                            <ItemStyle Width="100%" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>                                        
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteGroup" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>  
                </div>        
                           
                <div class="tab-pane" id="loginlog">                            
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-6" >
                                <div class="input-group">
                                     <asp:TextBox ID="txtYearLoginLog" runat="server" CssClass="form-control" placeholder="Year" MaxLength="4" Width="70"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="rfvYearLoginLog" runat="server" ErrorMessage="*" ControlToValidate="txtYearLoginLog" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:TextBox ID="txtMonthLoginLog" runat="server" CssClass="form-control" placeholder="Month" MaxLength="2" Width="70"></asp:TextBox>   
                                     <asp:RequiredFieldValidator ID="rfvMonthLoginLog" runat="server" ErrorMessage="*" ControlToValidate="txtMonthLoginLog" Display="Dynamic"></asp:RequiredFieldValidator>                                                                    
                                     <asp:LinkButton ID="btnViewGvwListLoginLog" runat="server" CssClass="btn btn-primary" onclick="btnViewGvwListLoginLog_OnClick"><i class="icon-plus"></i>  View</asp:LinkButton>                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updLoginLog" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListLoginLog" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" DataKeyNames="ID" OnPageIndexChanging="gvwListLoginLog_PageIndexChanging"
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
                                        <asp:BoundField DataField="LOGIN_DATE" HeaderText="Login Date" DataFormatString="{0:dd/MM/yyyy HH:mm}">
                                            <ItemStyle Width="40%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="IP_ADDRESS" HeaderText="IP Address">
                                            <ItemStyle Width="40%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FLAG_CODE" HeaderText="Status">
                                            <ItemStyle Width="20%"/>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnViewGvwListLoginLog" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                
                <div class="tab-pane" id="activitylog">                            
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-6" >
                                <div class="input-group">
                                     <asp:TextBox ID="txtYearActivityLog" runat="server" CssClass="form-control" placeholder="Year" MaxLength="4" Width="70"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="rfvYearActivityLog" runat="server" ErrorMessage="*" ControlToValidate="txtYearActivityLog" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:TextBox ID="txtMonthActivityLog" runat="server" CssClass="form-control" placeholder="Month" MaxLength="2" Width="70"></asp:TextBox>   
                                     <asp:RequiredFieldValidator ID="rfvMonthActivityLog" runat="server" ErrorMessage="*" ControlToValidate="txtMonthActivityLog" Display="Dynamic"></asp:RequiredFieldValidator>                                                                    
                                     <asp:LinkButton ID="btnViewGvwListActivityLog" runat="server" CssClass="btn btn-primary" onclick="btnViewGvwListActivityLog_OnClick"><i class="icon-plus"></i>  View</asp:LinkButton>                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updActivityLog" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListActivityLog" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" DataKeyNames="ID" OnPageIndexChanging="gvwListActivityLog_PageIndexChanging"
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
                                        <asp:BoundField DataField="ACTIVITY_DATE" HeaderText="Activity Date" DataFormatString="{0:dd/MM/yyyy HH:mm}">
                                            <ItemStyle Width="20%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACTIVITY_TYPE_CODE" HeaderText="Activity Type">
                                            <ItemStyle Width="20%"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="REMARK" HeaderText="Remark">
                                            <ItemStyle Width="60%"/>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnViewGvwListActivityLog" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>          
    </section> 
</asp:Content>
