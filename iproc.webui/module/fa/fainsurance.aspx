<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fainsurance.aspx.cs" Inherits="module_fa_fainsurance" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>FA Asset Insurance Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R90000086E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal" style="height:500px">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
           <!--ID-->
           <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="DBToUIOnly" Text= "0" style="Display:none;" ></cc1:XUILabel>
           <cc1:XUILabel ID="lblBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String" BindType="Both" style="Display:none;" ></cc1:XUILabel>
            <cc1:XUILabel ID="lblAstCode" runat="server" DBColumnName="AST_CODE" SPParameterName="p_ast_code" DataType="String" BindType="Both" style="Display:none"></cc1:XUILabel>
            <cc1:XUILabel ID="lblfaid" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" style="Display:none;" ></cc1:XUILabel>

           <!--Barcode-->
           <cc1:XUILabel ID="txtAstCode" runat="server" DBColumnName="AST_CODE" SPParameterName="p_ast_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
           <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Policy Insurance No. *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtPolicyInsuranceNo" runat="server" CssClass="form-control" placeholder="Policy Insurance No" DBColumnName="POLICY_INSURANCE_NO" SPParameterName="p_policy_insurance_no" MaxLength="15" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvInsuranceNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPolicyInsuranceNo" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
           </div>
           <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Policy Insurance Company *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtInsuranceCompany" runat="server" CssClass="form-control" placeholder="Policy Insurance Company" DBColumnName="POLICY_INSURANCE_COMPANY" SPParameterName="p_policy_insurance_company" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvInsuranceCompany" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtInsuranceCompany" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>
           <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 ">Policy Start Date *</label>
                        <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtStartDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="Policy Start Date" DBColumnName="POLICY_START_DATE" SPParameterName="p_policy_start_date"  DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvPolicyStartDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtStartDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                 </div>
           </div>
           <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 ">Policy Due Date *</label>
                        <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtPolicyDueDate" runat="server" CssClass="form-control default-date-picker" placeholder="Policy Due Date" DBColumnName="POLICY_DUE_DATE" SPParameterName="p_policy_due_date"  DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvPolicyDueDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPolicyDueDate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtPolicyDueDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                 </div>
           </div>
           <div class="row">  
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2 ">Policy Premium *</label>
                        <div class="col-sm-3">
                        <cc1:XUITextBox ID="txtPolicyPremium" runat="server" CssClass="form-control" placeholder="Policy Premium" DBColumnName="POLICY_PREMIUM" SPParameterName="p_policy_premium" DataType="Number" BindType="Both" MaxLength="15" Format="N2"></cc1:XUITextBox>
                        <asp:RequiredFieldValidator ID="rfvPolicyPremium" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPolicyPremium" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPolicyPremium" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
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
