<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventorymaintenance.aspx.cs" Inherits="module_inventory_inventorymaintenance" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Inventory Maintenance Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R60000145E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R60000145O"  runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="R60000145O" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DataType="Number" Text="100" style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel>
                  <cc1:XUITextBox ID="txtEntry" style="display:none;"  runat="server"  CssClass="form-control" DBColumnName="ENTRY" SPParameterName="p_entry" DataType="String" BindType="Both"></cc1:XUITextBox>
                 <cc1:XUILabel ID="lblEntry" runat="server" DBColumnName="ENTRY_DESC" DataType="String" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel> 
                 <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Barcode *</label>
                                <cc1:XUILabel ID="txtId" runat="server" style="display:none"  CssClass="form-control" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both"></cc1:XUILabel>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpInventory" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>      
                                    <cc1:XUITextBox ID="txtBarcode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="BARCODE" SPParameterName="p_barcode" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblBarcode" runat="server"  DBColumnName="BARCODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                    <asp:RequiredFieldValidator ID="rfvAssetCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBarcode" Display="Dynamic"></asp:RequiredFieldValidator>      
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="TRX_STATUS" SPParameterName="p_trx_status" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-6" style="display:none">
                            <div class="form-group">
                                <label class="col-sm-3 ">Asset Code</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="lblAssetCode" runat="server" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both" MaxLength= "60" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>     
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3 ">Asset Name</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblAssetName" runat="server" DBColumnName="ITEM_NAME" SPParameterName="p_item_asset" DataType="String" BindType="Both" MaxLength= "60" ></cc1:XUILabel>   
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Requestor *</label> 
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpRequestoro"  class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtRequestorCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="REQUESTOR" SPParameterName="p_requestor" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblRequestorName" runat="server"  DBColumnName="REQUESTOR_DESC" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvRequestorName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRequestorCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>                            
                            </div>  
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Transaction Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtTrxDate" runat="server" CssClass="form-control default-date-picker" placeholder="Trx Date" DBColumnName="TRX_DATE" SPParameterName="p_trx_date" DataType="DateTime" BindType="Both"  Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtTrxDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator> 
                                    <asp:RequiredFieldValidator ID="rfvTrxdate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTrxDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
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
                                <label class="col-sm-3 ">Location</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblLocation" runat="server" DBColumnName="LOC_NAME" DataType="String" BindType="DBToUIOnly" MaxLength= "60" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                    <div class="col-sm-6">
                                        <asp:UpdatePanel ID="updDep" runat="server">
                                            <ContentTemplate>
                                                <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
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
                                <label class="col-sm-3">Transaction Amount</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtTrxAmount" runat="server" CssClass="form-control" placeholder="Trx Amount" DBColumnName="TRX_AMOUNT" SPParameterName="p_trx_amount" MaxLength="15" DataType="Number" Enabled="false" BindType="Both" Format="N2"></cc1:XUITextBox>
                                   <%-- <asp:RequiredFieldValidator ID="rfvTrxAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTrxAmount" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTrxAmount" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                          
                        <div class="col-sm-6" runat="server" id="vendor">
                            <div class="form-group">
                             <label class="col-sm-4">Vendor By </label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtVendorBy" Enabled= "false" runat="server" CssClass="form-control" placeholder="Vendor By" DBColumnName="VENDOR_BY" SPParameterName="p_vendor_by" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                     
                                </div>
                            </div>                            
                        </div>
                            <div class="col-sm-6" >
                            <div class="form-group">
                                <label class="col-sm-4 ">Paid Status</label>
                                <div class="col-sm-6">
                                      <cc1:XUILabel ID="lblPaidStatus" runat="server"  DBColumnName="PAID_STATUS" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                   
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
                                <label class="col-sm-3">Remarks</label>
                                <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="100" DataType="String" BindType="Both" TextMode="MultiLine" ></cc1:XUITextBox>
                                <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 100" Display="Dynamic"></asp:RegularExpressionValidator>
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
                    <div class="row" style="display:none;">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Receipt No. *</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtReceiptNo" runat="server" CssClass="form-control" placeholder="Receipt No" DBColumnName="RECEIPT_NO" SPParameterName="p_receipt_no" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                     
                                </div>
                            </div>                            
                        </div> 
                        
                   </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>  
    </section> 
    
    <asp:Panel runat="server" ID="pnlService">
        <section class="panel">
        <header class="panel-heading">
            <span>Service List</span>
        </header>
            <div class="panel-heading">
                <div class="row">
                    <div class="col-sm-8">
                        <cc1:XUILinkButton ID="btnAdd" RoleCode="R90000070E" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
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
            <asp:UpdatePanel ID="updService" runat="server">
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
                        <asp:BoundField DataField="BARCODE" HeaderText="Asset Code">
                            <ItemStyle Width="40%" HorizontalAlign="center"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Asset Name">
                            <ItemStyle Width="60%" HorizontalAlign="Left" />
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
        </section>    
    </asp:Panel>
</asp:Content>



