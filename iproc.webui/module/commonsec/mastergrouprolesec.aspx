<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastergrouprolesec.aspx.cs" Inherits="module_commonsec_mastergrouprolesec" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Group Role Security Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                      <cc1:XUILinkButton ID="btnSaveGroupRole" RoleCode="R40000020E" runat="server" CssClass="btn btn-primary" OnClick="btnSaveGroupRole_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                      <cc1:XUILinkButton ID="btnCancelGroupRole" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancelGroupRole_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">             
            <asp:Panel ID="pnlGroupRole" runat="server">                                 
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Group Code</label>                                
                        <div class="col-sm-4">
                            <cc1:XUILabel ID="lblGroupCode" runat="server" DBColumnName="GROUP_CODE" SPParameterName="p_group_code" DataType="String" BindType="Both"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
            </div>
            <asp:Panel ID="pnlGroupName" runat="server">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Group Description</label>                                
                            <div class="col-sm-4">
                                <cc1:XUILabel ID="lblGroupName" runat="server" DBColumnName="NAME" SPParameterName="p_name" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
            </asp:Panel>
                <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Role Code</label>
                        <asp:RequiredFieldValidator ID="rfvRoleCode"  runat="server" ErrorMessage="*" ControlToValidate="txtRoleCode" Display="Dynamic"></asp:RequiredFieldValidator>                                 
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtRoleCode" style="display:none" runat="server"  CssClass="form-control" placeholder="Role Code" DBColumnName="ROLE_CODE" SPParameterName="p_role_code" MaxLength="8" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblRoleCode" runat="server"  DBColumnName="ROLE_CODE" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblRoleDesc" runat="server"  DBColumnName="ROLE_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <asp:LinkButton runat="server" ID="btnLookUpRole" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                        </div>
                    </div>                             
                </div>
            </div>
          </asp:Panel>   
        </div>
    </section>                       
</asp:Content>
