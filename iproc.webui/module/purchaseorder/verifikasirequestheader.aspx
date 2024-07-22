    <%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="verifikasirequestheader.aspx.cs" Inherits="module_purchaseorder_verifikasirequestheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Verification Purchase Request Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                    <%--<cc1:XUILinkButton RoleCode="R06000001O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>--%>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R50000020O" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click" ><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnUnPost" RoleCode="R50000020O" runat="server" CssClass="btn btn-danger"><i class="icon-envelope"></i>  Un-Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R50000020E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <%--code barcode--%>
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUILabel>
                        <%--requestor--%>
                        <cc1:XUILabel ID="lblRequestorUID" runat="server" DBColumnName="REQUESTOR" SPParameterName="p_requestor" DataType="String" BindType="Both" style="display:none;"></cc1:XUILabel>
                        
                        <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None" style="display:none"></cc1:XUILabel>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">IR No.</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                                </div>
                                  <div class="col-sm-2">
                                      <cc1:XUILinkButton ID="btnViewDocument" runat="server" CausesValidation="false" Text="View Document Request"></cc1:XUILinkButton>
                               </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server"  DBColumnName="TRANS_FLAG_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                </div>
                            </div>                             
                        </div>                
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Date</label>
                                <div class="col-sm-3">
                                    <cc1:XUILabel ID="lblRequestDate" runat="server" DBColumnName="REQUEST_DATE" MaxLength="10" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblBranchCode" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;" ></cc1:XUILabel> 
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Requestor</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblRequestor" runat="server" DBColumnName="REQUESTOR_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblDepartment" runat="server" DBColumnName="DEPARTMENT_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>       
                    </div>
                    <div class="row">     
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Entry</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblEntry" runat="server" DBColumnName="ENTRY_DESC" DataType="String" BindType="DBToUIOnly" MaxLength="100"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">SubDepartment</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblSubDepartment" runat="server"  DBColumnName="SUB_DEPARTMENT_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                </div>
                            </div>                             
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Requirement Type</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="XUILabel1" runat="server" DBColumnName="REQUIREMENT_TYPE" SPParameterName="p_requirement_type" DataType="String" BindType="DBToUIOnly" MaxLength="100"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblDivision" runat="server"  DBColumnName="DIVISION_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel> 
                                </div>
                            </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblRemarks" runat="server" DBColumnName="REMARKS" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div>
                         </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Units</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblUnits" runat="server"  DBColumnName="UNITS_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel> 
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
                        <%--<div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Purpose Department</label>
                                <div class="col-sm-6">
                                     <cc1:XUILabel ID="lblPurposeDepartment" runat="server" DBColumnName="PURPOSE_DEPARTMENT" SPParameterName="p_purpose_department" DataType="String" BindType="Both" >
                                     </cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>    
                    <div class="row">
                        
                    </div>--%>   
                    </div>                
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "ENTRY_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                           <div class="form-group">
                                <label class="col-sm-4">Modified</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "EMP_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName= "MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                 </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    <label>    * Save untuk setelah input approve quantity</label> 
    <asp:Panel runat="server" ID="pnlPurchaseRequest">
    <section class="panel">
        <header class="panel-heading">
          <span>Item List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R50000020E" ID="btnSaveChecklist" runat="server" CssClass="btn btn-primary" OnClick="btnSaveChecklist_Click" ><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                  <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search" ></i>  Search</asp:LinkButton>
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
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        OnRowDataBound="gvwList_OnRowDataBound"
                        onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There is no data" Width="100%" >
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
                            
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="SPECIFICATION" HeaderText="Spesifation">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REMARKS_UNPOST" HeaderText="Remarks Unpost Procurement">
                                <ItemStyle Width="35%"/>
                            </asp:BoundField> 
                            <asp:BoundField DataField="QUANTITY" HeaderText="Qty" DataFormatString="{0:N2}">
                                <ItemStyle Width="5%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Approve Qty">
                                    <ItemStyle Width="10%" HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("APPROVE_QUANTITY","{0:N2}") %>'  style="text-align:right;" ID="txtApproveQty" CssClass="form-control"/>
                                        <asp:RegularExpressionValidator ID="revApproveQty" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtApproveQty" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                        <asp:RequiredFieldValidator ID="rfvApproveQty" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtApproveQty" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:BoundField DataField="UNIT_DESC" HeaderText="UOM">
                                <ItemStyle Width="5%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="STATUS" HeaderText="Status">
                            <ItemStyle Width="5%" />
                            </asp:BoundField>
                            
                           <%-- <asp:CommandField ShowSelectButton="true" />--%>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    </asp:Panel>
     
</asp:Content>
