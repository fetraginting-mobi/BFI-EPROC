<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="mastercreditor.aspx.cs" Inherits="module_commonmst_mastercreditor" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Creditor Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R02000003E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>   
            <cc1:XUILabel ID="lblId" runat="server"  DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text="0" style="display:none" ></cc1:XUILabel>
               <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Supplier</label>
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookUpSupplier" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>   
                                <asp:RequiredFieldValidator ID="rfvSupplier" runat="server" ErrorMessage="*" ControlToValidate="txtSupplier" Display="Dynamic"></asp:RequiredFieldValidator>                        
                                <cc1:XUITextBox ID="txtSupplier" style="display:none" runat="server"  CssClass="form-control" DBColumnName="SUPPLIER_ID" SPParameterName="p_supplier_id" DataType="Integer" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblSupplier" runat="server" DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                            </div>
                        </div>                               
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Creditor</label>
                            <asp:RequiredFieldValidator ID="rfvCreditorCode" runat="server" ErrorMessage="*" ControlToValidate="txtCreditorCode" Display="Dynamic"></asp:RequiredFieldValidator>                                
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtCreditorCode" runat="server"  CssClass="form-control" placeholder="Creditor Code" DBColumnName="CREDITOR_CODE" SPParameterName="p_creditor_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                            </div>
                        </div>                               
                    </div>
               </div>
               <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Name</label>
                            <asp:RequiredFieldValidator ID="rfvCreditorName" runat="server" ErrorMessage="*" ControlToValidate="txtCreditorName" Display="Dynamic"></asp:RequiredFieldValidator>                                
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtCreditorName" runat="server"  CssClass="form-control" placeholder="Creditor Name" DBColumnName="CREDITOR_NAME" SPParameterName="p_creditor_name" MaxLength="200" DataType="String" BindType="Both"></cc1:XUITextBox>
                            </div>
                        </div>                               
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Creditor Type</label>
                            <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlCreditorTypeCode" runat="server" CssClass="form-control" DBColumnName="CREDITORTYPE_CODE" SPParameterName="p_creditortype_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                            </div>
                        </div>                               
                    </div>
               </div>
               <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Tax Code</label>
                            <%--<asp:RequiredFieldValidator ID="rfvTaxCode" runat="server" ErrorMessage="*" ControlToValidate="txtTaxCode" Display="Dynamic"></asp:RequiredFieldValidator>                                
    --%>                    <div class="col-sm-4">
                                <cc1:XUIDropDownList ID="ddlTaxCode" runat="server" CssClass="form-control" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                            </div>
                        </div>                               
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Currency</label>
                            <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlCurrency" runat="server" CssClass="form-control" DBColumnName="CURRENCY" SPParameterName="p_currency" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                            </div>
                        </div>                             
                    </div> 
               </div>
               <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Credit Limit</label>
                            <asp:RequiredFieldValidator ID="rfvCreditLimit" runat="server" ErrorMessage="*" ControlToValidate="txtCreditLimit" Display="Dynamic"></asp:RequiredFieldValidator>                                
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtCreditLimit" runat="server"  CssClass="form-control" placeholder="Credit Limit" DBColumnName="CREDIT_LIMIT" SPParameterName="p_credit_limit" MaxLength="18" DataType="Number" BindType="Both" Format="N2"></cc1:XUITextBox>
                            </div>
                       </div>
                    </div>               
                    <div class="col-sm-6">
                         <div class="form-group">
                             <label class="col-sm-3">Credit Term</label>
                             <asp:RequiredFieldValidator ID="rfvCreditTerm" runat="server" ErrorMessage="*" ControlToValidate="txtCreditterm" Display="Dynamic"></asp:RequiredFieldValidator>                                
                             <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtCreditTerm" runat="server"  CssClass="form-control" placeholder="Credit Term" DBColumnName="CREDIT_TERM" SPParameterName="p_credit_term" MaxLength="18" DataType="Number" BindType="Both" Format="N0"></cc1:XUITextBox>
                             </div>
                         </div>                             
                    </div>
               </div>
               <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-2">Flag PPH</label>
                            <div class="col-sm-7">
                                <cc1:XUICheckBox ID="chbFlagPph" runat="server" DBColumnName="FLAG_PPH" SPParameterName="p_flag_pph" MaxLength="1" DataType="String" BindType="Both"></cc1:XUICheckBox>                              
                            </div>
                       </div>
                    </div>                 
                    <div class="col-sm-6">
                         <div class="form-group">
                             <label class="col-sm-3">Flag Gross Up</label>
                             <div class="col-sm-7">
                                <cc1:XUICheckBox ID="chbFlagGrossUp" runat="server" DBColumnName="FLAG_GROSS_UP" SPParameterName="p_flag_gross_up" MaxLength="1" DataType="String" BindType="Both"></cc1:XUICheckBox>                            
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
