<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="faadjustheader.aspx.cs" Inherits="module_fa_faadjustheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Fixed Asset Adjustment Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R90000066E" runat="server" CssClass="btn btn-primary" CausesValidation="true" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R90000066O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R90000066O" runat="server" CssClass="btn btn-success" ><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                     <%--<cc1:XUILinkButton ID="btnUnPost" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnUnpost_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>--%>
                   
                    <cc1:XUILinkButton ID="btnReject" RoleCode="R90000066O" runat="server" CssClass="btn btn-danger"  CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="R90000066O" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                     <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                     <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DataType="Number" DBColumnName="OBJECT_AMOUNT" Text="100" style="display:none;" BindType="Both"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">FA Adjust No.</label>
                                <!--CODE BARCODE-->
                                <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode"  DataType="String"  BindType="Both" style="display:none"></cc1:XUILabel>
                                 <cc1:XUILabel ID="lblIsUsed" runat="server" DBColumnName="IS_USED" DataType="String"  BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                <cc1:XUITextBox ID="txtCodeBarcode" runat="server" CssClass="form-control" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUITextBox>
                                 <cc1:XUITextBox ID="txtItemCode" runat="server" CssClass="form-control" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" style="display:none;"  MaxLength="14" DataType="String" Text="--" BindType="None" ></cc1:XUITextBox>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                       <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></cc1:XUILinkButton>
                                </div>
                                
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_CODE" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Date *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtFadjustDate" runat="server" CssClass="form-control default-date-picker" placeholder="Reconciliation Date" DBColumnName="FADJUST_DATE" SPParameterName="p_fadjust_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="revFadjustDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFadjustDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revReconDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtFadjustDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Cost Center</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" AutoPostBack="true" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Asset Barcode *</label>
                                <div class="col-sm-6">
                                    <asp:LinkButton runat="server" ID="btnLookUpFaAsset" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>      
                                    <cc1:XUITextBox ID="txtBarcode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ASSET_BARCODE" SPParameterName="p_asset_barcode" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUITextBox ID="txtBarcode2" runat="server" Enabled="false" CssClass="form-control" DBColumnName="ASSET_BARCODE_NAME" SPParameterName="p_asset_barcode" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                    <%--<cc1:XUILabel ID="lblBarcode" runat="server"  DBColumnName="ASSET_BARCODE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <asp:RequiredFieldValidator ID="rfvAssetCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBarcode" Display="Dynamic"></asp:RequiredFieldValidator>      
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
                                <label class="col-sm-3">Asset Location</label>
                               <div class="col-sm-8">
                                     <cc1:XUITextBox ID="txtFromLocation" Enabled = "false" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="ASSET_LOCATION_NAME"  MaxLength="100" DataType="String" BindType="DBToUIOnly" ></cc1:XUITextBox> 
                                    <cc1:XUITextBox ID="txtFromLocationCode" Enabled = "false" style="display:none" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="ASSET_LOCATION_CODE" SPParameterName="p_asset_location_code" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>                                               
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
                              <label class="col-sm-3">Asset Name</label>
                              <div class="col-sm-8">
                              <cc1:XUILabel ID="lblAssetName" runat="server"  DBColumnName="AST_NAME" DataType="String" BindType="DBToUIOnly" Text="--" ></cc1:XUILabel>
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
                                  <label class="col-sm-3">Cost Price</label>
                                  <div class="col-sm-8">
                                  <cc1:XUILabel ID="lblCostPrice" runat="server"  DBColumnName="COST_PRICE" DataType="Number" Format="N2" BindType="DBToUIOnly" Text="--" ></cc1:XUILabel>
                                  </div>
                                </div>
                            </div>
                             <div class="col-sm-6">
                                <div class="form-group">
                                  <label class="col-sm-3">Orig Price</label>
                                  <div class="col-sm-8">
                                  <cc1:XUILabel ID="lblOrigPrice" runat="server"  DBColumnName="ORIG_PRICE" DataType="Number" Format="N2" BindType="DBToUIOnly" Text="--" ></cc1:XUILabel>
                                  </div>
                                </div>
                            </div>
                      </div>
                       <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Description *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="100" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 100" Display="Dynamic"></asp:RegularExpressionValidator>
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
                                <label class="col-sm-3">Net Book Value</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblNetBookValue" runat="server" DBColumnName="NET_BOOK_VALUE" BindType="DBToUIOnly" format="N2" DataType="Number" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Net Book Value Fiscal</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblNetBookValueFiscal" runat="server" DBColumnName="NET_BOOK_VALUE_FISCAL" format="N2" BindType="DBToUIOnly" DataType="Number" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">New Net Book Value</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblNewNetBookValue" runat="server" DBColumnName="NEW_NET_BOOK_VALUE" BindType="DBToUIOnly" format="N2" DataType="Number" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">New Net Book Value Fiscal</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblNewNetBookValueFiscal" runat="server" DBColumnName="NEW_NET_BOOK_VALUE_FISCAL" format="N2" BindType="DBToUIOnly" DataType="Number" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                      <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Total Adjust</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTotalAdjust" runat="server" DBColumnName="TOTAL_ADJUST" BindType="DBToUIOnly" format="N2" DataType="Number" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                              <label class="col-sm-3">Adjust Type</label>
                              <div class="col-sm-8">
                              <cc1:XUILabel ID="lblAdjustType" runat="server"  DBColumnName="flag_adjust" DataType="String" BindType="DBToUIOnly" Text="--" ></cc1:XUILabel>
                   
                              </div>
                            </div>
                        </div>
                    </div>
                    <div class="row"> 
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Supplier *</label> 
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpSupplier" class="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtSupplierCode" runat="server"  CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" DataType="String" MaxLength="18" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtSupplier"  runat="server" DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"  Enabled="false" Width="200px" style="border:0px; background:inherit"></cc1:XUITextBox> 
                                    <asp:RequiredFieldValidator ID="rfvSupplier" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplier" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                    <div class="col-sm-6">
                            <div class="form-group">
                               <label class="col-sm-3">Payment By *</label>
                                  <div class="col-sm-6">
                                     <cc1:XUIDropDownList ID="ddlPaymentBy" runat="server" CssClass="form-control" DBColumnName="PAYMENT_BY" SPParameterName="p_payment_by" AutoPostBack = "true" OnSelectedIndexChanged="ddlPaymentBy_SelectedIndex" BindType="Both" DataType="String">
                                       <asp:ListItem Selected Value="0" Text="-=Select=-"></asp:ListItem>
                                        <asp:ListItem Text="HO" Value="HO"></asp:ListItem>
                                        <asp:ListItem Text="BRANCH" Value="BRANCH"></asp:ListItem>
                                     </cc1:XUIDropDownList>
                                  
                                </div>
                             </div>
                        </div>
                          <div class="col-sm-6" runat="server" id="ToRekName">
                            <div class="form-group">
                               <label class="col-sm-3">To Rek Name</label>
                                  <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtToRekName" runat="server" CssClass="form-control" placeholder="To Rek Name" DBColumnName="TO_BANK_ACC_NAME" SPParameterName="p_to_bank_acc_name"  DataType="String" BindType="Both" TextMode ="MultiLine"  style="border:0;  background:inherit;"></cc1:XUITextBox>
                                </div>
                             </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6" runat="server" id="ToBank">
                            <div class="form-group">
                               <label class="col-sm-3">To Bank *</label>
                              
                                  <div class="col-sm-4">
                                     <asp:LinkButton runat="server" ID="btnLookUpToBank" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                     <cc1:XUITextBox ID="txtToBank" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_BANK" SPParameterName="p_to_bank" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                     <cc1:XUILabel ID="lblBankName"  runat="server"  DBColumnName="TO_BANK_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                     <asp:RequiredFieldValidator ID="rfvToBank" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToBank" Display="Dynamic" ValidationGroup="Header"></asp:RequiredFieldValidator>
                                </div>
                             </div>
                        </div>   
                          <div class="col-sm-6" runat="server" id="ToRekNo">
                            <div class="form-group">
                               <label class="col-sm-3">To Rek No</label>
                                  <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtToRekNo" runat="server" CssClass="form-control" placeholder="To Rek No." DBColumnName="TO_BANK_ACC_NO" SPParameterName="p_to_bank_acc_no" MaxLength="20" DataType="String" BindType="Both" style="border:0; background:inherit;"></cc1:XUITextBox>
                                </div>
                             </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Created  </label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                             </div>
                          </div>
                          <div class="col-sm-6">
                              <div class="form-group">
                                    <label class="col-sm-3">Modified </label>
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
            <legend></legend> <%--Ari 28-06-2022 ket : upload file--%>
            <%--<div class="row" id="pnl1" runat="server">          
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-3">
                            <label>Attachment</label>
                        </div>
                        <div class="col-sm-3">
                            <asp:FileUpload ID="fuInvoice" runat="server"/>--%>
                            <%--<cc1:XUILabel style="color:red"> * Max. Size File Upload : 5MB.</cc1:XUILabel>--%>
                      <%--  </div>
                    </div>                            
                </div>               
                 <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-8">
                            <cc1:XUILinkButton RoleCode="R80000010E" ID="btnSaveupload" runat="server" CssClass="btn btn-primary" OnClick="btnSaveupload_Click" CausesValidation="true"><i class="icon-save"></i>  Upload</cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="R80000010E" ID="btnPreview" runat="server" CssClass="btn btn-warning" OnClick="btnPreview_Click" CausesValidation="false" ToolTip="View invoice"><i class="icon-eye-open"></i></cc1:XUILinkButton>
                        </div>
                    </div>
                 </div>            
            </div>--%>
            <%--<div class="row" id="pnl2" runat="server">          
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-3">
                            <label>File Name</label>
                            <asp:RequiredFieldValidator ID="rfvFileName" runat="server" ErrorMessage="*" ValidationGroup="NotaryPayment" ToolTip="Please fill this field" ControlToValidate="txtFileName" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtFileName" runat="server" DataType="String" BindType="DBToUIOnly" DBColumnName="FILE_NAME" SPParameterName="p_file_name" Enabled="false" style="border:0px; background:inherit; min-width:80%"></cc1:XUITextBox>
                            <cc1:XUITextBox ID="txtPaths" runat="server" DataType="String" BindType="DBToUIOnly" DBColumnName="PATHS" SPParameterName="p_paths" Enabled="false" style="border:0px; background:inherit;" Visible="false"></cc1:XUITextBox>
                        </div>
                    </div>
                </div>
            </div>--%>
            <%--<legend></legend>--%>
        </div>
    </section>
    
    <asp:Panel runat="server" ID="pnlDisposal">
    <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">       
              <li class="active">
                  <a href="#asset" id="assetlist" onclick="javascript:fnSetTab('assetlist');" data-toggle="tab" style="padding-bottom:28px">
                      Additional Cost Asset
                  </a>
              </li>
             <li class="">
                  <a href="#uploaddoc" id="poupdoc" onclick="javascript:fnSetTab('poupdoc');" data-toggle="tab" style="padding-bottom:28px">
                      Upload Doc
                  </a>
              </li>
          </ul>
        </header>
        <%--<header class="panel-heading">
            <span>Additional Cost Asset</span>
        </header>--%>
         <div class="panel-body">                    
            <div class="tab-content tasi-tab">
                 <div class="tab-pane active" id="asset" >
                 <div class="panel-heading" id="assetheader" runat="server">
                      <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton RoleCode="R80000010E" ID="btnAddDetail" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="R80000010E" ID="btnDeleteDetail" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteDetail_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="R80000010E" ID="btnSaveDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDetail_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                        </div>
                        <div class="col-sm-4 ">
                              <asp:Panel ID="pnlSearchDetail" runat="server" DefaultButton="btnSearchDetail" class="input-group">
                                   <asp:TextBox ID="txtSearchDetail" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                   <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchDetail" runat="server" CssClass="btn btn-info" OnClick="btnSearchDetail_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                   </div>
                               </asp:Panel>
                         </div>
                      </div>
                 </div>
                 <div class="panel-body">
                        <asp:UpdatePanel ID="updDetail" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListDetail" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                    OnPageIndexChanging="gvwListDetail_PageIndexChanging" OnRowDataBound="gvwListDetail_RowDataBound"
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
                                                 <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TRX_NAME" HeaderText="Transaction Type" >
                                            <ItemStyle Width="50%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Currency">
                                          <ItemStyle Width="20%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlCurrencyCodeDetail" CssClass="form-control">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                          <ItemStyle Width="30%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtAmountDetail" CssClass="form-control"/>
                                                <asp:RegularExpressionValidator ID="revAmountDetail" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmountDetail" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                                <asp:RequiredFieldValidator ID="rfvAmountDetail" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmountDetail" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:BoundField DataField="EQUAL" HeaderText="Transaction Equal" >
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        </asp:BoundField>--%>
                                       <%-- <asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchDetail" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteDetail" EventName="Click" />
                            </Triggers>
            </asp:UpdatePanel>
            </div>
                 </div>
                    <%--(+) Ari 03-08-2022 ket : enhancement 2022, Upload--%>
                 <div class="tab-pane" id="uploaddoc" >
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R80000010E" ID="btnAddUploadDoc" runat="server" CssClass="btn btn-primary" OnClick="btnAddUploadDoc_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <%--<cc1:XUILinkButton RoleCode="" ID="btnSaveDocumentDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDocumentDetail_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton> --%>
                            </div>
                            <div class="col-sm-4 ">
                                <asp:Panel ID="pnlSearchDoc" runat="server" DefaultButton="btnSearchDoc" class="input-group">
                                <asp:TextBox ID="txtSearchDoc" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchDoc" runat="server" CssClass="btn btn-info" OnClick="btnSearchDoc_Click"><i class="icon-search"></i> Search</asp:LinkButton>
                                </div>
                           </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:GridView ID="gvwListDoc" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="ID, PATHS, FILE_NAME"
                            OnPageIndexChanging="gvwListDoc_PageIndexChanging" OnRowCommand="gvwListDoc_RowCommand" OnRowDataBound="gvwListDoc_OnRowDataBound" 
                            onselectedindexchanged="gvwListDoc_SelectedIndexChanged" EmptyDataText="There is no data"  AllowSorting="true">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <span>No</span>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:BoundField DataField="DESCRIPTION" HeaderText="Document" >
                                    <ItemStyle Width="40%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="File Name">
                                    <ItemStyle Width="60%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                         <asp:Label runat="server" Text='<%# Eval("PATHS") %>' ID="lblFileName"/>
                                         <br />
                                        <asp:FileUpload runat="server" ID="fupFilename" style="display:none"/>
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

