<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="procurementreview.aspx.cs" Inherits="module_purchaseorder_procurementreview" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Procurement Review</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                <cc1:XUILinkButton ID="btnProcess" RoleCode="R50000030O" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="true"><i class="icon-adv-table"></i>Process</cc1:XUILinkButton>
                  <cc1:XUILinkButton ID="btnSave" RoleCode="R50000030E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                  
                  <cc1:XUILinkButton ID="btnUnPost" RoleCode="R50000030O" runat="server" OnClick="btnUnPost_Click" CssClass="btn btn-danger"><i class="icon-envelope"></i>  Un-Post</cc1:XUILinkButton>
                   <cc1:XUILinkButton ID="btnCancelReq" RoleCode="R50000030O" runat="server" OnClick="btnCancelReq_Click" CssClass="btn btn-danger"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                  <%--  <cc1:XUILinkButton ID="btnPost" RoleCode="R50000020O" runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnUnPost" RoleCode="R50000020O" runat="server" CssClass="btn btn-danger"><i class="icon-envelope"></i>  Un-Post</cc1:XUILinkButton>--%>
                      
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <%--code barcode--%>
                        <cc1:XUILabel ID="lblid" runat="server" DBColumnName="ID" DataType="Integer"  BindType="DBToUIOnly" style="display:none;" ></cc1:XUILabel>
                         <cc1:XUILabel ID="lblItemCode" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                         <cc1:XUILabel ID="lblJenisItem" runat="server"  DBColumnName="JENIS_ITEM" DataType="String" BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                         <cc1:XUITextBox ID="txtBranch" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="None"></cc1:XUITextBox>
                         
                        <%--requestor--%>
                       <%-- <cc1:XUILabel ID="lblRequestorUID" runat="server" DBColumnName="REQUESTOR" SPParameterName="p_requestor" DataType="String" BindType="Both" style="display:none;"></cc1:XUILabel>
                        --%>
                        <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None" style="display:none"></cc1:XUILabel>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">IR No.</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                                </div>
                            </div>                            
                        </div>
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item *</label>
                                <div class="col-sm-8">                       
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>        
                                </div>
                                <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewDocument" runat="server" CausesValidation="false" Text="View Document Request"></cc1:XUILinkButton>
                               </div>
                            </div>                            
                        </div>           
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-8">                       
                                    <cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="Branch_name" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>        
                                </div>
                            </div>                            
                        </div>  
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Spesification</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="txtSpesification" runat="server"  DBColumnName="SPECIFICATION" SPParameterName="p_specification"  DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>
                        <div class="col-sm-6" id="unit" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">UOM</label>
                                <div class="col-sm-4">
                                    <cc1:XUIDropDownList ID="ddlUOM" Enabled="false" runat="server" CssClass="form-control" DBColumnName="UOM" SPParameterName="p_unit_code" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvUom" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUOM" ></asp:RequiredFieldValidator>
                                </div>
                            </div>                               
                        </div>
                      </div>
                      <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Quantity Approved</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblQuantityReq" runat="server"  DBColumnName="QUANTITY_APPROVED"  DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Quantity Purchase</label>
                               <div class="col-sm-3">
                               <cc1:XUITextBox ID="txtQuantityPurchase" runat="server"  CssClass="form-control" placeholder="Quantity Purchase" DBColumnName="QTY_PURCHASE" SPParameterName="p_qty_purchase" Format="N2" DataType="Number" Text="0.00" BindType="Both"></cc1:XUITextBox>
                               <asp:RequiredFieldValidator ID="revQuantityPurchase" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuantityPurchase" ></asp:RequiredFieldValidator>
                               </div>
                            </div>   
                        </div>
                        <div class="col-sm-6">
                                <div class="form-group">
                                <label class="col-sm-4">Quantity Inventory</label>
                                    <div class="col-sm-3">
                                        <cc1:XUITextBox ID="txtQuantityInventory" runat="server"  CssClass="form-control" placeholder="Quantity Inventory" DBColumnName="QTY_INVENTORY" SPParameterName="p_qty_inventory" Format="N2" Text="0.00" DataType="Number" BindType="Both"></cc1:XUITextBox>
                                        <asp:RequiredFieldValidator ID="revQuantityInventory" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuantityInventory" ></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewStock" runat="server" CausesValidation="false" Text="View Stock"></cc1:XUILinkButton>
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
                                <label class="col-sm-4">Action</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlFlagAction" runat="server" CssClass="form-control" DBColumnName="INVENTORY_ACTION" SPParameterName="p_inventory_action" DataType="String" BindType="Both">
                                    <asp:ListItem Value="0">-=Select=- </asp:ListItem>
                                    <asp:ListItem Value="ISSUE"> ISSUE </asp:ListItem>
                                    <asp:ListItem Value="MUTATION"> MUTATION </asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvFlagAction" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlFlagAction" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
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
                                <label class="col-sm-4">Location *</label>
                                <div class="col-sm-1" id="lookupWarehouse" runat="server">
                                    <%--<cc1:XUILabel ID="lblLocation" runat="server"  DBColumnName="DESCRIPTION" SPParameterName="p_location" BindType="Both" DataType="String" ></cc1:XUILabel>--%>
                                    <%--<cc1:XUITextBox ID="txtLocation"  runat="server"  CssClass="form-control" DBColumnName="LOCATION" SPParameterName="p_location" MaxLength="20" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                                    
                                    <asp:LinkButton runat="server" ID="btnLookUpWarehouseCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtWarehouseCode" runat="server"  CssClass="form-control" DBColumnName="LOCATION" SPParameterName="p_location" style="display:none;" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtWarehouseName" runat="server"  DBColumnName="LOCATION_DESC" DataType="String" BindType="DBToUIOnly" Text="--" TextMode="MultiLine" style="border:0; background:inherit;" ></cc1:XUITextBox>  <%----%>
                                    <asp:RequiredFieldValidator ID="rvfWarehouse" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtWarehouseName" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                       <div class="row">
                         <div class="col-sm-6" id="Div1" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">Type</label>
                               <div class="col-sm-5">
                                     <cc1:XUIDropDownList ID="ddlType" runat="server" CssClass="form-control" DBColumnName="TYPE1" SPParameterName="p_type" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="revType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlType" ></asp:RequiredFieldValidator>
                                </div>
                            </div>                               
                        </div>
                        <div class="col-sm-6" id="Div4" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">Requestor</label>
                                  <div class="col-sm-4">
                                     <cc1:XUILabel ID="lblRequestor" runat="server"   DBColumnName="emp_name" DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                </div>
                             </div>
                           </div>
                       </div> 
                       <div class="row">
                         <div class="col-sm-6" id="Div3" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4"></label>
                                  <div class="col-sm-4">
                                     <cc1:XUIDropDownList ID="ddlPurchaseBy" runat="server" CssClass="form-control" style="display:none" DBColumnName="BRANCH" SPParameterName="p_branch" BindType="Both" DataType="String">
                                       <asp:ListItem Value="0" Text="-=Select=-"></asp:ListItem>
                                        <asp:ListItem Text="HO" Value="HO"></asp:ListItem>
                                        <asp:ListItem Text="BRANCH" Value="BRANCH"></asp:ListItem>
                                     </cc1:XUIDropDownList>
                                </div>
                             </div>
                           </div>
                            <div class="col-sm-6" id="Div5" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">Is Review</label>
                                  <div class="col-sm-4">
                                     <cc1:XUIDropDownList ID="lblReview" runat="server" CssClass="form-control" DBColumnName="IS_REVIEW" SPParameterName="p_is_review" BindType="Both" DataType="String">
                                     <asp:ListItem  Value="0" Text="-=Select=-"></asp:ListItem>
                                     <asp:ListItem Value="YES" Text="YES"></asp:ListItem>
                                     <asp:ListItem Value="NO" Text="NO"></asp:ListItem>
                                     </cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="revIsReview" runat="server" ErrorMessage="Required Field!" ControlToValidate="lblReview" ></asp:RequiredFieldValidator>
                                </div>
                             </div>
                           </div>
                         </div>
                        <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Warning</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblWarning" runat="server" ForeColor = "Red" DBColumnName="WARNING" SPParameterName="p_specification"  DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks For Unpost</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtRemarksUnpost" runat="server"  CssClass="form-control" placeholder="Remarks For Unpost" DBColumnName="REMARKS_UNPOST" SPParameterName="p_remarks_unpost" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    
                                </div>
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
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created</label>
                                <div class="col-sm-8">
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
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
      <section class="panel"  runat="server" ID="pnlItemList">
        <header class="panel-heading">
          <span>Review List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                     <cc1:XUILinkButton RoleCode="R50000010E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000010E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                            <asp:BoundField DataField="PR_CODE" HeaderText="PR Code">
                                <ItemStyle Width="40%" HorizontalAlign="Center"/>
                            </asp:BoundField> 
                             <asp:BoundField DataField="REVIEW_DATE" HeaderText="Review Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Units Name">
                                <ItemStyle Width="50%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_CODE" HeaderText="Status">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                           
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
    </section>
</asp:Content>

