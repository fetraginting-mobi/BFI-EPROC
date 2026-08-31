<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="farequestmutationdetail.aspx.cs" Inherits="module_fa_farequestmutationdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R90000080E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-12">
                            <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_ir_code" DBColumnName="IR_CODE" BindType="UIToDBOnly"></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtBranchEmp" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                            <cc1:XUITextBox ID="txtBranchHeader" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                            <cc1:XUITextBox ID="txtLocation" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                            <cc1:XUITextBox ID="txtOwner" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                            <div class="form-group">
                                <label class="col-sm-2">FA Mutation No.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblIRCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblIRStatus" runat="server" DBColumnName="IR_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblBranchHeader" runat="server" DBColumnName="BRANCH_HEADER" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                   
                                </div>
                            </div>
                        </div>                            
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Asset *</label>
                                 <div class="col-sm-8">    
                                    <asp:LinkButton runat="server" ID="btnLookUpInventoryRequestItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                           
                                    <cc1:XUILabel ID="lblItemName" runat="server" DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    <%--<cc1:XUITextBox ID="txtItemName" runat="server" Enabled = "false" DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUITextBox> --%>
                                    <cc1:XUITextBox ID="txtloccode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>    
                                 </div>
                            </div>              
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Asset Code</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtItemCode" runat="server" Enabled="false" CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Description</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="ITEM_DESCRIPTION" SPParameterName="p_item_description" MaxLength="100" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                  
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 100" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                         </div>
                         <div class="col-sm-6" style="display:none;">
                            <div class="form-group">
                                <label class="col-sm-4">Process</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblProcess" runat="server" DBColumnName="PROCESS" DataType="String"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>     
                    </div>
                    <div class="row" style="display:none;" >
                         <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Division</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblDivision" runat="server" DBColumnName="DIVISION_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                     
                                </div>
                            </div>                             
                        </div> 
                    </div>
                    <div class="row" style="display:none;" >
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Department</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblDepartement" runat="server" DBColumnName="DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                       <div class="row" style="display:none;">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Units</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblUnits" runat="server" DBColumnName="UNITS_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
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


