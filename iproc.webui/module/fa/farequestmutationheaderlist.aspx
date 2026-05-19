<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="farequestmutationheaderlist.aspx.cs" Inherits="module_fa_farequestmutationheaderlist"
    Title="Untitled Page" %>
    <%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
            <section class="panel">
                <header class="panel-heading">
                    <span>FA Mutation List</span>
                    <script type="text/javascript">
                        function toggleUploadButton() {
                            var fileInput = document.getElementById('<%= FileUploadControlMutation.ClientID %>');
                            var uploadBtn = document.getElementById('<%= btnUploadRowFormat.ClientID %>');

                            if (!fileInput || !uploadBtn)
                                return;

                            if (fileInput.value === "") {
                                uploadBtn.disabled = true;
                                if (uploadBtn.className.indexOf("disabled") === -1)
                                    uploadBtn.className += " disabled";
                            } else {
                                uploadBtn.disabled = false;
                                uploadBtn.className = uploadBtn.className.replace(" disabled", "");
                            }
                        }

                        window.onload = function () {
                            toggleUploadButton();
                        };
                    </script>
                </header>
                <header class="panel-heading tab-bg-dark-navy-blue">
                    <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                    <ul class="nav nav-tabs nav-justified">
                        <li class="active">
                            <a href="#famutation" id="inventory" onclick="javascript:fnSetTab('inventory');"
                                data-toggle="tab">
                                FA Mutation
                            </a>
                        </li>
                        <li>
                            <a href="#uploadfamutation" id="uploadinventory"
                                onclick="javascript:fnSetTab('uploadinventory');" data-toggle="tab">
                                FA Upload Mutation
                            </a>
                        </li>
                    </ul>
                </header>

                <div class="panel-body">
                    <div class="tab-content">
                        <div class="tab-pane active" id="famutation">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-sm-8">
                                        <cc1:XUILinkButton RoleCode="R90000080C" ID="btnAdd" runat="server"
                                            CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>
                                            Create
                                        </cc1:XUILinkButton>
                                        <cc1:XUILinkButton RoleCode="R90000080D" ID="btnDelete" runat="server"
                                            CssClass="btn btn-danger" OnClick="btnDelete_Click"><i
                                                class="icon-trash"></i>
                                            Delete</cc1:XUILinkButton>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"
                                            class="input-group">
                                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                                placeholder="Keywords"></asp:TextBox>
                                            <div class="input-group-btn">
                                                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info"
                                                    OnClick="btnSearch_Click"><i class="icon-search"></i> Search
                                                </asp:LinkButton>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label class="col-sm-3">Status</label>
                                            <div class="col-sm-5">
                                                <cc1:XUIDropDownList ID="ddlStatus" Width="200px" runat="server"
                                                    CssClass="form-control" SPParameterName="p_status" DataType="String"
                                                    BindType="Both" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                                    <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                                    <asp:ListItem Text="NEW" Value="NEW"></asp:ListItem>
                                                    <asp:ListItem Text="POST" Value="POST"></asp:ListItem>
                                                    <asp:ListItem Text="PENDING" Value="PENDING"></asp:ListItem>
                                                    <asp:ListItem Text="RETURNED" Value="RETURNED"></asp:ListItem>
                                                </cc1:XUIDropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="col-sm-3">Cost Center</label>
                                            <div class="col-sm-5">
                                                <cc1:XUIDropDownList ID="ddlBranch" runat="server"
                                                    CssClass="form-control" DBColumnName="BRANCH_CODE"
                                                    SPParameterName="p_branch_code" DataType="String" BindType="Both"
                                                    AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged">
                                                </cc1:XUIDropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group"></div>
                                    </div>
                                </div>
                                <asp:UpdatePanel ID="upd" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false"
                                            CssClass="display table table-bordered table-striped" AllowPaging="true"
                                            PageSize="10" DataKeyNames="CODE_BARCODE"
                                            OnPageIndexChanging="gvwList_PageIndexChanging"
                                            onselectedindexchanged="SelectedIndexChanged"
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
                                                        <asp:CheckBox ID="chbSelect" runat="server"
                                                            onclick="Check_Click" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CODE" HeaderText="FA Mutation Request No.">
                                                    <ItemStyle Width="15%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CODE_BARCODE" HeaderText="Reff No.">
                                                    <ItemStyle Width="15%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="REQUEST_DATE" HeaderText="Date"
                                                    DataFormatString="{0:dd/MM/yyyy}">
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="BRANCH_NAME" HeaderText="From Cost Center">
                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="BRANCH_NAME_TO" HeaderText="To Cost Center">
                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DIVISION_NAME" HeaderText="Division">
                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DEPARTMENT_NAME" HeaderText="Department">
                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="EMP_NAME" HeaderText="Requestor">
                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                                    <ItemStyle Width="5%" HorizontalAlign="Center" />
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
                        </div>
                        <div class="tab-pane" id="uploadfamutation">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-sm-8">
                                        <div class="form-group">
                                            <label>Upload Excel : </label>
                                            <asp:FileUpload ID="FileUploadControlMutation" runat="server"
                                                onchange="toggleUploadButton()" />
                                            <div style="margin-top:10px;">
                                                <cc1:XUIButton ID="btnUploadRowFormat" RoleCode="R60000110O"
                                                    runat="server" CssClass="btn btn-primary disabled" Text="Upload"
                                                    Enabled="false" OnClick="btnUploadRowFormat_Click" />
                                                <cc1:XUIButton ID="btnDownload" RoleCode="R60000110O" runat="server"
                                                    Text="Download Template" CssClass="btn btn-info"
                                                    OnClick="btnDownload_Click" />
                                                <cc1:XUILinkButton ID="btnPost" RoleCode="R60000110O" runat="server"
                                                    CssClass="btn btn-success" OnClick="btnPost_Click"><i
                                                        class="icon-envelope"></i> Post
                                                </cc1:XUILinkButton>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Panel ID="pnlSearchUpload" runat="server" DefaultButton="btnSearch"
                                            class="input-group">
                                            <asp:TextBox ID="txtSearchUpload" runat="server" CssClass="form-control"
                                                placeholder="Keywords"></asp:TextBox>
                                            <div class="input-group-btn">
                                                <asp:LinkButton ID="btnSearchUpload" runat="server"
                                                    CssClass="btn btn-info" OnClick="btnSearch_Click">
                                                    <i class="icon-search"></i> Search
                                                </asp:LinkButton>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>

                                <!-- <div class="row">
                                    <div class="col-sm-8">
                                        <asp:GridView ID="gvwUploadLog" runat="server" AutoGenerateColumns="false"
                                            CssClass="display table table-bordered table-striped" AllowPaging="true"
                                            PageSize="5" DataKeyNames="upload_id,file_name"
                                            OnPageIndexChanging="gvwUploadLog_PageIndexChanging"
                                            OnRowCommand="gvwUploadLog_RowCommand" EmptyDataText="There Is No Data"
                                            Width="100%" Style="margin-top:10px;">
                                            <Columns>
                                                <asp:TemplateField ItemStyle-Width="2%">
                                                    <HeaderTemplate>
                                                        <span>No</span>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="upload_date" HeaderText="Date Upload">
                                                    <ItemStyle Width="15%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="upload_id" Visible="false">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="file_name" HeaderText="File Name">
                                                    <ItemStyle Width="30%" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="total_rows" HeaderText="Total Upload Data">
                                                    <ItemStyle Width="15%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Total Valid">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkValid" runat="server"
                                                            Visible='<%# Convert.ToInt32(Eval("total_valid")) > 0 %>'
                                                            Text='<%# Eval("total_valid") %>' CommandName="VIEW_VALID"
                                                            CommandArgument='<%# Eval("upload_id") + "|" + Eval("file_name") %>'
                                                            Style="color:Green" />

                                                        <asp:Label ID="lblValid" runat="server"
                                                            Visible='<%# Convert.ToInt32(Eval("total_valid")) == 0 %>'
                                                            Text="0" />
                                                    </ItemTemplate>
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Total Error">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkError" runat="server"
                                                            Visible='<%# Convert.ToInt32(Eval("total_error")) > 0 %>'
                                                            Text='<%# Eval("total_error") %>' CommandName="VIEW_ERROR"
                                                            CommandArgument='<%# Eval("upload_id") + "|" + Eval("file_name") %>'
                                                            Style="color:Red" />

                                                        <asp:Label ID="lblError" runat="server"
                                                            Visible='<%# Convert.ToInt32(Eval("total_error")) == 0 %>'
                                                            Text="0" />

                                                    </ItemTemplate>
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div> -->
                            </div>
                            <div class="panel-body">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class="col-sm-3">From Cost Center</label>
                                        <div class="col-sm-5">
                                            <!-- Tambahkan AutoPostBack, OnSelectedIndexChanged, dan ListItem Hardcode -->
                                            <cc1:XUIDropDownList ID="ddlFromBranch" Width="200px" runat="server"
                                                CssClass="form-control" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlFromBranch_SelectedIndexChanged">
                                            </cc1:XUIDropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class="col-sm-3">From Location</label>
                                        <div class="col-sm-5">
                                            <cc1:XUIDropDownList ID="ddlFromLocation" Width="200px" runat="server"
                                                CssClass="form-control" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlFromLocation_SelectedIndexChanged">
                                            </cc1:XUIDropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class="col-sm-3">To Cost Center</label>
                                        <div class="col-sm-5">
                                            <!-- Tambahkan AutoPostBack, OnSelectedIndexChanged, dan ListItem Hardcode -->
                                            <cc1:XUIDropDownList ID="ddltoBranch" Width="200px" runat="server"
                                                CssClass="form-control" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlToBranch_SelectedIndexChanged">
                                            </cc1:XUIDropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class="col-sm-3">To Location</label>
                                        <div class="col-sm-5">
                                            <!-- Tambahkan AutoPostBack, OnSelectedIndexChanged, dan ListItem Hardcode -->
                                            <cc1:XUIDropDownList ID="ddltoLocation" Width="200px" runat="server"
                                                CssClass="form-control" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlToLocation_SelectedIndexChanged">
                                            </cc1:XUIDropDownList>
                                        </div>
                                    </div>
                                </div>

                                <hr style="border-top: 2px solid #ccc;" />
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group"></div>
                                    </div>
                                </div>
                                <asp:UpdatePanel ID="updUpload" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvwListUpload" runat="server" AutoGenerateColumns=" false"
                                            CssClass="display table table-bordered table-striped" AllowPaging="true"
                                            PageSize="10" DataKeyNames="CODE_BARCODE"
                                            OnPageIndexChanging="gvwListUpload_PageIndexChanging"
                                            onselectedindexchanged="SelectedUploadIndexChanged"
                                            EmptyDataText="There Is No Data">
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
                                                        <asp:CheckBox ID="chbSelectAllUpload" runat="server"
                                                            onclick="checkAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chbSelectUpload" runat="server"
                                                            onclick="Check_Click" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CODE" HeaderText="FA Mutation Request No.">
                                                    <ItemStyle Width="25%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CODE_BARCODE" Visible="false">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="MUTATION_DATE" HeaderText="Date"
                                                    DataFormatString="{0:dd/MM/yyyy}">
                                                    <ItemStyle Width="15%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="FROM_BRANCH" HeaderText="From Cost Center">
                                                    <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TO_BRANCH" HeaderText="To Cost Center">
                                                    <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="IS_UPLOAD" HeaderText="Process">
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:CommandField ShowSelectButton="true" HeaderText="Action" />
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                    <Triggers>
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <div style="display:none;">
                <asp:Label ID="lblDummyBarcode" runat="server" Text="BULK_POST"></asp:Label>
                <asp:Label ID="lblDummyBranch" runat="server" Text="ALL"></asp:Label>
                <asp:Label ID="lblDummyAmount" runat="server" Text="0"></asp:Label>
                <asp:Label ID="lblDummyCode" runat="server" Text="BULK_CODE"></asp:Label>
                <asp:Label ID="lblDummyRemarks" runat="server" Text="Bulk Post FA Mutation"></asp:Label>
            </div>
        </asp:Content>