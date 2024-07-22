<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masteremailnotification.aspx.cs" Inherits="module_commonmst_masteremailnotification" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Email Notification Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R20000050C" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
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
                            <label class="col-sm-2">Code *</label>
                            <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="CODE" SPParameterName="p_code" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                          </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Description *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="200" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="valtxtDescription" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,200}$" ErrorMessage="Please enter a maximum of 200 characters" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Email Subject *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtEmailSubject" runat="server" CssClass="form-control" placeholder="Email Subject" DBColumnName="EMAIL_SUBJECT" SPParameterName="p_email_subject" MaxLength="100" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvEmailSubject" runat="server" ErrorMessage="Required Field!"  ControlToValidate="txtEmailSubject" Display="Dynamic"></asp:RequiredFieldValidator>
                          </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Email Body *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtEmailBody" runat="server" CssClass="form-control" placeholder="Email Body" DBColumnName="EMAIL_BODY" SPParameterName="p_email_body" MaxLength="4000" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvEmailBody" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtEmailBody" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="revEmailBody" ControlToValidate="txtEmailBody" ValidationExpression="^[\s\S]{0,4000}$" ErrorMessage="Please enter a maximum of 4000 characters" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Reply To</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtReplyTo" runat="server" CssClass="form-control" placeholder="Reply To" DBColumnName="REPLY_TO" SPParameterName="p_reply_to" MaxLength="100" DataType="String" BindType="Both"></cc1:XUITextBox>
                          </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Flag 1</label>
                            <div class="col-sm-5">
                                <cc1:XUIDropDownList ID="ddlFlag1" runat="server" CssClass="form-control" DBColumnName="FLAG_1" SPParameterName="p_flag_1" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlFlag1_OnSelectedIndexChanged">
                                <asp:ListItem Text="E-mail" Value="E"></asp:ListItem>
                                <asp:ListItem Text="Field" Value="F"></asp:ListItem>
                                <asp:ListItem Text="Field-Lookup" Value="L"></asp:ListItem>
                                <asp:ListItem Text="User" Value="U"></asp:ListItem>
                                </cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Email/Field/User *</label>
                            <div class="col-sm-8">
                                <cc1:XUITextBox ID="txtEmail1" runat="server" CssClass="form-control" placeholder="Email 1" DBColumnName="EMAIL_1" SPParameterName="p_email_1" MaxLength="100" DataType="String" BindType="Both"></cc1:XUITextBox>                            
                                <asp:RequiredFieldValidator ID="rfvEmail1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtEmail1" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEmail1" runat="server" ErrorMessage="Invalid Format Email" ControlToValidate="txtEmail1" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                    </div>
               </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Flag 2</label>
                            <div class="col-sm-5">
                                <cc1:XUIDropDownList ID="ddlFlag2" runat="server" CssClass="form-control" DBColumnName="FLAG_2" SPParameterName="p_flag_2" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlFlag2_OnSelectedIndexChanged">
                                <asp:ListItem Text="E-mail" Value="E"></asp:ListItem>
                                <asp:ListItem Text="Field" Value="F"></asp:ListItem>
                                <asp:ListItem Text="Field-Lookup" Value="L"></asp:ListItem>
                                <asp:ListItem Text="User" Value="U"></asp:ListItem>
                                </cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Email/Field/User</label>
                            <div class="col-sm-8">
                                <cc1:XUITextBox ID="txtEmail2" runat="server" CssClass="form-control" placeholder="Email 2" DBColumnName="EMAIL_2" SPParameterName="p_email_2" MaxLength="100" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="revEmail2" runat="server" ErrorMessage="Invalid Format Email" ControlToValidate="txtEmail2" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                    </div>
                </div> 
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Flag 3</label>
                            <div class="col-sm-5">
                                <cc1:XUIDropDownList ID="ddlFlag3" runat="server" CssClass="form-control" DBColumnName="FLAG_3" SPParameterName="p_flag_3" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlFlag3_OnSelectedIndexChanged">
                                <asp:ListItem Text="E-mail" Value="E"></asp:ListItem>
                                <asp:ListItem Text="Field" Value="F"></asp:ListItem>
                                <asp:ListItem Text="Field-Lookup" Value="L"></asp:ListItem>
                                <asp:ListItem Text="User" Value="U"></asp:ListItem>
                                </cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Email/Field/User</label> 
                            <div class="col-sm-8">
                                <cc1:XUITextBox ID="txtEmail3" runat="server" CssClass="form-control" placeholder="Email 3" DBColumnName="EMAIL_3" SPParameterName="p_email_3" MaxLength="100" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="revEmail3" runat="server" ErrorMessage="Invalid Format Email" ControlToValidate="txtEmail3" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Flag 4</label>
                            <div class="col-sm-5">
                                <cc1:XUIDropDownList ID="ddlFlag4" runat="server" CssClass="form-control" DBColumnName="FLAG_4" SPParameterName="p_flag_4" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlFlag4_OnSelectedIndexChanged">
                                <asp:ListItem Text="E-mail" Value="E"></asp:ListItem>
                                <asp:ListItem Text="Field" Value="F"></asp:ListItem>
                                <asp:ListItem Text="Field-Lookup" Value="L"></asp:ListItem>
                                <asp:ListItem Text="User" Value="U"></asp:ListItem>
                                </cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Email/Field/User</label>
                            <div class="col-sm-8">
                                <cc1:XUITextBox ID="txtEmail4" runat="server" CssClass="form-control" placeholder="Email 4" DBColumnName="EMAIL_4" SPParameterName="p_email_4" MaxLength="100" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="revEmail4" runat="server" ErrorMessage="Invalid Format Email" ControlToValidate="txtEmail4" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Flag 5</label>
                            <div class="col-sm-5">
                                <cc1:XUIDropDownList ID="ddlFlag5" runat="server" CssClass="form-control" DBColumnName="FLAG_5" SPParameterName="p_flag_5" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlFlag5_OnSelectedIndexChanged">
                                <asp:ListItem Text="E-mail" Value="E"></asp:ListItem>
                                <asp:ListItem Text="Field" Value="F"></asp:ListItem>
                                <asp:ListItem Text="Field-Lookup" Value="L"></asp:ListItem>
                                <asp:ListItem Text="User" Value="U"></asp:ListItem>
                                </cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Email/Field/User</label>
                            <div class="col-sm-8">
                                <cc1:XUITextBox ID="txtEmail5" runat="server" CssClass="form-control" placeholder="Email 5" DBColumnName="EMAIL_5" SPParameterName="p_email_5" MaxLength="100" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="revEmail5" runat="server" ErrorMessage="Invalid Format Email" ControlToValidate="txtEmail5" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
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