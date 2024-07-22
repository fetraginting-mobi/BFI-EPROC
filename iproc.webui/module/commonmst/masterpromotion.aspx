<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterpromotion.aspx.cs" Inherits="module_commonmst_masterpromotion" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Master Promotion</span>
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
                    <cc1:XUITextBox ID="txtID" runat="server"  DBColumnName="ID" DataType="Integer" BindType="Both" SPParameterName="p_id" style="display:none;" ></cc1:XUITextBox>
                    <cc1:XUITextBox ID="txtJenis" runat="server" DataType="String" BindType="None"  style="display:none;" ></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Start Date *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtStartDate" runat="server" CssClass="form-control default-date-picker" placeholder="Start Date" DBColumnName="START_DATE_PROMOTION" SPParameterName="p_start_date_promotion" DataType="DateTime" Format="dd/MM/yyyy" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revStartDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtStartDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">End Date *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtEndDate" runat="server" CssClass="form-control default-date-picker" placeholder="End Date" DBColumnName="END_DATE_PROMOTION" SPParameterName="p_end_date_promotion" DataType="DateTime" Format="dd/MM/yyyy" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtEndDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEndDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtEndDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>   
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Group *</label>                                
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpParentGroup" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtParentGroup" runat="server" CssClass="form-control" style="display:none" DBColumnName="ITEM_GROUP" SPParameterName="p_item_group" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblParentGroup" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvParentGroup" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtParentGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>    
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Group Level</label>
                                <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblGroupLevel" runat="server"  placeholder="Group Level" DBColumnName="GROUP_LEVEL" DataType="String"   BindType="DBToUIOnly" ></cc1:XUILabel>
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
    <asp:Panel runat="server" ID="pnlItem">
        <section class="panel">
        <header class="panel-heading">
          <span> Item List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="" ID="btnAdd" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnSaveDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDetail_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
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
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID" OnPageIndexChanging="gvwList_PageIndexChanging" 
                    EmptyDataText="There is no data" Width="100%" >
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
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="">
                                <ItemStyle Width="50%" HorizontalAlign="Center"/>  
                            </asp:BoundField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblAmount" Text="Amount"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="50%" />
                                <ItemTemplate>
                                    <cc1:XUITextBox runat="server" ID="txtAmount" CssClass="form-control" DataType="Number" Format="N2"  Text='<%# Eval("AMOUNT") %>'  Font-Bold="true"></cc1:XUITextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnSaveDetail" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    </asp:Panel>
</asp:Content>

