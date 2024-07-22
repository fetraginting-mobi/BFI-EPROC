<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"
    CodeFile="masterwarehousetrx.aspx.cs" Inherits="module_commonmst_masterwarehousetrx" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Warehouse Trx Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R60000040E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
       <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <cc1:XUILabel ID="lblId" runat="server"  CssClass="form-control" placeholder="Id" DBColumnName="ID" SPParameterName="p_id" MaxLength="5" DataType="Integer" BindType="Both" Visible="false" Text="0"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Warehouse Code *</label>
                            <div class="col-sm-7">
                      <%--          <cc1:XUIDropDownList ID="ddlWarehouseCode" runat="server" CssClass="form-control" DBColumnName="WAREHOUSE_CODE" SPParameterName="p_warehouse_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList> --%>
                                <asp:LinkButton runat="server" ID="btnLookUpWarehouseCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                <cc1:XUITextBox ID="txtWarehouseCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="WAREHOUSE_CODE" SPParameterName="p_warehouse_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblWarehouseCode" runat="server"  DBColumnName="LOCATION_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                <asp:RequiredFieldValidator ID="rfvWarehouseCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtWarehouseCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Minimum Qty *</label>  
					        <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtMinumQuantity" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="MINIMUM_QTY" SPParameterName="p_minimum_qty" DataType="Integer" BindType="Both" MaxLength="8"></cc1:XUITextBox>  
                                <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMinumQuantity" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMinumQuantity" ValidationExpression="[0-9 ./()+]*[0-9 ./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>  
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Maximum Qty *</label>  
					        <div class="col-sm-2">
                                <cc1:XUITextBox ID="txtMaximumQTY" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="MAXIMUM_QTY" SPParameterName="p_maximum_qty" DataType="Integer" BindType="Both" MaxLength="8"></cc1:XUITextBox>  
                                <asp:RequiredFieldValidator ID="rfvMaximumQty" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMaximumQTY" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revMaximumQty" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMaximumQTY" ValidationExpression="[0-9 ./()+]*[0-9 ./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>  
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
        
        <asp:Panel runat="server" ID="pnlAllEmployee">
        <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#Lot" id="trxlot" onclick="javascript:fnSetTab('trxlot');" style="padding-bottom:28px" data-toggle="tab" >
                      Lot
                  </a>
              </li>
              <li class="">
                  <a href="#Rak" id="trxRak" onclick="javascript:fnSetTab('trxRak');" style="padding-bottom:28px" data-toggle="tab" >
                      Rak
                  </a>
              </li>
              <li class="">
                  <a href="#Slot" id="trxSlot" onclick="javascript:fnSetTab('trxSlot');" style="padding-bottom:28px" data-toggle="tab" >
                      Slot
                  </a>
              </li>
              <li class="">
                  <a href="#Item" id="trxItem" onclick="javascript:fnSetTab('trxItem');" style="padding-bottom:28px" data-toggle="tab" >
                      Item
                  </a>
              </li>
          </ul>
        </header>
        
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
              <div class="tab-pane active" id="Lot">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton ID="btnAddLot" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDeleteLot" RoleCode="R60000040E" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteLot_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="BtnSaveLot" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" OnClick="btnSaveLot_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                        </div>
                        <asp:Panel ID="pnlSearchLot" runat="server" DefaultButton="btnSearchLot"     class="input-group">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearchLot" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchLot" runat="server" CssClass="btn btn-info" OnClick="btnSearchLot_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdLot" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListLot" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                 AllowPaging="true" PageSize="10" DataKeyNames="ID,LOT_CODE"
                                OnPageIndexChanging="gvwListLot_PageIndexChanging" OnRowDataBound="gvwListLot_RowDataBound"
                                onselectedindexchanged="gvwListLot_SelectedIndexChanged" EmptyDataText="There is no data">
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
                                            <asp:CheckBox runat="server" ID="chbCheckedAllLot" AutoPostBack="true" OnCheckedChanged="chbCheckedAllLot_CheckedChanged"/>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chbCheckedLot"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="LOT_CODE" HeaderText="Lot Code">
                                        <ItemStyle Width="20%"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LOT_NAME" HeaderText="Lot Name">
                                        <ItemStyle Width="60%"/>
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Minimal Qty">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtMinQty" CssClass="form-control">
                                            </asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Maximal Qty">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtMaxQty" CssClass="form-control">
                                            </asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:CommandField ShowSelectButton="true" />--%>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchLot" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnDeleteLot" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
            
            <div class="tab-pane" id="Rak">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8" >
                                <!-- Subscription pop up here-->
                                <cc1:XUILinkButton ID="btnAddRak" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton ID="btnDeleteRak" RoleCode="R60000040E" runat="server" CssClass="btn btn-danger" onclick="btnDeleteRak_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>                                      
                                <cc1:XUILinkButton ID="btnSaveRak" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" OnClick="btnSaveRak_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                            </div>
                            
                            <div class="col-sm-4">
                                <asp:Panel ID="pnlSearchRak" runat="server" DefaultButton="btnSearchRak" class="input-group">
                                   
                                    <asp:TextBox ID="txtSearchRak" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchRak" runat="server" CssClass="btn btn-info" OnClick="btnSearchRak_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-1">
                                Lot :
                            </div>
                            <div class="col-sm-2">
                                 <asp:DropDownList ID="ddlLot" runat="server" style="width:auto" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlLot_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updRak" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListRak" runat="server" 
                                    AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListRak_PageIndexChanging" 
                                    onselectedindexchanged="gvwListRak_SelectedIndexChanged" OnRowDataBound="gvwListRak_RowDataBound"
                                    DataKeyNames="ID,LOT_CODE,RAK_CODE" EmptyDataText="There is no data">
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
                                                <asp:CheckBox runat="server" ID="chbCheckedAllRak" AutoPostBack="true" OnCheckedChanged="chbCheckedAllRak_CheckedChanged"/>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chbCheckedRak"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="RAK_CODE" HeaderText="Rak Code">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="RAK_NAME" HeaderText="Rak Name">
                                            <ItemStyle Width="60%" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Minimal Qty">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtMinQtyRak" CssClass="form-control">
                                            </asp:TextBox>
                                        </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Maximal Qty">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtMaxQtyRak" CssClass="form-control">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchRak" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteRak" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                
                <div class="tab-pane" id="Slot">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8" >
                                <!-- Subscription pop up here-->
                                <cc1:XUILinkButton ID="BtnAddSlot" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton ID="btnDeleteSlot" RoleCode="R60000040E" runat="server" CssClass="btn btn-danger" onclick="btnDeleteSlot_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>                                      
                                <cc1:XUILinkButton ID="btnSaveSlot" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" OnClick="btnSaveSlot_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4">
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearchSlot" class="input-group">
                                    <asp:TextBox ID="txtSearchSlot" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchSlot" runat="server" CssClass="btn btn-info" OnClick="btnSearchSlot_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                         
                        
                    </div>
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-1">
                                Lot :
                            </div>
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddlLotSlot" style="width:auto" runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlLotSlot_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                            <div class="col-sm-1">
                                Rak :
                            </div>
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddlRak" style="width:auto" runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlRak_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updSlot" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListSlot" runat="server" 
                                    AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListSlot_PageIndexChanging" 
                                    onselectedindexchanged="gvwListSlot_SelectedIndexChanged" OnRowDataBound="gvwListSlot_RowDataBound"
                                    DataKeyNames="ID,LOT_CODE,RAK_CODE,SLOT_CODE" EmptyDataText="There is no data">
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
                                                <asp:CheckBox runat="server" ID="chbCheckedAllSlot" AutoPostBack="true" OnCheckedChanged="chbCheckedAllSlot_CheckedChanged"/>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chbCheckedSlot"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="SLOT_CODE" HeaderText="Slot Code">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SLOT_NAME" HeaderText="Slot Name">
                                            <ItemStyle Width="60%" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Minimal Qty">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtMinQtySlot" CssClass="form-control">
                                            </asp:TextBox>
                                        </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Maximal Qty">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtMaxQtySlot" CssClass="form-control">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:CommandField ShowSelectButton="true" />--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchSlot" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteSlot" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                
                <div class="tab-pane" id="Item">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8" >
                                <!-- Subscription pop up here-->
                               <cc1:XUILinkButton ID="BtnAddItem" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" OnClick="btnAddItem_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton ID="btnDeleteItem" RoleCode="R60000040E" runat="server" CssClass="btn btn-danger" onclick="btnDeleteItem_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>                                      
                            </div>
                            <div class="col-sm-4">
                                <asp:Panel ID="pnlSearchItem" runat="server" DefaultButton="btnSearchItem" class="input-group">
                                    <asp:TextBox ID="txtSearchItem" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchItem" runat="server" CssClass="btn btn-info" OnClick="btnSearchItem_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updItem" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListItem" runat="server" 
                                    AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListItem_PageIndexChanging" 
                                    onselectedindexchanged="gvwListItem_SelectedIndexChanged"
                                    DataKeyNames="ID" EmptyDataText="There is no data">
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
                                                <asp:CheckBox runat="server" ID="chbCheckedAllItem" AutoPostBack="true" OnCheckedChanged="chbCheckedAllItem_CheckedChanged"/>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chbCheckedItem"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ITEM_CODE" HeaderText="Item Code">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ITEM_NAME" HeaderText="Item Name">
                                            <ItemStyle Width="80%" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchItem" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteItem" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
        
        
        </section>
    </asp:Panel>
</asp:Content>
