<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fagroupingasset.aspx.cs"
    Inherits="module_fa_fagroupingasset" Title="Untitled Page" %>
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
                function singleCheck(current, detailID) {
                    var grid = document.getElementById('<%= gvwList.ClientID %>');
                    var checkboxes = grid.getElementsByTagName("input");
                    var selectedParentID = document.getElementById('<%= hdnSelectedParentID.ClientID %>');

                    for (var i = 0; i < checkboxes.length; i++) {
                        if (checkboxes[i].type === "checkbox" && checkboxes[i] !== current && checkboxes[i].id.indexOf("chkParent") >= 0) {
                            checkboxes[i].checked = false;
                        }
                    }

                    if (selectedParentID) {
                        selectedParentID.value = current.checked ? detailID : "";
                    }

                    return true;
                }

                function checkAssetRowsAll(objRef) {
                    var grid = document.getElementById('<%= gvwList.ClientID %>');
                    if (!grid) {
                        return;
                    }

                    var inputList = grid.getElementsByTagName("input");
                    for (var i = 0; i < inputList.length; i++) {
                        if (inputList[i].type === "checkbox" && inputList[i].id.indexOf("chbSelect") >= 0 && inputList[i].id.indexOf("chbSelectAll") < 0) {
                            inputList[i].checked = objRef.checked;
                        }
                    }
                }

                function checkAssetRowClick(objRef) {
                    var grid = document.getElementById('<%= gvwList.ClientID %>');
                    if (!grid) {
                        return;
                    }

                    var inputList = grid.getElementsByTagName("input");
                    var headerCheckBox = null;
                    var allChecked = true;

                    for (var i = 0; i < inputList.length; i++) {
                        if (inputList[i].type !== "checkbox") {
                            continue;
                        }

                        if (inputList[i].id.indexOf("chbSelectAll") >= 0) {
                            headerCheckBox = inputList[i];
                        } else if (inputList[i].id.indexOf("chbSelect") >= 0 && inputList[i].id.indexOf("chbSelectAll") < 0 && !inputList[i].checked) {
                            allChecked = false;
                        }
                    }

                    if (headerCheckBox) {
                        headerCheckBox.checked = allChecked;
                    }
                }

                function handleMovePopup() {
                    var ddlBranch = document.getElementById('<%= ddlBranch.ClientID %>');
                    var ddlLoc = document.getElementById('<%= ddlLocation.ClientID %>');
                    var groupCode = '<%= lblGroupAssetCode.Text %>';
                    var grid = document.getElementById('<%= gvwList.ClientID %>');
                    var barcodes = [];

                    if (!ddlBranch) {
                        alert("Cost Center tidak ditemukan di halaman.");
                        return false;
                    }

                    if (!ddlBranch.value || ddlBranch.value === "") {
                        alert("Pilih Cost Center terlebih dahulu!");
                        return false;
                    }

                    if (!groupCode || groupCode === "--") {
                        alert("Asset Group Code tidak ditemukan.");
                        return false;
                    }

                    if (grid) {
                        var checkboxes = grid.getElementsByTagName("input");
                        for (var i = 0; i < checkboxes.length; i++) {
                            if (checkboxes[i].type === "checkbox" && checkboxes[i].checked && checkboxes[i].id.indexOf("chbSelect") >= 0 && checkboxes[i].id.indexOf("chbSelectAll") < 0) {
                                var row = checkboxes[i].parentNode;
                                while (row && row.tagName !== "TR") {
                                    row = row.parentNode;
                                }

                                if (row && row.cells.length > 2) {
                                    var barcode = row.cells[2].innerText || row.cells[2].textContent;
                                    barcode = barcode.replace(/^\s+|\s+$/g, "");

                                    if (barcode) {
                                        barcodes.push(barcode);
                                    }
                                }
                            }
                        }
                    }

                    if (barcodes.length === 0) {
                        alert("Pilih minimal 1 asset terlebih dahulu!");
                        return false;
                    }

                    var url = "../../lookup/genericwithparametercustom.aspx?code=FGAMV" +
                        "&par_cost_center=" + encodeURIComponent(ddlBranch.value) +
                        "&par_location=" + encodeURIComponent(ddlLoc ? ddlLoc.value : "") +
                        "&move_source_ga_code=" + encodeURIComponent(groupCode) +
                        "&move_barcodes_string=" + encodeURIComponent(barcodes.join(","));

                    if (document.getElementById('ifrpopup') && typeof $ === 'function') {
                        document.getElementById('ifrpopup').src = url;
                        $('#ModalPopup').modal('show');
                    } else {
                        window.open(url, '_blank', 'width=900,height=600,scrollbars=yes');
                    }
                    return false;
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
                                CssClass="btn btn-primary" OnClick="btnSave_Click"><i
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
                                        <label class="col-sm-4">Branch *</label>
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
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                                                DBColumnName="FA_GROUP_ASSET_NAME" SPParameterName="p_fa_group_asset_name"
                                                DataType="String" BindType="Both" MaxLength="255"></cc1:XUITextBox>
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
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                                        <label class="col-sm-4">Date</label>
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
                                        <label class="col-sm-4">Status Aktif</label>
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
                                        <label class="col-sm-4">Remark</label>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control"
                                                placeholder="Remark" DBColumnName="REMARKS" SPParameterName="p_remarks"
                                                MaxLength="400" DataType="String" BindType="Both"
                                                TextMode="MultiLine"></cc1:XUITextBox>
                                            <asp:RegularExpressionValidator runat="server" ID="revRemark"
                                                ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$"
                                                ErrorMessage="Exceed maximum length 400" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
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
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                <header id="pnlTabsHeader" runat="server" class="panel-heading tab-bg-dark-navy-blue">
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
                <div class="panel-body">
                    <div class="tab-content tasi-tab">
                        <div class="tab-pane active" id="AssetList">
                            <asp:Panel runat="server" ID="pnlAssetList">
                                <section class="panel">
                                    <header class="panel-heading">
                                        <span>Asset List</span>
                                    </header>
                                    <div class="panel-heading">
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <cc1:XUILinkButton ID="btnAdd" RoleCode="R90000070E" runat="server"
                                                    CssClass="btn btn-primary" OnClick="btnAdd_Click"
                                                    CausesValidation="false"><i class="icon-plus"></i> Create
                                                </cc1:XUILinkButton>
                                                <cc1:XUILinkButton ID="btnSaveDetail" RoleCode="R90000070E" runat="server"
                                                    CssClass="btn btn-primary" OnClick="btnSaveDetail_Click" 
                                                    CausesValidation="false"><i class="icon-save"></i> Save
                                                </cc1:XUILinkButton>
                                                <cc1:XUILinkButton ID="btnDelete" RoleCode="R90000070E" runat="server"
                                                    CssClass="btn btn-danger" OnClick="btnDelete_Click"
                                                    CausesValidation="false"><i class="icon-trash"></i> Delete
                                                </cc1:XUILinkButton>
                                                <a id="btnMove" href="#" class="btn btn-purple"
                                                    onclick="return handleMovePopup();">
                                                    <i class="icon-arrow-right"></i> Move
                                                </a>
                                            </div>
                                            <div class="col-sm-4">
                                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"
                                                    class="input-group">
                                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                                        placeholder="Keywords"></asp:TextBox>
                                                    <div class="input-group-btn">
                                                        <asp:LinkButton ID="btnSearch" runat="server"
                                                            CssClass="btn btn-info" OnClick="btnSearch_Click"
                                                            CausesValidation="false"><i class="icon-search"></i> Search
                                                        </asp:LinkButton>
                                                    </div>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-body">
                                        <asp:UpdatePanel ID="upd" runat="server">
                                            <ContentTemplate>
                                                <asp:HiddenField ID="hdnSelectedParentID" runat="server" />
                                                <asp:GridView ID="gvwList" runat="server"
                                                    CssClass="display table table-bordered table-striped grid-auto"
                                                    AutoGenerateColumns="false" AllowPaging="true" PageSize="10"
                                                    DataKeyNames="ID,is_parent"
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
                                                                    onclick="checkAssetRowsAll(this)" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chbSelect" runat="server"
                                                                    onclick="checkAssetRowClick(this);" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="BARCODE" HeaderText="Asset Code">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Asset Name">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="category" HeaderText="Asset category">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="owner" HeaderText="Owner">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="mod_by" HeaderText="Modified By">
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Parent">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hdnDetailID" runat="server"
                                                                    Value='<%# Eval("ID") %>' />
                                                                <asp:HiddenField ID="hdnIsParent" runat="server"
                                                                    Value='<%# Eval("is_parent") %>' />
                                                                <asp:CheckBox ID="chkParent" runat="server"
                                                                    Checked='<%# IsCheckedValue(Eval("is_parent")) %>'
                                                                    onclick='<%# "return singleCheck(this, \"" + Eval("ID") + "\");" %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="btnSaveDetail" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </section>
                            </asp:Panel>
                        </div>
                        <div class="tab-pane" id="MovementHistory">
                            <asp:Panel runat="server" ID="pnlMovementHistory">
                                <section class="panel">
                                    <header class="panel-heading">
                                        <span>Movement Grouping Asset History</span>
                                    </header>
                                    <div class="panel-heading">
                                        <div class="row">
                                            <div class="col-sm-8">
                                            </div>
                                            <div class="col-sm-4">
                                                <asp:Panel ID="pnlSearchHistory" runat="server"
                                                    DefaultButton="btnSearch" class="input-group">
                                                    <asp:TextBox ID="txtSearchHistory" runat="server"
                                                        CssClass="form-control" placeholder="Keywords"></asp:TextBox>
                                                    <div class="input-group-btn">
                                                        <asp:LinkButton ID="btnSearchHistory" runat="server"
                                                            CssClass="btn btn-info" OnClick="btnSearchHistory_Click"
                                                            CausesValidation="false"><i class="icon-search"></i> Search
                                                        </asp:LinkButton>
                                                    </div>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-body">
                                        <asp:UpdatePanel ID="updpnlMovementHistory" runat="server">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvwMovementHistory" runat="server"
                                                    CssClass="display table table-bordered table-striped grid-auto"
                                                    AutoGenerateColumns="false" AllowPaging="true" PageSize="10"
                                                    DataKeyNames="historyid"
                                                    onselectedindexchanged="gvwMovementHistory_SelectedIndexChanged"
                                                    EmptyDataText="There Is No Data" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <HeaderTemplate><span>No</span></HeaderTemplate>
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                Asset Code<br />Asset Item
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <strong>
                                                                    <%# Eval("barcode") %>
                                                                </strong><br />
                                                                <span style="color: #333;">
                                                                    <%# Eval("item_name") %>
                                                                </span>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="asset_category"
                                                            HeaderText="Asset Category"></asp:BoundField>
                                                        <asp:BoundField DataField="cre_date" HeaderText="Date"
                                                            DataFormatString="{0:dd/MM/yyyy}"
                                                            ItemStyle-HorizontalAlign="Center">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="action" HeaderText="Type Transaksi">
                                                        </asp:BoundField>

                                                        <asp:BoundField DataField="doc_reff_no"
                                                            HeaderText="Doc. Reff No" NullDisplayText="-">
                                                        </asp:BoundField>


                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <HeaderTemplate>
                                                                <u>PIC Asset</u><br />Mut.
                                                                From Branch
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <%# string.IsNullOrEmpty(Eval("pic_from").ToString())
                                                                    ? "-" : Eval("pic_from") %>
                                                                    <hr
                                                                        style="margin: 3px 0; border-top: 1px solid #000;" />
                                                                    <strong>
                                                                        <%# Eval("branch_from") %>
                                                                    </strong>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <HeaderTemplate>
                                                                <u>PIC
                                                                    Asset</u><br />Mut.
                                                                To Branch
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <%# string.IsNullOrEmpty(Eval("pic_to").ToString())
                                                                    ? "-" : Eval("pic_to") %>
                                                                    <hr
                                                                        style="margin: 3px 0; border-top: 1px solid #000;" />
                                                                    <strong>
                                                                        <%# Eval("branch_to") %>
                                                                    </strong>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </section>
                            </asp:Panel>

                        </div>
                    </div>
                </div>

            </section>
        </asp:Content>
