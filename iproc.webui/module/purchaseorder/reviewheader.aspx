<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="reviewheader.aspx.cs" Inherits="module_purchaseorder_reviewheader" %>


<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
<section class="panel">
        <header class="panel-heading">
          <span>Procurement Review</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                    <%--<cc1:XUILinkButton RoleCode="R06000001O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>--%>
                 <cc1:XUILinkButton ID="btnPost" RoleCode="R50000055O" runat="server" CssClass="btn btn-success"  OnClick="btnPost_Click"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                  <%--  <cc1:XUILinkButton ID="btnUnPost" RoleCode="R50000020O" runat="server" CssClass="btn btn-danger" OnClick="btnSave_Click"><i class="icon-envelope"></i>  Un-Post</cc1:XUILinkButton>--%>
                      <cc1:XUILinkButton ID="btnSave" RoleCode="R50000055E" runat="server" OnClick="btnSave_Click" CssClass="btn btn-primary"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                  <cc1:XUILabel ID="lblid" runat="server" DBColumnName="ID" DataType="Integer"  BindType="DBToUIOnly" style="display:none;" ></cc1:XUILabel>
                  <div class="row">
                  <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">IR No.</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblIrNo" runat="server" DBColumnName="PR_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                                </div>
                            </div>                            
                        </div>
                       <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="TRANS_FLAG_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                                </div>
                            </div>                            
                        </div>       
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                                <div class="form-group">
                                </div>
                         </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Request Review Date</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblRequestDate" runat="server" DBColumnName="REQUEST_REVIEW_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy" Text="--"></cc1:XUILabel>                        
                                </div>
                            </div>                            
                        </div> 
                    </div>    
                    <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item *</label>
                                <div class="col-sm-8">                       
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code"  DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>        
                                </div>
                            </div>                            
                        </div>     
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-8">                       
                                    <cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="Branch_name" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>        
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Spesification</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="txtSpesification" runat="server"  DBColumnName="SPECIFICATION" SPParameterName="p_specification"  DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                    </div>
                                </div>                             
                            </div> 
                          <div class="col-sm-6">
                            <div class="form-group">
                                    <label class="col-sm-4">Quantity Inventory</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblQuantityInventory" runat="server"   DBColumnName="QTY_INVENTORY" SPParameterName="p_qty_inventory"  DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                    </div>
                                </div>           
                        </div> 
                      </div>
                      <div class="row">
                       <div class="col-sm-6">
                           <div class="form-group">
                                    <label class="col-sm-4">Quantity Purchase</label>
                                    <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblQuantityPurchase" runat="server"   DBColumnName="QTY_PURCHASE" SPParameterName="p_qty_purchase"  DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                    </div>
                              </div>   
                        </div> 
                        <div class="col-sm-6" id="unit" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">UOM</label>
                                <div class="col-sm-8">
                                        <cc1:XUILabel ID="lblUOM" runat="server"   DBColumnName="UOM" SPParameterName="p_unit_code" DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                    </div>
                            </div>                               
                        </div>
                      </div>
                       <div class="row">
                         <div class="col-sm-6" id="Div1" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">Type</label>
                               <div class="col-sm-8">
                                     <cc1:XUILabel ID="lblType" runat="server"   DBColumnName="TYPE" DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                </div>
                            </div>                               
                        </div>
                         <div class="col-sm-6" id="Div2" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">Switch Department</label>
                                    <div class="col-sm-8">
                                     <cc1:XUILabel ID="lblSwitch" runat="server"   DBColumnName="PURPOSE_DEPARTMENT" SPParameterName="p_purpose_Department" DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                </div>
                             </div>
                           </div>
                         </div> 
                       <div class="row">
                         <div class="col-sm-6" id="Div3" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">Purchase By</label>
                                  <div class="col-sm-8">
                                     <cc1:XUILabel ID="lblPurchaseBy" runat="server"   DBColumnName="BRANCH" SPParameterName="p_branch" DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                </div>
                             </div>
                           </div>
                           <div class="col-sm-6" id="Div4" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">Requestor</label>
                                  <div class="col-sm-8">
                                     <cc1:XUILabel ID="lblRequestor" runat="server"   DBColumnName="emp_name" DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>
                                </div>
                             </div>
                           </div>
                         </div>
                    <div class="row">
                        <%--code barcode--%>
                      
                        <%--requestor--%>
                       <%-- <cc1:XUILabel ID="lblRequestorUID" runat="server" DBColumnName="REQUESTOR" SPParameterName="p_requestor" DataType="String" BindType="Both" style="display:none;"></cc1:XUILabel>
                        --%>
                      
                      
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Units</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblUnits" runat="server" DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
                                </div>
                            </div>                            
                        </div>
                      </div>
                           <div class="row">
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks Review</label>
                                <div class="col-sm-8"> 
                                    <cc1:XUITextBox ID="txtRemarksReview" runat="server"  CssClass="form-control" DBColumnName="REMARKS_REVIEW" SPParameterName="p_remarks_review" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>           
                    </div>
                  
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "ENTRY_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                           <div class="form-group">
                                <label class="col-sm-4">Modified</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "EMP_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName= "MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                                 </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers> 
                   
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

