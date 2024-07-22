<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="financialrptgenrow.aspx.cs" Inherits="module_accounting_financialrptgenrow" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Financial Report Generate Row Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R37000004E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <cc1:XUILabel ID="lblRowID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="DBToUIOnly" Style="Display:none"></cc1:XUILabel>
                <cc1:XUITextBox ID="txtRow" runat="server" SPParameterName="p_report_code" DBColumnName="REPORT_CODE" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUITextBox>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Format No</label>
                        <%--<asp:RequiredFieldValidator ID="rfvRptNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRptNo" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                        <div class="col-sm-6">
                           <%-- <cc1:XUILabel ID="lblID" runat="server" DBColumnName="NO" SPParameterName="p_no" DataType="String" BindType="Both" style="display:none"></cc1:XUILabel>--%>
                            <%--<asp:LinkButton ID="btnLookUpFeeCode" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>--%>
                            <cc1:XUITextBox ID="txtRptNo" runat="server" MaxLength="10" Cssclass="form-control" SPParameterName="p_row_no" DBColumnName="ROW_NO" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <%--<cc1:XUILabel ID="lblDescription" runat="server" DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>--%>
                        </div>
                    </div>                             
                </div>  
                <div class="col-sm-6">
                     <div class="form-group">
                        <label class="col-sm-4">Row Status</label>
                        <div class="col-sm-6">
                           <cc1:XUIDropDownList ID="ddlRow" runat="server" CssClass="form-control" DBColumnName="FMT_1" SPParameterName="p_fmt_1" DataType="String" BindType="Both">
                                <asp:ListItem Value=" "> </asp:ListItem>
                                <asp:ListItem Value="A+">A+ (Add)</asp:ListItem>
                                <asp:ListItem Value="S-">S- (Substract)</asp:ListItem>
                                <asp:ListItem Value="PG">PG (Start new page)</asp:ListItem>
                                <asp:ListItem Value="T1">T1 (1st Total)</asp:ListItem>
                                <asp:ListItem Value="T2">T2 (2nd Total)</asp:ListItem>
                                <asp:ListItem Value="T3">T3 (3rd Total)</asp:ListItem>
                                <asp:ListItem Value="T4">T4 (4th Total)</asp:ListItem>
                                <asp:ListItem Value="T5">T5 (5th Total)</asp:ListItem>
                                <asp:ListItem Value="T6">T6 (6th Total)</asp:ListItem>
                                <asp:ListItem Value="T7">T7 (7th Total)</asp:ListItem>
                                <asp:ListItem Value="T8">T8 (8th Total)</asp:ListItem>
                                <asp:ListItem Value="/-">/- (Print single line)</asp:ListItem>
                                <asp:ListItem Value="/=">/= (Print double line)</asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>                        
                </div> 
            </div>   
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                       <label class="col-sm-4">Sign</label>
                      <%-- <asp:RequiredFieldValidator ID="rfvBasePct" runat="server" ErrorMessage="Required Field!" ControlToValidate="rblBasePct" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                       <div class="col-sm-6">
                        <cc1:XUIDropDownList ID="ddlSign" runat="server" CssClass="form-control" DBColumnName="FMT_2" SPParameterName="p_fmt_2" DataType="String" BindType="Both">
                                <asp:ListItem Value=" "> </asp:ListItem>
                                <asp:ListItem Value="+">+ (Retain sign conversion)</asp:ListItem>
                                <asp:ListItem Value="-">- (Reverse sign conversion)</asp:ListItem>
                        </cc1:XUIDropDownList>
                       </div>
                    </div>                          
                </div>  
                <div class="col-sm-6">
                    <div class="form-group">
                         <label class="col-sm-4">Total</label>
                         <div class="col-sm-6">
                           <cc1:XUIDropDownList ID="ddlTotal" runat="server" CssClass="form-control" DBColumnName="FMT_3" SPParameterName="p_fmt_3" DataType="String" BindType="Both">
                                <asp:ListItem Value=" "> </asp:ListItem>
                                <asp:ListItem Value="T2">T2 (2nd Total)</asp:ListItem>
                                <asp:ListItem Value="T3">T3 (3rd Total)</asp:ListItem>
                                <asp:ListItem Value="T4">T4 (4th Total)</asp:ListItem>
                                <asp:ListItem Value="T5">T5 (5th Total)</asp:ListItem>
                                <asp:ListItem Value="T6">T6 (6th Total)</asp:ListItem>
                                <asp:ListItem Value="T7">T7 (7th Total)</asp:ListItem>
                                <asp:ListItem Value="T8">T8 (8th Total)</asp:ListItem>
                        </cc1:XUIDropDownList>
                         </div>
                    </div>                               
                </div> 
            </div>
                <div class="row">
               <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Relation Code </label>
                        <%--<asp:RequiredFieldValidator ID="rfvRelationCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRelationCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                        <div class="col-sm-4">
                            <cc1:XUILabel ID="lblRelationCode" runat="server" DBColumnName="ACC_CODE" DataType="String" BindType="DBToUIOnly" Style="Display:none"></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtRelationCode" runat="server" CssClass="form-control" DBColumnName="ACC_CODE" SPParameterName="p_acc_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                        </div>
                        <div class="col-sm-4">   
                            <asp:LinkButton ID="btnLookUpDefaultRC" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                      
                      </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Description</label>
                        <%--<asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                        <div class="col-sm-6">
                           <%-- <asp:LinkButton ID="btnLookUpDefaultCOA" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>--%>
                            <%--<asp:RequiredFieldValidator ID="rfvDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            <cc1:XUILabel ID="lblDesc" runat="server" DBColumnName="FMT_DESC" DataType="String" BindType="DBToUIOnly" Style="display:none"></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" DBColumnName="FMT_DESC" SPParameterName="p_fmt_desc" MaxLength="60" DataType="String" BindType="Both"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div> 
             </div> 
                <div class="row">
                 <div class="col-sm-6">
                    <div class="form-group">
                       <label class="col-sm-4">Page</label>
                       <%--<asp:RequiredFieldValidator ID="rfvPage" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPage" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                       <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtPage" MaxLength="3" runat="server" CssClass="form-control" DBColumnName="PAGE" SPParameterName="p_page" Type="Integer" BindType="Both" Format="N2"></cc1:XUITextBox>
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


