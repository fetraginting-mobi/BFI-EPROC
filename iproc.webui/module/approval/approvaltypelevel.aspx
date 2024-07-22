<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="approvaltypelevel.aspx.cs" Inherits="module_approval_approvaltypelevel" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Approval Type Level Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R40000040E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text="0" style="display:none"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
                 <div class="col-sm-6">                   
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Approval Code</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblApprovalCode" runat="server" DBColumnName="APPROVAL_CODE" SPParameterName="p_approval_code" DataType="String" BindType="Both" ></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Order Key *</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtOrder" runat="server" CssClass="form-control" placeholder="Order Key" DBColumnName="ORDER_KEY" SPParameterName="p_order_key" MaxLength="2" DataType="Integer" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvOrder" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtOrder" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtOrder" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-4">
                            <label>From Amount *</label>
                        </div>    
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtFromAmount" runat="server" CssClass="form-control decimal-only" DBColumnName="FROM_AMOUNT" SPParameterName="p_from_amount" MaxLength="14" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvFromAmount" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtFromAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revFromAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtFromAmount" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-4">
                            <label>To Amount *</label>
                        </div>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtToAmount" runat="server" CssClass="form-control decimal-only" DBColumnName="TO_AMOUNT" SPParameterName="p_to_amount" MaxLength="14" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvToAmount" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtToAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revToAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtToAmount" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Max Person *</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtMax" runat="server" CssClass="form-control" placeholder="Max Person" DBColumnName="MAX_PERSON" SPParameterName="p_max_person" MaxLength="3" DataType="Integer" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvMax" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMax" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revMax" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMax" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Min Person *</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtMin" runat="server" CssClass="form-control" placeholder="Min Person" DBColumnName="MIN_PERSON" SPParameterName="p_min_person" MaxLength="3" DataType="Integer" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvMin" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMin" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revMin" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMin" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
            </div>
        </div>
    </section>
    <asp:Panel ID="pnlAll" runat="server">
    <section class="panel">
        <header class="panel-heading">
          <span>Approval Type Level Position</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R40000040E" ID="btnAddApprovalTypeLevelPosition" runat="server" 
                        CssClass="btn btn-primary" OnClick="btnAddApprovalTypeLevelPosition_OnClick" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R40000040E" ID="btnDeleteApprovalTypeLevelPosition" runat="server" 
                        CssClass="btn btn-danger" OnClick="btnDeleteApprovalTypeLevelPosition_OnClick" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>                
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearchPosition" runat="server" DefaultButton="btnSearchPosition"     class="input-group">
                        <asp:TextBox ID="txtSearchPosition" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchPosition" runat="server" CssClass="btn btn-info" OnClick="btnSearchPosition_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListApprovalTypeLevelPosition" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="LEVEL_ID, POSITION_CODE"
                        OnPageIndexChanging="gvwListApprovalTypeLevelPosition_PageIndexChanging" 
                        onselectedindexchanged="gvwListApprovalTypeLevelPosition_SelectedIndexChanged" EmptyDataText="There Is No Data">
                        <Columns>
                             <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                            <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="POSITION_NAME" HeaderText="Position" SortExpression="POSITION_NAME">
                                    <ItemStyle Width="100%" />
                                </asp:BoundField>                                    
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnAddApprovalTypeLevelPosition" EventName="Click" /> 
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteApprovalTypeLevelPosition" EventName="Click" />                    
                    <asp:AsyncPostBackTrigger ControlID="btnSearchPosition" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    </asp:Panel>
</asp:Content>


