<%@ Page Language="C#" MasterPageFile="~/iproc.master"  AutoEventWireup="true" CodeFile="purchasequotationheader.aspx.cs" Inherits="module_purchaseorder_purchasequotationheader" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Purchase Quotation Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R50000050E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" ValidationGroup="header"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000050O" ID="btnApprovalTiered" runat="server" Visible="false" CssClass="btn btn-success"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R50000050O" runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>   Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPostAuthority" RoleCode="R50000050P" runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>  Post Authority</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPrint" RoleCode="R50000050P" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" Visible="false" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnReject" RoleCode="R50000050O" runat="server" CssClass="btn btn-danger" CausesValidation="false"><i class="icon-remove"></i>  Un-Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnUnPost" RoleCode="R50000030C" runat="server" OnClick="btnUnPost_Click" style="display:none;" CssClass="btn btn-danger"><i class="icon-envelope"></i>  Un-Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <%--code barcode--%>
                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" ></cc1:XUILabel> 
                    <%--ID APPROVEL--%>
                  <%--  <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None" style="display:none;"></cc1:XUILabel>--%>
                    <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DataType="Number" Text="100" style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PQ No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                </div>
                                 <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewDocument" runat="server" CausesValidation="false" Text="View Quotation Review Document"></cc1:XUILinkButton>
                               </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_DESC" DataType="String" BindType="DBToUIOnly"  Text="--" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>   
                    </div> 
                    <div class="row">  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Date *</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtQuotationDate" runat="server" CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="QUOTATION_DATE" SPParameterName="p_quotation_date" MaxLength="10" DataType="DateTime" BindType="Both" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvQuotationDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuotationDate" Display="Dynamic" ValidationGroup="header"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtQuotationDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div> 
                         <div class="col-sm-6"> 
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-5">
                                   <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" AutoPostBack= "true" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" BindType="Both"></cc1:XUIDropDownList>
                                   <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Expiry Date </label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtExpDate" runat="server" CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="EXP_DATE" SPParameterName="p_exp_date" DataType="DateTime" BindType="Both" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                    <%--<asp:CompareValidator ID="cmvExpiredDate" runat="server" ErrorMessage="Expired Date must be greater than Effective Date" ControlToValidate="txtExpDate" Display="Dynamic" EnableClientScript="true" CultureInvariantValues="false" ControlToCompare="txtQuotationDate" Type="Date" Operator="GreaterThanEqual"></asp:CompareValidator>--%>
<%--                                    <asp:RequiredFieldValidator ID="rfvExpiryDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtExpDate" Display="Dynamic" ValidationGroup="header"></asp:RequiredFieldValidator>--%>
                                </div>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtExpDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
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
                                <label class="col-sm-4 ">Item Group</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblItemGroup" runat="server" DBColumnName="ITEM_GROUP" DataType="String" BindType="DBToUIOnly"  Text="--" ></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtItemGroup" runat="server" CssClass="form-control" placeholder="Description" style="display:none;" DBColumnName="GROUP_CODE"  DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>   
                       <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                    <asp:UpdatePanel ID="updDep" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTEMENT_CODE" SPParameterName="p_departement_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
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
                             <label class="col-sm-4">Remarks *</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both" MaxLength="400" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,2000}$" ErrorMessage="Exceed maximum length 2000" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
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
                          </div>
                        </div>
                    <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks For Unpost</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtRemarksUnpost" runat="server" CssClass="form-control" placeholder="Remarks For Unpost" DBColumnName="REMARKS_UNPOST" SPParameterName="p_remarks_unpost" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Created  </label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                        <span>@</span>
                                        <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                               <div class="form-group">
                                    <label class="col-sm-4">Modified  </label>
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
        <asp:Panel runat="server" ID="pnlQuotation">
        <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                <ul class="nav nav-tabs nav-justified">
                  <li class="active">
                      <a href="#ItemList" id="itemlist" onclick="javascript:fnSetTab('itemlist');" data-toggle="tab" >
                          Item List
                      </a>
                  </li>
                  <li>
                      <a href="#UploadDoc" id="uploaddoc" onclick="javascript:fnSetTab('uploaddoc');" data-toggle="tab" >
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
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R50000050E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false" style="display:none;"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000050E" ID="btnCopy" runat="server" CssClass="btn btn-primary" OnClick="btnCopy_Click" CausesValidation="false"><i class="icon-plus"></i>  Copy</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="R50000050E" ID="btnSaveDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDetail_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000050E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                   
                </div>
                <div class="col-sm-4 ">
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
                    AllowPaging="false" PageSize="10" DataKeyNames="ID_LIST,PQ_CODE,ITEM_CODE,UNIT_CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" OnRowDataBound="gvwList_RowDataBound"
                        onselectedindexchanged="gvwList_SelectedIndexChanged"  EmptyDataText="There is no data" Width="100%" >
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
                          <asp:TemplateField>
                                <ItemStyle Width="5%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnLookUpSupplierID" class="btn btn-primary input-sm" data-toogle="modal" runat="server" ><i class="icon-table"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Supplier">
                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtSupplierCode" runat="server" style="display:none;"></asp:TextBox>
                                    <asp:Label ID="lblSupplierName" runat="server" ></asp:Label>   
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                <ItemStyle Width="30%"/>  
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Qty">
                                <ItemStyle Width="10%" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="txtQuantity" Enabled="false" CssClass="form-control"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revQuantity" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQuantity" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="UNIT_DESC" HeaderText=UOM>
                                <ItemStyle Width="10%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Currency">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlCurrencyCode" CssClass="form-control">
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Unit Price">
                                <ItemStyle Width="25%" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="txtUnitPrice" CssClass="form-control" DataFormatString ="{0:N2}"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revUnitPrice" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtUnitPrice" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                    <asp:RequiredFieldValidator ID="rfvUnitPrice" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitPrice" Display="Dynamic"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            </div>
        </div>
        <div class="tab-pane" id="UploadDoc">
               <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton RoleCode="R30000150E" ID="btnAddUploadDoc" runat="server" CssClass="btn btn-primary" OnClick="btnAddUploadDoc_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="R50000150E" ID="btnSaveDocumentDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDocumentDetail_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton> 
                        </div>
                        <div class="col-sm-4 ">
                            <asp:Panel ID="pnlSearchDocReq" runat="server" DefaultButton="btnSearchDocReq" class="input-group">
                            <asp:TextBox ID="txtSearchDocReq" runat="server" CssClass="form-control" ></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchDocReq" runat="server" CssClass="btn btn-info" OnClick="btnSearchDocReq_Click"><i class="icon-search"></i> Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <asp:GridView ID="gvwListDocReq" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, PQ_CODE, PATHS, FILE, ID"
                        OnPageIndexChanging="gvwListDocReq_PageIndexChanging" OnRowDataBound="gvwListDocReq_OnRowDataBound" OnRowCommand="gvwListDocReq_RowCommand"
                        onselectedindexchanged="gvwListDocReq_SelectedIndexChanged" EmptyDataText="There is no data"  AllowSorting="true">
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
                                     <asp:Label runat="server" Text='<%# Eval("PATHS") %>' ID="lblFileName"/>
                                     <br />
                                    <asp:FileUpload runat="server" ID="fupFilename" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%--<asp:Label ID="btnPreviewDoc" runat="server">Preview</asp:Label>--%>
                                     <asp:LinkButton ID="btnPreviewDoc" runat="server" CausesValidation="false" Text="Preview"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                               <asp:TemplateField HeaderText="">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDeleteDoc" runat="server" CausesValidation="false" Text="Delete" CommandName="del"/>
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

