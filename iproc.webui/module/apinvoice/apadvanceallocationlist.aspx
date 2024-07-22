<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="apadvanceallocationlist.aspx.cs" Inherits="module_apinvoice_apadvanceallocationlist" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Advance List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                       <!--ID-->
                       <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                       <!--Barcode-->
                       <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="ADVANCE_CODE" SPParameterName="p_advance_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
                       <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-3">Description</label>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="*" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    <div class="col-sm-8">
                                        <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="200" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
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

