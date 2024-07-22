<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchaseticketheader.aspx.cs" Inherits="module_purchaseorder_purchaseticketheader" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
            <span>Purchase Ticket/Hotel Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R60000142E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                        <cc1:XUILinkButton RoleCode="R60000142O" ID="btnApprovalTiered" Visible ="false" runat="server" CssClass="btn btn-success"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                         <cc1:XUILinkButton ID="btnPost" RoleCode="R60000142O" runat="server" CssClass="btn btn-success" CausesValidation="true" ValidationGroup="Header"><i class="icon-envelope"></i>   Post</cc1:XUILinkButton>
                    <%--<cc1:XUILinkButton ID="btnApprove" RoleCode="R50000080" runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>--%>
                   <%-- <cc1:XUILinkButton ID="btnReject" RoleCode="R50000080O" runat="server" CssClass="btn btn-danger"  CausesValidation="false"><i class="icon-remove"></i>  Reject</cc1:XUILinkButton>--%>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                   
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Trx. Code</label>
                                <!--CODE BARCODE-->
                                <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="BARCODE" SPParameterName="p_code" MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                       <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DBColumnName="OBJECT_AMOUNT" DataType="Number" Text="0" style="display:none;" BindType="Both"></cc1:XUILabel>
                                <%--<cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None" style="display:none;"></cc1:XUILabel>--%>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" SPParameterName="p_barcode" DataType="String" BindType="Both" Text="--"></cc1:XUILabel>
                                     <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control"  DBColumnName="BARCODE" SPParameterName="p_barcode" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                     <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                                     <cc1:XUITextBox ID="txtUnits" runat="server" CssClass="form-control"  DBColumnName="UNITS" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                                      <cc1:XUITextBox ID="txtStatus" runat="server" CssClass="form-control"  DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly" style="display:none" ></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtDateSystem" runat="server" CssClass="form-control"  DBColumnName="STATUS" DataType="DateTime" BindType="None" style="display:none" ></cc1:XUITextBox>
                                </div>
                                 <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></cc1:XUILinkButton>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_CODE" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch *</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Date *</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtTrxDate" runat="server" CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="TRX_DATE" SPParameterName="p_trx_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvTrxDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTrxDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revTrxDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtTrxDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>                        
                    </div>
                  <div class="row">       
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Type</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlType" runat="server" CssClass="form-control" DBColumnName="TYPE_CODE" SPParameterName="p_type_code" DataType="String" BindType="Both" >
                                     <asp:ListItem Value="REQ">REQUEST</asp:ListItem>
                                     <asp:ListItem Value="RES">RESCHEDULE</asp:ListItem>
                                      <asp:ListItem Value="RET">REFUND/CANCEL</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>                             
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="4000" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvRemarks" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                             
                        </div>                          
                    </div>                   
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                     <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click"/>
                    <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
   <asp:Panel runat="server" ID="pnlItemList">
        <section class="panel">
            <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                <ul class="nav nav-tabs nav-justified">
                  <li class="active">
                      <a href="#ItemList" id="itemlist" onclick="javascript:fnSetTab('itemlist');" data-toggle="tab" >
                          Item List
                      </a>
                  </li>
                  <li>
                      <a href="#UploadDoc" id="uploaddoc" onclick="javascript:fnSetTab('uploaddoc');" data-toggle="tab" >
                          Upload Doc
                      </a>
                  </li>
                </ul>
            </header>
            <div class="panel-body"> 
                <div class="tab-content tasi-tab">
                    <div class="tab-pane active" id="ItemList">
            <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                     <cc1:XUILinkButton RoleCode="R50000010E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                      <cc1:XUILinkButton ID="btnAddAdDep" RoleCode="R50000010E" runat="server" CssClass="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000010E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                      <cc1:XUILinkButton RoleCode="R50000010E" ID="btnReject" runat="server" CssClass="btn btn-danger" OnClick="btnReject_Click"><i class="icon-remove"></i>  Reject</cc1:XUILinkButton>
                      <cc1:XUILinkButton RoleCode="R50000010E" ID="btnRefund" runat="server"  style="display:none" CssClass="btn btn-warning" OnClick="btnRefund_Click"><i class="icon-remove"  style="display:none"></i></cc1:XUILinkButton>
                      <cc1:XUILinkButton RoleCode="R50000010E" ID="btnConfirm" runat="server" CssClass="btn btn-primary" OnClick="btnConfirm_Click"><i class="icon-employe"></i>  Confirm</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                  <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search" ></i>  Search</asp:LinkButton>
                        </div>
                   </asp:Panel>
                </div>
            </div>   
        </div>                   
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="ID,CODE_BOOKING"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                         OnRowDataBound="gvwList_OnRowDataBound"
                        onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There is no data" Width="100%" >
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
                            <asp:BoundField DataField="CODE_BOOKING" HeaderText="Code Booking">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField> 
                            
                            <asp:BoundField DataField="EMP_NAME" HeaderText="Name">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REFF_TYPE" HeaderText="Reff Type">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                              <asp:BoundField DataField="PURPOSE_TICKET" HeaderText="Purpose">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField> 
                            <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="STATUS" HeaderText="Status">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>
                              <asp:TemplateField HeaderText="Refund Date" SortExpression="REFUND_DATE">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("REFUND_DATE", "{0:dd/MM/yyyy}") %>' ID="txtReceiveDate"  CssClass="form-control default-date-picker date-only number-only"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                               <asp:TemplateField HeaderText="">
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnViewDocument" runat="server" CausesValidation="false" Text="Select"/>
                                        </ItemTemplate>
                                </asp:TemplateField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                     <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                      <asp:AsyncPostBackTrigger ControlID="btnRefund" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        </div>
          <div class="tab-pane" id="UploadDoc">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton RoleCode="R50000050E" ID="btnAddDocument" runat="server" CssClass="btn btn-primary" OnClick="btnAddDocument_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="R50000050E" ID="btnSaveDocumentDetail" runat="server" CssClass="btn btn-primary" OnClick="btnSaveDocumentDetail_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton> 
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
                       <%-- <asp:UpdatePanel ID="updDetail" runat="server">
                            <ContentTemplate>--%>
                                <asp:GridView ID="gvwListDocReq" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, TRX_CODE, PATHS, FILE, ID"
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

