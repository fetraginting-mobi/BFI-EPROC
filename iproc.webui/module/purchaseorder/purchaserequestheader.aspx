<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="~/module/purchaseorder/purchaserequestheader.aspx.cs" Inherits="module_purchaseorder_purchaserequestheader" %>
 
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <%--<script  type="text/javascript">
        function jsDoAfterLookUp()
        {
            __doPostBack('ctl00$cpb$ddlDivision','');
        }
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Requisition Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R50000010E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000010O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R50000010O" runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancelReq" RoleCode="R50000010O" runat="server" CssClass="btn btn-danger"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPrint" RoleCode="R50000010P" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                   
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
                     <%--code barcode--%>
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUILabel>
                     <%--requestor--%>
                        <cc1:XUILabel ID="lblRequestorUID" runat="server" DBColumnName="REQUESTOR" SPParameterName="p_requestor" DataType="String" BindType="Both" style="display:none;"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DataType="Number" Text="100" style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel>
                          <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">IR No.</label> 
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
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
                                <label class="col-sm-4">Date *</label>                              
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtRequestDate" runat="server"  CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="REQUEST_DATE" SPParameterName="p_request_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvRequestDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRequestDate" Display="Dynamic"></asp:RequiredFieldValidator>  
                                </div>
                                    <asp:RegularExpressionValidator ID="revRequesstDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy"  MinimumValue="GetDate"  ControlToValidate="txtRequestDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-6">
                                 <asp:UpdatePanel ID="UpB" runat="server">
                                        <ContentTemplate>
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" AutoPostBack= "true" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                    <!-- (+) Ari 30-06-2022 ket : enhancement 2022 -->
                                    <cc1:XUILabel ID="lblIsAgas" runat="server"  DBColumnName="MULTIPLEBRANCH" DataType="String" BindType="DBToUIOnly" Visible="false"></cc1:XUILabel>
                                    </ContentTemplate>
                                  </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Entry</label> 
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtEntry" style="display:none;"  runat="server"  CssClass="form-control" DBColumnName="ENTRY" SPParameterName="p_entry" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblEntry" runat="server" DBColumnName="ENTRY_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
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
                                <label class="col-sm-4">Requestor *</label> 
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpRequestoro"  class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtRequestorCode" style="display:none"  runat="server"  CssClass="form-control" DBColumnName="REQUESTOR" SPParameterName="p_requestor" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblRequestorName" runat="server"  DBColumnName="REQUESTOR_DESC" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvRequestorName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRequestorCode" ></asp:RequiredFieldValidator>
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
                                <label class="col-sm-4">Requirement Type *</label>
                                <div class="col-sm-6">
                                     <cc1:XUIDropDownList ID="ddlRequirementType" runat="server" CssClass="form-control" DBColumnName="REQUIREMENT_TYPE" SPParameterName="p_requirement_type" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                      <asp:RequiredFieldValidator ID="rfvddlRequirementType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlRequirementType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
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
                                <label class="col-sm-4">Remarks *</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server"  CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine" ></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" ></asp:RequiredFieldValidator>
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
                                <label class="col-sm-4">Promotion Flag </label>
                                   <div class="col-sm-6">
                                    <cc1:XUICheckBox ID="chbIsPromotion" runat="server" BindType="Both" DataType="String" DBColumnName="IS_PROMOTION" SPParameterName="p_is_promotion" AutoPostBack="true" OnCheckedChanged="chbIsPromotion_CheckedChanged" ></cc1:XUICheckBox>
                                    <label> * jika kebutuhan promotion untuk item 3 bln</label> 
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6" ID="IGP" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">Item Group Promotion </label>  
					            <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpParentGroup" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtParentGroup" runat="server" CssClass="form-control" style="display:none" DBColumnName="ITEM_GROUP_CODE_PROMOTION" SPParameterName="p_item_group_code_promotion" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblParentGroup" runat="server"  DBColumnName="ITEM_GROUP_NAME" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel> 
                                    (
                                        <cc1:XUILabel ID="lblPlafond" runat="server"  DBColumnName="PLAFOND" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel> 
                                    )
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
                                <label class="col-sm-4">Remarks Unpost Verification</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblRemaksUnpost" runat="server" DBColumnName="REMARKS_UNPOST" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
                                </div>
                            </div>                            
                        </div>
                    </div>
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
                     <div class="row">  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4"></label>
                                   <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlReq" st runat="server" style="display:none;" CssClass="form-control" DBColumnName="IS_PROJECT" SPParameterName="p_is_project" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlReq_SelectedIndex" DataType="String">
                                        <asp:ListItem Value="0">-=Select=-</asp:ListItem>
                                        <asp:ListItem Value="P">PROJECT</asp:ListItem>
                                        <asp:ListItem Value="N">NON PROJECT</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                 
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6" ID="EBY" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4"></label>  
					            <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtEstimasi" runat="server" style="display:none;"  CssClass="form-control" placeholder="Estimasi Biaya" DBColumnName="ESTIMASI_BIAYA" SPParameterName="p_estimasi_biaya" DataType="Number" Text="0" BindType="Both" MaxLength="15"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvEstimasi" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtEstimasi" InitialValue="0" Display="Dynamic" ></asp:RequiredFieldValidator>  
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnCancelReq" EventName="Click" />
                        <%--<asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />--%>
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
                                <cc1:XUILinkButton RoleCode="R50000010E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000010E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                        <div class="col-sm-4 ">
                            <asp:Panel ID="pnlSearchList" runat="server" DefaultButton="btnSearch" class="input-group">
                                <asp:TextBox ID="txtSearchList" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
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
                                    <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                        <ItemStyle Width="20%"/>
                                    </asp:BoundField> 
                                    <asp:BoundField DataField="SPECIFICATION" HeaderText="Specification">
                                        <ItemStyle Width="20%"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DESCRIPTION" HeaderText="Remarks">
                                        <ItemStyle Width="20%"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="QUANTITY" HeaderText="Qty" DataFormatString="{0:N2}">
                                        <ItemStyle Width="10%" HorizontalAlign="Right"/>
                                    </asp:BoundField>
                                     <asp:BoundField DataField="CONFIRM_DATE" HeaderText="Confirm Date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle Width="10%" HorizontalAlign="Right"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="STATUS" HeaderText="Status">
                                        <ItemStyle Width="10%"/>
                                    </asp:BoundField>
                                     <asp:BoundField DataField="APPROVED_STATUS" HeaderText="Aprroval Status">
                                        <ItemStyle Width="10%"/>
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
                        AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, PR_CODE, PATHS, FILE, ID"
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
                                    <%--<asp:FileUpload runat="server" ID="fupFilename" />--%>
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
