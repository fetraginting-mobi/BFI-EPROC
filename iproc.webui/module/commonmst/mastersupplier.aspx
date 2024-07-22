<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastersupplier.aspx.cs" Inherits="module_commonmst_mastersupplier" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
            <span>Supplier Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000150E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true" ><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R30000150E" ID="btnPost" runat="server" CssClass="btn btn-success" CausesValidation="true" ><i class="icon-ok"></i>  Valid</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R30000150E" ID="btnInValid" runat="server" CssClass="btn btn-success" CausesValidation="true" OnClick="btnInValid_Click"><i class="icon-ok"></i>  In-Valid</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Creditor Type *</label>
                    <div class="col-sm-7">
                        <cc1:XUIDropDownList ID="ddlCreditorTypeCode" runat="server" CssClass="form-control" DBColumnName="CREDITOR_TYPE" SPParameterName="p_creditor_type" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlCreditorTypeCode_OnSelectedIndexChanged">
                              
                              <%--<asp:ListItem Value="0">-=Select=-</asp:ListItem>
                              <asp:ListItem Text="CREDITOR STAFF" Value="SOF"></asp:ListItem>
                              <asp:ListItem Text="CREDITOR SUPPLIER GOODS" Value="SPL"></asp:ListItem> 
                              <asp:ListItem Text="CREDITOR SUPPLIER SERVICE" Value="SPS"></asp:ListItem> --%>
                            
                        </cc1:XUIDropDownList>
                         
                         <asp:RequiredFieldValidator ID="rfvCreditorTypeCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlCreditorTypeCode" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                    </div>
                </div>                            
            </div>               
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Status</label>
                    <div class="col-sm-7">
                        <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly" MaxLength="50"></cc1:XUILabel>
                        <%--<cc1:XUILabel ID="XUILabel1" runat="server" DBColumnName="STATUS" DataType="String"  BindType="DBToUIOnly"></cc1:XUILabel>--%>
                        <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" Text="100" DataType="Number" style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel>
                    </div>
                </div>                            
            </div> 
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Supplier Code </label>
                    <div class="col-sm-7">
                        <asp:LinkButton runat="server" ID="btnLookUpEmployee" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                        <cc1:XUITextBox ID="txtSupplierCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                        <cc1:XUILabel ID="lblSupplierCode" runat="server"  DBColumnName="SUPPLIER_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                    </div>
                </div>                            
            </div> 
            <div class="col-sm-6">
                <div class="form-group">
                <label class="col-sm-3"></label>
                    <div class="col-sm-7">
                        <cc1:XUIRadioButtonList ID="rblSupplierType" runat="server"  DBColumnName="SUPPLIER_TYPE" SPParameterName="p_supplier_type" style="display:none;" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" >
                        <asp:ListItem Value="I" Selected="True">Individual&nbsp&nbsp</asp:ListItem>
                        <asp:ListItem Value="B">Business</asp:ListItem>
                        </cc1:XUIRadioButtonList>
                    </div>
                </div>                            
            </div> 
        </div>
        <div class="row">            
             <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Supplier Name *</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtSupplierName" runat="server" CssClass="form-control" placeholder="Supplier Name" DBColumnName="SUPPLIER_NAME" SPParameterName="p_supplier_name" DataType="String" BindType="Both" MaxLength="50"></cc1:XUITextBox>
                        <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplierName" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>                            
            </div>    
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Branch</label>
                    <div class="col-sm-7">
                        <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                        <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                        <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                    </div>
                </div>                             
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Address *</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtAddress1" runat="server" CssClass="form-control" placeholder="Address" DBColumnName="ADDRESS_1" SPParameterName="p_address_1" MaxLength="200" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator runat="server" ID="rvAddres" ControlToValidate="txtAddress1" ValidationExpression="^[\s\S]{0,200}$" ErrorMessage="Exceed maximum length 200" Display="Dynamic"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAddress1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>                            
            </div>   
             <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Region</label>
                    <div class="col-sm-7">
                        <cc1:XUIDropDownList ID="ddlWilayah" runat="server" CssClass="form-control" DBColumnName="WILAYAH" SPParameterName="p_wilayah" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                    </div>
                </div>                            
            </div> 
            <div class="col-sm-6" style="display:none">
                <div class="form-group">
                    <label class="col-sm-3 ">Address 2</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtAddress2" runat="server" CssClass="form-control" placeholder="Address 2" DBColumnName="ADDRESS_2" SPParameterName="p_address_2" MaxLength="200" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                       
                    </div>
                </div>                            
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Zipcode</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtZipcode" runat="server" CssClass="form-control" placeholder="Zipcode" DBColumnName="ZIPCODE" SPParameterName="p_zipcode" DataType="String" BindType="Both" MaxLength="7"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator ID="revZipcode" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtZipcode" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                    </div>
                </div>                            
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">City *</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City" DBColumnName="CITY" SPParameterName="p_city" MaxLength="30" DataType="String" BindType="Both"></cc1:XUITextBox>
                        <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCity" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>                            
            </div>   
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Tax Code</label>
                    <div class="col-sm-7">
                        <cc1:XUIDropDownList ID="ddlTaxType" runat="server" CssClass="form-control" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>    
                    </div>
                </div>                            
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Phone *</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone" DBColumnName="PHONE" SPParameterName="p_phone" MaxLength="200" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator ID="rvPhone" runat="server"  ErrorMessage="Format Invalid!" ControlToValidate="txtPhone" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        <%--<asp:RequiredFieldValidator ID="rfvPhone" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPhone" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    </div>
                </div>                            
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Fax</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtFax" runat="server" CssClass="form-control" placeholder="Fax" DBColumnName="FAX" SPParameterName="p_fax" DataType="String" BindType="Both" MaxLength="15"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator ID="fvFax" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtFax" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                    </div>
                </div>                            
            </div>  
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Owner Name *</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtContactP" runat="server" CssClass="form-control" placeholder="Owner Name" DBColumnName="CONTACT_P" SPParameterName="p_contact_p" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                        <asp:RequiredFieldValidator ID="rfvContactPerson" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtContactP" Display="Dynamic"></asp:RequiredFieldValidator>
                         <asp:RegularExpressionValidator ID="revContactPerson" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtContactP" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                </div>                            
            </div>   
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Owner Contact Phone *</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtContactHP" runat="server" CssClass="form-control" placeholder="Owner Contact Phone" DBColumnName="CONTACT_HP" SPParameterName="p_contact_hp" DataType="String" BindType="Both" MaxLength="15"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator ID="rvContactP" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtContactHP" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="rfvContactP" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtContactHP" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>                            
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Marketing Name</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtContactP2" runat="server" CssClass="form-control" placeholder="Marketing Name" DBColumnName="CONTACT_P_2" SPParameterName="p_contact_p_2" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                          <asp:RegularExpressionValidator ID="RevContactPerson2" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtContactP2" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                </div>                            
            </div>   
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Marketing Contact Phone</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtContactHP2" runat="server" CssClass="form-control" placeholder=" Marketing Contact Phone" DBColumnName="CONTACT_HP_2" SPParameterName="p_contact_hp_2" DataType="String" BindType="Both" MaxLength="15"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator ID="rvContactHp2" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtContactHP2" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                    </div>
                </div>                            
            </div>
        </div>
        <%--<div class="row" >
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-2">Bank</label>
                    <div class="col-sm-7">
                        <cc1:XUIDropDownList ID="ddlBankDestination" runat="server" CssClass="form-control" DBColumnName="BANK_CODE" SPParameterName="p_bank_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>    
                    </div>
                </div>                            
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-2 ">Account No. *</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtAccountNo" runat="server" CssClass="form-control" placeholder="Account No" DBColumnName="ACCOUNT_NO" SPParameterName="p_account_no" DataType="String" BindType="Both" MaxLength="20"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator ID="rvAccountNo" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAccountNo" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="rfvAccountNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccountNo" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>                            
            </div>   
        </div>--%>
        <div class="row">  
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Mail Address *</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtMailAdd1" runat="server" CssClass="form-control" placeholder="Mail Address" DBColumnName="MAIL_ADD1" SPParameterName="p_mail_add1" DataType="String" BindType="Both" MaxLength="100" TextMode="MultiLine"></cc1:XUITextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMailAdd1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>                            
            </div>
              <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Mail Zipcode</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtMailZipcode" runat="server" CssClass="form-control" placeholder="Mail Zipcode" DBColumnName="MAIL_ZIPCODE" SPParameterName="p_mail_zipcode" DataType="String" BindType="Both" MaxLength="6"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMailZipcode" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                    </div>
                </div>                           
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Mail City</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtMailCity" runat="server" CssClass="form-control" placeholder="Mail City" DBColumnName="MAIL_CITY" SPParameterName="p_mail_city" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                         <asp:RegularExpressionValidator ID="revMailCity" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMailCity" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                </div>                            
            </div>   
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">WebSite Address</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtWebsite" runat="server" CssClass="form-control" placeholder="WebSite Address" DBColumnName="WEB_SITE_ADDRESS" SPParameterName="p_web_site_address" DataType="String" BindType="Both" MaxLength="50"></cc1:XUITextBox>
                        
                    </div>
                </div>                            
            </div>     
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">E-mail Address</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtMailAdd2" runat="server" CssClass="form-control" placeholder="E-mail Address" DBColumnName="MAIL_ADD2" SPParameterName="p_mail_add2" DataType="String" BindType="Both" MaxLength="200"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="Email Not Valid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtMailAdd2" Display="Dynamic"></asp:RegularExpressionValidator>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMailAdd2" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    </div>
                </div>                            
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">SIUP No.</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtSiup" runat="server" CssClass="form-control" placeholder="SIUP" DBColumnName="SIUP" SPParameterName="p_siup" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                    </div>
                </div>                            
            </div> 
        </div>
        <div class="row">   
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">NPWP</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtNPWP" runat="server" CssClass="form-control" placeholder="NPWP" DBColumnName="NPWP" SPParameterName="p_npwp" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator Display="Dynamic" ID="revNPWP" runat="server" ErrorMessage="Format is incorrect! Format = 00.000.000.0-000.000" ControlToValidate="txtNPWP" ValidationExpression="([0-9 ]{2}\.[0-9 ]{3}\.[0-9 ]{3}\.[0-9 ]{1}\-[0-9 ]{3}\.[0-9]{3})" />
                        
                    </div>
                </div>                            
            </div>
            <div class="col-sm-6"  style="display:none">
                <div class="form-group">
                    <label class="col-sm-3">Credit Term</label>
                    <div class="col-sm-6">
                        <cc1:XUITextBox ID="txtCreditTerm" runat="server" CssClass="form-control" placeholder="Credit Term" DBColumnName="CREDIT_TERM" SPParameterName="p_credit_term" DataType="String" BindType="Both" MaxLength="5" ></cc1:XUITextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtCreditTerm" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                    </div>
                        <label class="col-sm-1 ">Days</label>
                </div>                            
            </div>  
              <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">SKU No.</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtSKU" runat="server" CssClass="form-control" placeholder="SKU No" DBColumnName="SKU" SPParameterName="p_sku" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                    </div>
                </div>                            
            </div>           
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Flag PPH</label>
                    <div class="col-sm-7">
                        <cc1:XUICheckBox ID="chbFlagPPH" runat="server" DBColumnName="FLAG_PPH" SPParameterName="p_flag_pph" MaxLength="1" DataType="String" BindType="Both"></cc1:XUICheckBox>   
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
        <div class="row">  
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Flag PKP</label>
                    <div class="col-sm-7">
                        <cc1:XUICheckBox ID="txtFlagPKP" runat="server" DBColumnName="FLAG_PKP_OR_NON_PKP" SPParameterName="p_flag_pkp_or_non_pkp" MaxLength="1" DataType="String" BindType="Both"></cc1:XUICheckBox>                           
                    </div>
                </div>                            
            </div> 
            <div class="col-sm-6">
                <div class="form-group">
                <label class="col-sm-3">Rating Average Supplier</label>
                    <div class="col-sm-7">
                        <cc1:XUILabel ID="lblRating" runat="server" DBColumnName="RATING" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                   </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-3">Remarks</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both" MaxLength="200" TextMode="MultiLine"></cc1:XUITextBox>
                        <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,200}$" ErrorMessage="Exceed maximum length 200" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                </div>                            
            </div>
        </div>
          
        <div class="row" style="display:none">   
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-2 ">Transaction Year</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtTransactionYear" runat="server" CssClass="form-control" placeholder="Transaction Year" DBColumnName="TRX_YEAR" SPParameterName="p_trx_year" DataType="String" BindType="Both" MaxLength="4" ></cc1:XUITextBox>
                    </div>
                </div>                            
            </div> 
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-2 ">Transaction Month</label>
                    <div class="col-sm-7">
                        <cc1:XUITextBox ID="txtTransactionMonth" runat="server" CssClass="form-control" placeholder="Transaction Month" DBColumnName="TRX_MONTH" SPParameterName="p_trx_month" MaxLength="2" DataType="String" BindType="Both" ></cc1:XUITextBox>
                    </div>
                </div>                            
            </div>
              <%--(+) Ari 30-12-2022 ket : enhancement 2022, jika group role multiplebranch dapat akses pilih branch--%>
            <div class="col-sm-6" style="display:none">
                <div class="form-group">
                    <label class="col-sm-3">Is Multiplebranch</label>
                    <div class="col-sm-8">
                        <cc1:XUILabel ID="lblMultiplebranch" runat="server" DBColumnName="MULTIPLEBRANCH" BindType="DBToUIOnly" DataType="String"></cc1:XUILabel>
                    </div>
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
    
    <asp:Panel runat="server" ID="pnlBank">
     <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
          <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#Bank" id="branchbank" onclick="javascript:fnSetTab('branchbank');" data-toggle="tab" >
                      Bank
                  </a>
              </li>
              <li>
                  <a href="#Group" id="itemgroup" onclick="javascript:fnSetTab('itemgroup');" data-toggle="tab" >
                      Item Group
                  </a>
              </li>
              <li class="">
                        <a href="#History" id="hist" onclick="javascript:fnSetTab('hist');"  data-toggle="tab">
                            Supplier History
                        </a>
                    </li>
               <li>
                  <a href="#UploadDoc" id="uploadoc" onclick="javascript:fnSetTab('uploadoc');" data-toggle="tab" >
                      Upload Doc
                  </a>
              </li>
            </ul>
        </header>
        <div class="panel-body"> 
           <div class="tab-content tasi-tab">
              <div class="tab-pane active" id="Bank">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R30000150E" ID="btnAddBank" runat="server" CssClass="btn btn-primary" OnClick="btnAddBank_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R30000150E" ID="btnDeleteBank" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteBank_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                <asp:Panel ID="pnlSearchBank" runat="server" DefaultButton="btnSearchBank"     class="input-group">
                                    <asp:TextBox ID="txtSearchBank" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchBank" runat="server" CssClass="btn btn-info" OnClick="btnSearchBank_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="upd" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListBank" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                    OnPageIndexChanging="gvwListBank_PageIndexChanging" 
                                    onselectedindexchanged="gvwListBank_SelectedIndexChanged" EmptyDataText="There is no data">
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
                                        <asp:BoundField DataField="BANK_NAME" HeaderText="Bank">
                                            <ItemStyle Width="25%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BANK_ACCOUNT_NO" HeaderText="Account No.">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BANK_ACCOUNT_NAME" HeaderText="Account Name">
                                            <ItemStyle Width="25%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BANK_BRANCH" HeaderText="Bank Branch">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DEFAULT_FLAG" HeaderText="Default Flag">
                                            <ItemStyle Width="10%"  HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchBank" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteBank" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAddBank" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div> 
              <div class="tab-pane" id="Group">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R30000150E" ID="btnAddGroup" runat="server" CssClass="btn btn-primary" OnClick="btnAddGroup_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R30000150E" ID="btnDeleteGroup" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteGroup_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                <asp:Panel ID="pnlSearchGroup" runat="server" DefaultButton="btnSearchGroup"     class="input-group">
                                    <asp:TextBox ID="txtSearchGroup" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchGroup" runat="server" CssClass="btn btn-info" OnClick="btnSearchGroup_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updGroup" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListGroup" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                    OnPageIndexChanging="gvwListGroup_PageIndexChanging" 
                                    onselectedindexchanged="gvwListGroup_SelectedIndexChanged" EmptyDataText="There is no data">
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
                                        <asp:BoundField DataField="GROUP_CODE" HeaderText="Group">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DESCRIPTION" HeaderText="Description">
                                            <ItemStyle Width="30%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="REMARKS" HeaderText="REMARKS">
                                            <ItemStyle Width="50%" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchBank" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteBank" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAddBank" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div> 
              <div class="tab-pane" id="History">
               <div class="panel-heading">
                        <div class="row">
                           <div class="col-sm-8 ">
                    </div>
                <div class="col-sm-4">
                  <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                </div>
                    </asp:Panel>
                </div>
            </div>
           </div>
       <div class="panel-body"> 
            <asp:UpdatePanel ID="updHistory" runat="server">
                <ContentTemplate>
                   <asp:GridView ID="gvwListHist" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-stripe"
                    AllowPaging="true" PageSize="10" DataKeyNames="SUPPLIER_CODE,ID"  OnPageIndexChanging="gvwListHist_PageIndexChanging" 
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
                            <asp:BoundField DataField="PO_CODE" HeaderText="GRN Code">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="PO_DATE" HeaderText="PO Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="15%" HorizontalAlign="Left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ESTIMATED_RECEIPT_DATE" HeaderText="Estimated Receipt Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Left"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REAL_RECEIPT_DATE" HeaderText="Receipt Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                <ItemStyle Width="25%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PRICE" HeaderText="Price" DataFormatString="{0:N2}">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="RATING" HeaderText="Rating">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
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
                        AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, SUPPLIER_CODE, PATHS, FILE, ID"
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


