<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="masteritemgroup.aspx.cs" Inherits="module_commonmst_masteritem" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Group Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton >
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server" >
                <ContentTemplate>
                <cc1:XUILabel ID="lblCategory" runat="server" DBColumnName="GROUP_CATEGORY_TYPE" DataType="String" style="display:none" BindType="DBToUIOnly"></cc1:XUILabel>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Group Code *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtGroup" runat="server" CssClass="form-control" placeholder="Group Code" DBColumnName="CATEGORY_CODE" SPParameterName="p_category_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvGroup" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                               <%-- <asp:RegularExpressionValidator ID="revMerkName" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtGroup" ValidationExpression="^([\sA-Za-z0-9]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>--%>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Item Group Type</label>
                            <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlJenisItem" runat="server" CssClass="form-control" DBColumnName="GROUP_CATEGORY_TYPE" SPParameterName="p_group_category_type" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlJenisItem_OnSelectedIndex" DataType="String">
                                </cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div> 
                 </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Group Name *</label>
                            <div class="col-sm-7">
                                <%--<cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0"></cc1:XUILabel>--%>
                                <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Group Name" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                   <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Parent Group *</label>
                            <div class="col-sm-7">
                                   <asp:LinkButton runat="server" ID="btnLookUpParentGroup" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                   <cc1:XUITextBox ID="txtParentGroup" runat="server" CssClass="form-control" style="display:none" DBColumnName="PARENT_CODE" SPParameterName="p_parent_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblParentGroup" runat="server"  DBColumnName="DESCRIPTIONPG" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtParentGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                               <%-- <cc1:XUIDropDownList ID="ddlParentCode" runat="server" CssClass="form-control" DBColumnName="PARENT_CODE" SPParameterName="p_parent_code" BindType="Both" DataType="String"></cc1:XUIDropDownList>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">   
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="TaxType" class="col-sm-4">Tax Code *</label>
                            <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlTaxType" runat="server" CssClass="form-control" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>    
                                <asp:RequiredFieldValidator ID="rfvTaxType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlTaxType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>  
                    </div>  
                    <div class="col-sm-6" runat="server" id="Amount">
                        <div class="form-group">
                            <label class="col-sm-4">Amount Threshold Depresiasi</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtAssetAmountThreshold" runat="server" CssClass="form-control" placeholder="Asset Amount Threshold" DBColumnName="ASSET_AMOUNT_THRESHOLD" SPParameterName="p_asset_amount_threshold"  DataType="Number" BindType="Both" ></cc1:XUITextBox>
                                 <asp:RegularExpressionValidator ID="revAssetAmountThreshold" runat="server"  ErrorMessage="Format Invalid!" ControlToValidate="txtAssetAmountThreshold" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>                        
                </div>  
                <div class="row">
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Active</label>
                            <div class="col-sm-7">
                                <cc1:XUICheckBox ID="cbxIsActive" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" runat="server" Checked="true" />
                            </div>
                        </div>                            
                     </div>
                      <div class="col-sm-6" runat="server" id="divMassaAsset" >
                        <div class="form-group">
                           <%-- <label class="col-sm-4">Masa Asset Hak Guna (Month) </label>--%>
                            <label class="col-sm-4">Max Parameter Asset Hak Guna (Month) </label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtMasaAsset" runat="server" CssClass="form-control" placeholder="Max Parameter Asset Hak Guna" DBColumnName="ASSET_PERIOD_HAK_GUNA" SPParameterName="p_asset_period_hak_guna"  DataType="Integer" BindType="Both" MaxLength="4" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvMasaAsset" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMasaAsset" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>      
                <%--<div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4" runat="server" id="Flag" style="display:none">Flag Parent</label>
                            <div class="col-sm-7">
                                <cc1:XUICheckBox ID="chbFlagParent" runat="server" DBColumnName="FLAG_PARENT" SPParameterName="p_flag_parent" MaxLength="1" DataType="String" BindType="Both" Visible="false"></cc1:XUICheckBox>  
                            </div>
                        </div>                            
                    </div>
                </div> --%>                
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    <asp:Panel runat="server" ID="pnlGroupDetail">
        <section class="panel">
        <header class="panel-heading">
            <span>Item Group Link A/C List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnAdd" RoleCode="R30000120C" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnDelete" RoleCode="R30000120D" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">
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
                        OnPageIndexChanging="gvwList_PageIndexChanging" OnRowCreated="gvwList_RowCreated"
                        onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                                    <asp:CheckBox runat="server" ID="chbCheckedAll" AutoPostBack="true" OnCheckedChanged="chbCheckedAll_CheckedChanged"/>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chbChecked"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ACC_ASSET_PO" HeaderText="Fixed Asset ACC No.">
                                <ItemStyle Width="30%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="NAME_ASSET_PO" HeaderText="Fixed Asset ACC Name">
                                <ItemStyle Width="70%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ACC_EXPENSE_PO" HeaderText="Expence ACC No.">
                                <ItemStyle Width="30%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NAME_EXPENSE_PO" HeaderText="Expence ACC Name">
                                <ItemStyle Width="70%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ACC_NO_INV" HeaderText="Inventory ACC No.">
                                <ItemStyle Width="30%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NAME_NO_INV" HeaderText="Inventory ACC Name">
                                <ItemStyle Width="70%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CURRENCY_CODE" HeaderText="">
                                <ItemStyle Width="0%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    </asp:Panel>
</asp:Content>
