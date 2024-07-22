<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="approvaltypelevelperson.aspx.cs" Inherits="module_approval_approvaltypelevelperson" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Approval Type Level Person Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R40000040E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <div class="row">
                <div class="col-sm-6">
                    <cc1:XUILabel ID="lblLevelID" runat="server" DBColumnName="LEVEL_ID" SPParameterName="p_level_id" DataType="String" BindType="Both" style="display:none" ></cc1:XUILabel>                         
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4"></label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text="0" style="display:none"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Employee</label>
                        
                        <div class="col-sm-8">
                            <asp:LinkButton runat="server" ID="btnLookUpUID" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                            <cc1:XUITextBox ID="txtUIDCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="UID" SPParameterName="p_uid" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblUIDCode" runat="server"  DBColumnName="EMP_CODE" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblUIDName" runat="server"  DBColumnName="EMP_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <asp:RequiredFieldValidator ID="rfvUIDCode" runat="server"  ErrorMessage="Required" ControlToValidate="txtUIDCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Compulsory</label>
                        <div class="col-sm-8">
                            <cc1:XUICheckBox ID="chbIsCompulsory" runat="server" DBColumnName="IS_COMPULSORY" SPParameterName="p_is_compulsory" DataType="String" BindType="Both"></cc1:XUICheckBox>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Max Day</label>
                        <asp:RequiredFieldValidator ID="rfvMaxDay" runat="server" ErrorMessage="Required" ControlToValidate="txtMaxDay" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revMaxDay" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMaxDay" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtMaxDay" runat="server" CssClass="form-control" placeholder="Max Day" DBColumnName="MAX_DAY" SPParameterName="p_max_day" MaxLength="3" DataType="Integer" BindType="Both" ></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Action On Max Day</label>
                        <div class="col-sm-8">
                            <cc1:XUIRadioButtonList ID="rblAction" runat="server" DBColumnName="ACTION_ON_MAX_DAY" SPParameterName="p_action_on_max_day" DataType="String" BindType="Both" RepeatDirection="Horizontal" >
                                <asp:ListItem Value="D">Delegate Upper &nbsp</asp:ListItem>
                                <asp:ListItem Value="A" Selected="True">Auto Approve</asp:ListItem>
                            </cc1:XUIRadioButtonList>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Notification Method</label>
                        <div class="col-sm-8">
                            <cc1:XUIRadioButtonList ID="rblNotif" runat="server" DBColumnName="NOTIF_METHOD" SPParameterName="p_notif_method" DataType="String" BindType="Both" RepeatDirection="Horizontal">
                                <asp:ListItem Value="S">SMS &nbsp</asp:ListItem>
                                <asp:ListItem Value="E" Selected="True">Email &nbsp</asp:ListItem>
                                <asp:ListItem Value="B">Both</asp:ListItem>
                            </cc1:XUIRadioButtonList>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Flag UID</label>
                        <div class="col-sm-8">
                             <cc1:XUIRadioButtonList ID="rblFlagUID" runat="server" DBColumnName="FLAG_UID" SPParameterName="p_flag_uid" DataType="String" BindType="Both" RepeatDirection="Horizontal" >
                                <asp:ListItem Value="A" Selected="True">Atasan &nbsp</asp:ListItem>
                                <asp:ListItem Value="S">Specific</asp:ListItem>
                            </cc1:XUIRadioButtonList>
                        </div>
                    </div>                            
                </div>
            </div>
        </div>
    </section>
</asp:Content>


