<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastercreditortypelinkacc.aspx.cs" Inherits="module_commonmst_mastercreditortypelinkacc" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Creditor Type Link A/C Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000140E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
             <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Creditor Type Code</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblCreditorTypeCode" runat="server" DBColumnName="CREDITORTYPE_CODE" SPParameterName="p_creditortype_code" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Currency Code *</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlCurrency" runat="server" CssClass="form-control" placeholder="Currency" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">AP ACC No. *</label>
                                <div class="col-sm-7">
                                     <asp:LinkButton runat="server" ID="btnLookUpCapyCOA"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtCapyAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Capy COA" DBColumnName="CAPY_ACC" SPParameterName="p_capy_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                      <cc1:XUITextBox ID="txtCapyPad" style="display:none" runat="server" CssClass="form-control" DBColumnName="CAPY_PAD" SPParameterName="p_capy_pad" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblCapyAcc"  runat="server" DBColumnName="CAPY_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> -
                                     <cc1:XUILabel ID="lblNameCapyAcc"  runat="server"  DBColumnName="CAPY_ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCapyAcc" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Advance ACC No. *</label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpAdvanceAcc"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtAdvanceAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Advance COA" DBColumnName="ADVANCE_ACC" SPParameterName="p_advance_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                       <cc1:XUITextBox ID="txtAdvancePad" style="display:none" runat="server" CssClass="form-control" DBColumnName="ADVANCE_PAD" SPParameterName="p_advance_pad" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAdvanceAcc"  runat="server" DBColumnName="ADVANCE_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> -
                                    <cc1:XUILabel ID="lblNameAdvanceAcc"  runat="server"  DBColumnName="ADVANCE_ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAdvanceAcc" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Accrued ACC No. *</label>
                                <div class="col-sm-7">
                                     <asp:LinkButton runat="server" ID="btnLookUpAccruedAcc"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtAccruedAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Accrued COA" DBColumnName="ACCRUED_ACC" SPParameterName="p_accrued_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtAccruedPad" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACCRUED_PAD" SPParameterName="p_accrued_pad" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblAccruedAcc"  runat="server" DBColumnName="ACCRUED_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> -
                                     <cc1:XUILabel ID="lblNameAccruedAcc"  runat="server"  DBColumnName="ACCRUED_ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccruedAcc" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Deposit ACC No. *</label>
                                <div class="col-sm-7">
                                     <asp:LinkButton runat="server" ID="btnLookUpDepositAcc"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtDepositAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Deposit COA" DBColumnName="DEPOSIT_ACC" SPParameterName="p_deposit_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                       <cc1:XUITextBox ID="txtDepositPad" style="display:none" runat="server" CssClass="form-control" DBColumnName="DEPOSIT_PAD" SPParameterName="p_deposit_pad" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblDepositAcc"  runat="server" DBColumnName="DEPOSIT_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> -
                                     <cc1:XUILabel ID="lblNameDepositAcc"  runat="server"  DBColumnName="DEPOSIT_ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDepositAcc" Display="Dynamic"></asp:RequiredFieldValidator>
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

