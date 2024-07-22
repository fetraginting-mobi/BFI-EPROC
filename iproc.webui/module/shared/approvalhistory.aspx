<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="approvalhistory.aspx.cs" Inherits="module_shared_approvalhistory" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
<%--<div class="col-sm-6" style="line-height:2.2">
    <section class="panel form-horizontal">                
      <asp:Panel ID="Panel3" runat="server">--%>
        <div class="panel-body">
            <header class="panel-heading">
              <span>My Approval History</span>
            </header>
        </div>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                   
                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"     class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
         <div class="panel-body">
              <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Modul</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlModul" Width="200px" runat="server" CssClass="form-control" SPParameterName="p_modul" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlModul_SelectedIndexChanged"></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div> 
             <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Branch</label>
                        <div class="col-sm-6">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
              </div>
             </div> 
             <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwList_PageIndexChanging" DataKeyNames="ID,OBJECT_ID,APPROVAL_CODE,TYPE"
                        onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There Is No Data">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="Branch">
                                <ItemStyle Width="5%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH" HeaderText="Branch">
                                <ItemStyle Width="15%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description">
                                <ItemStyle Width="50%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="READ_DATE" HeaderText="Approval Date" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField> 
                            <asp:BoundField DataField="LAST_STATUS" HeaderText="Status">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />       
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        
    </section>
</asp:Content>