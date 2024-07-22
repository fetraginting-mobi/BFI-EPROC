<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accpvdetail.aspx.cs" Inherits="module_finance_accpvdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span>Payment Voucher Detail Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
              <ContentTemplate>
                    <div class="row" style="display:none">
                <div class="col-sm-6">
                    <div class="col-sm-12">
                        <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" SPParameterName="p_pv_status" DataType="String" BindType="Both" Text="------"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblPvNo" runat="server" DBColumnName="PV_NO" SPParameterName="p_pv_no" DataType="String" BindType="Both" Text="------"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblID" runat="server" DataType="String" SPParameterName="p_id" DBColumnName="ID" BindType="Both" ></cc1:XUILabel>
                        <cc1:XUILabel ID="lblTrxCode" runat="server" DataType="String" DBColumnName="TRX_CODE" BindType="DBToUIOnly" ></cc1:XUILabel>
                    </div>
                </div>
            </div>
            <%--(+)Start Neng - 21/10/2016 20:35:27 - penambahan division dan department--%>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <div  class="col-sm-4">
                            <label>Division *</label>
                            <asp:RequiredFieldValidator ID="rfvDivision" runat="server" ErrorMessage="*" ToolTip="Please fill this field." ControlToValidate="txtDivisionCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>  
                        <div class="col-sm-8">
                            <div class="input-group"> 
                                <asp:LinkButton runat="server" ID="btnLookupDivision" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtDivisionCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUITextBox ID="txtDivisionDesc" CssClass="form-control" runat="server" DBColumnName="DIVISION_DESC" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox>
                            </div> 
                        </div>
                    </div>                            
                </div>  
            </div>
            <div class="row">                         
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-4" >
                            <label>Department *</label>
                                <asp:RequiredFieldValidator ID="rfvDepartement" runat="server" ErrorMessage="*" ToolTip="Please fill this field." ControlToValidate="txtDepartementCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-sm-8">
                            <div class="input-group"> 
                                <asp:LinkButton runat="server" ID="btnLookupDepartement" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtDepartementCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUITextBox ID="txtDepartementDesc" CssClass="form-control" runat="server" DBColumnName="DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox>
                            </div> 
                        </div>
                    </div>                            
                </div>                             
             </div>  
             <%--(+)End Neng - 21/10/2016 20:35:27 - penambahan division dan department--%>           
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Chart Of Account *</label>
                        <div class="col-sm-8">
                            <asp:LinkButton runat="server" ID="btnLookUpAccChart" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                            <cc1:XUITextBox ID="txtAccNo" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ACC_NO" SPParameterName="p_acc_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblAccNo" runat="server" DBColumnName="ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <asp:RequiredFieldValidator ID="rfvtxtAccNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccNo" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>                             
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Original Amount *</label>
                        <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtCurrencyCode" runat="server" CssClass="form-control" placeholder="" DBColumnName="ORIG_CURRENCY" SPParameterName="p_currency_code" MaxLength="3" DataType="String" BindType="Both" Enabled="false"></cc1:XUITextBox>
                        </div>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtOrigAmount" runat="server" CssClass="form-control" placeholder="Original Amount" DBColumnName="ORIG_AMOUNT" SPParameterName="p_orig_amount" MaxLength="14" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvOrigAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtOrigAmount" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Exch Rate *</label>       
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtExchRate" runat="server" CssClass="form-control" placeholder="Exch Rate" DBColumnName="EXCH_RATE" SPParameterName="p_exch_rate" MaxLength="10" DataType="Number" BindType="Both" Format="N2" Enabled="false"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvExchRate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtExchRate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revExchRate" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtExchRate" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                        </div>
                    </div>                            
                </div> 
             </div>
                    <div class="row">
                 <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Base Amount</label>
                        <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtBaseCurr" runat="server" CssClass="form-control" DBColumnName="BASE_CURRENCY" DataType="String" BindType="Both" Enabled="false" SPParameterName="p_base_currency"></cc1:XUITextBox>
                        </div>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtBaseAmount" runat="server" CssClass="form-control" placeholder="Debet Amount" DBColumnName="BASE_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="false"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>                                        
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Remarks</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                            <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
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

