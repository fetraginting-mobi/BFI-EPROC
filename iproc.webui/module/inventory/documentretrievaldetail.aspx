<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="documentretrievaldetail.aspx.cs" Inherits="module_inventory_documentretrievaldetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
 <%--   <script  type="text/javascript">
        function jsDoAfterLookUp()
        {
            __doPostBack('ctl00$cpb$btnRefresh','');
        }
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                   <cc1:XUILinkButton RoleCode="R60000144E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate> 
                    <!--ID-->
                        <cc1:XUILabel ID="lblId" runat="server" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0" style="display:none;"></cc1:XUILabel>
                    <!--Barcode-->
                        <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_ii_code" BindType="UIToDBOnly"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Document Retrivel No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblIICode" runat="server" DBColumnName="RETRIEVAL_CODE"  DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                  
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item *</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookInventoryIssueItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>        
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemCode" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                          <div class="col-sm-6" ID="RL" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4" >Receive Location </label>
                                <div class="col-sm-7">
                  <%--                  <asp:LinkButton runat="server" ID="btnReceiveLocation" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtReceiveLocation" runat="server" style="display:none"  CssClass="form-control" DBColumnName="RECEIVE_LOCATION" SPParameterName="p_receive_location" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblReceiveLocation" runat="server"  DBColumnName="FROM_LOCATION_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  --%>
                                    <cc1:XUIDropDownList ID="ddlReceiveLocation" runat="server" CssClass="form-control" placeholder="" DBColumnName="RECEIVE_LOCATION" SPParameterName="p_receive_location"  MaxLength="10" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>     
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>              
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtItemDescription" runat="server"  CssClass="form-control" placeholder="Description" DBColumnName="ITEM_DESCRIPTION" SPParameterName="p_item_description" DataType="String"  BindType="Both" TextMode="MultiLine" MaxLength="100" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvItemDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemDescription" Display="Dynamic"></asp:RequiredFieldValidator> 
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
