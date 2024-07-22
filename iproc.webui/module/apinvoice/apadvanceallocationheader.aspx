<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apadvanceallocationheader.aspx.cs" Inherits="module_apinvoice_apadvanceallocationheader" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
     <section class="panel">
        <header class="panel-heading">
          <span>Advance Allocation Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R80000070E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R80000070O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R80000070O" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnReject" RoleCode="R80000070O" runat="server" CssClass="btn btn-danger" OnClick="btnReject_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                        <div class="row">
                             <%--code barcode--%>
                            <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String" style="display:none;" BindType="Both"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None"  style="display:none;"></cc1:XUILabel>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Advance No.</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblBarcode" runat="server" DBColumnName="CODE_BARCODE" DataType="String" style="display:none;" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                        <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Status</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_DESC" DataType="String" BindType="DBToUIOnly" Text="--" ></cc1:XUILabel>
                                    </div>
                                </div>                            
                            </div>   
                        </div> 
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Date *</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtAllocationDate" runat="server" CssClass="form-control default-date-picker" placeholder="Allocation Date" DBColumnName="ALLOCATION_DATE" SPParameterName="p_allocation_date" MaxLength="10" DataType="DateTime" BindType="Both" Format ="dd/MM/yyyy"></cc1:XUITextBox>
                                        <asp:RequiredFieldValidator ID="rfvAllocationDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAllocationDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtAllocationDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Branch</label>
                                    <div class="col-sm-6">
                                        <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="BRANCH_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                        <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                        <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
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
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <asp:UpdatePanel ID="updDiv" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE"  SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="revddlDivision" runat="server" ControlToValidate="ddlDivision"
                                                 ErrorMessage="Value Required!" InitialValue="-"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Reference No. *</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtReferenceNo" runat="server"  CssClass="form-control" placeholder="Reference No" DBColumnName="REFERENCE_NO" SPParameterName="p_reference_no" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <asp:RequiredFieldValidator ID="rfvReferenceNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReferenceNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                             <<div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                    <asp:UpdatePanel ID="updDep" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                       </ContentTemplate>
                                       <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlDivision" EventName="SelectedIndexChanged" />
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
                                           <asp:LinkButton runat="server" ID="btnLookUpUserRequest" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtUserRequestCode" runat="server"  CssClass="form-control" DBColumnName="EMP_CODE" SPParameterName="p_emp_code" DataType="String" MaxLength="10" BindType="Both" style="display:none"></cc1:XUITextBox>
                                            <cc1:XUITextBox ID="txtUserRequest"  runat="server" DBColumnName="USER_REQUEST" DataType="String" BindType="DBToUIOnly" Text="--"  Enabled="false" Width="200px" style="border:0px; background:inherit"></cc1:XUITextBox> 
                                           <asp:RequiredFieldValidator ID="rfvUserRequest" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUserRequestCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                       </div>
                                   </div>
                                 </div> 
                              <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Sub Department</label>
                            <div class="col-sm-6">
                               <asp:UpdatePanel ID="updSub" runat="server">
                                 <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlSubDepartment" runat="server" CssClass="form-control" DBColumnName="SUB_DEPARTMENT_CODE" SPParameterName="p_sub_department_code" OnSelectedIndexChanged= "ddlSubDepartment_SelectedIndexChanged" AutoPostBack="true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvddlSubDepartment" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                 </ContentTemplate>
                                 <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="ddlDepartment" EventName="SelectedIndexChanged" />
                                 </Triggers>
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
                               <label class="col-sm-4">Units</label>
                               <div class="col-sm-6">
                                   <asp:UpdatePanel ID="updUn" runat="server">
                                       <ContentTemplate>
                                           <cc1:XUIDropDownList ID="ddlUnits" runat="server" CssClass="form-control" DBColumnName="UNITS_CODE" SPParameterName="p_units_code"  DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                           <asp:RequiredFieldValidator ID="rfvddlUnits" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUnits" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                       </ContentTemplate>
                                          <Triggers>
                                           <asp:AsyncPostBackTrigger ControlID="ddlSubDepartment" EventName="SelectedIndexChanged" />
                                      </Triggers>
                                   </asp:UpdatePanel>
                               </div>
                           </div>                             
                       </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Total Advance Amount</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtTotalAdvanceAmount" runat="server"  CssClass="form-control " placeholder="Total Advance Amount" DBColumnName="TOTAL_ADVANCE_AMOUNT" SPParameterName="p_total_advance_amount" DataType="Number" BindType="Both" Format="N2" Text="0.00" Enabled="False"></cc1:XUITextBox >
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Total Invoice Amount</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtInvoiceAmount" runat="server" CssClass="form-control " placeholder="Total Invoice Amount" DBColumnName="TOTAL_INVOICE_AMOUNT" SPParameterName="p_total_invoice_amount"  DataType="Number" BindType="Both" Text="0.00" Format="N2" Enabled="False"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4 ">Total Advance Allocation Amount</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtAdvanceAllocationAmount" runat="server"  CssClass="form-control " placeholder="Total Advance Allocation Amount" DBColumnName="TOTAL_ALLOCATION_ADVANCE" SPParameterName="p_total_allocation_advance" DataType="Number" BindType="Both" Format="N2" Text="0.00" Enabled="False"></cc1:XUITextBox >
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">  
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-2">Description *</label>
                                    <div class="col-sm-5">
                                        <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both" MaxLength="200" TextMode="MultiLine" Height="58px"></cc1:XUITextBox>
                                        <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,200}$" ErrorMessage="Exceed maximum length 200" Display="Dynamic"></asp:RegularExpressionValidator>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>                            
                            </div>  
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Created </label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        <span>@</span>
                                        <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                               <div class="form-group">
                                    <label class="col-sm-4">Modified </label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "EMP_MOD" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        <span>@</span>
                                        <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName= "MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
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
        
        <asp:Panel runat="server" ID="pnlAllocation">
        <section class="panel">
            <header class="panel-heading tab-bg-dark-navy-blue">
                <ul class="nav nav-tabs nav-justified">
                    <li class="active">
                        <a href="#AdvanceNo" data-toggle="tab">
                             Advance No.
                        </a>
                    </li>
                     <li class="">
                        <a href="#Buat" data-toggle="tab">
                            Invoice No.
                       </a>
                    </li>
                </ul>
            </header>
      <div class="panel-body">                    
        <div class="tab-content tasi-tab">
        <div class="tab-pane active" id="AdvanceNo">
        <header class="panel-heading">
          <span></span>
        </header>
       <div class="panel-heading">
                <div class="row">
                    <div class="col-sm-8">
                        <cc1:XUILinkButton ID="btnAddAdvance" RoleCode="R80000070E" runat="server" CssClass="btn btn-primary" OnClick="btnAddAdvance_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                        <cc1:XUILinkButton ID="btnGenerateAdvance" RoleCode="R80000070O" runat="server" CssClass="btn btn-success" OnClick="btnGenerateAdvance_Click"><i class="icon-envelope"></i>  Generate</cc1:XUILinkButton>
                        <cc1:XUILinkButton ID="btnDeleteAdvance" RoleCode="R80000070E" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteAdvance_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                    </div>
                <div class="col-sm-4">
                  <asp:Panel ID="pnlSearchAdvance" runat="server" DefaultButton="btnSearchAdvance" class="input-group">       
                        <asp:TextBox ID="txtSearchAdvance" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                        <asp:LinkButton ID="btnSearchAdvance" runat="server" CssClass="btn btn-info" OnClick="btnSearchAdvance_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                   </asp:Panel>
                </div>
            </div>
         </div>
          <div class="panel-body">
            <asp:UpdatePanel ID="updAdvance" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListAdvance" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwListAdvance_PageIndexChanging" 
                        onselectedindexchanged="gvwListAdvance_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                            <asp:BoundField DataField="CODE" HeaderText="Advance No." >
                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ADVANCE_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                              <asp:BoundField DataField="ADVANCE_AMOUNT" HeaderText="Advance Amount" DataFormatString= {0:N2}>
                                <ItemStyle Width="15%" HorizontalAlign="Right" />
                            </asp:BoundField>
                             <asp:BoundField DataField="AMOUNT" HeaderText="Total Amount" DataFormatString ="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                              <asp:BoundField DataField="PAYMENT" HeaderText="Payment" DataFormatString ="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchAdvance" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnGenerateAdvance" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteAdvance" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        </div>                     
        <div class="tab-pane" id="Buat">
        <header class="panel-heading">
          <span></span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnAdd" RoleCode="R80000070E" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnGenerate" RoleCode="R80000070O" runat="server" CssClass="btn btn-success" OnClick="btnGenerate_Click"><i class="icon-envelope"></i>  Generate</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="R80000070E" ID="btnSaveInvoice" runat="server" CssClass="btn btn-primary" CausesValidation = "false" OnClick="btnSaveInvoice_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnDelete" RoleCode="R80000070E" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                        OnPageIndexChanging="gvwList_PageIndexChanging" OnRowDataBound="gvwListGenerate_OnRowDataBound"
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
                            <asp:BoundField DataField="INVOICE_DESC" HeaderText="Invoice No." >
                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="INVOICE_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="BILL" HeaderText="Invoice Amount" DataFormatString= {0:N2}>
                                <ItemStyle Width="15%" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NET_BILL" HeaderText="Total Amount" DataFormatString= {0:N2}>
                                <ItemStyle Width="15%" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <%--<asp:BoundField DataField="PAYMENT_ADVANCE" HeaderText="Payment" DataFormatString= {0:N2}>
                                <ItemStyle Width="15%" HorizontalAlign="Right" />
                            </asp:BoundField>--%>
                            <asp:TemplateField HeaderText="Allocation Advance">
                                <ItemStyle Width="15%" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="txtAllocationAdvance" Text='<%# Eval("ALLOCATION_ADVANCE","{0:N2}") %>' CssClass="form-control"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revAllocationAdvance" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAllocationAdvance" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                    <asp:RequiredFieldValidator ID="rfvAllocationAdvance" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAllocationAdvance" Display="Dynamic"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                                <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnGenerate" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            </div>
          </div>
        </div>
      </div>
    </section>  
  </asp:Panel>  
</asp:Content>


