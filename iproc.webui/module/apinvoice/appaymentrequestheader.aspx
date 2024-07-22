<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="appaymentrequestheader.aspx.cs" Inherits="module_apinvoice_appaymentrequestheader" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
    <script type="text/javascript">


        function CalculateDiscountPct() {
            var DiscPct = $('#ctl00_cpb_txtDiscountPCT').val();
            var DiscAmount = $('#ctl00_cpb_txtDiscount').val();
            var Price = $('#ctl00_cpb_lblPaymentAmount').val();

            DiscPct = DiscPct / 1.00;

            DiscAmount = DiscPct / 100.00 * jsToNumber(Price);
            
            $('#ctl00_cpb_txtDiscountPCT').val(DiscPct);
            $('#ctl00_cpb_txtDiscount').val(DiscAmount);
            jsFormatCurrency(document.getElementById('ctl00_cpb_txtDiscount'));
        }

        function CalculateDiscountAmount() {
            var DiscPct = $('#ctl00_cpb_txtDiscountPCT').val();
            var DiscAmount = $('#ctl00_cpb_txtDiscount').val();
            var Price = $('#ctl00_cpb_lblPaymentAmount').val();
          

            if (DiscAmount == 0) {
                DiscAmount = 0;
                DiscPct = 0;
            }
            else {
                DiscAmount = DiscAmount / 1.00;
                DiscPct = DiscAmount / jsToNumber(Price) * 100.00;
            }
            
            $('#ctl00_cpb_txtDiscountPCT').val(DiscPct);
            $('#ctl00_cpb_txtDiscount').val(DiscAmount);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
     <section class="panel">
        <header class="panel-heading">
          <span>Payment Request Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R80000030E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="R80000030O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R80000030O" runat="server" CssClass="btn btn-success" ><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnReject" RoleCode="R80000030O" runat="server" CssClass="btn btn-danger" OnClick="btnReject_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <%--code barcode--%>
                    <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DataType="Number" Text="100" style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String" style="display:none;" BindType="Both"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_DESC" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>   
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Reference No.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblReferenceNo" runat="server" DBColumnName="REFERENCE_NO" SPParameterName="p_reference_no" MaxLength="14" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Type</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblFlag" runat="server" DBColumnName="FLAG" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtFlag" style = "display:none" runat="server" CssClass="form-control" placeholder="Flag" DBColumnName="flag_code" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Payment To</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblPaymentTo" runat="server" DBColumnName="PAYMENT_TO" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Date</label>
                            <%--<asp:RequiredFieldValidator ID="rfvPaymentDate" runat="server" ErrorMessage="*" ControlToValidate="txtPaymentDate" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblPaymentDate" runat="server"  DBColumnName="PAYMENT_DATE" SPParameterName="p_payment_date" MaxLength="10" DataType="DateTime" BindType="Both" Format ="dd/MM/yyyy"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="BRANCH_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>--%> 
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Expired Date</label>
                                <%-- <asp:RequiredFieldValidator ID="rfvExpiredDate" runat="server" ErrorMessage="*" ControlToValidate="txtExpiredDate" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblExpiredDate" runat="server" DBColumnName="EXPIRED_DATE" SPParameterName="p_expired_date" MaxLength="10" DataType="DateTime" BindType="Both" Format ="dd/MM/yyyy"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>                   
                   </div>   
                   <div class="row">
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
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Exch Rate</label>
                                <%-- <asp:RequiredFieldValidator ID="rfvExchRate" runat="server" ErrorMessage="*" ControlToValidate="txtExchrate" ></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revExchRate" runat="server" ErrorMessage="*" ControlToValidate="txtExchrate" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>         --%>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblExchrate" runat="server" DBColumnName="EXCH_RATE"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtExchrate" runat="server" DBColumnName="EXCH_RATE" SPParameterName="p_exch_rate" MaxLength="18" DataType="Number" BindType="Both" Format="N2" style = "display:none"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div> 
                   </div>
                   <div class="row">
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
                        <div class="col-sm-6">
                         <div class="form-group">
                             <label class="col-sm-4">Invoice Amount</label>       
                             <div class="col-sm-5">
                                  <cc1:XUILabel ID="lblInvoiceAmount" runat="server" DBColumnName="INVOICE_AMOUNT" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                             </div>
                         </div>                            
                     </div> 
                    </div>
                    <div class="row">
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
                      <div class="col-sm-6">
                         <div class="form-group">
                             <label class="col-sm-4">Vat Amount</label>       
                             <div class="col-sm-5">
                                  <cc1:XUILabel ID="lblVatAmount" runat="server" DBColumnName="PPN_TAX" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                             </div>
                         </div>                            
                     </div>
                    </div>
                    <div class="row">
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
                        <div class="col-sm-6">
                         <div class="form-group">
                             <label class="col-sm-4">PPH Amount</label>       
                             <div class="col-sm-5">
                                <cc1:XUILabel ID="lblPphAmount" runat="server" DBColumnName="PPH_TAX" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                             </div>
                        </div>                            
                      </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 "></label>
                                <div class="col-sm-8">
                                <cc1:XUIRadioButtonList ID="rblPaymentMethod" runat="server"  DBColumnName="PAYMENT_METHOD_CODE" SPParameterName="p_payment_method_code" DataType="String" BindType="Both" RepeatLayout="Table" style="display:none;" RepeatDirection="Horizontal" >
                                    <asp:ListItem Value="CG" Selected="True">Cheque/Giro&nbsp&nbsp</asp:ListItem>
                                    <asp:ListItem Value="BT">Bank Transfer&nbsp&nbsp</asp:ListItem>
                                    <asp:ListItem Value="CS">Cash</asp:ListItem>
                                </cc1:XUIRadioButtonList>
                                </div>
                            </div>                        
                        </div>
                        <div class="col-sm-6">
                         <div class="form-group">
                             <label class="col-sm-4">Discount</label>       
                             <div class="col-sm-5">
                                <cc1:XUILabel ID="lblDiscount" runat="server" DBColumnName="DISCOUNT" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                             </div>
                         </div>                            
                       </div>
                    </div>
                     <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                             <label class="col-sm-4"></label>       
                             <div class="col-sm-5">
                                <cc1:XUILabel ID="XUILabel2"   ></cc1:XUILabel>
                             </div>
                         </div>                            
                       </div>
                        <div class="col-sm-6">
                         <div class="form-group">
                             <label class="col-sm-4">Discount Additional</label>       
                             <div class="col-sm-5">
                                <cc1:XUILabel ID="XUILabel1" runat="server" DBColumnName="DISCOUNT_ADDITIONAL" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                             </div>
                         </div>                            
                       </div>
                    </div>
                     <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Voucher No.</label>
                                <%--<asp:RequiredFieldValidator ID="rfvPaymentDate" runat="server" ErrorMessage="*" ControlToValidate="txtPaymentDate" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-5">
                                     <cc1:XUILabel ID="lblVoucherNo" runat="server" DBColumnName="VOUCHER_NO" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                         <div class="form-group">
                             <label class="col-sm-4">Fee Amount</label>       
                             <div class="col-sm-5">
                                <cc1:XUILabel ID="lblFeeAmount" runat="server" DBColumnName="TOTAL_AMOUNT" DataType="Number" Format="N2" BindType="DBToUIOnly" ></cc1:XUILabel>
                             </div>
                         </div>                            
                       </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Voucer Date</label>
                                <%-- <asp:RequiredFieldValidator ID="rfvExpiredDate" runat="server" ErrorMessage="*" ControlToValidate="txtExpiredDate" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblVoucherDate" runat="server" DBColumnName="VOUCHER_DATE"  MaxLength="10" DataType="DateTime" BindType="DBToUIOnly" Format ="dd/MM/yyyy"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Payment Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblCurrency" runat="server" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" BindType="Both" DataType="String" ></cc1:XUILabel>
                                    <cc1:XUITextBox ID="lblPaymentAmount" runat="server"  DBColumnName="PAYMENT_AMOUNT" SPParameterName="p_payment_amount"  MaxLength="18" DataType="Number" BindType="Both" Enabled="false" Format="N2"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div> 
                    <div class="row">  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both" MaxLength="400" TextMode="MultiLine" Height="58px"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <label class="col-sm-4">To Bank</label>
                                  <div class="col-sm-7">
                                  <cc1:XUILabel ID="lblBank" runat="server"  DBColumnName="BANK_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Payment By.</label>
                                  <div class="col-sm-7">
                                  <cc1:XUILabel ID="lblPaymentBy" runat="server"  DBColumnName="PAYMENT_BY" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <label class="col-sm-4">To Bank ACC No.</label>
                                  <div class="col-sm-7">
                                  <cc1:XUILabel ID="lblACCno" runat="server"  DBColumnName="BANK_ACCOUNT_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
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
                                 <label class="col-sm-4">To Bank ACC Name</label>
                                  <div class="col-sm-7">
                                  <cc1:XUILabel ID="lblACCname" runat="server"  DBColumnName="BANK_ACCOUNT_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
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
        
    <section class="panel">
    <header class="panel-heading">
      <span>Invoice List</span>
    </header>
    <div class="panel-heading">
        <div class="row">
            <div class="col-sm-8">
                <cc1:XUILinkButton ID="btnAdd" RoleCode="R80000030E" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                <cc1:XUILinkButton ID="btnDelete" RoleCode="R80000030E" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                        <%--<asp:TemplateField>
                        <HeaderTemplate>
                             <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                        </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:BoundField DataField="INVOICE_CODE" HeaderText="Doc Reff No." >
                            <ItemStyle Width="25%" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BILL_DATE" HeaderText="Doc Reff Date" DataFormatString="{0:dd/MM/yyyy}" >
                            <ItemStyle Width="25%" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PAYMENT" HeaderText="Total Amount" DataFormatString= {0:N2} >
                            <ItemStyle Width="25%" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PAYMENT" HeaderText="Payment" DataFormatString= {0:N2} >
                            <ItemStyle Width="25%" HorizontalAlign="Right" />
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


