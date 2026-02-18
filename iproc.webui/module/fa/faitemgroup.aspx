<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="faitemgroup.aspx.cs" Inherits="module_fa_faitemgroup" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>FA Group Info</span>
        </header>
         <div class="panel-heading">
            <div class="row">
                 <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R90000070E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="R90000070O" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Cancel</cc1:XUILinkButton>
                 </div>
            </div>
         </div>
         <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Group Code.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblItemGroupCode" runat="server" DBColumnName="FA_ITEM_GROUP_CODE" SPParameterName="p_fa_item_group_code" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch Code</label>
                                <div class="col-sm-6">
                                <asp:UpdatePanel ID="updDep" runat="server">
                                   <ContentTemplate>                                    
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" AutoPostBack="true"  OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                   </ContentTemplate>
                                </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Group Name*</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtGroupName" runat="server" CssClass="form-control" placeholder ="Group Name" DBColumnName="FA_ITEM_GROUP_NAME" SPParameterName="p_fa_item_group_name" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvItemName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtGroupName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Location *</label>
                                <div class="col-sm-6">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlLocation" runat="server" CssClass="form-control" DBColumnName="FA_LOCATION" SPParameterName="p_fa_location" DataType="String"  BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblLocation" runat="server"  DBColumnName="FA_LOCATION" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                      <asp:RequiredFieldValidator ID="rvfLocation" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlLocation" Display="Dynamic"></asp:RequiredFieldValidator>
                                </ContentTemplate>
                                <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlBranch" EventName="SelectedIndexChanged" />
                                </Triggers>
                                </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created  </label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "cre_by" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Modified </label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "mod_by" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName= "MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
         </div>
    </section>
    <asp:Panel runat="server" ID="pnlEntry">
        <section class="panel">
            <header class="panel-heading">
                <span>Asset Grouping List</span>
            </header>
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8">
                            <cc1:XUILinkButton ID="btnAdd" RoleCode="R90000070E" runat="server" CssClass="btn btn-primary" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDelete" RoleCode="R90000070E" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                                OnPageIndexChanging="gvwList_PageIndexChanging" 
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
                                    <asp:BoundField DataField="ITEM_NAME" HeaderText="Asset Name">
                                        <ItemStyle Width="30%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BARCODE" HeaderText="Asset Barcode">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>          
        </section>
    </asp:Panel>
</asp:Content>

