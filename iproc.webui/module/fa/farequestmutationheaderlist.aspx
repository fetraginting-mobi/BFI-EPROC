<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="farequestmutationheaderlist.aspx.cs" Inherits="module_fa_farequestmutationheaderlist" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>FA Mutation List</span>
          <style type="text/css">
            .disabled {
                cursor: not-allowed;
            }
          </style>
          <script type="text/javascript">
            function toggleUploadButton() {
                var fileInput = document.getElementById('<%= FileUploadControlMutation.ClientID %>');
                var uploadBtn = document.getElementById('<%= btnUploadRowFormat.ClientID %>');

                if (!fileInput || !uploadBtn)
                    return;

                if (fileInput.value === "") {
                    uploadBtn.disabled = true;
                    if (uploadBtn.className.indexOf("disabled") === -1)
                        uploadBtn.className += " disabled";
                } else {
                    uploadBtn.disabled = false;
                    uploadBtn.className = uploadBtn.className.replace(" disabled", "");
                }
            }

            window.onload = function () {
                toggleUploadButton();
            };
        </script>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R90000080C" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus" ></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R90000080D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">  
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">     
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
                  <span>Upload Excel : </span>
                  <asp:FileUpload ID="FileUploadControlMutation" runat="server" onchange="toggleUploadButton()"/>
                  <cc1:XUIButton ID="btnUploadRowFormat" RoleCode="R60000110O" runat="server" CssClass="btn btn-primary disabled" Text="Upload" Enabled="false" Style=" width:auto; margin-top:10px;" OnClick="btnUploadRowFormat_Click" />      
                  <cc1:XUIButton ID="btnDownload" RoleCode="R60000110O" Style="width: auto; margin-top:10px;" runat="server" Text="Download Template" CssClass="btn btn-primary" OnClick="btnDownload_Click" />
                  <%--<cc1:XUILinkButton ID="btnPost" RoleCode="R60000110O" runat="server" CssClass="btn btn-success disabled" Enabled="false" Style="width:auto; margin-top:10px;" OnClick="btnPost_Click"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>--%>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Status</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlStatus" Width="200px" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                             <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                             <asp:ListItem Text="NEW" Value="NEW"></asp:ListItem>
                             <asp:ListItem Text="POST" Value="POST"></asp:ListItem>
                             <asp:ListItem Text="PENDING" Value="PENDING"></asp:ListItem>
                              <asp:ListItem Text="RETURNED" Value="RETURNED"></asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>    
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Cost Center</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="CODE_BARCODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                     <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                     <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CODE" HeaderText="FA Mutation Request No.">
                                <ItemStyle Width="15%" HorizontalAlign="Center"  />
                            </asp:BoundField>
                             <asp:BoundField DataField="CODE_BARCODE" HeaderText="Reff No.">
                                <ItemStyle Width="15%" HorizontalAlign="Center"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQUEST_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Center"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_NAME" HeaderText="From Cost Center">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_NAME_TO" HeaderText="To Cost Center">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="DIVISION_NAME" HeaderText="Division">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="DEPARTMENT_NAME" HeaderText="Department">
                                <ItemStyle Width="10%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="EMP_NAME" HeaderText="Requestor">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                <ItemStyle Width="5%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>



