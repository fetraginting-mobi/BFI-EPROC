<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="itemownerprocess.aspx.cs" Inherits="module_commonmst_itemownerprocess" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section class="panel">
        <header class="panel-heading">
          <span>Update Owner or Process Item</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000140E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>

                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Update For</label>
                                <div class="col-sm-7">
                                      <cc1:XUIDropDownList ID="ddlUpdateFor" runat="server" CssClass="form-control" placeholder="Creditor Type" DBColumnName="IS_OWNER" AutoPostBack="true" OnSelectedIndexChanged="ddlJenisItem_OnSelectedIndex"  SPParameterName="p_is_owner" DataType="String" BindType="UIToDBOnly" >
                                        <asp:ListItem Value="0">-=Select=-</asp:ListItem>
                                        <asp:ListItem Text="PROCESS BY" Value="process"></asp:ListItem>
                                        <asp:ListItem Text="OWNER" Value="owner"></asp:ListItem> 
                                    </cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvUpdateFor" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUpdateFor"  InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row">
                       <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="fromowner" class="col-sm-4">From Owner *</label>
                                <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlFromOwner" runat="server" CssClass="form-control" placeholder="" DBColumnName="OWNER"  SPParameterName="p_from_owner"  MaxLength="10" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="rfvFromOwner" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlFromOwner" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>
                        </div>      
                    </div>
                    <div class="row">
                       <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="owner" class="col-sm-4">Owner *</label>
                                <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlOwner" runat="server" CssClass="form-control" placeholder="" DBColumnName="OWNER"  SPParameterName="p_owner"  MaxLength="10" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="rfvOwner" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlOwner" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>
                        </div>      
                    </div>
                    <div class="row">
                      <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="fromprocess" class="col-sm-4">From Process By *</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlfromProcess" runat="server" CssClass="form-control" DBColumnName="PROCESS_BY"  SPParameterName="p_from_process_by" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvFromProcess" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlfromProcess" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                        </div>                            
                    </div>
                   </div>
                    <div class="row">
                      <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="process" class="col-sm-4">Process By *</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlProcessBy" runat="server" CssClass="form-control" DBColumnName="PROCESS_BY"  SPParameterName="p_process_by" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvProcessBy" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlProcessBy" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                        </div>                            
                    </div>
                   </div>
                  
                    <%--<div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">AP ACC No. *</label>
                                <div class="col-sm-7">
                                     <asp:LinkButton runat="server" ID="btnLookUpCapyCOA"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtCapyAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Capy COA" DBColumnName="NO_CAPY_ACC" SPParameterName="p_capy_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblCapyAcc"  runat="server"  style="display:none" DBColumnName="NO_CAPY_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <cc1:XUILabel ID="lblNameCapyAcc"  runat="server"  DBColumnName="CAPY_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Advance ACC No. *</label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpAdvanceAcc"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtAdvanceAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Advance COA" DBColumnName="NO_ADVANCE_ACC" SPParameterName="p_advance_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAdvanceAcc"  runat="server"  style="display:none" DBColumnName="NO_ADVANCE_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNameAdvanceAcc"  runat="server"  DBColumnName="ADVANCE_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Accrued ACC No. *</label>
                                <div class="col-sm-7">
                                     <asp:LinkButton runat="server" ID="btnLookUpAccruedAcc"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtAccruedAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Accrued COA" DBColumnName="NO_ACCRUED_ACC" SPParameterName="p_accrued_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblAccruedAcc"  runat="server"  style="display:none" DBColumnName="NO_ACCRUED_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <cc1:XUILabel ID="lblNameAccruedAcc"  runat="server"  DBColumnName="ACCRUED_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Deposit ACC No. *</label>
                                <div class="col-sm-7">
                                     <asp:LinkButton runat="server" ID="btnLookUpDepositAcc"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtDepositAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Deposit COA" DBColumnName="NO_DEPOSIT_ACC" SPParameterName="p_deposit_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblDepositAcc"  runat="server"  style="display:none" DBColumnName="NO_DEPOSIT_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <cc1:XUILabel ID="lblNameDepositAcc"  runat="server"  DBColumnName="DEPOSIT_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>--%>                                                
            </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
      </section>
</asp:Content>

