<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterlocation.aspx.cs"
    Inherits="module_commonmst_masterlocation" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">

    <script type="text/javascript">
        function tab()
        {
            var lot = document.getElementById('Lot');
            var lilot = document.getElementById('ctl00_cpb_liLot');
            
            var rak = document.getElementById('Rak');
            var lirak = document.getElementById('ctl00_cpb_liRak');
            
            var slot = document.getElementById('Slot');
            var lislot = document.getElementById('ctl00_cpb_liSlot');
            
            var item = document.getElementById('Item');
            var chb = document.getElementById('ctl00_cpb_chbStorageControl');
             
            var ddl = document.getElementById('ctl00_cpb_updItemDDL');
            
            if (chb.checked)
            {
                lilot.style.display = '';
                lot.style.display = '';
                
                 lirak.style.display = '';
                rak.style.display = '';
               
                lislot.style.display = '';
                slot.style.display = '';
                
                
                item.style.display = '';
                ddl.style.display = '';
            }
            else
            {
                lot.style.display = 'none';
                lilot.style.display = 'none';
                
                rak.style.display = 'none';
                lirak.style.display = 'none';
                
                slot.style.display = 'none';
                lislot.style.display = 'none';
                
                item.style.display = 'inline';
                ddl.style.display = 'none';
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Warehouse Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R60000040E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>

                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Code *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="CODE" SPParameterName="p_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>                                    
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Branch *</label>
                            <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" placeholder="Branch" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>                                   
                            </div>
                        </div>                            
                    </div>
                </div>   
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Description *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox> 
                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>                                   
                            </div>
                        </div>                            
                    </div>
                
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Address *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" DBColumnName="ADDRESS" SPParameterName="p_address" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine" ></cc1:XUITextBox>
                                <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtAddress" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAddress" Display="Dynamic"></asp:RequiredFieldValidator>                                    
                            </div>
                        </div>                            
                    </div>
                </div>   
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4 ">PIC *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtName" runat="server" CssClass="form-control" placeholder="PIC" DBColumnName="PIC" SPParameterName="p_pic" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">City *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City" DBColumnName="CITY" SPParameterName="p_city" MaxLength="20" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCity" Display="Dynamic"></asp:RequiredFieldValidator>                                    
                            </div>
                        </div>                            
                    </div>
                 
                    
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Phone</label>
                            <asp:RegularExpressionValidator ID="revPhoneNo" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPhone" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone No" DBColumnName="PHONE_NO" SPParameterName="p_phone_no" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Minimum Qty *</label>  
					        <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtMinumQuantity" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="MINIMUM_QTY" SPParameterName="p_minimum_qty" DataType="Number" BindType="Both" MaxLength="6"></cc1:XUITextBox>  
                                <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMinumQuantity" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMinumQuantity" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>  
                            </div>
                        </div>
                    </div>
                    
                </div>
                
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Storage Control *</label>
                            <div class="col-sm-7">
                                 <cc1:XUICheckBox ID="chbStorageControl" runat="server" DBColumnName="STORAGE_CONTROL" SPParameterName="p_storage_control" onclick="tab();" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" ></cc1:XUICheckBox>                                   
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Maximum Qty *</label>  
					        <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtMaximumQTY" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="MAXIMUM_QTY" SPParameterName="p_maximum_qty" DataType="Number" BindType="Both" MaxLength="16"></cc1:XUITextBox>  
                                <asp:RequiredFieldValidator ID="rfvMaximumQty" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMaximumQTY" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ID="revMaximumQty" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMaximumQTY" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>  
                              
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2">Remarks *</label>
                            <div class="col-sm-10">
                                <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine" ></cc1:XUITextBox>
                                <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator>                                    
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
                    <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                    <ul class="nav nav-tabs nav-justified">
                      <li class="active" runat="server" id="liLot" >
                          <a href="#Lot" id="trxlot" runat="server" onclick="javascript:fnSetTab('trxlot');" style="padding-bottom:28px" data-toggle="tab" >
                              Lot
                          </a>
                      </li>
                      <li class="" runat="server" id="liRak">
                          <a href="#Rak" id="trxRak" runat="server" onclick="javascript:fnSetTab('trxRak');" style="padding-bottom:28px" data-toggle="tab" >
                              Rack
                          </a>
                      </li>
                      <li class="" runat="server" id="liSlot">
                          <a href="#Slot" id="trxSlot" runat="server" onclick="javascript:fnSetTab('trxSlot');" style="padding-bottom:28px" data-toggle="tab" >
                              Slot
                          </a>
                      </li>
                      <li class="" runat="server" id="liitem">
                          <a href="#Item" id="trxItem" runat="server" onclick="javascript:fnSetTab('trxItem');" style="padding-bottom:28px" data-toggle="tab" >
                              Item
                          </a>
                      </li>
                  </ul>
                </header>
        
                <div class="panel-body">                    
                    <div class="tab-content tasi-tab">
                      <div id="Lot" class="tab-pane active">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-sm-8 ">
                                    <cc1:XUILinkButton ID="btnAddLot" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton> 
                                    <cc1:XUILinkButton ID="BtnSaveLot" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" OnClick="btnSaveLot_Click" ValidationGroup="Lot"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                                    <cc1:XUILinkButton ID="btnDeleteLot" RoleCode="R60000040E" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteLot_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                                </div>
                                <asp:Panel ID="pnlSearchLot" runat="server" DefaultButton="btnSearchLot"     class="input-group">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearchLot" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchLot" runat="server" CssClass="btn btn-info" OnClick="btnSearchLot_Click"><i class="icon-search"></i> Search</asp:LinkButton>
                                        </div>
                                     </div>
                                </asp:Panel>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel ID="UpdLot" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gvwListLot" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                         AllowPaging="true" PageSize="10" DataKeyNames="ID,LOT_CODE"
                                        OnPageIndexChanging="gvwListLot_PageIndexChanging" OnRowDataBound="gvwListLot_RowDataBound"
                                        EmptyDataText="There is no data">
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
                                            <asp:BoundField DataField="LOT_CODE" HeaderText="Code">
                                                <ItemStyle Width="20%"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LOT_NAME" HeaderText="Description">
                                                <ItemStyle Width="60%"/>
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Minimal Qty">
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtMinQty" CssClass="form-control">
                                                    </asp:TextBox>
                                                    <asp:RegularExpressionValidator ValidationGroup="Lot" ID="revMinQty" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMinQty" ValidationExpression="[0-9.,]*[0-9.,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Maximal Qty">
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtMaxQty" CssClass="form-control">
                                                    </asp:TextBox>
                                                    <asp:RegularExpressionValidator ValidationGroup="Lot" ID="revMaxQty" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMaxQty" ValidationExpression="[0-9.,]*[0-9.,]" Display="Dynamic" ></asp:RegularExpressionValidator>
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
                                        <cc1:XUILinkButton ID="btnSaveRak" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" OnClick="btnSaveRak_Click" ValidationGroup="Rak"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                                           <cc1:XUILinkButton ID="btnDeleteRak" RoleCode="R60000040E" runat="server" CssClass="btn btn-danger" onclick="btnDeleteRak_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                                    </div>
                                    <asp:Panel ID="pnlSearchRak" runat="server" DefaultButton="btnSearchRak" class="input-group">
                                           <asp:TextBox ID="txtSearchRak" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                           <div class="input-group-btn">
                                               <asp:LinkButton ID="btnSearchRak" runat="server" CssClass="btn btn-info" OnClick="btnSearchRak_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                                           </div>
                                       </asp:Panel>
                                </div>
                            </div>
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-sm-1">
                                        Lot :
                                    </div>
                                    <div class="col-sm-2">
                                    <asp:UpdatePanel ID ="updLotDDL" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlLot" runat="server" style="width:auto" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlLot_SelectedIndexChanged"></asp:DropDownList>   
                                        </ContentTemplate>
                                    </asp:UpdatePanel>                                         
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <asp:UpdatePanel ID="updRak" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvwListRak" runat="server" 
                                            AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                            AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListRak_PageIndexChanging" 
                                            OnRowDataBound="gvwListRak_RowDataBound"
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
                                                <asp:BoundField DataField="RAK_CODE" HeaderText="Rack Code">
                                                    <ItemStyle Width="20%" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="RAK_NAME" HeaderText="Rack Name">
                                                    <ItemStyle Width="60%" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Minimal Qty">
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtMinQtyRak" CssClass="form-control">
                                                    </asp:TextBox>
                                                    <asp:RegularExpressionValidator ValidationGroup="Rak" ID="revMinQtyRak" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMinQtyRak" ValidationExpression="[0-9.,]*[0-9.,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Maximal Qty">
                                                    <ItemStyle Width="10%"  HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtMaxQtyRak" CssClass="form-control">
                                                        </asp:TextBox>
                                                        <asp:RegularExpressionValidator ValidationGroup="Rak" ID="revMaxQtyRak" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMaxQtyRak" ValidationExpression="[0-9.,]*[0-9.,]" Display="Dynamic" ></asp:RegularExpressionValidator>
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
                                        <cc1:XUILinkButton ID="btnSaveSlot" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" OnClick="btnSaveSlot_Click" ValidationGroup="Slot"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                                         <cc1:XUILinkButton ID="btnDeleteSlot" RoleCode="R60000040E" runat="server" CssClass="btn btn-danger" onclick="btnDeleteSlot_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>        
                                    </div>
                                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearchSlot" class="input-group">
                                            <asp:TextBox ID="txtSearchSlot" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                            <div class="input-group-btn">
                                                <asp:LinkButton ID="btnSearchSlot" runat="server" CssClass="btn btn-info" OnClick="btnSearchSlot_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                                            </div>
                                        </asp:Panel>
                                </div>
                            </div>
                            <div class="panel-heading">
                                <div class="row">
                                    <asp:UpdatePanel ID ="updRakDDL" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="col-sm-1">
                                                Lot :
                                            </div>
                                            <div class="col-sm-4">
                                                <asp:DropDownList ID="ddlLotSlot"  runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlLotSlot_SelectedIndexChanged"></asp:DropDownList>
                                            </div>
                                            <div class="col-sm-1">
                                                Rack :
                                            </div>
                                            <div class="col-sm-4">
                                                <asp:DropDownList ID="ddlRak"  runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlRak_SelectedIndexChanged"></asp:DropDownList>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="panel-body">
                                <asp:UpdatePanel ID="updSlot" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvwListSlot" runat="server" 
                                            AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                            AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListSlot_PageIndexChanging" 
                                            OnRowDataBound="gvwListSlot_RowDataBound"
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
                                                    <asp:RegularExpressionValidator ValidationGroup="Slot" ID="revMinQtySlot" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMinQtySlot" ValidationExpression="[0-9.,]*[0-9.,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Maximal Qty">
                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtMaxQtySlot" CssClass="form-control">
                                                        </asp:TextBox>
                                                        <asp:RegularExpressionValidator ValidationGroup="Slot" ID="revMaxQtySlot" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMaxQtySlot" ValidationExpression="[0-9.,]*[0-9.,]" Display="Dynamic" ></asp:RegularExpressionValidator>
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
                                       <cc1:XUILinkButton ID="BtnAddItem" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                        <cc1:XUILinkButton ID="btnSaveItem" RoleCode="R60000040E" runat="server" CssClass="btn btn-primary" OnClick="btnSaveItem_Click" ValidationGroup="ItemDetail"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                                          <cc1:XUILinkButton ID="btnDeleteItem" RoleCode="R60000040E" runat="server" CssClass="btn btn-danger" onclick="btnDeleteItem_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>  
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Panel ID="pnlSearchItem" runat="server" DefaultButton="btnSearchItem" class="input-group">
                                            <asp:TextBox ID="txtSearchItem" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                            <div class="input-group-btn">
                                                <asp:LinkButton ID="btnSearchItem" runat="server" CssClass="btn btn-info" OnClick="btnSearchItem_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-heading">
                                <div class="row">
                                    <asp:UpdatePanel ID ="updItemDDL" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="col-sm-1">
                                                Lot :
                                            </div>
                                            <div class="col-sm-3">
                                                <asp:DropDownList ID="ddlLotItem" runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlLotItem_SelectedIndexChanged"></asp:DropDownList>
                                            </div>
                                            <div class="col-sm-1">
                                                Rack :
                                            </div>
                                            <div class="col-sm-3">
                                                <asp:DropDownList ID="ddlRakItem" runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlRakItem_SelectedIndexChanged"></asp:DropDownList>
                                            </div>
                                            <div class="col-sm-1">
                                                Slot :
                                            </div>
                                            <div class="col-sm-3">
                                                <asp:DropDownList ID="ddlSlotItem" runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlSlotItem_SelectedIndexChanged"></asp:DropDownList>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="panel-body">
                                <asp:UpdatePanel ID="updItem" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvwListItem" runat="server" 
                                            AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                            AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListItem_PageIndexChanging" 
                                            onselectedindexchanged="gvwListItem_SelectedIndexChanged" OnRowDataBound="gvwListItem_RowDataBound"
                                            DataKeyNames="ID,LOT_CODE,RAK_CODE,SLOT_CODE,ITEM_CODE" EmptyDataText="There is no data">
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
                                                    <ItemStyle Width="50%" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Minimal Qty">
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtMinQtyItem" CssClass="form-control">
                                                    </asp:TextBox>
                                                    <asp:RegularExpressionValidator ValidationGroup="ItemDetail" ID="revMinQtyItem" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMinQtyItem" ValidationExpression="[0-9.,]*[0-9.,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Maximal Qty">
                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtMaxQtyItem" CssClass="form-control">
                                                        </asp:TextBox>
                                                        <asp:RegularExpressionValidator ValidationGroup="ItemDetail" ID="revMaxQtyItem" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtMaxQtyItem" ValidationExpression="[0-9.,]*[0-9.,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Reorder Qty">
                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtReorderQtyItem" CssClass="form-control">
                                                        </asp:TextBox>
                                                        <asp:RegularExpressionValidator ValidationGroup="ItemDetail" ID="revReorderQtyItem" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtReorderQtyItem" ValidationExpression="[0-9.,]*[0-9.,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%--<asp:CommandField ShowSelectButton="true" />--%>
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
                    </div>
                </div>
        </section>
    </asp:Panel>
</asp:Content>
