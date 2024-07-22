<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="cancellationticketheader.aspx.cs" Inherits="module_purchaseorder_cancellationticketheader" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
            <span>Cancellation Ticket Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R50000080E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnApprove" RoleCode="R50000080" runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>  Approve</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnReject" RoleCode="R50000080O" runat="server" CssClass="btn btn-danger"  CausesValidation="false"><i class="icon-remove"></i>  Reject</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                   
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
                                <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="BARCODE" SPParameterName="p_barcode" MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUILabel>
                                <%--<cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None" style="display:none;"></cc1:XUILabel>--%>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" SPParameterName="p_code" DataType="String" BindType="Both" Text="--"></cc1:XUILabel>
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
                        <%--  <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Requestor *</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpRequestor"  class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtRequestorCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="REQUESTOR_CODE" SPParameterName="p_requestor_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblRequestorName" runat="server"  DBColumnName="REQUESTOR_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvRequestorName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRequestorCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div> --%> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="4000" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>                          
                    </div>                   
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnApprove" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    
    <section class="panel">
        <header class="panel-heading">
          <span>Detail List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                     <cc1:XUILinkButton RoleCode="R50000010E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000010E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
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
                        AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
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
                            <asp:BoundField DataField="REFF_NO" HeaderText="Reff No.">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField> 
                            <asp:BoundField DataField="MASKAPAI" HeaderText="Name Makapai / Hotel">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="EMP_NAME" HeaderText="Name">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REFF_TYPE" HeaderText="Reff Type">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>



