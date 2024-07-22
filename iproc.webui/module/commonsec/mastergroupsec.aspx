<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="mastergroupsec.aspx.cs" Inherits="module_commonsec_mastergroupsec" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Group Security Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">   
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>        
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Code</label>                                
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtCode" runat="server"  CssClass="form-control" placeholder="Code" DBColumnName="CODE" SPParameterName="p_code" MaxLength="8" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtName" runat="server"  CssClass="form-control" placeholder="Name" DBColumnName="NAME" SPParameterName="p_name" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtName" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Multiplebranch</label>
                                <div class="col-sm-5">
                                    <cc1:XUICheckBox runat="server" ID="chbIsAgas" DBColumnName="MULTIPLEBRANCH" SPParameterName="p_multiplebranch" BindType="Both" DataType="String"/>
                                    <cc1:XUITextBox ID="txtIsAgas" runat="server"  CssClass="form-control" DBColumnName="MULTIPLEBRANCH" SPParameterName="p_multiplebranch" BindType="DBToUIOnly" Visible="false"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>       
                </ContentTemplate>
                <%--<Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" /> 
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>--%>
            </asp:UpdatePanel>  
        </div>
    </section>
          
    <section class="panel">
        <header class="panel-heading">
            <span>Group Role Security List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                     <cc1:XUILinkButton RoleCode="" ID="btnSaveGroupRole" runat="server" CssClass="btn btn-primary" OnClick="btnSaveGroupRole_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListRoleSec" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="false" DataKeyNames="CODE, APPLICATION_CODE" EmptyDataText="There is no data" 
                        onrowdatabound="gvwListRoleSec_RowDataBound" OnRowCreated="gvwListRoleSec_RowDataCreated">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>  
                            <asp:BoundField DataField="APPLICATION_CODE" HeaderText="Application">
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="NAME" HeaderText="Module Name">
                                <ItemStyle Width="40%" />
                            </asp:BoundField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <span>Create</span>
                                    <asp:CheckBox runat="server" ID="chbCreateAll" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <cc1:XUICheckBox runat="server" ID="chbCreate" SPParameterName="p_allow" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <span>Delete</span>
                                    <asp:CheckBox runat="server" ID="chbDeleteAll" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <cc1:XUICheckBox runat="server" ID="chbDelete" SPParameterName="p_allow" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <span>Edit</span>
                                    <asp:CheckBox runat="server" ID="chbEditAll"  />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <cc1:XUICheckBox runat="server" ID="chbEdit" SPParameterName="p_allow" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <span>Process</span>
                                    <asp:CheckBox runat="server" ID="chbProsessAll"  />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <cc1:XUICheckBox runat="server" ID="chbProsess" SPParameterName="p_allow" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                             <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <span>Print</span>
                                    <asp:CheckBox runat="server" ID="chbPrintAll"  />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <cc1:XUICheckBox runat="server" ID="chbPrint" SPParameterName="p_allow" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSaveGroupRole" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>     
    </section>
</asp:Content>