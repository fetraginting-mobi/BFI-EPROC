<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apdepositalocationdeposit.aspx.cs" Inherits="module_apinvoice_apdepositalocationdeposit" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
 <section class="panel">
        <header class="panel-heading">
          <span>Deposit Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R80000070E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <!--ID-->
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                    <!--Barcode-->
                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="AP_CODE_BARCODE" SPParameterName="p_ap_code_barcode" DataType="String" BindType="Both" style="Display:none;"></cc1:XUILabel>
                    <cc1:XUILabel ID="XUILabel1" runat="server" DBColumnName="AP_CODE" SPParameterName="p_ap_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
                    <!--EMP_CODE-->
                    <cc1:XUITextBox ID="txtEmpCode" style="Display:none;"  runat="server" CssClass="form-control" DBColumnName="EMP_CODE"  DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4 ">No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblAAStatus" runat="server" DBColumnName="AA_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNo" runat="server" DBColumnName="INVOICE_DESC" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">Deposit No. *</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpDeposit" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                                         
                                    <cc1:XUITextBox ID="txtDepositNo" style="display:none" runat="server" CssClass="form-control" DBColumnName="AP_CODE" SPParameterName="p_ap_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblDepositDesc"  runat="server"  DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                    <asp:RequiredFieldValidator ID="rfvInvoiceNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDepositNo" Display="Dynamic"></asp:RequiredFieldValidator>  
                                 </div>
                             </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4 ">Deposit Date</label>
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="lblDepositDate" runat="server" placeholder="Deposit Date" DBColumnName="DEPOSIT_DATE" DataType="DateTime" BindType="DBToUIOnly" Format ="dd/MM/yyyy"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblDepartmentDesc" runat="server" DBColumnName="DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
                                    <cc1:XUITextBox ID="txtDepartmentCode" style="display:none"  runat="server"  CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblDivision" runat="server" DBColumnName="DIVISION_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
                                    <cc1:XUITextBox ID="txtDivision" style="display:none" runat="server"  CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">Deposit Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblBill" runat="server"  placeholder="Bill" DBColumnName="AMOUNT"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel> 
                                    <cc1:XUILabel ID="lblCurrencyDesc" style="display:none" runat="server" CssClass="form-control" placeholder="Currency Desc" DBColumnName="CURRENCY_DESC"  MaxLength="50" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>   
                                </div>
                             </div>                            
                         </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                            <label class="col-sm-4">Total Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblNetBill" runat="server"  placeholder="Total Amount" DBColumnName="AMOUNT"  MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                                <div class="form-group">
                                <label class="col-sm-4">Payment</label>
                                    <div class="col-sm-5">
                                         <cc1:XUILabel ID="lblPayment" runat="server" DBColumnName="PAYMENT" SPParameterName="p_payment" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" ></cc1:XUILabel> 
                                        <cc1:XUITextBox ID="txtpayment" style="display:none" runat="server" CssClass="form-control" DBColumnName="PAYMENT" SPParameterName="p_payment" MaxLength="14" DataType="Number" BindType="Both"></cc1:XUITextBox>   
                                    </div>
                                </div>                            
                           </div>
                       </div>
                    <div class="row">
                        <div class="col-sm-6" style="display:none" >
                            <div class="form-group">
                            <label class="col-sm-4">Description</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="200" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div> 
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

