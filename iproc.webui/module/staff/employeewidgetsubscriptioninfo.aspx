<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="employeewidgetsubscriptioninfo.aspx.cs" Inherits="module_personel_employeewidgetsubscriptioninfo" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Widget Subscription Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblEmpCode" runat="server" DBColumnName="EMP_CODE" SPParameterName="p_emp_code"  DataType="String" BindType="Both" style="display:none;"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblWidgetCode" runat="server" DBColumnName="WIDGET_CODE" SPParameterName="p_widget_code"  DataType="String" BindType="Both" style="display:none;"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Widget</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblWidgetDesc" runat="server" DBColumnName="WIDGET_DESC" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Orientation</label>
                                <div class="col-sm-5">
                                    <cc1:XUIRadioButtonList ID="rblOrientation" runat="server" DBColumnName="WIDGET_ORIENTATION" SPParameterName="p_widget_orientation" DataType="String" BindType="Both" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="L" Selected="True" Text="Left&nbsp&nbsp"></asp:ListItem>
                                        <asp:ListItem Value="R" Text="Right"></asp:ListItem>
                                    </cc1:XUIRadioButtonList>
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
