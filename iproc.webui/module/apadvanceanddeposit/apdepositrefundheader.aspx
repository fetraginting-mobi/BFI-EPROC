<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apdepositrefundheader.aspx.cs" Inherits="module_apadvanceanddeposit_apdepositrefundheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Deposit Refund Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton RoleCode="R80000110E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                    <asp:LinkButton RoleCode="R80000110O" ID="btnPost" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click"><i class="icon-envelope"></i>  Post</asp:LinkButton>
                      <cc1:XUILinkButton RoleCode="R80000110O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                       <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                    <asp:LinkButton RoleCode="R80000110O" ID="btnReject" runat="server" CssClass="btn btn-danger" OnClick="btnReject_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                    <asp:LinkButton RoleCode="R80000110" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remmove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Deposit Refund No.</label>
                        <!--CODE BARCODE-->
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String" style="display:none;" BindType="Both"></cc1:XUILabel>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                             <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control" placeholder="Reference No" DBColumnName="REFERENCE_NO" SPParameterName="p_reference_no" style="display:none;" MaxLength="10" DataType="String" BindType="None" ></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Status</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_DESC" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Date</label>
                        <asp:RequiredFieldValidator ID="rfvRefundDate" runat="server" ErrorMessage="*" ControlToValidate="txtRefundDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtRefundDate" runat="server" CssClass="form-control default-date-picker" placeholder="Refund Date" DBColumnName="REFUND_DATE" SPParameterName="p_refund_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Reference No.</label>
                        <asp:RequiredFieldValidator ID="rfvReferenceNo" runat="server" ErrorMessage="*" ControlToValidate="txtReferenceNo" Display="Dynamic" Enabled="False"></asp:RequiredFieldValidator>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtReferenceNo" runat="server" CssClass="form-control" placeholder="Reference No" DBColumnName="REFERENCE_NO" SPParameterName="p_reference_no" MaxLength="10" DataType="String" BindType="Both" Enabled="False"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
            </div>
             <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Deposit No *</label>
                        <div class="col-sm-6">
                            <asp:LinkButton runat="server" ID="btnLookUpUserRequest" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                              <cc1:XUILabel ID="lblReffNo" runat="server" DBColumnName="REFERENCE_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                 <cc1:XUITextBox ID="txtReffNo" runat="server" style="display:none;"  CssClass="form-control" placeholder="Reference No" DBColumnName="REFERENCE_NO" SPParameterName="p_reference_no"  DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvUserRequest" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReffNo" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div> 
            </div> 
            <div class="row">
                <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4 ">Supplier</label>
                            <div class="col-sm-12"></div>
                            <div class="col-sm-8">
                                <asp:LinkButton runat="server" ID="btnLookUpSupplier" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>   
                                <asp:RequiredFieldValidator ID="rfvSupplier" runat="server" ErrorMessage="*" ControlToValidate="txtSupplier" Display="Dynamic"></asp:RequiredFieldValidator>
                                <cc1:XUITextBox ID="txtSupplier" style="display:none" runat="server"  CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" MaxLength="14" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblSupplier" runat="server" DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Currency</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlCurrencyCode" runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                        </div>
                    </div>                            
                </div>  
            </div>
            <div class="row" style="display:none" > 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Payment</label>
                              <asp:RequiredFieldValidator ID="rfvPaymentMethodCode" runat="server" ErrorMessage="*" ControlToValidate="rblPaymentMethodCode" Display="Dynamic"></asp:RequiredFieldValidator>         
                        <div class="col-sm-8">
                            <cc1:XUIRadioButtonList ID="rblPaymentMethodCode" runat="server"  DBColumnName="PAYMENT_METHOD_CODE" SPParameterName="p_payment_method_code" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" >
                                <asp:ListItem Value="DEBIT" Selected="True">Debit&nbsp&nbsp</asp:ListItem>
                                <asp:ListItem Value="CREDIT">Credit</asp:ListItem>
                            </cc1:XUIRadioButtonList> 
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4"></label>
                    <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBankCode" style="display:none"  runat="server" CssClass="form-control" DBColumnName="BANK_CODE" SPParameterName="p_bank_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList> 
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Amount</label>
                        <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="*" ControlToValidate="txtAmount" Display="Dynamic" Enabled="False"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revAmount" runat="server" ErrorMessage="*" ControlToValidate="txtAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic" Enabled="False"></asp:RegularExpressionValidator>         
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control"  style="display:none"  placeholder="Amount" DBColumnName="AMOUNT" SPParameterName="p_amount" MaxLength="18" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblAmount" runat="server" DBColumnName="AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2"  Text="--"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
             </div>
              <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Description*</label>
                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
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
    <section class="panel" style="display:none;" >
        <header class="panel-heading">
          <span>Deposit Registration List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
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
                    AllowPaging="true" PageSize="10" DataKeyNames="ID" OnPageIndexChanging="gvwList_PageIndexChanging" 
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
                            <asp:TemplateField>
                            <HeaderTemplate>
                                  <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DR_CODE" HeaderText="Code">
                                <ItemStyle Width="40%" HorizontalAlign="Center"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="REFUND_AMOUNT" HeaderText="Refund Amount" 
                                DataFormatString= {0:N2}>
                                <ItemStyle Width="60%" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                  </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
