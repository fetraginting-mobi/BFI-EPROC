<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterusermaingroup.aspx.cs" Inherits="module_user_masterusermaingroup" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>User Group Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
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
                                    <cc1:XUILabel ID="lblUID" runat="server" DBColumnName="UID" SPParameterName="p_uid" DataType="String" BindType="Both"></cc1:XUILabel>
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
                                <label class="col-sm-2">Group</label>
                                <div class="col-sm-5">
                                    <asp:LinkButton runat="server" ID="btnLookUpGroup" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                            
                                    <cc1:XUITextBox ID="txtGroupCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="CODE" SPParameterName="p_group_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblGroupCode" runat="server"  DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblGroupName" runat="server"  DBColumnName="NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
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

