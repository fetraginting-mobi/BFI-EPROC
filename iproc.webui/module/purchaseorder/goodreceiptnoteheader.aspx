<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="goodreceiptnoteheader.aspx.cs" Inherits="module_purchaseorder_goodreceiptnoteheader" %>

    <%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
            <section class="panel">
                <header class="panel-heading">
                    <span>Good Receipt Note Info</span>
                </header>
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-12">
                            <cc1:XUILinkButton ID="btnSave" RoleCode="R50000080E" runat="server"
                                CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i> Save
                            </cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="R50000080O" ID="btnApprovalTiered" Visible="false"
                                runat="server" CssClass="btn btn-success"><i class="icon-ok"></i> Approval
                            </cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnPost" RoleCode="R50000080O" runat="server"
                                CssClass="btn btn-success"><i class="icon-envelope"></i> Post</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnReject" RoleCode="R50000080O" runat="server"
                                CssClass="btn btn-danger" CausesValidation="false"><i class="icon-remove"></i> Cancel
                            </cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnCancelGRN" RoleCode="R50000080O" runat="server" CssClass="btn btn-danger"
                                OnClick="btnCancelGRN_Click" CausesValidation="false"><i class="icon-remove"></i> Cancel
                                GRN</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnPrint" RoleCode="R50000080P" runat="server"
                                CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i
                                    class="icon-print"></i> Print</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnPrintBAST" RoleCode="R50000080P" runat="server"
                                CssClass="btn btn-primary" OnClick="btnPrintBAST_Click" CausesValidation="false"><i
                                    class="icon-print"></i> Print BAST</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger"
                                OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i> Cancel
                            </cc1:XUILinkButton>

                        </div>
                    </div>
                </div>
                <div class="panel-body form-horizontal">
                    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                        <ContentTemplate>

                            <cc1:XUILabel ID="lblOrderType" runat="server" DBColumnName="ORDER_TYPE" DataType="String"
                                BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">GRN No.</label>
                                        <!--CODE BARCODE-->
                                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE"
                                            SPParameterName="p_code_barcode" DataType="String" style="display:none"
                                            BindType="Both"></cc1:XUILabel>
                                        <%--ID APPROVEL--%>
                                            <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server"
                                                DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer"
                                                style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                                            <cc1:XUILabel ID="lblAmount" runat="server"
                                                SPParameterName="p_object_amount" DataType="Number" Text="100"
                                                style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel>
                                            <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"
                                                DBColumnName="BRANCH" DataType="String" BindType="None"
                                                style="display:none"></cc1:XUITextBox>
                                            <div class="col-sm-8">
                                                <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE"
                                                    SPParameterName="p_grn_code" DataType="String" BindType="Both"
                                                    Text="--"></cc1:XUILabel>
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
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtReceiveDate" runat="server"
                                                CssClass="form-control default-date-picker" placeholder="Receive Date"
                                                DBColumnName="RECEIVE_DATE" SPParameterName="p_receive_date"
                                                MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy">
                                            </cc1:XUITextBox>
                                            <asp:RequiredFieldValidator ID="rfvReceiveDate" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtReceiveDate"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                        <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server"
                                            ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy"
                                            ControlToValidate="txtReceiveDate"
                                            ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)"
                                            Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Branch</label>
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
                                                        <cc1:XUILabel ID="lblBranch" runat="server"
                                                            DBColumnName="BRANCH_CODE" DataType="String"
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
                                        <label class="col-sm-4">PO No. *</label>
                                        <div class="col-sm-8">
                                            <asp:LinkButton runat="server" ID="btnLookUpPurchaseOrderCode"
                                                class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i
                                                    class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtPurchaseOrderCode" style="display:none"
                                                runat="server" CssClass="form-control"
                                                DBColumnName="PURCHASE_ORDER_CODE"
                                                SPParameterName="p_purchase_order_code" MaxLength="14" DataType="String"
                                                BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblPurchaseOrderCode" runat="server"
                                                DBColumnName="CODE_BARCODE" DataType="String" BindType="DBToUIOnly"
                                                Text="-" style="display:none"></cc1:XUILabel>
                                            <cc1:XUILabel ID="lblPOCode" runat="server" DBColumnName="PO_CODE"
                                                DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                            <asp:RequiredFieldValidator ID="rfvPurchaseOrderCode" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtPurchaseOrderCode"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="col-sm-2">
                                            <cc1:XUILinkButton ID="btnViewHistory" runat="server"
                                                CausesValidation="false" Text="View PO"></cc1:XUILinkButton>
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
                                                        InitialValue="-"></asp:RequiredFieldValidator>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Supplier</label>
                                        <div class="col-sm-8">
                                            <cc1:XUITextBox ID="txtSupplierID" style="display:none" runat="server"
                                                CssClass="form-control" DBColumnName="SUPPLIER_CODE"
                                                SPParameterName="p_supplier_code" DataType="String" BindType="Both">
                                            </cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblSupplierName" runat="server"
                                                DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly"
                                                Text="-"></cc1:XUILabel>
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
                                                        ControlToValidate="ddlDepartment" InitialValue="0"
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
                                <div class="col-sm-6" runat="server">
                                    <div class="form-group">
                                        <label class="col-sm-4">Supplier Rating *</label>
                                        <div class="col-sm-6">
                                            <cc1:XUIDropDownList ID="ddlRating" runat="server" CssClass="form-control"
                                                DBColumnName="RATING" SPParameterName="p_rating" BindType="Both"
                                                DataType="String">
                                                <asp:ListItem Value="0">-=Select=-</asp:ListItem>
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem>
                                                <asp:ListItem Value="3">3</asp:ListItem>
                                                <asp:ListItem Value="4">4</asp:ListItem>
                                                <asp:ListItem Value="5">5</asp:ListItem>
                                            </cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="rfvRating" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="ddlRating"
                                                InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                <%--(+) Ari 30-12-2022 ket : enhancement 2022, jika group role multiplebranch dapat
                                    akses pilih branch--%>
                                    <div class="col-sm-6" style="display:none">
                                        <div class="form-group">
                                            <label class="col-sm-3">Is Multiplebranch</label>
                                            <div class="col-sm-8">
                                                <cc1:XUILabel ID="lblMultiplebranch" runat="server"
                                                    DBColumnName="MULTIPLEBRANCH" BindType="DBToUIOnly"
                                                    DataType="String"></cc1:XUILabel>
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
                                                            InitialValue="0" Display="Dynamic">
                                                        </asp:RequiredFieldValidator>
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
                                        <label class="col-sm-4">Remarks *</label>
                                        <div class="col-sm-6">
                                            <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control"
                                                placeholder="Description" DBColumnName="REMARKS"
                                                SPParameterName="p_remarks" MaxLength="400" DataType="String"
                                                BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                            <asp:RequiredFieldValidator ID="rvfRemarks" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtRemarks"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Created </label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName="EMP_CRE"
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
                                            <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName="EMP_MOD"
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
            <asp:Panel runat="server" ID="pnlItemList">
                <section class="panel">
                    <header class="panel-heading tab-bg-dark-navy-blue">
                        <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                        <ul class="nav nav-tabs nav-justified">
                            <li class="active">
                                <a href="#ItemList" id="itemlist" onclick="javascript:fnSetTab('itemlist');"
                                    data-toggle="tab">
                                    Item List
                                </a>
                            </li>
                            <li>
                                <a href="#UploadDoc" id="uploaddoc" onclick="javascript:fnSetTab('uploaddoc');"
                                    data-toggle="tab">
                                    Upload Doc
                                </a>
                            </li>
                        </ul>
                    </header>
                    <div class="panel-body">
                        <div class="tab-content tasi-tab">
                            <div class="tab-pane active" id="ItemList">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-sm-8">
                                            <%--<asp:LinkButton ID="btnAddRequestDetail" runat="server"
                                                CssClass="btn btn-primary" OnClick="btnAddRequestDetail_Click"
                                                CausesValidation="false"><i class="icon-plus"></i> Create
                                                </asp:LinkButton>--%>
                                                <cc1:XUILinkButton RoleCode="R50000080E" ID="btnDeleteRequestDetail"
                                                    runat="server" CssClass="btn btn-danger"
                                                    OnClick="btnDeleteRequestDetail_Click" CausesValidation="false"><i
                                                        class="icon-trash"></i> Delete</cc1:XUILinkButton>
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
                                                PageSize="10" DataKeyNames="ID" OnRowDataBound="gvwList_OnRowDataBound"
                                                ShowFooter="true" OnPageIndexChanging="gvwList_PageIndexChanging"
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
                                                    <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                                        <ItemStyle Width="40%" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="JENIS_ITEM1" HeaderText="Item Type">
                                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="LOCATION_DESC" HeaderText="Location">
                                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PO_QUANTITY" HeaderText="PO Quantity"
                                                        DataFormatString="{0:N2}">
                                                        <ItemStyle Width="10%" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="RECEIVE_QUANTITY" HeaderText="Receive"
                                                        DataFormatString="{0:N2}">
                                                        <ItemStyle Width="10%" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="UNIT_DESC" HeaderText="Unit">
                                                        <ItemStyle Width="10%" HorizontalAlign="Right" />
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
                            <div class="tab-pane" id="UploadDoc">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-sm-8 ">
                                            <cc1:XUILinkButton RoleCode="R30000150E" ID="btnAddUploadDoc" runat="server"
                                                CssClass="btn btn-primary" OnClick="btnAddUploadDoc_Click"
                                                CausesValidation="false"><i class="icon-plus"></i> Create
                                            </cc1:XUILinkButton>
                                            <cc1:XUILinkButton RoleCode="R50000150E" ID="btnSaveDocumentDetail"
                                                runat="server" CssClass="btn btn-primary"
                                                OnClick="btnSaveDocumentDetail_Click" CausesValidation="false"><i
                                                    class="icon-save"></i> Save</cc1:XUILinkButton>
                                        </div>
                                        <div class="col-sm-4 ">
                                            <asp:Panel ID="pnlSearchDocReq" runat="server"
                                                DefaultButton="btnSearchDocReq" class="input-group">
                                                <asp:TextBox ID="txtSearchDocReq" runat="server"
                                                    CssClass="form-control"></asp:TextBox>
                                                <div class="input-group-btn">
                                                    <asp:LinkButton ID="btnSearchDocReq" runat="server"
                                                        CssClass="btn btn-info" OnClick="btnSearchDocReq_Click"><i
                                                            class="icon-search"></i> Search</asp:LinkButton>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <asp:GridView ID="gvwListDocReq" runat="server" AutoGenerateColumns="false"
                                        CssClass="display table table-bordered table-striped" AllowPaging="true"
                                        PageSize="10" DataKeyNames="GENERAL_DOC_CODE, GRN_CODE, PATHS, FILE, ID"
                                        OnPageIndexChanging="gvwListDocReq_PageIndexChanging"
                                        OnRowDataBound="gvwListDocReq_OnRowDataBound"
                                        OnRowCommand="gvwListDocReq_RowCommand"
                                        onselectedindexchanged="gvwListDocReq_SelectedIndexChanged"
                                        EmptyDataText="There is no data" AllowSorting="true">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <span>No</span>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Document">
                                                <ItemStyle Width="40%" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="File Name">
                                                <ItemStyle Width="60%" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("PATHS") %>'
                                                        ID="lblFileName" />
                                                    <br />
                                                    <asp:FileUpload runat="server" ID="fupFilename" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="btnPreviewDoc" runat="server">Preview</asp:Label>
                                                        --%>
                                                        <asp:LinkButton ID="btnPreviewDoc" runat="server"
                                                            CausesValidation="false" Text="Preview" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnDeleteDoc" runat="server"
                                                        CausesValidation="false" Text="Delete" CommandName="del" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </asp:Panel>
        </asp:Content>