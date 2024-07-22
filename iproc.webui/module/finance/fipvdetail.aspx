<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fipvdetail.aspx.cs"
    Inherits="module_finance_fipvdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Detail Info</span>
        </header>
         <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <%--<cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>--%>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
           <ContentTemplate>
                <div class="row" style="display:none">
                <div class="col-sm-6">
                    <div class="col-sm-12">
                        <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer"  BindType="Both" Text="0"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblPvNo" runat="server" DBColumnName="PV_NO" SPParameterName="p_jm_no" DataType="String" BindType="Both" Text="------"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblPvStatus" runat="server" DBColumnName="PV_STATUS" SPParameterName="p_pv_status" DataType="String" BindType="DBToUIOnly" Text="------"></cc1:XUILabel>
                    </div>
                </div>
            </div>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Request No.</label>
                        <div class="col-sm-6">
                           <cc1:XUILabel ID="txtPrNo" runat="server" DBColumnName="PR_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Date</label>
                        <div class="col-sm-3">
                            <cc1:XUILabel ID="lblDate" runat="server" DBColumnName="PR_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>   
            </div> 
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Request Type </label>
                        <div class="col-sm-3">
                            <cc1:XUILabel ID="lblPrType" runat="server" DBColumnName="PR_TYPE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>                
           </div>          
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Amount</label>
                        <div class="col-sm-2">
                            <cc1:XUILabel ID="lblOrigCurrCode" runat="server" DBColumnName="ORIG_CURR_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                        <div class="col-sm-5">
                            <cc1:XUILabel ID="lblOrigAmount" runat="server" DBColumnName="ORIG_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Exch Rate</label>
                        <div class="col-sm-5">
                            <cc1:XUILabel ID="txtExchRate" runat="server" DBColumnName="EXCH_RATE" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>    
            </div>                          
                <div class="row">
                 <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Base Amount</label>
                        <div class="col-sm-2">
                            <cc1:XUILabel ID="lblBaseCurrCode" runat="server" DBColumnName="BASE_CURR_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                        <div class="col-sm-5">
                            <cc1:XUILabel ID="lblBaseAmount" runat="server" DBColumnName="BASE_AMOUNT" DataType="Number" BindType="DBToUIOnly" Format="N2" Enabled="false"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>                                         
             </div>
           </ContentTemplate>
               <Triggers>
                  <%--<asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />--%>
               </Triggers>   
        </asp:UpdatePanel>   
        </div> 
    </section>
</asp:Content>
