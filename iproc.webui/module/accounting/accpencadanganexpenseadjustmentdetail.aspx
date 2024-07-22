<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/iproc.master"  CodeFile="accpencadanganexpenseadjustmentdetail.aspx.cs" Inherits="module_accounting_accpencadanganexpensedetail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span> Pencadangan Prepaid Expense Adjustment Detail Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <%--<cc1:XUILinkButton RoleCode="" ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print PDF</cc1:XUILinkButton>--%>
                    <%--<cc1:XUILinkButton RoleCode="" ID="btnSaveDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDetail_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>--%>
                    <cc1:XUILinkButton ID="btnCancelDetail" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancelDetail_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton> 
                </div>
            </div>
        </div>
       
     <asp:Panel runat="server" ID="pnlDetail">
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="updMain" runat="server">
                <ContentTemplate>
                     <div class="row">
                        <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">COA No</label>
                                <asp:RequiredFieldValidator ID="rfvCoaNo" runat="server" ErrorMessage="*" ControlToValidate="txtACCNo" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-9">
                                <div class="input-group"> 
                                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="DBToUIOnly" Text= "0" style="Display:none;" ></cc1:XUILabel>
                                     <asp:LinkButton ID="btnLookupCOA" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                                    <cc1:XUITextBox ID="txtACCNo" runat="server" CssClass="form-control" DBColumnName="ACC_NO" SPParameterName="p_acc_no" MaxLength="50" DataType="String" BindType="Both" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtACCName" CssClass="form-control" runat="server" DBColumnName="ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                </div> 
                            </div>
                        </div>                            
                    </div>
                     </div> 
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Amount</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control" DBColumnName="AMOUNT" BindType="Both" SPParameterName="p_amount" DataType="Number" Display="Dynamic" Format="N2" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                     </div>
                      <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Rate</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtRate" runat="server" CssClass="form-control" DBColumnName="RATE" BindType="Both" SPParameterName="p_rate" DataType="Number" Display="Dynamic" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Base Amount</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtBaseAmount" runat="server" CssClass="form-control" DBColumnName="BASE_AMOUNT" BindType="Both" SPParameterName="p_base_amount" Enabled="false" DataType="Number" Display="Dynamic" Format="N2" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                     </div>
                     <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Description</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" DBColumnName="DESCRIPTION" SPParameterName="p_description" BindType="Both" DataType="String" Display="Dynamic"  TextMode="MultiLine"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                      </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Debit/Kredit</label>
                                <div class="col-sm-4">
                                    <cc1:XUIRadioButtonList ID="rblDC" runat="server"  DBColumnName="D_C" SPParameterName="p_dc" DataType="String" BindType="Both" RepeatDirection="Horizontal"  RepeatLayout="Table"  >
                                        <asp:ListItem Value="DB">Debit&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="CR" >Credit</asp:ListItem>
                                    </cc1:XUIRadioButtonList>
                                </div>
                            </div>                            
                        </div>
                     </div>
                     
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnCancelDetail" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
      </asp:Panel> 
    </section>
</asp:Content>

