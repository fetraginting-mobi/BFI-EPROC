<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="masterbudgetinghistory.aspx.cs" Inherits="module_commonmst_masterbudgetinghistory" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Budgeting History Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R60000070E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>   
            <cc1:XUILabel ID="lblId" runat="server"  DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text="0" style="display:none" ></cc1:XUILabel>      
            <cc1:XUILabel ID="lblBranchID" runat="server"  DBColumnName="BUDGET_ID" SPParameterName="p_budget_id" DataType="Integer" BindType="Both" Text="0" style="display:none" ></cc1:XUILabel>
            <cc1:XUILabel ID="lblBranchCode" runat="server"  DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" Text="0" style="display:none" ></cc1:XUILabel>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                       <label class="col-sm-2">Department</label>
                          <div class="col-sm-5">
                              <cc1:XUIDropDownList ID="ddlDepartmentCode" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                          </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Group</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlItem" runat="server" CssClass="form-control" DBColumnName="GROUP_ITEM_ID" SPParameterName="p_group_item_id" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Budget</label>
                        <asp:RequiredFieldValidator ID="rfvBudget" runat="server" ErrorMessage="*" ControlToValidate="txtBudget" Display="Dynamic"></asp:RequiredFieldValidator>                                
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtBudget" runat="server"  CssClass="form-control" placeholder="Budget" DBColumnName="BUDGET" SPParameterName="p_budget" MaxLength="18" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                        </div>
                    </div>                               
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Year</label>
                        <asp:RequiredFieldValidator ID="rfvYear" runat="server" ErrorMessage="*" ControlToValidate="txtYear" Display="Dynamic"></asp:RequiredFieldValidator>                                
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtYear" runat="server"  CssClass="form-control" placeholder="Year" DBColumnName="YEAR" SPParameterName="p_year" MaxLength="4" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format = Number only 0000-0000-0000" ControlToValidate="txtYear" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        </div>
                    </div>                             
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Revision Date</label>
                        <asp:RequiredFieldValidator ID="rfvRevisionDate" runat="server" ErrorMessage="*" ControlToValidate="txtRevisionDate" Display="Dynamic"></asp:RequiredFieldValidator>                                
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtRevisionDate" runat="server"  CssClass="form-control default-date-picker" placeholder="Revision Date" DBColumnName="REVISION_DATE" SPParameterName="p_revision_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
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
