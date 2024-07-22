<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="employeebranch.aspx.cs" Inherits="module_user_employeebranch" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Staff Branch Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton ID="btnSave" RoleCode="R40000010C"  runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" RoleCode="R40000010E" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Staff</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlEmpCode" runat="server" CssClass="form-control" DBColumnName="EMP_CODE" SPParameterName="p_emp_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12"> 
                            <div class="form-group">
                                <label class="col-sm-2">Branch</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Home Base</label>
                                <div class="col-sm-5">
                                    <cc1:XUICheckBox ID="cbIsHomeBase" runat="server" DBColumnName="IS_HOME_BASE" SPParameterName="p_is_home_base" DataType="String" BindType="Both"></cc1:XUICheckBox>
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

