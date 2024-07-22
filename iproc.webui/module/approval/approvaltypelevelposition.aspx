<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="approvaltypelevelposition.aspx.cs" Inherits="module_approval_approvaltypelevelposition" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <div class="row">
                <div class="col-sm-11">
                <span>Approval Type Level Position Info</span>
                </div>
            </div>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    
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
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtLevelID" runat="server" DBColumnName="LEVEL_ID" SPParameterName="p_level_id" DataType="String" BindType="Both" Text="0" style="display:none"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                 <div class="col-sm-6">                   
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <div class="col-sm-1">
                            <label>Position</label>
                        </div>    
                        <div class="col-sm-11">
                            <div class="input-group">
                                <asp:LinkButton runat="server" ID="btnLookupPosition" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtCode" CssClass="form-control" runat="server"  DBColumnName="POSITION_CODE" DataType="String" BindType="Both" SPParameterName="p_position_code" Text="-" Enabled="false" Width="100px" style="border:0px; background:inherit; display:none" ></cc1:XUITextBox>
                                <cc1:XUITextBox ID="txtDesc" CssClass="form-control" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="180px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvPosition" runat="server"  ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
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
    
    <asp:Panel ID="pnlAll" runat="server">
        <section class="panel">
            <header class="panel-heading">
              <span>Approval Type Level Person</span>
            </header>
            <div class="panel-heading">
                <div class="row">
                    <div class="col-sm-8">
                         
                    </div>                
                    <div class="col-sm-4">
                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"     class="input-group">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>  
                            <div class="input-group-btn">
                                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <asp:UpdatePanel ID="upd" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvwListApprovalTypeLevelPerson" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="EMP_CODE" OnPageIndexChanging="gvwListApprovalTypeLevelPerson_PageIndexChanging" 
                            onselectedindexchanged="gvwListApprovalTypeLevelPerson_SelectedIndexChanged" EmptyDataText="There Is No Data" >
                            <Columns>
                                 <asp:TemplateField>
                                    <HeaderTemplate>
                                        <span>No</span>
                                    </HeaderTemplate> 
                                <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                </asp:TemplateField>
                                 
                                <asp:BoundField DataField="EMP_CODE" HeaderText="Employee Code" SortExpression="EMP_CODE">
                                    <ItemStyle Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="EMP_NAME" HeaderText="Employee Name" SortExpression="EMP_NAME">
                                    <ItemStyle Width="40%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="BRANCH_NAME" HeaderText="Branch" SortExpression="BRANCH_NAME">
                                    <ItemStyle Width="40%" />
                                </asp:BoundField>
                                 
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>            
                        <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </section>
    </asp:Panel>
    
</asp:Content>

