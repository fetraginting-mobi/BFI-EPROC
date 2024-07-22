<%@ Control Language="C#" AutoEventWireup="true" CodeFile="wcbasicinfo.ascx.cs" Inherits="widget_wcbasicinfo" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<section class="panel">
    <header class="panel-heading">
      <span>Basic Info</span>
    </header>        
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12">
                <cc1:XUILabel ID="lblEmpCode" runat="server" DBColumnName="EMP_CODE" SPParameterName="p_emp_code" DataType="String" BindType="Both" style="display:none"></cc1:XUILabel>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">Address</span>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="*" ControlToValidate="txtAddress" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" DBColumnName="ADDRESS" SPParameterName="p_address" MaxLength="400" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">City</span>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="*" ControlToValidate="txtCity" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City" DBColumnName="CITY" SPParameterName="p_city" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">Post Code</span>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Post Code" DBColumnName="POST_CODE" SPParameterName="p_post_code" MaxLength="10" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>                
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">Phone</span>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone No" DBColumnName="PHONE_NO" SPParameterName="p_phone_no" MaxLength="15" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">HP</span>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtHP" runat="server" CssClass="form-control" placeholder="Handphone No" DBColumnName="HANDPHONE_NO" SPParameterName="p_handphone_no" MaxLength="15" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">Email</span>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" DBColumnName="EMAIL" SPParameterName="p_email" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <span class="col-sm-3">Other Email</span>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtEmail2" runat="server" CssClass="form-control" placeholder="Other Email" DBColumnName="EMAIL2" SPParameterName="p_email2" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
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
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Change Data</asp:LinkButton>
                <asp:LinkButton ID="btnClear" runat="server" CssClass="btn btn-primary" OnClick="btnClear_Click" CausesValidation="false"><i class="icon-delete"></i>  Clear Data</asp:LinkButton>
            </div>
        </div>
    </div>
</section>