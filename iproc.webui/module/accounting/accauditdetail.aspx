<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accauditdetail.aspx.cs" Inherits="module_accounting_accauditdetail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>Audit Detail Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R12000090E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton> 
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                    <div class="row" style="display:none">
                <div class="col-sm-6">
                    <div class="col-sm-12">
                        <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" SPParameterName="p_jm_status" DataType="String" BindType="Both" Text="------"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblAuditNo" runat="server" DBColumnName="AUDIT_NO" SPParameterName="p_audit_no" DataType="String" BindType="Both" Text="------"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblID" runat="server" DataType="String" SPParameterName="p_id" DBColumnName="ID" BindType="Both" ></cc1:XUILabel>
                    </div>
                </div>
            </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Debit Or Credit *</label>
                        <div class="col-sm-5">
                            <cc1:XUIRadioButtonList ID="rblDebitOrCredit" runat="server" DBColumnName="DEBIT_OR_CREDIT" SPParameterName="p_debit_or_credit" DataType="String" BindType="Both" RepeatDirection="Horizontal">
                                <asp:ListItem Value="D" Text="  Debit&nbsp&nbsp"></asp:ListItem>
                                <asp:ListItem Value="C" Text="  Credit"></asp:ListItem>
                            </cc1:XUIRadioButtonList>
                            <asp:RequiredFieldValidator ID="rfvDebitOrCredit" runat="server" ErrorMessage="Required Field!" ControlToValidate="rblDebitOrCredit" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Chart Of Account *</label>
                        <div class="col-sm-8">
                            <asp:LinkButton runat="server" ID="btnLookUpAccChart" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                            <cc1:XUITextBox ID="txtAccNo" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ACC_NO" SPParameterName="p_acc_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblAccNo" runat="server" DBColumnName="ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <asp:RequiredFieldValidator ID="rfvtxtAccNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccNo" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>                             
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Exch Rate</label>                        
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtRate" runat="server" CssClass="form-control" placeholder="Exch Rate" DBColumnName="EXCH_RATE" SPParameterName="p_exch_rate"  DataType="Number" Format="N2"  BindType="Both" Enabled = "false"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Division</label>
                        <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISI" SPParameterName="p_divisi" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                          <%--<cc1:XUILabel ID="lblDivision" runat="server" DBColumnName="DIVISION_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>  --%>                     
                        </div>
                    </div>                             
                </div>                                             
            </div>                
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Orig Amount *</label>     
                         <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtOrigCurr" runat="server" CssClass="form-control" placeholder="Currency" DBColumnName="ORIG_CURRENCY" SPParameterName="p_orig_currency" MaxLength="3" DataType="String" BindType="Both" Enabled = "false"></cc1:XUITextBox>
                        </div>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtOrigAmount" runat="server" CssClass="form-control" placeholder="Orig Amount" DBColumnName="ORIG_AMOUNT" SPParameterName="p_orig_amount" MaxLength="14" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvDebitAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtOrigAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revDebitAmount" runat="server" ErrorMessage="Format Invalid!" MinValue="0" ControlToValidate="txtOrigAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Department</label>
                        <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT" SPParameterName="p_department" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                          <%--<cc1:XUILabel ID="lblDepartement" runat="server" DBColumnName="DEPARTEMENT_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel> --%>     
                        <%--   <cc1:XUILabel ID="lblASU" runat="server" DBColumnName="DIVISION_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>    --%>               
                        </div>
                    </div>                             
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Base Amount</label>
                        <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtBaseCurr" runat="server" CssClass="form-control" placeholder="Currency" DBColumnName="BASE_CURRENCY" SPParameterName="p_base_currency" MaxLength="3" DataType="String" BindType="Both" Enabled = "false"></cc1:XUITextBox>
                        </div>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtBbaseAmount" runat="server" CssClass="form-control" placeholder="Base Amount" DBColumnName="BASE_AMOUNT" SPParameterName="p_base_amount" MaxLength="14" DataType="Number" Format="N2" BindType="Both" Text="0" Enabled="false"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Description</label>
                        
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="350" DataType="String" BindType="Both" TextMode="MultiLine" ></cc1:XUITextBox>
                            <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,350}$" ErrorMessage="Exceed maximum length 350" Display="Dynamic"></asp:RegularExpressionValidator>
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

