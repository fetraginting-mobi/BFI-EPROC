<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apdepositregistration.aspx.cs" Inherits="module_apadvanceanddeposit_apdepositregistration" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Deposit Request Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton RoleCode="R80000045E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                     <cc1:XUILinkButton RoleCode="R80000045O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <asp:LinkButton RoleCode="R80000045O" ID="btnPost" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click"><i class="icon-envelope"></i>  Post</asp:LinkButton>  
                    <asp:LinkButton RoleCode="R80000045O" ID="btnReject" runat="server" CssClass="btn btn-danger" OnClick="btnReject_Click" CausesValidation="false"><i class="icon-remove"></i>  Back</asp:LinkButton>
                    <asp:LinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
                <div class="row">
                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUILabel>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Deposit No.</label>
                            <div class="col-sm-8">
                                <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <cc1:XUITextBox ID="txtType" runat="server" style="display:none;" DataType="String" BindType="None" Text="--"></cc1:XUITextBox>
                                <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></cc1:XUILinkButton>
                                <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DBColumnName="OBJECT_AMOUNT" DataType="Number" Text="0.00" style="display:none;" BindType="Both"></cc1:XUILabel>
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
                            <asp:RequiredFieldValidator ID="rfvDepositDate" runat="server" ErrorMessage="*" ControlToValidate="txtDepositDate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-5">
                                <cc1:XUITextBox ID="txtDepositDate" runat="server" CssClass="form-control default-date-picker" placeholder="Deposit Date" DBColumnName="DEPOSIT_DATE" SPParameterName="p_deposit_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                         <div class="form-group">
                            <label class="col-sm-4">Branch</label>
                              <div class="col-sm-6">
                                  <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="BRANCH_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                  <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" AutoPostBack="true" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                  <cc1:XUILabel ID="lblBranch" runat="server" style="display:none;"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                              </div>
                         </div>                             
                      </div> 
                  </div>
                <%--<div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Rent From Date</label>
                           
                            <div class="col-sm-5">
                                <cc1:XUITextBox ID="txtRentFrom" runat="server" CssClass="form-control default-date-picker" placeholder="Rent From Date" DBColumnName="RENT_FROM_DATE" SPParameterName="p_rent_from_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Rent To Date</label>
                          
                            <div class="col-sm-5">
                                <cc1:XUITextBox ID="txtRentTo" runat="server" CssClass="form-control default-date-picker" placeholder="Rent To Date" DBColumnName="RENT_TO_DATE" SPParameterName="p_rent_to_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                 </div>--%>
                <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Additional Deposit</label>
                                   <div class="col-sm-6">
                                    <cc1:XUICheckBox ID="chbIsPo" runat="server" BindType="Both" DataType="String" AutoPostBack="true" DBColumnName="IS_PO" SPParameterName="p_is_po"  ></cc1:XUICheckBox>
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
                           <label class="col-sm-4">PO No. *</label>
                           <div class="col-sm-8">
                               <asp:LinkButton runat="server" ID="btnLookUpPurchaseOrderCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                        
                               <cc1:XUITextBox ID="txtReferenceNo" style="display:none" runat="server" CssClass="form-control" DBColumnName="REFERENCE_NO" SPParameterName="p_reference_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                               <cc1:XUILabel ID="lblPurchaseOrderCode" runat="server"  DBColumnName="CODE_BARCODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none"></cc1:XUILabel>
                               <cc1:XUILabel ID="lblPOCode"  runat="server"  DBColumnName="PO_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                          
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Requeried Field!" ControlToValidate="txtReferenceNo" Display="Dynamic"></asp:RequiredFieldValidator> 
                           </div>
                        </div>                            
                    </div>
                   <%-- <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Reference No.</label>
                             <div class="col-sm-6">
                                <cc1:XUITextBox ID="txtReferenceNo" runat="server" CssClass="form-control" placeholder="Reference No" DBColumnName="REFERENCE_NO" SPParameterName="p_reference_no" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblReferenceNo" runat="server" DBColumnName="PO_CODE" DataType="String" BindType="DBToUIOnly" style="display:none;"  Text="--"></cc1:XUILabel>                        
                                <asp:RequiredFieldValidator ID="rfvReferenceNo" runat="server" ErrorMessage="*" ControlToValidate="txtReferenceNo" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>--%>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                    <asp:UpdatePanel ID="updDep" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="revDepartment" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
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
                        <label class="col-sm-4">Payment By *</label>
                           <div class="col-sm-6">
                              <cc1:XUIDropDownList ID="ddlPaymentBy" runat="server" CssClass="form-control" DBColumnName="PAYMENT_BY" SPParameterName="p_payment_by" AutoPostBack = "true" OnSelectedIndexChanged="ddlPaymentBy_SelectedIndex" BindType="Both" DataType="String">
                                <asp:ListItem Selected Value="0" Text="-=Select=-"></asp:ListItem>
                                 <asp:ListItem Text="HO" Value="HO"></asp:ListItem>
                                 <asp:ListItem Text="BRANCH" Value="BRANCH"></asp:ListItem>
                              </cc1:XUIDropDownList>
                              <asp:RequiredFieldValidator ID="rfvPaymentBy" runat="server" ErrorMessage="Required Field!"  InitialValue="0" ControlToValidate="ddlPaymentBy" ></asp:RequiredFieldValidator>
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
                        <label class="col-sm-4">Supplier</label>
                         <div class="col-sm-6">
                         <asp:LinkButton runat="server" ID="btnLookUpRequestor" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table" ></i></asp:LinkButton>   
                             <asp:RequiredFieldValidator ID="rfvSupplier" runat="server" ErrorMessage="Requeried Field!" ControlToValidate="txtSupplier" Display="Dynamic"></asp:RequiredFieldValidator>
                             <cc1:XUITextBox ID="txtSupplier" style="display:none" runat="server"  CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                             <cc1:XUILabel ID="lblSupplier" runat="server" DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                         </div>
                     </div>                            
                </div>
                    
                          <div class="col-sm-6" runat="server" id="ToRekName">
                            <div class="form-group">
                               <label class="col-sm-4">To Rek Name</label>
                                  <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtToRekName" runat="server" CssClass="form-control" placeholder="To Rek Name" DBColumnName="TO_BANK_ACC_NAME" SPParameterName="p_to_bank_acc_name"  DataType="String" BindType="Both" TextMode ="MultiLine"  style="border:0;  background:inherit;"></cc1:XUITextBox>
                                </div>
                             </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6" runat="server" id="ToBank">
                            <div class="form-group">
                               <label class="col-sm-4">To Bank *</label>
                                  <div class="col-sm-6">
                                     <asp:LinkButton runat="server" ID="btnLookUpToBank" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtToBank" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_BANK" Text="--" SPParameterName="p_to_bank" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblBankName"  runat="server"  DBColumnName="TO_BANK_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <asp:RequiredFieldValidator ID="rfvToBank" runat="server" ErrorMessage="Required Field!" InitialValue="-" ControlToValidate="txtToBank" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator>
                                </div>
                             </div>
                        </div>   
                          <div class="col-sm-6" runat="server" id="ToRekNo">
                            <div class="form-group">
                               <label class="col-sm-4">To Rek No</label>
                                  <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtToRekNo" runat="server" CssClass="form-control" placeholder="To Rek No." DBColumnName="TO_BANK_ACC_NO" SPParameterName="p_to_bank_acc_no" MaxLength="20" DataType="String" BindType="Both" style="border:0; background:inherit;"></cc1:XUITextBox>
                                </div>
                             </div>
                        </div>
                    </div>
            <div class="row">
                 <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4 ">Currency</label>
                            <div class="col-sm-5">
                                <cc1:XUIDropDownList ID="ddlCurrencyCode" runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                  </div>
                  <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Reff Type</label>
                            <div class="col-sm-4">
                                <cc1:XUILabel ID="lblReffType" runat="server" DBColumnName="REFF_TYPE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                            </div>
                        </div>                            
                    </div>
                        
                  <%--      <label class="col-sm-4">Payment</label>
                              <asp:RequiredFieldValidator ID="rfvPaymentMethodCode" runat="server" ErrorMessage="*" ControlToValidate="rblPaymentMethodCode" Display="Dynamic"></asp:RequiredFieldValidator>         
                        <div class="col-sm-8">
                            <cc1:XUIRadioButtonList ID="rblPaymentMethodCode" runat="server"  DBColumnName="PAYMENT_METHOD_CODE" SPParameterName="p_payment_method_code" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" >
                                <asp:ListItem Value="DEBIT" Selected="True">Debit&nbsp&nbsp</asp:ListItem>
                                <asp:ListItem Value="CREDIT">Credit</asp:ListItem>
                            </cc1:XUIRadioButtonList> 
                        </div>
                   </div>     --%>   
            </div> 
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Deposit Amount</label>
                        <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="Requeried Field!" ControlToValidate="txtAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revAmount" runat="server" ErrorMessage="*" ControlToValidate="txtAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control" Enabled = "false" placeholder="Amount" DBColumnName="LAST_AMOUNT" SPParameterName="p_amount" MaxLength="18" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblAmountDeposit" style="display:none;" runat="server" DBColumnName="AMOUNT" DataType="Number" Format="N2" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
                 <div class="col-sm-6" id="Adddepo" runat="server">
                    <div class="form-group">
                        <label class="col-sm-4">Add Deposit Amount</label>
                        <asp:RequiredFieldValidator ID="rfvAddAmount" runat="server" ErrorMessage="Requeried Field!" ControlToValidate="txtAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revAddAmount" runat="server" ErrorMessage="*" ControlToValidate="txtAddAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtAddAmount" runat="server" CssClass="form-control" placeholder="Amount" DBColumnName="AMOUNT" SPParameterName="p_amount" MaxLength="18" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblAmountAddDeposit" style="display:none;" runat="server" DBColumnName="AMOUNT" DataType="Number" Format="N2" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
             </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Description *</label>
                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Requeried Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Remarks</label>
                        <div class="col-sm-10">
                            <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
            </div>  
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Created</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            <span>@</span>
                            <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                   <div class="form-group">
                        <label class="col-sm-4">Modified</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "EMP_MOD" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                            <span>@</span>
                            <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName= "MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                        </div>
                    </div>
                </div>
            </div>                                             
        </div>
    </section>
    <asp:Panel runat="server" ID="pnlDetail">
    <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">       
              <li class="active">
                  <a href="#UploadDoc" id="UploadDoc" onclick="javascript:fnSetTab('UploadDoc');" data-toggle="tab" style="padding-bottom:28px">
                      Upload Doc
                  </a>
              </li>
        </header> 
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
            <div class="tab-pane active" id="UploadDoc">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R80000045E" ID="btnAddUploadDoc" runat="server" CssClass="btn btn-primary" OnClick="btnAddUploadDoc_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R80000045E" ID="btnSaveDocumentDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDocumentDetail_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton> 
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
                        AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, DEPOSIT_CODE, PATHS, FILE, ID"
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
