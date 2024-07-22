<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accchart.aspx.cs" Inherits="module_commonmst_accchart" Title="Untitled Page" %>


<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
            <span>ACC Chart Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R12000010E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblAccChartID" runat="server" DBColumnName="ACC_CHARTID" SPParameterName="p_acc_chartid" DataType="Integer" BindType="Both"  Text= "0" style =  "Display:none;"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">COA No. *</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtAccNo" runat="server" CssClass="form-control" placeholder="COA No." DBColumnName="ACC_NO" SPParameterName="p_acc_no" MaxLength="9" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvAccNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revAccNo" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAccNo" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Payment Allocation</label>
                            <div class="col-sm-2">
                                <asp:LinkButton runat="server" ID="btnPaymentAllocation" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtPaymentAllocation" style="display:none" runat="server" CssClass="form-control" DBColumnName="CODE" SPParameterName="p_payment_allocation_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblPaymentAllocation" runat="server"  DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblPaymentAllocationName" runat="server"  DBColumnName="NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                
                                <%--<asp:RequiredFieldValidator ID="rfvMerk" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMerk" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>
                    </div>  
                    <div class="row">      
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">PAA Name *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtAccName" runat="server" CssClass="form-control" placeholder="PAA Name" DBColumnName="NAME" SPParameterName="p_acc_name" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvAccName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccName" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>   
                    </div> 
                      <div class="row">      
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">COA Name</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtCoaName" runat="server" CssClass="form-control" placeholder="COA Name" DBColumnName="ACC_NAME" SPParameterName="p_acc_name" MaxLength="50" DataType="String" Enabled ="false"  BindType="DBToUIOnly"></cc1:XUITextBox>
                                  
                                </div>
                            </div>                            
                        </div>   
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">COA Currency</label>
                                <div class="col-sm-2">
                                    <cc1:XUIDropDownList ID="ddlCurrencyCode" runat="server" CssClass="form-control" DBColumnName="CURRENCY" SPParameterName="p_acc_curr" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>   
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">COA Spec</label>
                                <div class="col-sm-4">
                                <cc1:XUIRadioButtonList ID="rblAccSpec" runat="server"  DBColumnName="ACC_SPEC" SPParameterName="p_acc_spec" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" >
                                    <asp:ListItem Value="1" Selected="True">Balance Stock&nbsp&nbsp</asp:ListItem>
                                    <asp:ListItem Value="2">Profit Loss&nbsp&nbsp</asp:ListItem>
                                </cc1:XUIRadioButtonList>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">COA Type</label>
                                <div class="col-sm-4">
                                <cc1:XUIRadioButtonList ID="rblAccType" runat="server"  DBColumnName="ACC_TYPE" SPParameterName="p_acc_type" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" Format="N0" >
                                    <asp:ListItem Value="1" Selected="True">Header&nbsp&nbsp</asp:ListItem>
                                    <asp:ListItem Value="2">Detail&nbsp&nbsp</asp:ListItem>
                                </cc1:XUIRadioButtonList>
                                </div>
                            </div>                            
                        </div>   
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">COA Level</label>
                                <div class="col-sm-2">
                                    <cc1:XUIDropDownList ID="ddlAccLevel" runat="server" CssClass="form-control" DBColumnName="ACC_LEVEL" SPParameterName="p_acc_level" BindType="Both" DataType="Number" Format="N0">
                                        <asp:ListItem Value="1">Level 1</asp:ListItem>
                                        <asp:ListItem Value="2">Level 2</asp:ListItem>
                                        <asp:ListItem Value="3">Level 3</asp:ListItem>
                                        <asp:ListItem Value="4">Level 4</asp:ListItem>
                                        <asp:ListItem Value="5">Level 5</asp:ListItem>
                                        <asp:ListItem Value="6">Level 6</asp:ListItem>
                                        <asp:ListItem Value="7">Level 7</asp:ListItem>
                                        <asp:ListItem Value="8">Level 8</asp:ListItem>
                                        <asp:ListItem Value="9">Level 9</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                    </div> 
                    <div class="row">   
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">Flag </label>
                                <div class="col-sm-4">
                                    <cc1:XUICheckBox ID="chbFlag" runat="server" DBColumnName="FLAG" SPParameterName="p_flag" MaxLength="1" DataType="String" BindType="Both"></cc1:XUICheckBox>   
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