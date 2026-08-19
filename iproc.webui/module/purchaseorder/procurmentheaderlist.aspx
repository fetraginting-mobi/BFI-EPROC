<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="procurmentheaderlist.aspx.cs" Inherits="module_purchaseorder_procurmentheaderlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
   <script  type="text/javascript">
        function jsDoAfterLookUp(obj) {
     //       alert(obj);
            obj = obj.replace(/%24/g, '$');
      //      alert(obj);
            __doPostBack(obj, '');

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span> Procurement List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <%-- <cc1:XUILinkButton RoleCode="R50000030C" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save" ></i>  Save</cc1:XUILinkButton>
                     <cc1:XUILinkButton ID="btnProcess" RoleCode="R50000030C" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-adv-table"></i>Process</cc1:XUILinkButton>--%>
                    <%-- <cc1:XUILinkButton ID="btnUnPost" RoleCode="R50000030C" runat="server" OnClick="btnUnPost_Click" CssClass="btn btn-danger"><i class="icon-envelope"></i>  Un-Post</cc1:XUILinkButton>--%>
                </div>
                <div class="col-sm-4 ">
                <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUILabel>
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
                    <div class="form-group">
                    <label class="col-sm-3">Branch</label>
                        <div class="col-sm-4">
                          <cc1:XUIDropDownList ID="ddlBranch" Width="200px" runat="server" CssClass="form-control"  DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <%--(+) Ari 13-07-2022 ket : enhancement 2022, filter by date--%>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4" style="padding-left:50px; width:150px">From Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtFromDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="REQUEST_DATE" SPParameterName="p_from_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
                 <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-sm-4" style="width:100px">To Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtToDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="REQUEST_DATE" SPParameterName="p_to_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" OnTextChanged="txtToDateChanged" AutoPostBack="true"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>                
                 <%--<div class="col-sm-2">
                    <div class="form-group">
                    <label class="col-sm-4">Budget</label>
                        <div class="col-sm-4">
                          <cc1:XUIDropDownList ID="ddlPromotion" Width="100px" runat="server" CssClass="form-control" SPParameterName="p_is_promotion" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlPromotion_SelectedIndexChanged">
                            <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                             <asp:ListItem Text="Cabang" Value="1"></asp:ListItem>
                             <asp:ListItem Text="HO" Value="0"></asp:ListItem>
                             </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                 <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-4">Item Type</label>
                        <div class="col-sm-4">
                          <cc1:XUIDropDownList ID="ddlItemType" Width="200px"  runat="server" CssClass="form-control" SPParameterName="p_item_type" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlItemType_SelectedIndexChanged">
                            <asp:ListItem Text="ALL" Selected Value="ALL"></asp:ListItem>
                             <asp:ListItem Text="ASSET" Value="FA"></asp:ListItem>
                             <asp:ListItem Text="INVENTORY" Value="IT"></asp:ListItem>
                             <asp:ListItem Text="EXPENSE" Value="ET"></asp:ListItem>
                             <asp:ListItem Text="INVENTORY CONSUMTIF" Value="IC"></asp:ListItem>
                             </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>--%>
            </div> 
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
             <div class="row">
                 <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Item Type</label>
                        <div class="col-sm-3">
                          <cc1:XUIDropDownList ID="ddlItemType" Width="200px"  runat="server" CssClass="form-control" SPParameterName="p_item_type" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlItemType_SelectedIndexChanged">
                            <asp:ListItem Text="ALL" Selected Value="ALL"></asp:ListItem>
                             <asp:ListItem Text="ASSET" Value="FA"></asp:ListItem>
                             <asp:ListItem Text="INVENTORY" Value="IT"></asp:ListItem>
                             <asp:ListItem Text="EXPENSE" Value="ET"></asp:ListItem>
                             <asp:ListItem Text="INVENTORY CONSUMTIF" Value="IC"></asp:ListItem>
                             </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3" style="padding-left:50px; width:150px">Budget</label>
                        <div class="col-sm-3">
                          <cc1:XUIDropDownList ID="ddlPromotion" Width="100px" runat="server" CssClass="form-control" SPParameterName="p_is_promotion" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlPromotion_SelectedIndexChanged">
                            <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                             <asp:ListItem Text="Cabang" Value="1"></asp:ListItem>
                             <asp:ListItem Text="HO" Value="0"></asp:ListItem>
                             </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                    <label class="col-sm-3">Owner</label>
                        <div class="col-sm-8">
                          <cc1:XUIDropDownList ID="ddlOwner" Width="200px" runat="server" CssClass="form-control" DBColumnName="OWNER_CODE" SPParameterName="p_owner" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlOwner_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div> 
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="false"  DataKeyNames="ID,PR_CODE,CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging"
                        onselectedindexchanged="SelectedIndexChanged"  EmptyDataText="There is no data" Width="100%" >
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                         <%--   <asp:TemplateField>
                                <HeaderTemplate>
                                       <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField DataField="CODE" HeaderText="PR No.">
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="REQUEST_DATE" HeaderText="Procurement Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </asp:BoundField>
                             <asp:BoundField DataField="SPECIFICATION" HeaderText="Specification">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </asp:BoundField>
                          <%--  <asp:TemplateField HeaderText="">
                                <ItemStyle Width="5%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnLookupItem" class="btn btn-primary input-sm" data-toogle="modal" runat="server"><i class="icon-table"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField DataField="BRANCH_DESC" HeaderText="Branch">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="REQUESTOR" HeaderText="REQUESTOR">
                                <ItemStyle Width="15%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="OWNER_NAME" HeaderText="Owner Asset">
                                <ItemStyle Width="15%"/>
                            </asp:BoundField>
                            <%--<asp:TemplateField HeaderText="Procurement Type">
                              <ItemStyle Width="10%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlTypeProcurment" CssClass="form-control input-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlTypeProcurment_SelectedIndexChanged">
                                    </asp:DropDownList> 
                                </ItemTemplate>
                           <%-- <asp:TemplateField HeaderText="Switch Department">
                              <ItemStyle Width="5%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlSwitchDepartment" CssClass="form-control input-sm">
                                       
                                        <asp:ListItem Text="LOGISTIC" Value="LOGISTIC"></asp:ListItem>
                                        <asp:ListItem Text="INFRA DEV" Value="INFRA DEV"></asp:ListItem>
                                        <asp:ListItem Text="PROMOTION" Value="PROMOTION"></asp:ListItem>
                                         <%-- <asp:ListItem Text="INTERN CABANG" Value="INTERN CABANG"></asp:ListItem>
                                        </asp:DropDownList>  
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            
                            <%--<asp:TemplateField HeaderText="Aut. By Branch">
                              <ItemStyle Width="0%" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="cbAuthorityByBranch">
                                    </asp:CheckBox> 
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                           <%-- <asp:TemplateField HeaderText="Stock">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnViewStock" runat="server" CausesValidation="false" Text="View Stock"/>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                          <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <%--<asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


 <%-- </asp:BoundField>
                            <asp:BoundField DataField="APPROVE_QUANTITY" HeaderText="Qty" DataFormatString="{0:N2}">
                                <ItemStyle Width="5%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            
                          <asp:TemplateField HeaderText="Qty Inventory">
                                    <ItemStyle Width="5%" HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("QTY_INVENTORY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyInventory" CssClass="form-control"/>
                                        <asp:RegularExpressionValidator ID="revQtyInventory" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyInventory" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                    <asp:RequiredFieldValidator ID="rfvApproveQty" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQtyInventory" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Qty Purchase">
                                    <ItemStyle Width="5%" HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("QTY_PURCHASE","{0:N2}") %>'  style="text-align:right;" ID="txtQtyPurchase" CssClass="form-control"/>
                                        <asp:RegularExpressionValidator ID="revQtyPurchase" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyPurchase" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                       <asp:RequiredFieldValidator ID="rfvApproveQtyPurchase" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQtyPurchase" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="UOM">
                                <ItemStyle Width="5%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:UpdatePanel ID="updUom" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList runat="server" ID="ddlUOM" CssClass="form-control input-sm">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnFillUOM" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </ItemTemplate>
                            </asp:TemplateField><asp:TemplateField HeaderText="Procurement Type">
                              <ItemStyle Width="10%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlTypeProcurment" CssClass="form-control input-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlTypeProcurment_SelectedIndexChanged">
                                    </asp:DropDownList> 
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type">
                                <ItemStyle Width="5%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlType" CssClass="form-control input-sm">
                                    </asp:DropDownList>
                            <<asp:RequiredFieldValidator ID="rfvddlType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="Switch Department">
                              <ItemStyle Width="5%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlSwitchDepartment" CssClass="form-control input-sm">
                                        <asp:ListItem Text="LOGISTIC" Value="LOGISTIC"></asp:ListItem>
                                        <asp:ListItem Text="INFRA DEV" Value="INFRA DEV"></asp:ListItem>
                                        <asp:ListItem Text="PROMOTION" Value="PROMOTION"></asp:ListItem>
                                         <asp:ListItem Text="INTERN CABANG" Value="INTERN CABANG"></asp:ListItem>
                                        </asp:DropDownList>  
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Aut. By Branch">
                              <ItemStyle Width="0%" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="cbAuthorityByBranch">
                                    </asp:CheckBox> 
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Purchase By">
                              <ItemStyle Width="5%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlBranch" CssClass="form-control input-sm">
                                        <asp:ListItem Value="0" Text="-=Select=-"></asp:ListItem>
                                        <asp:ListItem Text="HO" Value="HO"></asp:ListItem>
                                        <asp:ListItem Text="BRANCH" Value="BRANCH"></asp:ListItem>
                                    </asp:DropDownList> 
                             <asp:RequiredFieldValidator ID="rvfddlBranch" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlBranch" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Is Review">
                              <ItemStyle Width="5%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlReview" CssClass="form-control input-sm">
                                         <asp:ListItem  Value="0" Text="-=Select=-"></asp:ListItem>
                                         <asp:ListItem Value="YES" Text="YES"></asp:ListItem>
                                         <asp:ListItem Value="NO" Text="NO"></asp:ListItem>
                                    </asp:DropDownList> 
                               <asp:RequiredFieldValidator ID="rfvddlReview" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlReview" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
