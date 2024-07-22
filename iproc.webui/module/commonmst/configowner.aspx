<%--<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="configowner.aspx.cs" Inherits="module_commonmst_configowner" %>

asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Unit Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000035E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Active</label>
                                <div class="col-sm-9">
                                    <cc1:XUICheckBox ID="cbxIsActive" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" runat="server" Checked="true" />
                                </div>
                            </div>                            
                        </div>
                   </div> 
                    <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Is Owner</label>
                                <div class="col-sm-9">
                                    <cc1:XUICheckBox ID="txtOwner" DBColumnName="IS_OWNER" SPParameterName="p_is_owner" DataType="String" BindType="Both" runat="server" Checked="true" />
                                </div>
                            </div>                            
                        </div>
                   </div>
                    <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Is Process By</label>
                                <div class="col-sm-9">
                                    <cc1:XUICheckBox ID="txtIsProcessBy" DBColumnName="IS_PROCESS" SPParameterName="p_is_process" DataType="String" BindType="Both" runat="server" Checked="true" />
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

--%>