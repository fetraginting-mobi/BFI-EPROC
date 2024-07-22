<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastersuppliergroup.aspx.cs" Inherits="module_commonmst_mastersuppliergroup" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Group Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000150E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"  CausesValidation="true" ><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
                    <cc1:XUITextBox ID="txtSupplierCode" runat="server" CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" MaxLength="20" DataType="String" BindType="Both" Style="display:none" ></cc1:XUITextBox>
                   <cc1:XUILabel ID="lblId" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-1">Item Type*</label>
                                <div class="col-sm-4">
                                    <cc1:XUIDropDownList ID="ddlJenisItem" runat="server" CssClass="form-control" DBColumnName="JENIS_ITEM" SPParameterName="p_jenis_item" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlJenisItem_OnSelectedIndex" DataType="String">
                                    </cc1:XUIDropDownList>
                                      <asp:RequiredFieldValidator ID="rfvJenisItem" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlJenisItem" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-1">Group*</label>                                
                                <div class="col-sm-4">                                    
                                    <cc1:XUIDropDownList ID="ddlItemGroup" runat="server" CssClass="form-control" DBColumnName="GROUP_CODE" SPParameterName="p_group_code" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvItemGroup" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlItemGroup" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                                 <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewStock" runat="server" CausesValidation="false" Text="View Item List"></cc1:XUILinkButton>
                                 </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-1">Description*</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both" MaxLength="200" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,200}$" ErrorMessage="Exceed maximum length 200" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvRemarks" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                                
                            </div>                            
                        </div>
                    </div>
                  
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <%--<asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

