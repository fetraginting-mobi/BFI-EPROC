<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="farequestmutationheader.aspx.cs"
    Inherits="module_fa_farequestmutationheader" Title="Untitled Page" %>

    <%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
            <script type="text/javascript">
                function fnShowFaMutationUploadLogTab() {
                    $('#mutation').removeClass('active');
                    $('#mutationuploadlog').addClass('active');
                    $('#mutdetail').parent().removeClass('active');
                    $('#lnkMutationUploadLog').parent().addClass('active');
                    fnSetTab('mutationuploadlog');
                    return false;
                }

                function fnShowFaMutationDetailTab() {
                    $('#mutationuploadlog').removeClass('active');
                    $('#mutation').addClass('active');
                    $('#lnkMutationUploadLog').parent().removeClass('active');
                    $('#mutdetail').parent().addClass('active');
                    fnSetTab('mutdetail');
                    return false;
                }
            </script>
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
            <section class="panel">
                <header class="panel-heading">
                    <span>FA Mutation Info</span>
                </header>
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-12">
                            <cc1:XUILinkButton ID="btnSave" RoleCode="R90000080E" runat="server"
                                CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i> Save
                            </cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnPost" RoleCode="R90000080O" runat="server"
                                CssClass="btn btn-success" OnClick="btnPost_Click"><i class="icon-envelope"></i> Post</cc1:XUILinkButton>

                            <cc1:XUILinkButton ID="btnReject" RoleCode="R90000080O" runat="server"
                                CssClass="btn btn-danger" CausesValidation="false" style="display:none"><i
                                    class="icon-remove" style="display:none"></i> Cancel</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnCancel" RoleCode="R90000080O" runat="server"
                                CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i
                                    class="icon-remove"></i> Cancel</cc1:XUILinkButton>
                        </div>
                    </div>
                </div>
                <div class="panel-body form-horizontal">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-sm-6">
                                    <%--code barcode--%>
                                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE"
                                            SPParameterName="p_code_barcode" DataType="String" style="display:none"
                                            BindType="Both"></cc1:XUILabel>
                                            <cc1:XUITextBox ID="txtBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String" BindType="Both" style="display:none;" ></cc1:XUITextBox>
                                        <%--requestor--%>
                                            <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server"
                                                DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer"
                                                style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                                            <cc1:XUILabel ID="lblAmount" runat="server"
                                                SPParameterName="p_object_amount" DataType="Number" Text="100"
                                                style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel>
                                            <div class="form-group">
                                                <label class="col-sm-4">No.</label>
                                                <div class="col-sm-8">
                                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE"
                                                        DataType="String" BindType="DBToUIOnly" Text="--">
                                                    </cc1:XUILabel>
                                                    <cc1:XUITextBox ID="txtBranch" runat="server"
                                                        DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode"
                                                        MaxLength="14" DataType="String" BindType="None"
                                                        style="display:none;"></cc1:XUITextBox>
                                                    <cc1:XUITextBox ID="txtBranchRequest" runat="server"
                                                        CssClass="form-control" placeholder="Ref No."
                                                        DBColumnName="BRANCH_REQ" style="display:none;"
                                                        SPParameterName="p_branch_req" MaxLength="20" DataType="String"
                                                        BindType="Both"></cc1:XUITextBox>
                                                </div>
                                            </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Status</label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblTransFlagCode" runat="server"
                                                DBColumnName="TRANS_FLAG_DESC" BindType="DBToUIOnly" DataType="String"
                                                Text="--"></cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Date *</label>
                                        <div class="col-sm-4">
                                            <cc1:XUITextBox ID="txtRequestDate" runat="server"
                                                CssClass="form-control default-date-picker" placeholder="Request Date"
                                                DBColumnName="REQUEST_DATE" SPParameterName="p_request_date"
                                                MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy">
                                            </cc1:XUITextBox>
                                            <asp:RequiredFieldValidator ID="rfvRequestDate" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtRequestDate"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                        <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server"
                                            ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy"
                                            ControlToValidate="txtRequestDate"
                                            ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)"
                                            Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Process</label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblProcess" runat="server" DBColumnName="PROCESS"
                                                BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Upload ID</label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblUploadId" runat="server" DataType="String" Text="-">
                                            </cc1:XUILabel>
                                            </cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">From Branch</label>
                                        <div class="col-sm-6">
                                            <asp:UpdatePanel ID="UpB" runat="server">
                                                <ContentTemplate>
                                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"
                                                        DBColumnName="DESCRIPTION" DataType="String"
                                                        BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                                        <cc1:XUIDropDownList ID="ddlBranch" runat="server"
                                                            CssClass="form-control" DBColumnName="BRANCH_CODE"
                                                            SPParameterName="p_branch_code" DataType="String"
                                                            OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged"
                                                            AutoPostBack="true" BindType="Both"></cc1:XUIDropDownList>
                                                        <cc1:XUILabel ID="lblbranch" runat="server"
                                                            DBColumnName="BRANCH_CODE" DataType="String"
                                                            BindType="DBToUIOnly" Text="--" style="display:none;">
                                                        </cc1:XUILabel>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Requestor</label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblRequestor" runat="server" DBColumnName="REQUESTOR_DESC"
                                                DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">From Location</label>
                                        <div class="col-sm-6">
                                            <cc1:XUIDropDownList ID="ddlFromLocationCode" runat="server"
                                                CssClass="form-control" DBColumnName="FROM_LOCATION_CODE"
                                                SPParameterName="p_from_location_code" BindType="Both"
                                                DataType="String"></cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="rfvFromLocation" runat="server"
                                                ControlToValidate="ddlFromLocationCode" ErrorMessage="Value Required!"
                                                InitialValue="0"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Division</label>
                                        <div class="col-sm-6">
                                            <asp:UpdatePanel ID="updDiv" runat="server">
                                                <ContentTemplate>
                                                    <cc1:XUIDropDownList ID="ddlDivision" runat="server"
                                                        CssClass="form-control" DBColumnName="DIVISION_CODE"
                                                        SPParameterName="p_division_code"
                                                        OnSelectedIndexChanged="ddlDivision_SelectedIndexChanged"
                                                        AutoPostBack="true" DataType="String" BindType="Both">
                                                    </cc1:XUIDropDownList>
                                                    <asp:RequiredFieldValidator ID="revddlDivision" runat="server"
                                                        ControlToValidate="ddlDivision" ErrorMessage="Value Required!"
                                                        InitialValue="0"></asp:RequiredFieldValidator>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">To Branch</label>
                                        <div class="col-sm-6">
                                            <cc1:XUIDropDownList ID="ddlTocc" runat="server" CssClass="form-control"
                                                DBColumnName="BRANCH_CODE" SPParameterName="p_to_cost_center"
                                                DataType="String"
                                                OnSelectedIndexChanged="ddlToBranch_SelectedIndexChanged"
                                                AutoPostBack="true" BindType="Both"></cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="ddlTocc"
                                                InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Department</label>
                                        <div class="col-sm-6">
                                            <asp:UpdatePanel ID="updDep" runat="server">
                                                <ContentTemplate>
                                                    <cc1:XUIDropDownList ID="ddlDepartment" runat="server"
                                                        CssClass="form-control" DBColumnName="DEPARTMENT_CODE"
                                                        SPParameterName="p_department_code" AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged"
                                                        DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                                        runat="server" ErrorMessage="Required Field!"
                                                        ControlToValidate="ddlSubDepartment" InitialValue="0"
                                                        Display="Dynamic"></asp:RequiredFieldValidator>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddlDivision"
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
                                        <label class="col-sm-4">To Location</label>
                                        <div class="col-sm-6">
                                            <cc1:XUIDropDownList ID="ddlToLocationCode" runat="server"
                                                CssClass="form-control" DBColumnName="TO_LOCATION_CODE"
                                                SPParameterName="p_to_location_code" BindType="Both" DataType="String">
                                            </cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                ControlToValidate="ddlToLocationCode" ErrorMessage="Value Required!"
                                                InitialValue="0"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Sub Department</label>
                                        <div class="col-sm-6">
                                            <asp:UpdatePanel ID="updSub" runat="server">
                                                <ContentTemplate>
                                                    <cc1:XUIDropDownList ID="ddlSubDepartment" runat="server"
                                                        CssClass="form-control" DBColumnName="SUB_DEPARTMENT_CODE"
                                                        SPParameterName="p_sub_department_code"
                                                        OnSelectedIndexChanged="ddlSubDepartment_SelectedIndexChanged"
                                                        AutoPostBack="true" DataType="String" BindType="Both">
                                                    </cc1:XUIDropDownList>
                                                    <asp:RequiredFieldValidator ID="rfvddlSubDepartment" runat="server"
                                                        ErrorMessage="Required Field!"
                                                        ControlToValidate="ddlSubDepartment" InitialValue="0"
                                                        Display="Dynamic"></asp:RequiredFieldValidator>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddlDepartment"
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
                                        <label class="col-sm-4">Remarks</label>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control"
                                                placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks"
                                                MaxLength="400" TextMode="MultiLine" Height="58px" DataType="String"
                                                BindType="Both"></cc1:XUITextBox>
                                            <asp:RegularExpressionValidator runat="server" ID="valInput"
                                                ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$"
                                                ErrorMessage="Exceed maximum length 400" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Units</label>
                                        <div class="col-sm-6">
                                            <asp:UpdatePanel ID="updUn" runat="server">
                                                <ContentTemplate>
                                                    <cc1:XUIDropDownList ID="ddlUnits" runat="server"
                                                        CssClass="form-control" DBColumnName="UNITS_CODE"
                                                        SPParameterName="p_units_code" DataType="String"
                                                        BindType="Both"></cc1:XUIDropDownList>
                                                    <asp:RequiredFieldValidator ID="rfvddlUnits" runat="server"
                                                        ErrorMessage="Required Field!" ControlToValidate="ddlUnits"
                                                        InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddlSubDepartment"
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
                                        <label class="col-sm-4">Remarks Return</label>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtRemarksUnpost" runat="server" CssClass="form-control"
                                                placeholder="Remarks" ForeColor="Red" DBColumnName="REMARK_UNPOST"
                                                MaxLength="400" Enabled="false" Height="58px" TextMode="MultiLine"
                                                DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Owner</label>
                                        <div class="col-sm-8">
                                            <cc1:XUIDropDownList ID="ddlOwner" runat="server" CssClass="form-control"
                                                placeholder="" DBColumnName="OWNER" SPParameterName="p_owner"
                                                MaxLength="10" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="rfvOwner" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="ddlOwner"
                                                InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Created</label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName="REQUESTOR_DESC"
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
                                        <label class="col-sm-4">Modified</label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName="EMP_DESC"
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
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </section>

            <asp:Panel runat="server" ID="pnlInventoryRequest">
                <section class="panel">
                    <header class="panel-heading tab-bg-dark-navy-blue">
                        <ul class="nav nav-tabs nav-justified">
                            <li class="active">
                                <a href="#mutation" id="mutdetail" onclick="return fnShowFaMutationDetailTab();"
                                    data-toggle="tab" style="padding-bottom:28px">
                                    Mutation Detail
                                </a>
                            </li>
                            <li id="liMutationUploadLog" runat="server">
                                <a href="#mutationuploadlog" id="lnkMutationUploadLog"
                                    onclick="return fnShowFaMutationUploadLogTab();" data-toggle="tab"
                                    style="padding-bottom:28px">
                                    Post Upload Mutation History
                                </a>
                            </li>
                        </ul>
                    </header>
                    <div class="panel-body">
                        <div class="tab-content tasi-tab">
                            <div class="tab-pane active" id="mutation">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-sm-8">
                                            <%--<cc1:XUILinkButton ID="btnAddRequestDetail" RoleCode="R90000080E"
                                                runat="server" CssClass="btn btn-primary"
                                                OnClick="btnAddRequestDetail_Click"><i class="icon-plus"></i> Create
                                            </cc1:XUILinkButton>--%>
                                            <cc1:XUILinkButton ID="btnAddRequestDetail" RoleCode="R90000080E" runat="server" CssClass="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                            <cc1:XUILinkButton ID="btnDeleteRequestDetail" RoleCode="R90000080E"
                                                runat="server" CssClass="btn btn-danger"
                                                OnClick="btnDeleteRequestDetail_Click"><i class="icon-trash"></i> Delete
                                            </cc1:XUILinkButton>
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
                                            <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false"
                                                CssClass="display table table-bordered table-striped" AllowPaging="true"
                                                PageSize="10" DataKeyNames="ID"
                                                OnPageIndexChanging="gvwList_PageIndexChanging"
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
                                                            <asp:CheckBox ID="chbSelect" runat="server"
                                                                onclick="Check_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="ITEM_CODE" HeaderText="Asset Code">
                                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ITEM_NAME" HeaderText="Asset Name">
                                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ITEM_DESCRIPTION"
                                                        HeaderText="Description">
                                                        <ItemStyle Width="30%" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="RECEIVE_DATE" HeaderText="Receive Date"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="STATUS_RECEIVED"
                                                        HeaderText="Status Mutation">
                                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:CommandField ShowSelectButton="true" />
                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="btnDeleteRequestDetail"
                                                EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="tab-pane" id="mutationuploadlog">
                                <div class="panel-body">
                                    <asp:UpdatePanel ID="updmutationuploadlog" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvwListmutationuploadlog" runat="server"
                                                AutoGenerateColumns="false"
                                                CssClass="display table table-bordered table-striped" AllowPaging="true"
                                                PageSize="10" DataKeyNames="code_barcode"
                                                OnPageIndexChanging="gvwListMutationUploadlog_PageIndexChanging"
                                                EmptyDataText="There Is No Data" Width="100%">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate><span>No</span></HeaderTemplate>
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="date" HeaderText="Date"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="code_barcode" HeaderText="code_barcode"
                                                        Visible="false"></asp:BoundField>
                                                    <asp:BoundField DataField="process_name" HeaderText="Process">
                                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="item_code" HeaderText="Item Code">
                                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="item_name" HeaderText="Item">
                                                        <ItemStyle Width="17%" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="quantity" HeaderText="Quantity">
                                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="error_message"
                                                        HeaderText="Error message">
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </asp:Panel>
        </asp:Content>
