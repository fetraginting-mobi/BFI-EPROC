<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="supplierselectionheader.aspx.cs" Inherits="module_purchaseorder_supplierselectionheader" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Supplier Selection</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R50000060E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000060O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                 
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R50000060O" runat="server" CssClass="btn btn-success" ><i class="icon-envelope"></i>   Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnUnPost" RoleCode="R50000060O" runat="server" OnClick="btnUnPost_Click" CssClass="btn btn-danger"><i class="icon-envelope"></i>  Un-Post</cc1:XUILinkButton>
                     
                    <cc1:XUILinkButton ID="btnCancelReq" RoleCode="R50000060O" runat="server"  CssClass="btn btn-danger"><i class="icon-remove"></i>   Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal" >
            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
                     <%--code barcode--%>
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUILabel>
                        <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                         <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                        <cc1:XUITextBox ID="txtSupplierID" style="display:none" runat="server" CssClass="form-control" DBColumnName="SUPPLIER_CODE"  SPParameterName="p_supplier_code" MaxLength="20" DataType="string" BindType="Both"></cc1:XUITextBox>
                          <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                       <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DBColumnName="OBJECT_AMOUNT" DataType="Number" Text="0" style="display:none;" BindType="Both"></cc1:XUILabel>
                        <%--<cc1:XUITextBox ID="txtAmount" style="display:none" runat="server" CssClass="form-control"  placeholder="PQ Amount" DBColumnName="AMOUNT" SPParameterName="p_amount" DataType="Number" Format = "N2" BindType="Both" MaxLength="14" ></cc1:XUITextBox>--%>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">SS No.</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>     
                                    <cc1:XUITextBox ID="txtBarcode" style="display:none" runat="server" DBColumnName="CODE_BARCODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUITextBox>                  
                                </div>
                                <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="View Approval History"></cc1:XUILinkButton>
                               </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName= "TRANS_FLAG_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">PQ No. *</label>
                                <div class="col-sm-8">
                                    <%--<asp:LinkButton runat="server" ID="btnLookUpPQCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>--%>
                                    <cc1:XUITextBox ID="txtPQCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="PQ_CODE" SPParameterName="p_pq_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblPQCode" runat="server" DBColumnName="PQ_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvPQCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPQCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                  <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewQouDoc" runat="server" CausesValidation="false" Text="View Quotation Document"></cc1:XUILinkButton>
                               </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Branch</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row"> 
                        <div class="col-sm-6">
                             <div class="form-group">
                                     <label class="col-sm-3">Date *</label>                              
                                     <div class="col-sm-3">
                                         <cc1:XUITextBox ID="txtSelectionDate" runat="server"  CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="SELECTION_DATE" SPParameterName="p_selection_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                         <asp:RequiredFieldValidator ID="rfvSelectionDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSelectionDate" Display="Dynamic"></asp:RequiredFieldValidator>  
                                     </div>
                                <asp:RegularExpressionValidator ID="revSelectionDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtSelectionDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                             </div>                            
                        </div>
                    </div>
                    <div class="row">                     
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Remarks </label>                               
                                  <div class="col-sm-8">
                                      <cc1:XUITextBox ID="txtRemarks" runat="server"  CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                      <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                  </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Division</label>
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
                          </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Department</label>
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
                          </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Sub Department</label>
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
                                <label class="col-sm-3">Units</label>
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
                                <label class="col-sm-3">Created</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "CRE_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Modified</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "CRE_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
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
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
      <label>    * Save untuk melihat supplier dan item history </label>  
    <asp:Panel runat="server" ID="pnlPurchaseRequest">
    <section class="panel">
        <header class="panel-heading">
          <span>Item List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                   <%--  <cc1:XUILinkButton RoleCode="R06000004E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R06000004E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>--%>
                    <cc1:XUILinkButton RoleCode="R50000060E" ID="btnSaveChecklist" runat="server" CssClass="btn btn-primary" OnClick="btnSaveChecklist_Click"  CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                            <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search" ></i> Search</asp:LinkButton>
                            </div>
                   </asp:Panel>
                </div>
            </div>   
        </div>
                           
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
            
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="SELECTION_CODE,ITEM_CODE,SUPPLIER_CODE"
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
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                <ItemStyle Width="15%"/>
                            </asp:BoundField> 
                            <asp:BoundField DataField="QUANTITY" HeaderText="Quantity" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Supplier">
                                    <ItemStyle Width="20%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:DropDownList runat="server" ID="ddlSupplier" CssClass="form-control" AutoPostBack="true"  OnSelectedIndexChanged="ddlSupplier_SelectedIndexChanged"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" >
                                    <ItemStyle Width="20%" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("AMOUNT","{0:N2}") %>' style="text-align:right;" ID="txtAmount" CssClass="form-control" DataFormatString ="{0:N2}" Enabled ="false"  />
                                    </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total Amount" >
                                    <ItemStyle Width="20%" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("TOTAL_AMOUNT","{0:N2}") %>' style="text-align:right;" ID="txtTotalAmount" CssClass="form-control"  Enabled ="false"  />
                                    </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="RATING" HeaderText="Rating" >
                                <ItemStyle Width="5%" HorizontalAlign="Right"/>
                            </asp:BoundField>--%>
                            <asp:TemplateField HeaderText="Rating" >
                                    <ItemStyle Width="10%" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("RATING","{0:N2}") %>' style="text-align:right;" ID="txtRating" CssClass="form-control" Enabled ="false"  />
                                    </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSupplierHistory" runat="server" CausesValidation="false" Text="Supplier History"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnItemHistory" runat="server" CausesValidation="false" Text="Item History"/>
                                    </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField Visible = "false" HeaderText="">
                                    <ItemStyle Width="0%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton Visible = "false" ID="btnViewDocument" runat="server" CausesValidation="false" Text="View Document Request"/>
                                    </ItemTemplate>
                            </asp:TemplateField>
                           <asp:CommandField ShowSelectButton="true" />
                            
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                   <asp:AsyncPostBackTrigger ControlID="btnSaveChecklist" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
  </asp:Panel>
</asp:Content>
