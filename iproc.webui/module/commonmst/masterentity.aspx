<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterentity.aspx.cs" Inherits="module_commonmst_masterentity" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Entity Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R30000010E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <div class="row">
            <cc1:XUILabel ID="txtCode" runat="server" DBColumnName="CODE" SPParameterName="p_code" DataType="String" BindType="Both" style="display:none;"></cc1:XUILabel>    
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Name</label>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="*" ControlToValidate="txtName" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-10">
                            <cc1:XUITextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Corporate Name" DBColumnName="NAME" SPParameterName="p_name" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>                                    
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Address</label>
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="*" ControlToValidate="txtAddress" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-10">
                            <cc1:XUITextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" DBColumnName="ADDRESS" SPParameterName="p_address" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>                                    
                        </div>
                    </div>                         
                </div>         
            </div>  
            <div class="row"> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">City</label>
                        <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="*" ControlToValidate="txtCity" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City" DBColumnName="CITY" SPParameterName="p_city" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>                                    
                        </div>
                    </div>                         
                </div> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Corporate Type</label>
                        <div class="col-sm-8">
                            <cc1:XUIDropDownList ID="ddlCorporateType" runat="server" CssClass="form-control" DBColumnName="CORPORATE_TYPE_CODE" SPParameterName="p_corporate_type_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>                                 
                        </div>
                    </div>                              
                </div>
            </div>
            <div class="row"> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Corporate Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtCorporateDate" runat="server" CssClass="form-control default-date-picker" placeholder="Corporate Date" DBColumnName="CORPORATE_DATE" SPParameterName="p_corporate_date" MaxLength="10" DataType="DateTime" Format="dd/MM/yyyy" BindType="Both" ></cc1:XUITextBox>                                    
                        </div>
                        <asp:RegularExpressionValidator ID="revCorporateDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtCorporateDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Public Listing No.</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtPublicListing" runat="server" CssClass="form-control" placeholder="Public Listing No" DBColumnName="LISTING_NO" SPParameterName="p_listing_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>                                    
                        </div>
                    </div>                            
                </div>
            </div>  
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Listing Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtListingDate" runat="server" CssClass="form-control default-date-picker" placeholder="Listing Date" DBColumnName="LISTING_DATE" SPParameterName="p_listing_date" MaxLength="10" DataType="DateTime" Format="dd/MM/yyyy" BindType="Both" ></cc1:XUITextBox>                                    
                        </div>
                        <asp:RegularExpressionValidator ID="revListingDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtListingDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">SIUP No.</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtSiupNo" runat="server" CssClass="form-control" placeholder="SIUP No" DBColumnName="SIUP_NO" SPParameterName="p_siup_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>                                    
                        </div>
                    </div>                            
                </div>
            </div> 
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">SIUP Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtSiupDate" runat="server" CssClass="form-control default-date-picker" placeholder="SIUP Date" DBColumnName="SIUP_DATE" SPParameterName="p_siup_date" MaxLength="10" DataType="DateTime" Format="dd/MM/yyyy" BindType="Both" ></cc1:XUITextBox>                                    
                        </div>
                        <asp:RegularExpressionValidator ID="revSiupDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtSiupDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">NPWP No.</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtNpwpNo" runat="server" CssClass="form-control" placeholder="NPWP No" DBColumnName="NPWP_NO" SPParameterName="p_npwp_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>                                    
                            <asp:RegularExpressionValidator ID="revNPWPNo" Display="Dynamic" runat="server" ErrorMessage="Format is incorrect! Format = 00.000.000.0-000.000" ControlToValidate="txtNpwpNo" ValidationExpression="([0-9 ]{2}\.[0-9 ]{3}\.[0-9 ]{3}\.[0-9 ]{1}\-[0-9 ]{3}\.[0-9]{3})" />
                        </div>
                    </div>                            
                </div>
            </div>  
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Tax Mandatory</label>
                        <div class="col-sm-8">
                            <cc1:XUICheckBox ID="chbIsTax" runat="server" DBColumnName="IS_TAX" SPParameterName="p_is_tax" DataType="String" BindType="Both"></cc1:XUICheckBox>                                    
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Phone No.</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtPhoneNo" runat="server" CssClass="form-control" placeholder="Phone" DBColumnName="PHONE" SPParameterName="p_phone" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>                                    
                            <asp:RegularExpressionValidator ID="revPhoneNo" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPhoneNo" ValidationExpression="[0-9-+]*[0-9-+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Fax No.</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtFax" runat="server" CssClass="form-control" placeholder="Fax" DBColumnName="FAX" SPParameterName="p_fax" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>                                    
                            <asp:RegularExpressionValidator ID="revFax" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtFax" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        </div>
                    </div>                             
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Mail Profile *</label>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Required Field" ControlToValidate="txtEmail" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Mail Profile" DBColumnName="DBMAIL_PROFILE" SPParameterName="p_dbmail_profile" MaxLength="200" DataType="String" BindType="Both"></cc1:XUITextBox>                                    
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Prepared By *</label>
                        <asp:RequiredFieldValidator ID="rfvPrepared" runat="server" ErrorMessage="Required Field" ControlToValidate="txtPrepareBy" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtPrepareBy" runat="server" CssClass="form-control" placeholder="Prepare By" DBColumnName="PREPARE_BY" SPParameterName="p_prepare_by" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox> 
                              <asp:RegularExpressionValidator ID="revPrepareBy" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPrepareBy" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>                                   
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Direction 1</label>
                        <asp:RequiredFieldValidator ID="rfvApprove1" runat="server" ErrorMessage="Required Field" ControlToValidate="txtApprove1" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtApprove1" runat="server" CssClass="form-control" placeholder="Direksi 1" DBColumnName="APPROVE_1_BY" SPParameterName="p_approve_1_by" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>   
                             <asp:RegularExpressionValidator ID="refApprove1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtApprove1" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>                                                                    
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Direction 2</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtApprove2" runat="server" CssClass="form-control" placeholder="Direksi 2" DBColumnName="APPROVE_2_BY" SPParameterName="p_approve_2_by" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox> 
                            <asp:RegularExpressionValidator ID="refApprove2" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtApprove2" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>                                     
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Direction 3</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtApprove3" runat="server" CssClass="form-control" placeholder="Direksi 3" DBColumnName="APPROVE_3_BY" SPParameterName="p_approve_3_by" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RegularExpressionValidator ID="refApprove3" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtApprove3" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>                                     
                        </div>
                    </div>                            
                </div>
            </div>                    
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Validate By *</label>
                        <asp:RequiredFieldValidator ID="rfvValidateBy" runat="server" ErrorMessage="Required Field" ControlToValidate="txtValidateBy" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtValidateBy" runat="server" CssClass="form-control" placeholder="Validate By" DBColumnName="VALIDATE_BY" SPParameterName="p_validate_by" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox> 
                             <asp:RegularExpressionValidator ID="revValidateBy" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtValidateBy" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>                                    
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">SPT Validate By *</label>
                        <asp:RequiredFieldValidator ID="rfvSptValidateBy" runat="server" ErrorMessage="Required Field" ControlToValidate="txtSptValidateBy" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtSptValidateBy" runat="server" CssClass="form-control" placeholder="SPT Validate By" DBColumnName="SPT_VALIDATE_BY" SPParameterName="p_spt_validate_by" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                              <asp:RegularExpressionValidator ID="revSptValidateBy" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtSptValidateBy" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>                                      
                        </div>
                    </div>                            
                </div>
            </div> 
            <div class="row">                
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">NPWP 1721-A1 *</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtNPWP1721_A1" runat="server" CssClass="form-control" placeholder="NPWP1721-A1" DBColumnName="NPWP_1721_A1" SPParameterName="p_npwp_1721_a1" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>                                    
                            <asp:RequiredFieldValidator ID="rfvNPWP1721_A1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtNPWP1721_A1" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revNPWP1721_A1" Display="Dynamic" runat="server" ErrorMessage="Format is incorrect! Format = 00.000.000.0-000.000" ControlToValidate="txtNPWP1721_A1" ValidationExpression="([0-9 ]{2}\.[0-9 ]{3}\.[0-9 ]{3}\.[0-9 ]{1}\-[0-9 ]{3}\.[0-9]{3})" />
                        </div>
                    </div>                            
                </div>
            </div>  
        </div>
    </section>
</asp:Content>

