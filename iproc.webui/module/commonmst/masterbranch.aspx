<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterbranch.aspx.cs" Inherits="module_commonmst_masterbranch" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Branch Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000020E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
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
                                <label class="col-sm-3">Branch Initial *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="Branch Initial" DBColumnName="CODE" SPParameterName="p_code" MaxLength="3" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtCode" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Active</label>
                                <div class="col-sm-7">
                                    <%--<cc1:XUILabel ID="txtIsActive" runat="server" DBColumnName="IS_ACTIVE"  MaxLength="1" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>--%>
                                    <cc1:XUICheckBox ID="cbxIsActive" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" runat="server" Checked="true" />
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Code *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtInisialCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="INISIAL_CODE" SPParameterName="p_inisial_code" MaxLength="3" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvBranchinitial" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtInisialCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                   
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Branch *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Branch Name" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                                   <%-- <asp:RegularExpressionValidator ID="revDescription" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDescription" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Address *</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" DBColumnName="ADDRESS" SPParameterName="p_address" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtAddress" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAddress" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Code Area. *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtCodeArea" runat="server" CssClass="form-control" placeholder="Code Area" DBColumnName="CODE_AREA" SPParameterName="p_code_area" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCodeArea" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCodeArea" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtCodeArea" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div> 
                     <div class="row">
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">City *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City" DBColumnName="CITY" SPParameterName="p_city" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revCity" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtCity" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCity" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Phone No. *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPhoneNo" runat="server" CssClass="form-control" placeholder="Phone No" DBColumnName="PHONE_NO" SPParameterName="p_phone_no" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPhoneNo" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvPhoneNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPhoneNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>                        
                    <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">District *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDistrict" runat="server" CssClass="form-control" placeholder="District" DBColumnName="DISTRICT" SPParameterName="p_district" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                     <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDistrict" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDistrict" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Fax No. *</label>
                                <%--<asp:RequiredFieldValidator ID="rfvFaxNo" runat="server" ErrorMessage="*" ControlToValidate="txtFaxNo" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtFaxNo" runat="server" CssClass="form-control" placeholder="Fax No" DBColumnName="FAX_NO" SPParameterName="p_fax_no" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revtxtFaxNo" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtFaxNo" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvtxtFaxNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFaxNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                     </div>
                     <div class="row">
                       <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Sub District *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtSubDistrict" runat="server" CssClass="form-control" placeholder="Sub District" DBColumnName="SUBDISTRICT" SPParameterName="p_subdistrict" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvSubDistrict" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSubDistrict" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtSubDistrict" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Post Code *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Post Code" DBColumnName="POST_CODE" SPParameterName="p_post_code" MaxLength="5" DataType="String" BindType="Both"></cc1:XUITextBox>
                                   <asp:RegularExpressionValidator ID="rvPostCode" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPostCode" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvPostCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPostCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Email Address *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtEmailAddress" runat="server" CssClass="form-control" placeholder="Email" DBColumnName="EMAIL_ADDRESS" SPParameterName="p_email_address" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtEmailAddress" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Email Not Valid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmailAddress" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div> 
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Email Address 2</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtEmailAddress2" runat="server" CssClass="form-control" placeholder="Email" DBColumnName="EMAIL_ADDRESS_2" SPParameterName="p_email_address_2" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Email Not Valid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmailAddress2" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>             
                    </div>  
                     <div class="row" runat="server" id="Expanse">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">RAK ACC No. *</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpACCRAK"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtACCRAK" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_RAK_NO" SPParameterName="p_acc_rak_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblNoACCRAK"  runat="server" style="display:none"  DBColumnName="ACC_RAK_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNameACCRAK"  runat="server"  DBColumnName="NAME_RAK" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvACCExpensePO" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtACCRAK" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Email Address BOSH</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtEmailBOSH" runat="server" CssClass="form-control" placeholder="Email BOSH" DBColumnName="EMAIL_ADDRESS_BOSH" SPParameterName="p_email_address_bosh" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="Email Not Valid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmailBOSH" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>  
                    </div> 
                    <div class="row">
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Is HO</label>
                                <div class="col-sm-7">
                                    <%--<cc1:XUILabel ID="txtIsActive" runat="server" DBColumnName="IS_ACTIVE"  MaxLength="1" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>--%>
                                    <cc1:XUICheckBox ID="txtISHO" DBColumnName="IS_HO" SPParameterName="p_is_ho" DataType="String" BindType="Both" runat="server" Checked="true" />
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
              <%--<li class="">
                  <a href="#SubBranch" id="subbranch" onclick="javascript:fnSetTab('subbranch');" data-toggle="tab" >
                      Sub Branch
                  </a>
              </li>--%>
              <li class="">
                  <a href="#AccPeriod" id="a1" onclick="javascript:fnSetTab('accounting');" data-toggle="tab" >
                      Accounting Period
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
                                <cc1:XUILinkButton RoleCode="R30000020E" ID="btnAddBank" runat="server" CssClass="btn btn-primary" OnClick="btnAddBank_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R30000020E" ID="btnDeleteBank" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteBank_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                                AllowPaging="true" PageSize="10" DataKeyNames="CODE"
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
                                            <ItemStyle Width="22%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BANK_ACCOUNT_NO" HeaderText="Account No.">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BANK_ACCOUNT_NAME" HeaderText="Account Name">
                                            <ItemStyle Width="23%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BANK_BRANCH" HeaderText="Bank Branch">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DEFAULT_FLAG" HeaderText="Default Flag">
                                            <ItemStyle Width="12%"  HorizontalAlign="Center"/>
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
               <%-- <div class="tab-pane" id="SubBranch">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R30000020E" ID="btnAddSubBranch" runat="server" CssClass="btn btn-primary" OnClick="btnAddSubBranch_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R30000020E" ID="btnDeleteSubBranch" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteSubBranch_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                <asp:Panel ID="pnlSearchSubBranch" runat="server" DefaultButton="btnSearchSubBranch"     class="input-group">
                                    <asp:TextBox ID="txtSearchSubBranch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchSubBranch" runat="server" CssClass="btn btn-info" OnClick="btnSearchSubBranch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updSubBranch" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListSubBranch" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="CODE"
                                    OnPageIndexChanging="gvwListSubBranch_PageIndexChanging" 
                                    onselectedindexchanged="gvwListSubBranch_SelectedIndexChanged" EmptyDataText="There is no data">
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
                                        <asp:BoundField DataField="CODE" HeaderText="Code">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SUB_BRANCH_NAME" HeaderText="Sub Branch Name">
                                            <ItemStyle Width="30%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ADDRESS" HeaderText="Address">
                                            <ItemStyle Width="30%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TELP" HeaderText="Telephone">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchSubBranch" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteSubBranch" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAddSubBranch" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>    
                </div>--%>
                <div class="tab-pane" id="AccPeriod">
                <header class="panel-heading">
                    <span>Accounting Period List</span>
                </header>
                <div class="panel-heading"> 
                    <div class="row">
                        <div class="col-sm-12">
                            <cc1:XUILinkButton RoleCode="R30000020E" ID="btnSaveAccPeriod" runat="server" CssClass="btn btn-primary" OnClick="btnSaveAccPeriod_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                            <%--<cc1:XUILinkButton RoleCode="" ID="XUILinkButton2" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>--%>
                        </div>
                    </div>
                </div>
                <div class="panel-body form-horizontal">
                    <asp:UpdatePanel ID="updAcc" runat="server">
                        <ContentTemplate>   
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label class="col-sm-2">Code</label>
                                        <div class="col-sm-2">
                                            <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" MaxLength="10" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                            <asp:RequiredFieldValidator ID="rfvBranchCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBranch" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>                            
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label class="col-sm-2">Month *</label>
                                        <div class="col-sm-2">
                                            <cc1:XUIDropDownList ID="ddlMonth" runat="server" CssClass="form-control" placeholder="" DBColumnName="MONTH" SPParameterName="p_month"  MaxLength="2" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                        </div>
                                    </div>                            
                                </div>
                            </div> 
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label class="col-sm-2">Year *</label>
                                        <div class="col-sm-2">
                                            <cc1:XUITextBox ID="txtYear" runat="server" CssClass="form-control" placeholder="Year" DBColumnName="YEAR" SPParameterName="p_year" MaxLength="4" DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <asp:RequiredFieldValidator ID="rfvYear" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtYear" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revYear" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtYear" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                        </div>
                                    </div>                            
                                </div>
                            </div>            
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSaveAccPeriod" EventName="Click" />
                            <%--<asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />--%>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
              </div>
            </div>             
        </div>  
      </section>
    </asp:Panel>
</asp:Content>
