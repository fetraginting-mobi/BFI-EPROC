<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="paymentallocationdetail.aspx.cs" Inherits="paymentallocationdetail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Acc No Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000120E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
             <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text= "0" style="display:none"></cc1:XUILabel>
                  
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Category Code</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblAccChart" runat="server" DBColumnName="ALLOCATION_ID" SPParameterName="p_allocation_id" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                 
                    <div class="row" runat="server" id="COGS" >
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">ACC No. *</label>
                                <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpACCCOGS"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtACCNO" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_CHART" SPParameterName="p_acc_chart" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblACCName"  runat="server" DBColumnName="ACC_CHART" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                 
                                    <asp:RequiredFieldValidator ID="rfvACCCOGS" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtACCNO" Display="Dynamic"></asp:RequiredFieldValidator>
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

