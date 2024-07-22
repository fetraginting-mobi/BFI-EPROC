<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="confirmationlist.aspx.cs" Inherits="module_purchaseorder_confirmationlist" Title="Untitled Page" %>

<%--<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
            <span>Confirmation List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
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
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Branch</label>
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
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There Is No Data">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CODE" HeaderText="PO No.">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ORDER_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>                        
                            <asp:BoundField DataField="SUPPLIER_NAME" HeaderText="Supplier">
                                <ItemStyle Width="40%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PROCESS" HeaderText="Process">
                                <ItemStyle Width="30%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
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
</asp:Content>--%>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
<%--<script type="text/javascript">
    $('.default-date-picker').datepicker({
            ignoreReadonly: true,
            startDate:'now',
            maxDate: 'now',
            clearBtn: true,
            format: 'dd/mm/yyyy',
            daysOfWeekDisabled: "0,6",
            todayHighlight: true,
            orientation: "top auto"
        }).on('changeDate', function(e) {
            $(this).datepicker('hide');
        });

      function datepicker() {
          $('.default-date-picker').datepicker({
              ignoreReadonly: true,
              startDate: 'now',
              maxDate: 'now',
              format: "dd/mm/yyyy",
              clearBtn: true,
              orientation: "top auto",
              forceParse:false
          }).on('changeDate', function(e) {
              $(this).datepicker('hide');
          });
      }
</script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Purchase Confirm List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-6">
                    <cc1:XUILinkButton RoleCode="R50000070E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                </div>
                <div class="col-sm-6">
                    <div class="col-sm-8">
                      <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" ></asp:TextBox>  
                            <div class="input-group-btn">
                                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search" ></i>  Search</asp:LinkButton>
                            </div>
                       </asp:Panel>
                   </div>
                </div>
            </div>   
        </div>                   
        <div class="panel-body " >
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        EmptyDataText="There is no data" Width="100%" >
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
                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click(this)" />
                                </ItemTemplate>
                            </asp:TemplateField>  
                            <asp:BoundField DataField="ITEM_CODE" HeaderText="Procurment Request No." SortExpression="ITEM_CODE">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="ITEM_GROUP_NAME" HeaderText="Item Group Name" SortExpression="ITEM_GROUP_NAME">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>                                 
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name" SortExpression="ITEM_NAME">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField> 
                            <asp:BoundField DataField="QUANTITY" HeaderText="Quantity" DataFormatString="{0:N0}" SortExpression="QUANTITY">
                                <ItemStyle Width="10%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Confirm Date" SortExpression="CONFIRM_DATE">
                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("CONFIRM_DATE", "{0:dd/MM/yyyy}") %>' ID="txtConfirmDate" Height="50px" CssClass="form-control default-date-picker date-only number-only"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:BoundField DataField="BRANCH_NAME" HeaderText="Branch" SortExpression="Branch">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="STATUS" HeaderText="Status" SortExpression="STATUS">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
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
