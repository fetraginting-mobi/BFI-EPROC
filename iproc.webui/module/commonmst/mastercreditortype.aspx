<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastercreditortype.aspx.cs"
    Inherits="module_commonmst_mastercreditortype" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Creditor Type Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000140E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
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
                                <label class="col-sm-3">Creditor Code *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtCreditorTypeCode" runat="server" CssClass="form-control" placeholder="Creditor Type Code" DBColumnName="CREDITORTYPE_CODE" SPParameterName="p_creditortype_code" MaxLength="10" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCreditorTypeCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCreditorTypeCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="revCreditorTypeCode" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtCreditorTypeCode" ValidationExpression="^[a-zA-Z0-9]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Description *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <%--<asp:RegularExpressionValidator ID="revDescription" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDescription" ValidationExpression="^([\sA-Za-z0-9]+)$"  Display="Dynamic"></asp:RegularExpressionValidator> --%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Creditor Type *</label>
                                <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlCreditorType" runat="server" CssClass="form-control" placeholder="Creditor Type" DBColumnName="CREDITOR_TYPE" SPParameterName="p_creditor_type" DataType="String" BindType="Both" >
                                        <asp:ListItem Value="0">-=Select=-</asp:ListItem>
                                        <asp:ListItem Text="CREDITOR STAFF" Value="SOF"></asp:ListItem>
                                        <asp:ListItem Text="CREDITOR SUPPLIER" Value="SPl"></asp:ListItem> 
                                    </cc1:XUIDropDownList>
                                   <asp:RequiredFieldValidator ID="rfvCreditorType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlCreditorType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Active</label>
                                <div class="col-sm-9">
                                    <cc1:XUICheckBox ID="cbxIsActiveDivision" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" runat="server" Checked="true" />
                                </div>
                            </div>                            
                        </div>
                   </div>
                    <%--<div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">AP ACC No. *</label>
                                <div class="col-sm-7">
                                     <asp:LinkButton runat="server" ID="btnLookUpCapyCOA"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtCapyAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Capy COA" DBColumnName="NO_CAPY_ACC" SPParameterName="p_capy_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblCapyAcc"  runat="server"  style="display:none" DBColumnName="NO_CAPY_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <cc1:XUILabel ID="lblNameCapyAcc"  runat="server"  DBColumnName="CAPY_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Advance ACC No. *</label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpAdvanceAcc"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtAdvanceAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Advance COA" DBColumnName="NO_ADVANCE_ACC" SPParameterName="p_advance_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAdvanceAcc"  runat="server"  style="display:none" DBColumnName="NO_ADVANCE_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNameAdvanceAcc"  runat="server"  DBColumnName="ADVANCE_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Accrued ACC No. *</label>
                                <div class="col-sm-7">
                                     <asp:LinkButton runat="server" ID="btnLookUpAccruedAcc"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtAccruedAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Accrued COA" DBColumnName="NO_ACCRUED_ACC" SPParameterName="p_accrued_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblAccruedAcc"  runat="server"  style="display:none" DBColumnName="NO_ACCRUED_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <cc1:XUILabel ID="lblNameAccruedAcc"  runat="server"  DBColumnName="ACCRUED_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Deposit ACC No. *</label>
                                <div class="col-sm-7">
                                     <asp:LinkButton runat="server" ID="btnLookUpDepositAcc"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtDepositAcc" runat="server" style="display:none" CssClass="form-control" placeholder="Deposit COA" DBColumnName="NO_DEPOSIT_ACC" SPParameterName="p_deposit_acc" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblDepositAcc"  runat="server"  style="display:none" DBColumnName="NO_DEPOSIT_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <cc1:XUILabel ID="lblNameDepositAcc"  runat="server"  DBColumnName="DEPOSIT_ACC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>--%>                                                
            </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    <asp:Panel runat="server" ID="pnlEditorTypeAcc">
        <section class="panel">
        <header class="panel-heading">
          <span> Link Acc List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R30000140E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R30000140E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwList_PageIndexChanging"
                        onselectedindexchanged="gvwList_SelectedIndexChanged"  EmptyDataText="There is no data" Width="100%" >
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
                            <asp:BoundField DataField="CURRENCY_CODE" HeaderText="">
                                <ItemStyle Width="0%" HorizontalAlign="Center"/>  
                            </asp:BoundField>
                            <%--<asp:BoundField DataField="CAPY_ACC_NAME" HeaderText="AP Acc No.">
                                <ItemStyle Width="20%" HorizontalAlign="Left"/>  
                            </asp:BoundField>--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="Ap" Text="AP Acc No./Name"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="25%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblApNo" Text='<%# Eval("CAPY_ACC") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblApName" Text='<%# Eval("CAPY_ACC_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="ADVANCE_ACC_NAME" HeaderText="Advance Acc No.">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />  
                            </asp:BoundField>--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblAdvance" Text="Advance Acc No./Name"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="25%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblAdvanceNo" Text='<%# Eval("ADVANCE_ACC") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblAdvanceName" Text='<%# Eval("ADVANCE_ACC_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="ACCRUED_ACC_NAME" HeaderText="Accrued Acc No.">
                                <ItemStyle Width="20%"  HorizontalAlign="Left"/>
                            </asp:BoundField>--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblAccrued" Text="Accrued Acc No./Name"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="25%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblAccruedNo" Text='<%# Eval("ACCRUED_ACC") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblAccruedName" Text='<%# Eval("ACCRUED_ACC_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="DEPOSIT_ACC_NAME" HeaderText="Deposit Acc No.">
                                <ItemStyle Width="20%"  HorizontalAlign="Left"/>
                            </asp:BoundField>--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblDeposit" Text="Deposit Acc No./Name"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="25%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblDepositNo" Text='<%# Eval("DEPOSIT_ACC") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblDepositName" Text='<%# Eval("DEPOSIT_ACC_NAME") %>'></asp:Label>
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
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    </asp:Panel>
</asp:Content>
