<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="mastertaxscheme.aspx.cs" Inherits="module_commonmst_mastertaxscheme" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Tax Scheme Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000170E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                 <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2 ">Code *</label>
                            <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtTaxCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvTaxCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTaxCode" Display="Dynamic"></asp:RequiredFieldValidator>
                               <asp:RegularExpressionValidator ID="revTaxCode" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txttaxCode" ValidationExpression="^[a-zA-Z0-9]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                      </div>   
                   </div>
                 <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Description *</label>
                            <div class="col-sm-5">
                                <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>   
                 </div> 
                 <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">PPN (%)*</label>     
                            <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtPPNPCT" runat="server" CssClass="form-control" placeholder="Percent Tax" DBColumnName="PPN_PCT" SPParameterName="p_ppn_pct" MaxLength="9" DataType="Number" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvPPNPCT" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPPNPCT" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPPNPCT" runat="server" ErrorMessage="Must Be Numeric !!" ControlToValidate="txtPPNPCT" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator> 
                                <asp:RangeValidator ID="ravDPPct" runat="server" ErrorMessage="example :(0 - 100)" ControlToValidate="txtPPNPCT" Display="Dynamic" MinimumValue="0" MaximumValue="100" Type="Double"></asp:RangeValidator>   
                            </div>
                        </div>                            
                    </div>   
                 </div>
                 <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">PPH (%)*</label>                
                            <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtPPHPCT" runat="server" CssClass="form-control" placeholder="Percent Tax" DBColumnName="PPH_PCT" SPParameterName="p_pph_pct" MaxLength="10" DataType="Number" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvPPHPCT" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPPHPCT" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPPHPCT" runat="server" ErrorMessage="Must Be Numeric !!" ControlToValidate="txtPPHPCT" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator> 
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="example :(0 - 100)" ControlToValidate="txtPPHPCT" Display="Dynamic" MinimumValue="0" MaximumValue="100" Type="Double"></asp:RangeValidator>
                            </div>
                        </div>                            
                    </div>   
                 </div>
                 <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">PPN COA </label>
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookUpPPNCOA"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtPPNCOA" runat="server" style="display:none" CssClass="form-control" placeholder="PPN COA" DBColumnName="PPN_COA" SPParameterName="p_ppn_coa" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblPPNCOA"  runat="server"  style="display:none" DBColumnName="NO_PPN_COA" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblNamePPNCOA"  runat="server"  DBColumnName="NAME_PPN_COA" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                              <%--  <asp:RequiredFieldValidator ID="rfvPPNCOA" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPPNCOA" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>   
                 </div>     
                 <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">PPH COA </label>
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookUpPPHCOA"  class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtPPHCOA" runat="server" style="display:none" CssClass="form-control" placeholder="PPH COA" DBColumnName="PPH_COA" SPParameterName="p_pph_coa" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblPPHCOA"  runat="server"  style="display:none" DBColumnName="NO_PPH_COA" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblNamePPHCOA"  runat="server"  DBColumnName="NAME_PPH_COA" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                              <%--  <asp:RequiredFieldValidator ID="rfvPPHCOA" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPPHCOA" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                            
                        </div>                            
                    </div>  
                 </div> 
                  <div class="row">
                     <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Active</label>
                                <div class="col-sm-7">
                                    <cc1:XUICheckBox ID="cbxIsActiveDivision" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" runat="server" Checked="true" />
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
