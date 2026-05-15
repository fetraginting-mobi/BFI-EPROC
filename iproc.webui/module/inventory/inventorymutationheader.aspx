<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="inventorymutationheader.aspx.cs" Inherits="module_inventory_inventorymutationheader" %>

    <%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
            <section class="panel">
                <header class="panel-heading">
                    <span>Inventory Mutation Info</span>
                </header>
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-12">
                            <cc1:XUILinkButton ID="btnSave" RoleCode="R60000110E" runat="server"
                                CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i> Save
                            </cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="R60000110O" ID="btnApprovalTiered" runat="server"
                                CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i> Approval
                            </cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnPost" RoleCode="R60000110O" runat="server"
                                CssClass="btn btn-success"><i class="icon-envelope"></i> Post</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnReject" RoleCode="R60000110O" runat="server"
                                CssClass="btn btn-danger" CausesValidation="false"><i class="icon-remove"></i> Cancel
                            </cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger"
                                OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i> Cancel
                            </cc1:XUILinkButton>
                        </div>
                    </div>
                </div>
                <div class="panel-body form-horizontal">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">No.</label>
                                        <!--CODE BARCODE-->
                                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE"
                                            SPParameterName="p_code_barcode" MaxLength="14" DataType="String"
                                            BindType="Both" style="display:none"></cc1:XUILabel>
                                        <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server"
                                            DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer"
                                            BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                                        <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount"
                                            DataType="Number" Text="100" style="display:none;" BindType="UIToDBOnly">
                                        </cc1:XUILabel>
                                        <cc1:XUITextBox ID="txtCodeBarcode" style="display:none" runat="server"
                                            CssClass="form-control" DBColumnName="CODE_BARCODE" DataType="String"
                                            BindType="DBToUIOnly"></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"
                                            placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks"
                                            MaxLength="400" DataType="String" style="display:none;" BindType="None">
                                        </cc1:XUITextBox>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE"
                                                DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false"
                                        Text="Approval History"></cc1:XUILinkButton>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Branch</label>
                                        <div class="col-sm-6">
                                            <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control"
                                                DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code"
                                                DataType="String" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" BindType="Both">
                                            </cc1:XUIDropDownList>
                                            <cc1:XUILabel ID="lblbranch" runat="server" DBColumnName="BRANCH_CODE"
                                                DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;">
                                            </cc1:XUILabel>
                                            <%--<cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="DESCRIPTION"
                                                DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
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
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Process</label>
                                        <div class="col-sm-8">
                                            <cc1:XUILabel ID="lblProcess" runat="server" DBColumnName="PROCESS"
                                                DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Date *</label>
                                        <div class="col-sm-4">
                                            <cc1:XUITextBox ID="txtMutationDate" runat="server"
                                                CssClass="form-control default-date-picker" placeholder="Mutation Date"
                                                DBColumnName="MUTATION_DATE" SPParameterName="p_mutation_date"
                                                MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy">
                                            </cc1:XUITextBox>
                                            <asp:RequiredFieldValidator ID="rfvMutationDate" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtMutationDate"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                        <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server"
                                            ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy"
                                            ControlToValidate="txtMutationDate"
                                            ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)"
                                            Display="Dynamic"></asp:RegularExpressionValidator>
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
                                        <label class="col-sm-4">Requestor *</label>
                                        <div class="col-sm-6">
                                            <asp:LinkButton runat="server" ID="btnLookUpRequestoro"
                                                class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i
                                                    class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtRequestorCode" style="display:none" runat="server"
                                                CssClass="form-control" DBColumnName="REQUESTOR"
                                                SPParameterName="p_requestor" DataType="String" BindType="Both">
                                            </cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtRequestorName" Enabled="false" runat="server"
                                                CssClass="form-control" DBColumnName="REQUESTOR_DESC"
                                                SPParameterName="p_requestor" DataType="String" BindType="DBToUIOnly">
                                            </cc1:XUITextBox>

                                            <asp:RequiredFieldValidator ID="rfvRequestorName" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtRequestorCode">
                                            </asp:RequiredFieldValidator>
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
                                        <label class="col-sm-4">From Branch</label>
                                        <div class="col-sm-6">
                                            <asp:UpdatePanel ID="UpB" runat="server">
                                                <ContentTemplate>
                                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"
                                                        DBColumnName="DESCRIPTION" DataType="String"
                                                        BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                                        <cc1:XUITextBox ID="txtFromBranchDesc" Enabled="false"
                                                            runat="server" DBColumnName="BRANCH_DESC"
                                                            CssClass="form-control" DataType="String"
                                                            BindType="DBToUIOnly"></cc1:XUITextBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">To Branch</label>
                                        <div class="col-sm-6">
                                            <asp:UpdatePanel ID="UpC" runat="server">
                                                <ContentTemplate>
                                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"
                                                        DBColumnName="DESCRIPTION" DataType="String"
                                                        BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                                        <cc1:XUIDropDownList ID="ddlToBranch" runat="server"
                                                            CssClass="form-control" DBColumnName="TO_BRANCH"
                                                            SPParameterName="p_to_branch" DataType="String"
                                                            AutoPostBack="true" BindType="Both"></cc1:XUIDropDownList>
                                                        <cc1:XUILabel ID="lblToBranch" runat="server"
                                                            DBColumnName="to_branch_desc" DataType="String"
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
                                        <label class="col-sm-4">From Location *</label>
                                        <div class="col-sm-7">
                                            <asp:LinkButton runat="server" ID="btnFromLocation" class="btn btn-primary"
                                                data-toggle="modal" CausesValidation="false"><i class="icon-table"></i>
                                            </asp:LinkButton>
                                            <cc1:XUITextBox ID="txtFromLocationCode" runat="server" style="display:none"
                                                CssClass="form-control" DBColumnName="FROM_LOCATION"
                                                SPParameterName="p_from_location" DataType="String" BindType="Both">
                                            </cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblFromLocationName" runat="server"
                                                DBColumnName="FROM_LOCATION_DESC" DataType="String"
                                                BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                            <asp:RequiredFieldValidator ID="rfvFromLocationCode" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtFromLocationCode"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">To Location *</label>
                                        <div class="col-sm-5">
                                            <asp:LinkButton runat="server" ID="btnToLocation" class="btn btn-primary"
                                                data-toggle="modal" CausesValidation="false"><i class="icon-table"></i>
                                            </asp:LinkButton>
                                            <cc1:XUITextBox ID="txtToLocationCode" runat="server" style="display:none"
                                                CssClass="form-control" DBColumnName="TO_LOCATION"
                                                SPParameterName="p_to_location" DataType="String" BindType="Both">
                                            </cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblToLocationName" runat="server"
                                                DBColumnName="TO_LOCATION_DESC" DataType="String" BindType="DBToUIOnly"
                                                Text="--"></cc1:XUILabel>
                                            <asp:RequiredFieldValidator ID="rfvToLocationCode" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtToLocationCode"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">From LOT</label>
                                        <div class="col-sm-6">
                                            <asp:LinkButton runat="server" ID="btnLookUpFromLotCode"
                                                class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i
                                                    class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtFromLotCode" style="display:none" runat="server"
                                                CssClass="form-control" DBColumnName="FROM_LOT"
                                                SPParameterName="p_from_lot" DataType="String" BindType="Both">
                                            </cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtFromLotName" runat="server" style="display:none"
                                                DBColumnName="FROM_LOT_NAME" SPParameterName="p_from_lot_name"
                                                DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblFromLotName" runat="server"
                                                DBColumnName="FROM_LOT_NAME" DataType="String" BindType="DBToUIOnly"
                                                Text="--"></cc1:XUILabel>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtFromLotCode"
                                                Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">To LOT </label>
                                        <div class="col-sm-6">
                                            <asp:LinkButton runat="server" ID="btnLookUpToLotCode"
                                                class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i
                                                    class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtToLotCode" style="display:none" runat="server"
                                                CssClass="form-control" DBColumnName="TO_LOT" SPParameterName="p_to_lot"
                                                DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtToLotName" runat="server" style="display:none"
                                                DBColumnName="TO_LOT_NAME" SPParameterName="p_to_lot_name"
                                                DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblToLotName" runat="server" DBColumnName="TO_LOT_NAME"
                                                DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtToLotCode"
                                                Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">From RACK </label>
                                        <div class="col-sm-6">
                                            <asp:LinkButton runat="server" ID="btnLookUpFromRakCode"
                                                class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i
                                                    class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtFromRakCode" style="display:none" runat="server"
                                                CssClass="form-control" DBColumnName="FROM_RAK"
                                                SPParameterName="p_from_rak" DataType="String" BindType="Both">
                                            </cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtFromRakName" runat="server" style="display:none"
                                                DBColumnName="FROM_RAK_NAME" SPParameterName="p_from_rak_name"
                                                DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblFromRakName" runat="server"
                                                DBColumnName="FROM_RAK_NAME" DataType="String" BindType="DBToUIOnly"
                                                Text="--"></cc1:XUILabel>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtFromRakCode"
                                                Display="Dynamic"></asp:RequiredFieldValidator>--%>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">To RACK </label>
                                        <div class="col-sm-6">
                                            <asp:LinkButton runat="server" ID="btnLookUpToRakCode"
                                                class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i
                                                    class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtToRakCode" style="display:none" runat="server"
                                                CssClass="form-control" DBColumnName="TO_RAK" SPParameterName="p_to_rak"
                                                DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtToRakName" runat="server" style="display:none"
                                                DBColumnName="TO_RAK_NAME" SPParameterName="p_to_rak_name"
                                                DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblToRakName" runat="server" DBColumnName="TO_RAK_NAME"
                                                DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtToRakCode"
                                                Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">From SLOT </label>
                                        <div class="col-sm-6">
                                            <asp:LinkButton runat="server" ID="btnLookUpFromSlotCode"
                                                class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i
                                                    class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtFromSlotCode" style="display:none" runat="server"
                                                CssClass="form-control" DBColumnName="FROM_SLOT"
                                                SPParameterName="p_from_slot" DataType="String" BindType="Both">
                                            </cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtFromSlotName" runat="server" style="display:none"
                                                DBColumnName="FROM_SLOT_NAME" SPParameterName="p_from_slot_name"
                                                DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblFromSlotName" runat="server"
                                                DBColumnName="FROM_SLOT_NAME" DataType="String" BindType="DBToUIOnly"
                                                Text="--"></cc1:XUILabel>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtFromSlotCode"
                                                Display="Dynamic"></asp:RequiredFieldValidator>--%>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">To SLOT </label>
                                        <div class="col-sm-6">
                                            <asp:LinkButton runat="server" ID="btnLookUpToSlotCode"
                                                class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i
                                                    class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtToSlotCode" style="display:none" runat="server"
                                                CssClass="form-control" DBColumnName="TO_SLOT"
                                                SPParameterName="p_to_slot" DataType="String" BindType="Both">
                                            </cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtToSlotName" runat="server" style="display:none"
                                                DBColumnName="TO_SLOT_NAME" SPParameterName="p_to_slot_name"
                                                DataType="String" BindType="Both" Text="--"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblToSlotName" runat="server" DBColumnName="TO_SLOT_NAME"
                                                DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                                ErrorMessage="Required Field!" ControlToValidate="txtToSlotCode"
                                                Display="Dynamic"></asp:RequiredFieldValidator>--%>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Description *</label>
                                        <div class="col-sm-7">
                                            <cc1:XUITextBox ID="txtExpeditionDescription" runat="server"
                                                CssClass="form-control" placeholder="Description"
                                                DBColumnName="EXPEDITION_DESCRIPTION"
                                                SPParameterName="p_expedition_description" MaxLength="200"
                                                DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                            <asp:RequiredFieldValidator ID="rfvExpeditionDescription" runat="server"
                                                ErrorMessage="Required Field!"
                                                ControlToValidate="txtExpeditionDescription" Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator runat="server" ID="valInput"
                                                ControlToValidate="txtExpeditionDescription"
                                                ValidationExpression="^[\s\S]{0,50}$"
                                                ErrorMessage="Exceed maximum length 200" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Remarks</label>
                                        <div class="col-sm-7">
                                            <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control"
                                                placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks"
                                                MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine">
                                            </cc1:XUITextBox>
                                            <asp:RegularExpressionValidator runat="server"
                                                ID="RegularExpressionValidator1" ControlToValidate="txtRemarks"
                                                ValidationExpression="^[\s\S]{0,400}$"
                                                ErrorMessage="Exceed maximum length 400" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="col-sm-4">Created</label>
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
                                        <label class="col-sm-4">Modified</label>
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
                            <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </section>
            <asp:Panel runat="server" ID="pnlMutation">
                <section class="panel">
                    <header class="panel-heading tab-bg-dark-navy-blue">
                        <ul class="nav nav-tabs nav-justified">
                            <li class="active">
                                <a href="#mutation" id="mutdetail" onclick="javascript:fnSetTab('mutdetail');"
                                    data-toggle="tab" style="padding-bottom:28px">
                                    Mutation Detail
                                </a>
                            </li>

                            <li class="">
                                <a href="#expedition" id="mutatexpedition"
                                    onclick="javascript:fnSetTab('mutatexpedition');" data-toggle="tab"
                                    style="padding-bottom:28px">
                                    Mutation Expedition
                                </a>
                            </li>

                            <li class="">
                                <a href="#mutationuploadlog" id="mutationuploadlog"
                                    onclick="javascript:fnSetTab('mutationuploadlog');" data-toggle="tab"
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
                                            <cc1:XUILinkButton ID="btnAddAdDep" RoleCode="R80000010E" runat="server"
                                                CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false">
                                                <i class="icon-plus"></i> Add</cc1:XUILinkButton>
                                            <cc1:XUILinkButton RoleCode="R80000010E" ID="btnSaveDetail" runat="server"
                                                CssClass="btn btn-primary" OnClick="btnSaveDetail_Click"><i
                                                    class="icon-save"></i> Save</cc1:XUILinkButton>
                                            <cc1:XUILinkButton ID="btnDeleteRequestDetail" RoleCode="R80000010E"
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
                                                PageSize="10" DataKeyNames="ID"
                                                OnPageIndexChanging="gvwList_PageIndexChanging"
                                                OnRowDataBound="gvwList_RowDataBound"
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
                                                    <asp:BoundField DataField="ITEM_CODE" HeaderText="Item Code">
                                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                                        <ItemStyle Width="30%" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Remarks">
                                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox runat="server" TextMode="MultiLine"
                                                                ID="txtRemarks" CssClass="form-control" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Quantity">
                                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtQuantity"
                                                                CssClass="form-control" />
                                                            <asp:RegularExpressionValidator ID="revQuantity"
                                                                runat="server" ErrorMessage="Format Invalid!"
                                                                ControlToValidate="txtQuantity"
                                                                ValidationExpression="[0-9 .,]*[0-9 .,]"
                                                                Display="Dynamic"></asp:RegularExpressionValidator>
                                                            <asp:RequiredFieldValidator ID="rfvQuantity" runat="server"
                                                                ErrorMessage="Required Field!"
                                                                ControlToValidate="txtQuantity" Display="Dynamic">
                                                            </asp:RequiredFieldValidator>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%-- <asp:BoundField DataField="QUANTITY" HeaderText="Quantity"
                                                        DataFormatString="{0:N0}">
                                                        <ItemStyle Width="10%" HorizontalAlign="Right" />
                                                        </asp:BoundField>--%>
                                                        <asp:BoundField DataField="RECEIPT_DATE"
                                                            HeaderText="Receive Date" DataFormatString="{0:dd/MM/yyyy}">
                                                            <ItemStyle Width="10%" HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="STATUS" HeaderText="Status">
                                                            <ItemStyle Width="10%" HorizontalAlign="left" />
                                                        </asp:BoundField>
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
                            <div class="tab-pane" id="expedition">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-sm-8 ">
                                            <cc1:XUILinkButton RoleCode="R60000110E" ID="btnAddTOP" runat="server"
                                                CssClass="btn btn-primary" OnClick="btnAddTOP_Click"><i
                                                    class="icon-plus"></i> Create</cc1:XUILinkButton>
                                            <cc1:XUILinkButton RoleCode="R60000110E" ID="btnDeleteTOP" runat="server"
                                                CssClass="btn btn-danger" OnClick="btnDeleteTOP_Click"><i
                                                    class="icon-trash"></i> Delete</cc1:XUILinkButton>
                                        </div>
                                        <div class="col-sm-4 ">
                                            <asp:Panel ID="pnlSearchTOP" runat="server" DefaultButton="btnSearchTOP"
                                                class="input-group">
                                                <asp:TextBox ID="txtSearchTOP" runat="server" CssClass="form-control"
                                                    placeholder="Keywords"></asp:TextBox>
                                                <div class="input-group-btn">
                                                    <asp:LinkButton ID="btnSearchTOP" runat="server"
                                                        CssClass="btn btn-info" OnClick="btnSearchTOP_Click"
                                                        CausesValidation="false"><i class="icon-search"></i> Search
                                                    </asp:LinkButton>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <asp:UpdatePanel ID="updTOP" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvwListTOP" runat="server" AutoGenerateColumns="false"
                                                CssClass="display table table-bordered table-striped" AllowPaging="true"
                                                PageSize="10" DataKeyNames="ID"
                                                OnPageIndexChanging="gvwListTOP_PageIndexChanging"
                                                onselectedindexchanged="gvwListTOP_SelectedIndexChanged"
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
                                                    <asp:BoundField DataField="TRX_CODE_NAME" HeaderText="Trx Code">
                                                        <ItemStyle Width="50%" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="AMOUNT" HeaderText="Amount"
                                                        DataFormatString="{0:N2}">
                                                        <ItemStyle Width="50%" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:CommandField ShowSelectButton="true" />
                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnSearchTOP" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="btnDeleteTOP" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>

                            <div class="tab-pane" id="mutationuploadlog">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-sm-8">
                                            <cc1:XUILinkButton RoleCode="R60000110E" ID="btnAddTOPXXX" runat="server"
                                                CssClass="btn btn-primary"><i
                                                    class="icon-plus"></i> Create</cc1:XUILinkButton>
                                            <cc1:XUILinkButton RoleCode="R60000110E" ID="btnDeleteTOPXXX" runat="server"
                                                CssClass="btn btn-danger"><i
                                                    class="icon-trash"></i> Delete</cc1:XUILinkButton>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- </section>--%>
            </asp:Panel>

        </asp:Content>