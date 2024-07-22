<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastermenu.aspx.cs" Inherits="module_commonmst_mastermenu" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Menu Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R20000010E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
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
                            <div class="col-sm-4">
                                <cc1:XUILabel ID="lblMenuId" runat="server"  DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text="0" style="display:none"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>             
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Code *</label>
                            <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtCode" runat="server" placeholder="Code" CssClass="form-control" DBColumnName="CODE" SPParameterName="p_code" MaxLength="8" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>                                
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Description *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtName" runat="server"  CssClass="form-control" placeholder="Name" DBColumnName="NAME" SPParameterName="p_name" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtName" Display="Dynamic"></asp:RequiredFieldValidator>                                
                            </div>
                        </div>                            
                    </div>
                </div> 
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Module *</label>
                            <div class="col-sm-4">
                                <asp:LinkButton runat="server" ID="btnLookUpModule" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtModule" style="display:none" runat="server"  CssClass="form-control" placeholder="Module Code" DBColumnName="MODULE_CODE" SPParameterName="p_module_code" MaxLength="8" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblModule" runat="server"  DBColumnName="MODULE_CODE" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblModuleDesc" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                <asp:RequiredFieldValidator ID="rfvModul"  runat="server" ErrorMessage="Required Field!" ControlToValidate="txtModule" Display="Dynamic"></asp:RequiredFieldValidator>                                                                 
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Parent</label>                                
                            <div class="col-sm-4">         
                                <asp:LinkButton runat="server" ID="btnLookUpParent" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                           
                                <cc1:XUITextBox ID="txtId" style="display:none" runat="server"  CssClass="form-control" placeholder="Parent ID" DBColumnName="PARENT_ID" SPParameterName="p_parent_id" MaxLength="8" DataType="Integer" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblId" runat="server"  DBColumnName="PARENT_ID" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblName" runat="server"  DBColumnName="PARENT_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                <%--<asp:RequiredFieldValidator ID="rfvRoleCode"  runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRoleCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>                                                                 
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Role Code *</label>
                            <div class="col-sm-4">
                                <asp:LinkButton runat="server" ID="btnLookUpRole" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtRoleCode" style="display:none" runat="server"  CssClass="form-control" placeholder="Role Code" DBColumnName="ROLE_CODE" SPParameterName="p_role_code" MaxLength="8" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblRoleCode" runat="server"  DBColumnName="ROLE_CODE" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblRoleDesc" runat="server"  DBColumnName="ROLE_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                <asp:RequiredFieldValidator ID="rfvRoleCode"  runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRoleCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>    
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">URL</label>                                
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtURL" runat="server"  CssClass="form-control" placeholder="URL" DBColumnName="URL" SPParameterName="p_url" MaxLength="200" DataType="String" BindType="Both"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                </div>   
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">CSS Class</label>                                
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtCSSClass" runat="server"  CssClass="form-control" placeholder="CSS Class" DBColumnName="CSS_CLASS" SPParameterName="p_css_class" MaxLength="200" DataType="String" BindType="Both"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                   <div class="col-sm-12">
                       <div class="form-group">
                            <label class="col-sm-2">Status</label>
                            <div class="col-sm-4">
                                <cc1:XUICheckBox ID="chbIsActive" runat="server" DBColumnName="IS_ACTIVE_FLAG" SPParameterName="p_is_active_flag" DataType="String" BindType="Both"></cc1:XUICheckBox>
                            </div>
                        </div>                            
                    </div>
                </div>              
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>   
</asp:Content>
