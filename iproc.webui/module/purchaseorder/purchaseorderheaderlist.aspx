<%@ Page Title="" Language="C#"  MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchaseorderheaderlist.aspx.cs" Inherits="module_purchaseorder_purchaseorderheaderlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">

<script type="text/javascript">
  function btnDelete_Click()
  {
    window.location.reload();
  }
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Purchase Order Transaction</span>
        </header>
         <%--<section class="panel">--%>
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#Buat" id="poprocess"  onclick="javascript:fnSetTab('poprocess');"  data-toggle="tab">
                     PO Process
                  </a>
              </li>
             <li class=""  id="tabpo">
                  <a href="#PO" id="popo"  onclick="javascript:fnSetTab('popo');" data-toggle="tab">
                     PO
                  </a>
              </li>
          </ul>
        </header>
    
        <div class="panel-body">                    
                <div class="tab-content tasi-tab">
                    <div class="tab-pane" id="PO">
                    <header class="panel-heading">
                      <span></span>
                    </header>
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8">
                                <cc1:XUILinkButton ID="btnAdd" RoleCode="R50000070C" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000070D" ID="btnDelete" postb runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            
                            <div class="col-sm-4">
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
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                    <div class="col-sm-5">
                                        <cc1:XUIDropDownList ID="ddlStatus" Width="200px" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged"></cc1:XUIDropDownList>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-sm-3">
                                <div class="form-group">
                                <label class="col-sm-3">Branch</label>
                                    <div class="col-sm-5">
                                      <cc1:XUIDropDownList ID="ddlBranch" runat="server" Width="200px" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                                    </div>
                                </div>
                            </div>
                            <%--(+) Ari 13-07-2022 ket : enhancement 2022, filter by date--%>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="col-sm-4" style="padding-left:50px; width:150px">From Date</label>
                                    <div class="col-sm-4">
                                        <cc1:XUITextBox ID="txtFromDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="ORDER_DATE" SPParameterName="p_from_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                                    </div>
                                </div>                            
                            </div>
                             <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="col-sm-4" style="width:100px">To Date</label>
                                    <div class="col-sm-4">
                                        <cc1:XUITextBox ID="txtToDate" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="ORDER_DATE" SPParameterName="p_to_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" OnTextChanged="txtToDateChanged" AutoPostBack="true"></cc1:XUITextBox>
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
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CODE" HeaderText="PO No.">
                                            <ItemStyle Width="15%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BRANCH_NAME" HeaderText="Branch">
                                            <ItemStyle Width="15%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ORDER_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                            <ItemStyle Width="10%" HorizontalAlign="Center"/>
                                        </asp:BoundField>                        
                                        <asp:BoundField DataField="SUPPLIER_NAME" HeaderText="Supplier">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CREDITOR_TYPE" HeaderText="Creditor Type">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PROCESS" HeaderText="Process">
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="OWNER_NAME" HeaderText="Owner Asset">
                                            <ItemStyle Width="5%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TRANS_FLAG_DESC" HeaderText="Status">
                                            <ItemStyle Width="5%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    </div>
            
                    <div class="tab-pane active" id="Buat">
                    <header class="panel-heading">
                       <span></span>
                    </header>
                    <div class="panel-heading">
                         <div class="row">
                             <div class="col-sm-8 ">
                                <cc1:XUILinkButton ID="btnProcess" RoleCode="R50000070O" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-adv-table"></i>Process</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000070O" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                             </div>
                            <div class="col-sm-4 ">
                              <asp:Panel ID="pnlSearchProcess" runat="server" DefaultButton="btnSearchProcess" class="input-group">
                                   <asp:TextBox ID="txtSearchProcess" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                   <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchProcess" runat="server" CssClass="btn btn-info" OnClick="btnSearchProcess_Click"  CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
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
                                    <div class="col-sm-5">
                                      <cc1:XUIDropDownList ID="ddlBranchPO" runat="server" Width="200px" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" OnSelectedIndexChanged="ddlBranchPO_SelectedIndexChanged" AutoPostBack="true" ></cc1:XUIDropDownList>
                                    </div>
                                </div>
                            </div>
                            <%--(+) Ari 13-07-2022 ket : enhancement 2022, filter by date--%>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="col-sm-4" style="padding-left:50px; width:150px">From Date</label>
                                    <div class="col-sm-4">
                                        <cc1:XUITextBox ID="txtFromDatePO" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="SELECTION_DATE" SPParameterName="p_from_date_po" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                                    </div>
                                </div>                            
                            </div>
                             <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="col-sm-4" style="width:100px">To Date</label>
                                    <div class="col-sm-4">
                                        <cc1:XUITextBox ID="txtToDatePO" runat="server" Width="100px" CssClass="form-control default-date-picker-all" DBColumnName="SELECTION_DATE" SPParameterName="p_to_date_po" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" OnTextChanged="txtToDatePOChanged" AutoPostBack="true"></cc1:XUITextBox>
                                    </div>
                                </div>                            
                            </div>
                         </div> 
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group"></div>
                            </div>
                        </div>
                         <asp:UpdatePanel ID="UpdGenerate" runat="server">
                            <ContentTemplate>
                            <asp:GridView ID="gvwListGenerate" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                            AllowPaging="true" PageSize="10"  DataKeyNames="PQ_CODE, SUPPLIER_CODE, ITEM_CODE, BRANCH_CODE_DETAIL,ID"
                                OnPageIndexChanging="gvwListGenerate_PageIndexChanging" OnRowDataBound="gvwListGenerate_OnRowDataBound"
                                onselectedindexchanged="gvwListGenerate_SelectedIndexChanged" EmptyDataText="There Is No Data">
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
                                    <asp:BoundField DataField="PQ_DESC" HeaderText="PQ No.">
                                        <ItemStyle Width="10%" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BRANCH_NAME" HeaderText="Branch">
                                        <ItemStyle Width="5%" HorizontalAlign="Center"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SELECTION_DATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle Width="5%" HorizontalAlign="Center"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name" >
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemStyle Width="5%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnLookUpSupplierID" class="btn btn-primary input-sm" data-toogle="modal" runat="server" ><i class="icon-table"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Supplier">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtItemGroup" runat="server" style="display:none;"></asp:TextBox>
                                            <asp:TextBox ID="txtSupplierCode" runat="server" style="display:none;"></asp:TextBox>
                                            <asp:Label ID="lblSupplierName" runat="server" ></asp:Label>   
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CREDITOR_TYPE" HeaderText="Creditor Type">
                                        <ItemStyle Width="5%" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Currency">
                                        <ItemStyle Width="9%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:DropDownList runat="server" ID="ddlCurrencyCode" CssClass="form-control" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Rate" Visible="false" >
                                        <ItemStyle Width="5%" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtRate" Text='<%# Eval("RATE","{0:N0}") %>' CssClass="form-control"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="revRate" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtRate" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                            <%--<asp:RequiredFieldValidator ID="rfvRate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRate" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="WINNER_QUANTITY" HeaderText="QTY"  DataFormatString="{0:N2}">
                                        <ItemStyle Width="3%" HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Unit Price">
                                        <ItemStyle Width="25%" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtUnitPrice" Text='<%# Eval("WINNER_AMOUNT","{0:N2}") %>' CssClass="form-control"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="revUnitPrice" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtUnitPrice" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                            <asp:RequiredFieldValidator ID="rfvUnitPrice" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitPrice" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Is Termin?">
                                      <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                          <asp:DropDownList runat="server" ID="ddlIsTermin" CssClass="form-control input-sm">
                                                <asp:ListItem Selected  Text="NO" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="YES" Value="1"></asp:ListItem>
                                          </asp:DropDownList> 
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="OWNER_NAME" HeaderText="Owner Asset" >
                                        <ItemStyle Width="3%"/>
                                    </asp:BoundField>
                                   <%-- <asp:TemplateField HeaderText="Is Termin?">
                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:RadioButton runat="server" ID="chkTermin" Text='<%# Eval("IS_TERMIN") %>' ></asp:RadioButton>
                                            <%--<asp:RequiredFieldValidator ID="rfvTermin" runat="server" ErrorMessage="Required Field!" ControlToValidate="chkTermin" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="WINNER_AMOUNT" HeaderText="Amount" DataFormatString="{0:N2}">
                                        <ItemStyle Width="15%" HorizontalAlign="Right" />
                                    </asp:BoundField>  --%>
                                </Columns>
                            </asp:GridView>
                            </ContentTemplate>
                         <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchProcess" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnProcess" EventName="Click" />
                        </Triggers>
                         </asp:UpdatePanel>
                     </div>
                    </div>
                </div> 
        </div>    
    </section>
</asp:Content>
