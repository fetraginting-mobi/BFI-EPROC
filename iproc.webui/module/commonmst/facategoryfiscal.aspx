<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="facategoryfiscal.aspx.cs" Inherits="module_commonmst_facategory" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>FA Depre. Category Fiscal Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R90000030E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>

                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>        
             <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both"  Text= "0" style =  "Display:none;"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Code *</label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtCategoryCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="CAT_CODE" SPParameterName="p_cat_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCategoryCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCategoryCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>   
                    <div class="row">               
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Name *</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder="Name" DBColumnName="CAT_NAME" SPParameterName="p_cat_name" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCategoryName" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>    
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Method</label>
                                    <div class="col-sm-5">
                                    <cc1:XUIRadioButtonList ID="rblMethode" runat="server"  DBColumnName="METHODE" SPParameterName="p_methode" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" >
                                        <asp:ListItem Value="SL" Selected="True">Straight Line&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="RB">Reducing Balance</asp:ListItem>
                                    </cc1:XUIRadioButtonList> 
                                    </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Usefull / Life Span (Year) *</label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtUsefull" runat="server" CssClass="form-control" placeholder="Usefull(Year)" DBColumnName="USEFULL" SPParameterName="p_usefull" DataType="Integer" BindType="Both" MaxLength="2" Format="N2"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvtxtUsefull" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUsefull" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtUsefull" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>   
                    </div> 
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Rate / Year (%)</label>
                                    <%--<asp:RequiredFieldValidator ID="rfvtxtRate" runat="server" ErrorMessage="*" ControlToValidate="txtRate" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <%--<asp:RangeValidator ID="ravRate" runat="server" ErrorMessage="0 - 100" ControlToValidate="txtRate" Display="Dynamic" MinimumValue="0" MaximumValue="100" Type="Double"></asp:RangeValidator>--%>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtRate" runat="server" CssClass="form-control" placeholder="Rate(%)" DBColumnName="RATE" SPParameterName="p_rate" DataType="Number" BindType="Both" MaxLength="3" Format="N2" Enabled="false"></cc1:XUITextBox>
                                    <asp:RangeValidator ID="ravRate" runat="server" ErrorMessage="Value must be between 0 - 100" ControlToValidate="txtRate" Display="Dynamic" MinimumValue="0" MaximumValue="100" Type="Double"></asp:RangeValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row" style="display:none">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Rounding</label>
                                <div class="col-sm-1">
                                    <cc1:XUITextBox ID="txtRND" runat="server" CssClass="form-control" placeholder="Rounding" DBColumnName="RND" SPParameterName="p_rnd" DataType="Number" BindType="Both" MaxLength="18" Format="N2"></cc1:XUITextBox>
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
    </section>
</asp:Content>
