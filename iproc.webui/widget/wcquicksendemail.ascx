<%@ Control Language="C#" AutoEventWireup="true" CodeFile="wcquicksendemail.ascx.cs" Inherits="widget_wcquicksendemail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<section class="panel">
    <header class="panel-heading">
      <span>Quick Send Email</span>
    </header>        
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12">
                <cc1:XUILabel ID="lblEmpCode" runat="server" SPParameterName="p_emp_code" DataType="String" BindType="UIToDBOnly" style="display:none"></cc1:XUILabel>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">Sent From</span>
                            <div class="col-sm-9">
                                <cc1:XUIRadioButtonList ID="rblEmailOption" runat="server" SPParameterName="p_email_option" DataType="String" BindType="UIToDBOnly">
                                    <asp:ListItem Value="1" Selected="True" Text="  Primary Email"></asp:ListItem>
                                    <asp:ListItem Value="0" Text="  Other Email"></asp:ListItem>
                                </cc1:XUIRadioButtonList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">To</span>
                            <asp:RequiredFieldValidator ID="rfvTo" runat="server" ErrorMessage="*" ControlToValidate="txtTo" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtTo" runat="server" CssClass="form-control" placeholder="Send To" SPParameterName="p_send_to" MaxLength="200" DataType="String" BindType="UIToDBOnly" ></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">Title</span>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Email Title" SPParameterName="p_email_title" MaxLength="200" DataType="String" BindType="UIToDBOnly" ></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">Body</span>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtBody" runat="server" CssClass="form-control" placeholder="Email Body" SPParameterName="p_email_body" MaxLength="1000" DataType="String" BindType="UIToDBOnly" TextMode="MultiLine"></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>                
                </div>
            </div>
        </div>
    </div>
    
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12">
                <asp:LinkButton ID="btnSend" runat="server" CssClass="btn btn-primary" OnClick="btnSend_Click"><i class="icon-mail"></i>  Send Email</asp:LinkButton>
            </div>
        </div>
    </div>
</section>