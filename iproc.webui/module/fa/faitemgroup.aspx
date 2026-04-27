<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="faitemgroup.aspx.cs"
    Inherits="module_fa_faitemgroup" Title="Untitled Page" %>

    <%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
            <style>
                .grid-auto {
                    table-layout: auto !important;
                    width: 100% !important;
                }

                .grid-auto th,
                .grid-auto td {
                    white-space: nowrap;
                }

                .btn-purple {
                    background-color: #6f42c1 !important;
                    border-color: #6f42c1 !important;
                    color: #fff !important;
                }
            </style>
            <script type="text/javascript">
                function singleCheck(current) {
                    var grid = document.getElementById('<%= gvwList.ClientID %>');
                    var checkboxes = grid.getElementsByTagName("input");

                    for (var i = 0; i < checkboxes.length; i++) {
                        if (checkboxes[i].type === "checkbox" && checkboxes[i] !== current) {
                            checkboxes[i].checked = false;
                        }
                    }
                }
            </script>
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
            <section class="panel">
                <header class="panel-heading">
                    <span>FA Grouping Asset Info</span>
                </header>
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-12">
                            <cc1:XUILinkButton ID="btnSave" RoleCode="R90000070E" runat="server"
                                CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="false"><i
                                    class="icon-save"></i> Save</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnCancel" RoleCode="R90000070O" runat="server"
                                CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i
                                    class="icon-arrow-left"></i> Cancel</cc1:XUILinkButton>
                        </div>
                    </div>
                </div>
                <div class="panel-body form-horizontal">
                    <asp:HiddenField ID="hdnAssetId" runat="server" />
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Asset Group Code</label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblGroupAssetCode" runat="server"
                                                DBColumnName="FA_GROUP_ASSET_CODE"
                                                SPParameterName="p_fa_group_asset_code" DataType="String"
                                                BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Cost Center</label>
                                        <div class="col-sm-6">
                                            <asp:UpdatePanel ID="updDep" runat="server">
                                                <ContentTemplate>
                                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server"
                                                        CssClass="form-control" DBColumnName="cost_center"
                                                        SPParameterName="p_cost_center" DataType="String"
                                                        AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged"
                                                        BindType="Both"></cc1:XUIDropDownList>
                                                    <cc1:XUILabel ID="lblbranch" runat="server"
                                                        DBColumnName="cost_center" DataType="String"
                                                        BindType="DBToUIOnly" Text="--" style="display:none;">
                                                    </cc1:XUILabel>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Asset Group Name *</label>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtAssetGroupName" runat="server"
                                                CssClass="form-control" placeholder="Asset Group Name"
                                                DBColumnName="FA_GROUP_ASSET_NAME" SPParameterName="p_group_asset_name"
                                                DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <asp:RequiredFieldValidator ID="rfvAssetGroupName" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtAssetGroupName"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Location *</label>
                                        <div class="col-sm-6">
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <cc1:XUIDropDownList ID="ddlLocation" runat="server"
                                                        CssClass="form-control" DBColumnName="FA_LOCATION"
                                                        SPParameterName="p_fa_location" DataType="String"
                                                        BindType="Both"></cc1:XUIDropDownList>
                                                    <cc1:XUILabel ID="lblLocation" runat="server"
                                                        DBColumnName="FA_LOCATION" DataType="String"
                                                        BindType="DBToUIOnly" Text="--" style="display:none;">
                                                    </cc1:XUILabel>
                                                    <asp:RequiredFieldValidator ID="rvfLocation" runat="server"
                                                        ErrorMessage="Required Field!" ControlToValidate="ddlLocation"
                                                        Display="Dynamic"></asp:RequiredFieldValidator>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddlBranch"
                                                        EventName="SelectedIndexChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Date *</label>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtAssetGroupDate" runat="server"
                                                CssClass="form-control default-date-picker"
                                                placeholder="Asset Group Name" DBColumnName="CRE_DATE"
                                                SPParameterName="p_cre_date" MaxLength="10" DataType="Datetime"
                                                BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Status</label>
                                        <div class="col-sm-4">
                                            <cc1:XUICheckBox ID="chbIsActive" runat="server" DBColumnName="IS_ACTIVE"
                                                SPParameterName="p_status" DataType="String" BindType="Both">
                                            </cc1:XUICheckBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Created </label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName="CRE_BY"
                                                DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                            <span>@</span>
                                            <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName="CRE_DATE"
                                                DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss">
                                            </cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Modified </label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName="MOD_BY"
                                                DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                            <span>@</span>
                                            <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName="MOD_DATE"
                                                DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss">
                                            </cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </section>
            <section class="panel">
                <header class="panel-heading tab-bg-dark-navy-blue">
                    <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                    <ul class="nav nav-tabs nav-justified">
                        <li class="active">
                            <a href="#AssetList" id="assetlist" onclick="javascript:fnSetTab('assetspec');"
                                style="padding-bottom:28px" data-toggle="tab">
                                Asset List
                            </a>
                        </li>
                        <li class="">
                            <a href="#MovementHistory" id="movementhistory" onclick="javascript:fnSetTab('insuranc');"
                                style="padding-bottom:28px" data-toggle="tab">
                                Movement History
                            </a>
                        </li>
                    </ul>
                </header>
                <asp:Panel runat="server" ID="pnlEntry">
                    <section class="panel">
                        <header class="panel-heading">
                            <span>Asset Grouping List</span>
                        </header>
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-sm-8">
                                    <cc1:XUILinkButton ID="btnAdd" RoleCode="R90000070E" runat="server"
                                        CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i
                                            class="icon-plus"></i> Create</cc1:XUILinkButton>
                                    <cc1:XUILinkButton ID="btnDelete" RoleCode="R90000070E" runat="server"
                                        CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i
                                            class="icon-trash"></i> Delete</cc1:XUILinkButton>
                                    <cc1:XUILinkButton ID="btnMove" RoleCode="R90000070E" runat="server"
                                        CssClass="btn btn-purple" CausesValidation="false">
                                        <i class="icon-arrow-right"></i> Move
                                    </cc1:XUILinkButton>
                                </div>
                                <div class="col-sm-4">
                                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"
                                        class="input-group">
                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                            placeholder="Keywords"></asp:TextBox>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info"
                                                OnClick="btnSearch_Click" CausesValidation="false"><i
                                                    class="icon-search"></i> Search</asp:LinkButton>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel ID="upd" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gvwList" runat="server"
                                        CssClass="display table table-bordered table-striped grid-auto"
                                        AutoGenerateColumns="false" AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                        onselectedindexchanged="gvwList_SelectedIndexChanged"
                                        EmptyDataText="There Is No Data" Width="100%">
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
                                                    <asp:CheckBox ID="chbSelectAll" runat="server"
                                                        onclick="checkAll(this)" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="BARCODE" HeaderText="Asset Barcode">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Asset Name">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="category" HeaderText="Asset category">
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Parent">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkParent" runat="server"
                                                        Checked='<%# Convert.ToBoolean(Eval("is_parent")) %>'
                                                        onclick="return singleCheck(this);" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </section>
                </asp:Panel>
            </section>
        </asp:Content>