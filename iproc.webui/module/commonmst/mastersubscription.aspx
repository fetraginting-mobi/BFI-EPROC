<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastersubscription.aspx.cs" Inherits="module_commonmst_mastersubscription" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Subscription Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R20000030E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
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
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtSubscribeCode" runat="server" CssClass="form-control" placeholder="Subscribe Code" DBColumnName="SUBSCRIBE_CODE" SPParameterName="p_subscribe_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvSubscribeCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSubscribeCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">SP Table Source *</label>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtTSource" runat="server" CssClass="form-control" placeholder="SP Table Source" DBColumnName="SP_TABLE_SOURCE" SPParameterName="p_sp_table_source" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvTSource" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTSource" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>  
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">SP Table Target *</label>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtTTarget" runat="server" CssClass="form-control" placeholder="SP Table Target" DBColumnName="SP_TABLE_TARGET" SPParameterName="p_sp_table_target" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvTTarget" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTTarget" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>  
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">SP Source To Target *</label>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtSourceToTarget" runat="server" CssClass="form-control" placeholder="SP Source To Target" DBColumnName="SP_SOURCE_TO_TARGET" SPParameterName="p_sp_source_to_target" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvSourceToTarget" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSourceToTarget" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div> 
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">SP Target To Source *</label>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtTargetToSource" runat="server" CssClass="form-control" placeholder="SP Target To Source" DBColumnName="SP_TARGET_TO_SOURCE" SPParameterName="p_sp_target_to_source" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvTargetToSource" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTargetToSource" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>  
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">SP Save Data *</label>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtSPSaveName" runat="server" CssClass="form-control" placeholder="SP Save Name" DBColumnName="SP_SAVE_NAME" SPParameterName="p_sp_save_name" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvSPSaveName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSPSaveName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>     
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">SP Parameter Code *</label>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtSPParameter" runat="server" CssClass="form-control" placeholder="SP Parameter Code" DBColumnName="SP_PARAMETER_CODE" SPParameterName="p_sp_parameter_code" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfv" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSPParameter" Display="Dynamic"></asp:RequiredFieldValidator>
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
