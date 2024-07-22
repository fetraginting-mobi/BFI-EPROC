<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="peralatankerja.aspx.cs" Inherits="module_fa_peralatankerja" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Peralatan Kerja Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R50000020E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="col-sm-4">Asset Code</label> 
                                <div class="col-sm-2">
                                    <%--<cc1:XUITextBox ID="txtItemCode" runat="server" CssClass="form-control" BindType="Both" DataType="String" DBColumnName="ITEM_CODE" SPParameterName="p_item_code"></cc1:XUITextBox>--%>
                                    <asp:LinkButton runat="server" ID="btnLookUpItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtItemName" Enabled="false"  runat="server" DBColumnName="ITEM_NAME" SPParameterName="" DataType="String" BindType="UIToDBOnly" TextMode="MultiLine"  style="border:0; background:inherit;display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtBranchCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="" DataType="String" BindType="UIToDBOnly"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtStaffCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="staff_code" SPParameterName="" DataType="String" BindType="UIToDBOnly"></cc1:XUITextBox>
                                    <%--<cc1:XUITextBox ID="txtRequestno" style="display:none" runat="server" CssClass="form-control" BindType="None"></cc1:XUITextBox>--%>
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-sm-2">
                                    <cc1:XUILabel ID="lblItemCode" runat="server" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-8">

                                </div>
                            </div>                             
                        </div>  
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="col-sm-4">Asset Name</label>
                                <div class="col-sm-8">
                                   <%-- <cc1:XUILabel ID="lblItemName" runat="server" DBColumnName="ITEM_NAME" SPParameterName="" DataType="String" BindType="Both"></cc1:XUILabel>--%>
                                    <cc1:XUITextBox ID="lblItemName" runat="server" DBColumnName="ITEM_NAME" SPParameterName="p_item_name" DataType="String" BindType="Both" TextMode="MultiLine"  style="border:0; background:inherit;"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>                
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-8">

                                </div>
                            </div>                             
                        </div>  
                    </div>
                   <%-- <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="col-sm-4">Qty</label>
                                <div class="col-sm-6">
                                     <cc1:XUITextBox ID="txtQty" runat="server" CssClass="form-control" Width="50" BindType="Both" DataType="Integer" DBColumnName="QTY" SPParameterName="p_qty"></cc1:XUITextBox>
                                </div>
                            </div>
                         </div>
                    </div> --%>              
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
