<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="appaymentrequestdetail.aspx.cs" Inherits="module_apinvoice_appaymentrequestdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Invoice Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R80000030E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                   <!--ID-->
                   <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                   <!--Type-->
                   <cc1:XUITextBox ID="txtType" style = "display:none" runat="server" DBColumnName="FLAG" SPParameterName="p_code" CssClass="form-control" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                   <!--Barcode-->
                   <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="P_PAYMENT_CODE" SPParameterName="p_payment_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblPRStatus" runat="server" DBColumnName="PR_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblPaymentInvoice" runat="server" DBColumnName="PAYMENT_DESC" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Doc Ref No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="txtInvoiceNo" runat="server" DBColumnName="INVOICE_CODE" SPParameterName="p_invoice_code" MaxLength="14" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Doc Ref Date</label>
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="lblBillDate"  runat="server" DBColumnName="BILL_DATE" MaxLength="10" DataType="DateTime" BindType="DBToUIOnly" Format ="dd/MM/yyyy" Text="-"></cc1:XUILabel>
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
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblDivision" runat="server" DBColumnName="DIVISION_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
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
                                <label class="col-sm-4">Department</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblDepartement" runat="server" DBColumnName="DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
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
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblSubDepartment" runat="server" DBColumnName="SUB_DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Currency</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblCurrency"  runat="server" DBColumnName="CURR_CODE" MaxLength="3" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Bruto Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblBrutoInvoiceAmount" runat="server" DBColumnName="BRUT_AMOUNT" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" Text="-"></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div>                               
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Net Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblNetAmount" runat="server" DBColumnName="NET_AMOUNT" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" Text="-" ></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Total Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblTotalAmount" runat="server" DBColumnName="TOTAL_AMOUNT" MaxLength="18" DataType="Number" BindType="DBToUIOnly" Format="N2" Text="-"></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div>   
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remaining Invoice</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblRemainingInvoice" runat="server" DBColumnName="REAMINING" DataType="Number" BindType="DBToUIOnly" Format="N2" Text="0"></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Doc Ref Desc</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblBillDesc" runat="server" DBColumnName="BILL_DESC" SPParameterName="p_bill_desc" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Payment</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblPayment" runat="server" DBColumnName="PAYMENT" SPParameterName="p_payment" MaxLength="18" DataType="Number" BindType="Both" Format="N2"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Paid</label>
                                <div class="col-sm-8">
                                    <cc1:XUICheckBox ID="cbkPaid" runat="server" DBColumnName="PAID" SPParameterName="p_paid" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" Enabled="false" ></cc1:XUICheckBox>
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

