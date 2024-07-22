<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchaserequesttender.aspx.cs"
    Inherits="module_purchaseorder_purchaserequesttender" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <script  type="text/javascript">
        function CheckOne(obj) {
                var grid = obj.parentNode.parentNode.parentNode;
                var inputs = grid.getElementsByTagName("input");
                for (var i = 0; i < inputs.length; i++) {
                    if (inputs[i].type == "checkbox") {
                        if (obj.checked && inputs[i] != obj && inputs[i].checked) {
                            inputs[i].checked = false;
                        }
                    }
                }
            }  
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Purchase Request Tender Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    
                    <cc1:XUILinkButton ID="btnClosed" RoleCode="R50000010P" runat="server" CssClass="btn btn-primary" OnClick="btnClosed_Click" CausesValidation="false"><i class="icon-envelope"></i>  Closed</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPrint" RoleCode="R50000010P" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" Visible="false" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
             <asp:UpdatePanel ID="updRequest" runat="server">
                <ContentTemplate>
                    <%--code barcode--%>
                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" ></cc1:XUILabel> 
                   <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Request Tender No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_CODE" DataType="String" BindType="DBToUIOnly"  Text="--" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>   
                    </div> 
                    <div class="row">  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Date</label>
                                <div class="col-sm-3">
                                    <cc1:XUILabel ID="txtRequestTenderDate" runat="server" placeholder="Date" DBColumnName="REQUEST_TENDER_DATE" DataType="DateTime" BindType="DBToUIOnly" Format = "dd/MM/yyyy"></cc1:XUILabel>    
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Expiry Date </label>
                                <div class="col-sm-3">
                                    <cc1:XUILabel ID="txtExpDate" runat="server" placeholder="Date" DBColumnName="EXP_DATE" DataType="DateTime" BindType="DBToUIOnly" Format = "dd/MM/yyyy"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                    </div> 
                    <div class="row">
                      <div class="col-sm-6"> 
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-5">
                                   <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" DataType="String" Enabled="false" BindType="DBToUIOnly"></cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblItemCode" runat="server" placeholder="Item Code" DBColumnName="ITEM_CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblItemName" runat="server" placeholder="Item Name" DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>                     
                                </div>
                            </div>                             
                        </div>   
                    </div>
                      
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div> 
    </section>
    <asp:Panel runat="server" ID="pnlQuotation">
        <section class="panel">
        <header class="panel-heading">
          <span> Tender List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R30000130E" ID="btnWinner" runat="server" CssClass="btn btn-primary" OnClick="btnWinner_Click"><i class="icon-save"></i>  Winner</cc1:XUILinkButton>
                    <%--<cc1:XUILinkButton RoleCode="R50000050E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>--%>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="TENDER_CODE, REQUEST_TENDER_CODE, ITEM_CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" onselectedindexchanged="gvwList_SelectedIndexChanged"  
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
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="CheckOne(this)" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="TENDER_NO" HeaderText="Tender No.">
                                <ItemStyle Width="20%"/>  
                            </asp:BoundField>
                            <asp:BoundField DataField="SUPPLIER_NAME" HeaderText="Supplier">
                                <ItemStyle Width="20%"/>  
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Name">
                                <ItemStyle Width="20%"/>  
                            </asp:BoundField>
                            <asp:BoundField DataField="CURRENCY_CODE" HeaderText="Currency">
                                <ItemStyle Width="5%"/>  
                            </asp:BoundField>
                            <asp:BoundField DataField="AMOUNT" HeaderText="Amount" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DISCOUNT_AMOUNT" HeaderText="Discount" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%"  HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                <ItemStyle Width="20%"/>  
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
               <%-- <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                </Triggers>--%>
            </asp:UpdatePanel>
        </div>
    </section>
    </asp:Panel>
</asp:Content>
