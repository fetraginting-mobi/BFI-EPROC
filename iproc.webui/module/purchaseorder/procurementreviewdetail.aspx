<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="procurementreviewdetail.aspx.cs" Inherits="module_purchaseorder_procurementreviewdetail" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section class="panel">
        <header class="panel-heading">
          <span>Review Detail</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R50000030E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
        
                    <cc1:XUILabel ID="lblBarcode" runat="server"  DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String" BindType="UIToDBOnly" MaxLength="14"  style = "Display:none;"></cc1:XUILabel>
                  <%--  <cc1:XUILabel ID="lblIdDetail" runat="server" Visible="false" BindType="DBToUIOnly" DBColumnName="ID_DETAIL" SPParameterName="p_id_detail" DataType="Integer" style = "Display:none;" Text=0></cc1:XUILabel>--%>
                  
            
            <div class="row">
                 <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">IR No.</label> 
                                <div class="col-sm-6">
                                   <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="PR_CODE" SPParameterName="p_pr_code" DataType="String"  BindType="Both" Text="-"></cc1:XUILabel>
                                     <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="DBToUIOnly" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" style = "Display:none;" Text=0></cc1:XUILabel>
                                </div>
                            </div>                            
                  </div>
                    <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label> 
                                <div class="col-sm-6">
                                   <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="TRANS_FLAG_CODE"  DataType="String"  BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                  
                                </div>
                            </div>                            
                  </div>
                  
                     </div>
               <div class="row">
             <%-- <div class="col-sm-6">
                       <div class="form-group">
                           <label class="col-sm-4">Units</label>
                           <div class="col-sm-6">
                               <asp:UpdatePanel ID="updUn" runat="server">
                                   <ContentTemplate>
                                       <cc1:XUIDropDownList ID="ddlUnits" runat="server" CssClass="form-control" DBColumnName="UNITS_CODE" SPParameterName="p_units_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                   </ContentTemplate>
                        <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                     </Triggers>
                               </asp:UpdatePanel>
                           </div>
                       </div>                             
                   </div>--%>
                    <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Units</label> 
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpUnits" class="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    </div>
                                     <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtTrxCode" runat="server"  CssClass="form-control" DBColumnName="UNITS_CODE" SPParameterName="p_units_code" DataType="String" MaxLength="18" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDescription"  runat="server" DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"  Enabled="false" Width="200px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplier" Display="Dynamic"></asp:RequiredFieldValidator> --%>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks review</label> 
                                <div class="col-sm-6">
                                   <cc1:XUILabel ID="lblRemarksReview" runat="server" DBColumnName="REMARKS_REVIEW" SPParameterName="p_remarks_review" DataType="String"  BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                    
                                   
                                </div>
                            </div>                            
                        </div>
               </div>
            </div>
        </div>
    </section>
</asp:Content>
