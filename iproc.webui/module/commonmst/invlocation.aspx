<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="invlocation.aspx.cs" Inherits="module_commonmst_invlocation" Title="Untitled Page" %>


<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Inventory Location Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
             <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both"  Text= "0" style = "Display:none;"></cc1:XUILabel>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">Code</label>
                                    <asp:RequiredFieldValidator ID="rfvtxtCode" runat="server" ErrorMessage="*" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5 ">
                                    <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="PROJECT_NO" SPParameterName="p_project_no" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                          </div>   
                      </div>
                      <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">Location Code</label>
                                    <asp:RequiredFieldValidator ID="rfvLocationCode" runat="server" ErrorMessage="*" ControlToValidate="txtLocationCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtLocationCode" runat="server" CssClass="form-control" placeholder="Location Code" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code" DataType="String" BindType="Both" MaxLength="10"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>   
                      </div>    
                      <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">Location Name</label>
                                    <asp:RequiredFieldValidator ID="rfvtxtLocationName" runat="server" ErrorMessage="*" ControlToValidate="txtLocationName" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtLocationName" runat="server" CssClass="form-control" placeholder="Location Name" DBColumnName="LOCATION_NAME" SPParameterName="p_location_name" DataType="String" BindType="Both" MaxLength="50"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>   
                      </div> 
                      <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">Address</label>
                                    <asp:RequiredFieldValidator ID="rfvtxtAddress" runat="server" ErrorMessage="*" ControlToValidate="txtAddress" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" DBColumnName="ADDRESS" SPParameterName="p_address" DataType="String" BindType="Both" MaxLength="200"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>   
                     </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 ">Phone Number</label>
                                    <asp:RequiredFieldValidator ID="rfvtxtPhone" runat="server" ErrorMessage="*" ControlToValidate="txtPhone" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone Number" DBColumnName="PHONE" SPParameterName="p_phone" DataType="String" BindType="Both" MaxLength="30"></cc1:XUITextBox>
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

