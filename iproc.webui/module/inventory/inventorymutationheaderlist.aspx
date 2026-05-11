<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="inventorymutationheaderlist.aspx.cs" Inherits="module_inventory_inventorymutationheaderlist" %>
    <%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
            <section class="panel">
                <header class="panel-heading">
                    <span>Inventory Mutation List</span>
                    <script type="text/javascript">
                        function toggleUploadButton() {
                            var fileInput = document.getElementById('<%= FileUploadControlMutation.ClientID %>');
                            var uploadBtn = document.getElementById('<%= btnUploadRowFormat.ClientID %>');

                            if (!fileInput || !uploadBtn) return;

                            if (fileInput.value === "") {
                                uploadBtn.disabled = true;
                                if (uploadBtn.className.indexOf("disabled") === -1)
                                    uploadBtn.className += " disabled";
                            } else {
                                uploadBtn.disabled = false;
                                uploadBtn.className = uploadBtn.className.replace(" disabled", "");
                            }
                        }
                        window.onload = function () { toggleUploadButton(); };
                    </script>
                </header>

                <header class="panel-heading tab-bg-dark-navy-blue">
                    <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                    <ul class="nav nav-tabs nav-justified">
                        <li class="active">
                            <a href="#invmutation" id="inventory" onclick="javascript:fnSetTab('inventory');"
                                data-toggle="tab">
                                Fixed Asset
                            </a>
                        </li>
                        <li>
                            <a href="#uploadinvmutation" id="uploadinventory"
                                onclick="javascript:fnSetTab('uploadinventory');" data-toggle="tab">
                                Upload Inventory Mutation
                            </a>
                        </li>
                    </ul>
                </header>

                <div class="panel-body">
                    <div class="tab-content">

                        <div class="tab-pane active" id="invmutation">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-sm-8">
                                        <cc1:XUILinkButton RoleCode="R60000110C" ID="btnAdd" runat="server"
                                            CssClass="btn btn-primary" OnClick="btnAdd_Click">
                                            <i class="icon-plus"></i> Create
                                        </cc1:XUILinkButton>
                                        <cc1:XUILinkButton RoleCode="R60000110D" ID="btnDelete" runat="server"
                                            CssClass="btn btn-danger" OnClick="btnDelete_Click">
                                            <i class="icon-trash"></i> Delete
                                        </cc1:XUILinkButton>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"
                                            class="input-group">
                                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                                placeholder="Keywords"></asp:TextBox>
                                            <div class="input-group-btn">
                                                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info"
                                                    OnClick="btnSearch_Click">
                                                    <i class="icon-search"></i> Search
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
                                                    CssClass="form-control" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="col-sm-2">Branch</label>
                                            <div class="col-sm-5">
                                                <cc1:XUIDropDownList ID="ddlBranch" runat="server"
                                                    CssClass="form-control" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" />
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
                                            EmptyDataText="There Is No Data">
                                            <Columns>
                                                <asp:TemplateField HeaderText="No">
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
                                                <asp:BoundField DataField="CODE" HeaderText="Inventory Mutation No." />
                                                <asp:BoundField DataField="MUTATION_DATE" HeaderText="Date"
                                                    DataFormatString="{0:dd/MM/yyyy}" />
                                                <asp:BoundField DataField="FROM_BRANCH" HeaderText="From Branch" />
                                                <asp:BoundField DataField="TO_BRANCH" HeaderText="To Branch" />
                                                <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status" />
                                                <asp:CommandField ShowSelectButton="true" />
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>

                        <div class="tab-pane" id="uploadinvmutation">
                            <div class="panel-body">
                                <div class="row" style="margin-bottom: 15px;">
                                    <div class="col-md-5">
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
                                                    CssClass="btn btn-success disabled" Enabled="false"
                                                    OnClick="btnPost_Click"><i class="icon-envelope"></i> Post
                                                </cc1:XUILinkButton>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-7 text-right">
                                        <div class="form-inline">
                                            <label>Keywords </label>
                                            <asp:TextBox ID="txtSearchUpload" runat="server" CssClass="form-control"
                                                placeholder="Keywords" style="width:200px;"></asp:TextBox>
                                            <asp:LinkButton ID="btnSearchUpload" runat="server" CssClass="btn btn-info"
                                                OnClick="btnSearch_Click">
                                                <i class="icon-search"></i>
                                            </asp:LinkButton>
                                        </div>
                                        <div class="form-inline" style="margin-top:10px;">
                                            <label>Status : </label>
                                            <cc1:XUIDropDownList ID="ddlStatusUpload" Width="150px" runat="server"
                                                CssClass="form-control" AutoPostBack="true" />

                                            <label style="margin-left:15px;">Branch: </label>
                                            <cc1:XUIDropDownList ID="ddlBranchUpload" Width="180px" runat="server"
                                                CssClass="form-control" AutoPostBack="true" />
                                        </div>
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <asp:GridView ID="gvUploadLog" runat="server" AutoGenerateColumns="false"
                                        CssClass="table table-bordered text-center">
                                        <Columns>
                                            <asp:BoundField HeaderText="No" DataField="NO" />
                                            <asp:BoundField HeaderText="Date Upload" DataField="DATE_UPLOAD" />
                                            <asp:BoundField HeaderText="Upload By" DataField="UPLOAD_BY" />
                                            <asp:BoundField HeaderText="File Name" DataField="FILE_NAME" />
                                            <asp:BoundField HeaderText="Total Row" DataField="TOTAL_ROW" />
                                            <asp:BoundField HeaderText="Total Valid" DataField="TOTAL_VALID" />
                                            <asp:BoundField HeaderText="Total Error" DataField="TOTAL_ERROR" />
                                        </Columns>
                                    </asp:GridView>
                                </div>

                                <hr style="border-top: 2px solid #ccc;" />

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group"></div>
                                    </div>
                                </div>
                                <asp:UpdatePanel ID="updUpload" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvwListUpload" runat="server"
                                            onclick="togglePostButton()" AutoGenerateColumns=" false"
                                            CssClass="display table table-bordered table-striped" AllowPaging="true"
                                            PageSize="10" DataKeyNames="CODE_BARCODE"
                                            OnPageIndexChanging="gvwList_PageIndexChanging"
                                            onselectedindexchanged="SelectedIndexChanged"
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
                                                        <asp:CheckBox ID="chbSelectAll" runat="server"
                                                            onclick="checkAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chbSelect" runat="server"
                                                            onclick="Check_Click" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CODE" HeaderText="Inventory Mutation No.">
                                                    <ItemStyle Width="25%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="MUTATION_DATE" HeaderText="Date"
                                                    DataFormatString="{0:dd/MM/yyyy}">
                                                    <ItemStyle Width="25%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="FROM_BRANCH" HeaderText="From Branch">
                                                    <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TO_BRANCH" HeaderText="To Branch">
                                                    <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
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
                    </div>
                </div>
            </section>
        </asp:Content>