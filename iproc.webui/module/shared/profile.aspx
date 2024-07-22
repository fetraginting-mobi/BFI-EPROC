<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="profile" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Profile Info</span>
        </header>
        </div>
        <div class="panel-body form-horizontal">
            <%--<cc1:XUILabel ID="lblID" runat="server" CssClass="form-control" DBColumnName="ID" SPParameterName="p_uid" DataType="Integer" BindType="Both" style="display:none" Text="0"></cc1:XUILabel>--%>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Code</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
           </div>
           <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Name</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblName" runat="server" DBColumnName="NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                    
                </div>
           </div>
           <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Status</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
           </div>
           <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Phone Number</label>
                        <div class="col-sm-4">
                            <cc1:XUILabel ID="lblPhoneNo" runat="server" DBColumnName="PHONE_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
           </div>
           <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Handphone Number</label>
                        <div class="col-sm-4">
                            <cc1:XUILabel ID="lblHandphoneNo" runat="server" DBColumnName="HANDPHONE_NO" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
          </div> 
          <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Email</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblEmail" runat="server" DBColumnName="EMAIL" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
          </div>
          <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Other Email</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblOfficeEmail" runat="server" DBColumnName="EMAIL2" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
          </div>  
          <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Last Login</label>
                        <div class="col-sm-9">
                            <cc1:XUILabel ID="lblLastLogin" runat="server" DBColumnName="LAST_LOGIN_DATE" DataType="String" BindType="DBToUIOnly" Format="dd/MM/yyyy"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>  
          </div>                            
    </section>
</asp:Content>