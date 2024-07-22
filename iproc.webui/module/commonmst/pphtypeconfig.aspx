<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="pphtypeconfig.aspx.cs" Inherits="module_commonmst_pphtypeconfig" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section class="panel">
        <header class="panel-heading">
          <span>PPH Type Config</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000140E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>

                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PPH Type</label>
                                <div class="col-sm-7">
                                      <cc1:XUIDropDownList ID="ddlUpdateFor" runat="server" CssClass="form-control" placeholder="Creditor Type" DBColumnName="PPH_TYPE" AutoPostBack="true" OnSelectedIndexChanged="ddlUpdateFor_OnSelectedIndex"  SPParameterName="p_pph_type" DataType="String" BindType="Both" >
                                       <asp:ListItem Value="PRORATE">Prorate</asp:ListItem>
                                       <asp:ListItem Value="NONE">None</asp:ListItem>
                                       <asp:ListItem Value="FULL">Full</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvUpdateFor" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUpdateFor"  InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                    </div> 
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Use For</label>
                                <div class="col-sm-7">
                                 <cc1:XUIDropDownList ID="ddlUseFor" runat="server" CssClass="form-control" placeholder="Creditor Type" DBColumnName="FLAG_RENT" SPParameterName="p_flag_rent" DataType="String" BindType="Both" >   
                                       <asp:ListItem Value="1">Item Sewa</asp:ListItem>
                                       <asp:ListItem Value="2">Item Non Sewa</asp:ListItem>
                                       <asp:ListItem Value="0">Semua Item</asp:ListItem>
                                     </cc1:XUIDropDownList>
                                   
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
