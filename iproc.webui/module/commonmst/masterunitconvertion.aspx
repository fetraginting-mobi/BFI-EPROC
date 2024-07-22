<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterunitconvertion.aspx.cs" Inherits="module_commonmst_masterunitconvertion" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Unit Conversion Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000080E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>

                </div>
            </div>
        </div>
       <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-5">
                                <cc1:XUILabel ID="lblId" runat="server"  CssClass="form-control" placeholder="Id" DBColumnName="ID" SPParameterName="p_id" MaxLength="5" DataType="Integer" BindType="Both" Visible="false" Text="0"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">From UOM *</label>
                            <div class="col-sm-5">
                                <%--<cc1:XUITextBox ID="txtFromUnit" runat="server" CssClass="form-control" placeholder="From Unit" DBColumnName="FROM_UNIT" SPParameterName="p_from_unit" MaxLength="10" DataType="String" BindType="Both" ></cc1:XUITextBox>--%>
                                <asp:LinkButton runat="server" ID="btnLookUpFromUnit" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtFromUnitCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="FROM_UNIT" SPParameterName="p_from_unit" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblFromUnitCode" runat="server"  DBColumnName="FROM_UNIT" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblFromUnitName" runat="server"  DBColumnName="FROM_UNIT_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                
                                <asp:RequiredFieldValidator ID="rfvFromUnit" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFromUnitCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">From Qty *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtFromUnitQty" runat="server" CssClass="form-control" placeholder="From Unit Qty" DBColumnName="FROM_UNIT_QTY" SPParameterName="p_from_unit_qty" DataType="Number" MaxLength="15" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvFromUnitQty" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFromUnitQty" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revFromUnitQty" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtFromUnitQty" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">To UOM *</label>
                            <div class="col-sm-5">
                                <%--<cc1:XUITextBox ID="txtToUnit" runat="server" CssClass="form-control" placeholder="To Unit" DBColumnName="TO_UNIT" SPParameterName="p_to_unit" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>--%>
                                <asp:LinkButton runat="server" ID="btnLookUpToUnit" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtToUnitCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="TO_UNIT" SPParameterName="p_to_unit" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblToUnitCode" runat="server"  DBColumnName="TO_UNIT" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblToUnitName" runat="server"  DBColumnName="TO_UNIT_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                
                                <asp:RequiredFieldValidator ID="rfvToUnit" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToUnitCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">To Qty *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtToUnitQty" runat="server" CssClass="form-control" placeholder="To Unit " DBColumnName="TO_UNIT_QTY" SPParameterName="p_to_unit_qty" DataType="Number" MaxLength="15" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvToUnitQty" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToUnitQty" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revToUnitQty" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtToUnitQty" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic" ></asp:RegularExpressionValidator> 
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
