<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventoryamortizationheader.aspx.cs"
    Inherits="module_inventory_inventoryamortizationheader" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
<script type="text/javascript">
    function ChangeAccrueValue(evt) {

        var obj = evt.target;
        var charCode = evt.keyCode;
        
        
        var period = document.getElementById("ctl00_cpb_txtPeriod").value;
        var amount = document.getElementById("ctl00_cpb_txtUnitPrice").value;
        var pct = document.getElementById("ctl00_cpb_txtAccruePct").value;
        var accAmount = document.getElementById("ctl00_cpb_txtAccrueAmount").value;
        
        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 8) {

            if (obj.id == "<%= txtAccrueAmount.ClientID %>") {
                
                var periodreal = amount / accAmount ;
                var pctreal = accAmount / amount * 100;
                var amountreal = accAmount ;
                
                $("#<%= txtPeriod.ClientID %>").val(periodreal);
                $("#<%= txtAccruePct.ClientID %>").val(pctreal);
            }
            else if (obj.id == "<%= txtPeriod.ClientID %>") {
                
                var amountreal = amount / period ;
                var pctreal = accAmount / amount * 100;
                
                $("#<%= txtAccrueAmount.ClientID %>").val(amountreal);
                $("#<%= txtAccruePct.ClientID %>").val(pctreal);
            }
            else if (obj.id == "<%= txtAccruePct.ClientID %>") {
                var amoutreal = amount / pct * 100;
                var periodreal = amount / accAmount;
                
                $("#<%= txtAccrueAmount.ClientID %>").val(amoutreal);
                $("#<%= txtPeriod.ClientID %>").val(periodreal);
            }

        }
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Inventory Amortization Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R60000075E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnProcess" RoleCode="R60000075E" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click"><i class="icon-save"></i>  Process</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnChange" RoleCode="R60000075E" runat="server" CssClass="btn btn-primary" OnClick="btnChange_Click"><i class="icon-save"></i>  Change Branch</cc1:XUILinkButton>
                    
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="R60000075E" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">No.</label>
                                <!--CODE BARCODE-->
                                <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String"  BindType="Both" style="display:none"></cc1:XUILabel>
                                 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                      </div>
                      <div class="row">
                       <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Po No</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblPoNo" runat="server" DBColumnName="PO_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" AutoPostBack = "true" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Amortization Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtAmortizationDate" runat="server" CssClass="form-control default-date-picker" placeholder="Amortization Date" DBColumnName="AMORTIZATION_DATE" SPParameterName="p_amortization_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvAmortizationDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmortizationDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revAmortizationDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtAmortizationDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Barcode</label>
                                <div class="col-sm-2">
                                    <asp:LinkButton runat="server" ID="btnLookUpInvBarcode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtBarcode" runat="server"  CssClass="form-control" placeholder="Inventory Barcode" DBColumnName="INVENTORY_BARCODE" SPParameterName="p_inventory_barcode" DataType="String" BindType="Both"></cc1:XUITextBox>
                                   
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Amount Prepaid</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtUnitPrice" Enabled = "false" runat="server"  CssClass="form-control" placeholder="unit price" DBColumnName="UNITE_PRICE" DataType="Number" Format="N2" BindType="DBToUIOnly"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtItemCode" runat="server" CssClass="form-control" placeholder="Item Code" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both" style="display:none;" ></cc1:XUITextBox>    
                                    <cc1:XUITextBox ID="txtItemName" runat="server" CssClass="form-control" placeholder="Item Name" DBColumnName="ITEM_NAME" SPParameterName="p_item_name" DataType="String" BindType="Both" ></cc1:XUITextBox>    
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Period / Month</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtPeriod" runat="server" Enabled = "false" CssClass="form-control" placeholder="Period" DBColumnName="PERIOD" SPParameterName="p_period" DataType="Integer" BindType="Both" OnTextChanged="txtPeriod_TextChanged" AutoPostBack="true" onkeypress="return ChangeAccrueValue(event);"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Accrue % *</label>
                                <div class="col-sm-4">                    
                                    <cc1:XUITextBox ID="txtAccruePct" Enabled = "false" runat="server" CssClass="form-control" DBColumnName="ACCRUED_PCT" SPParameterName="p_accrued_pct" DataType="Number" Format="N2" BindType="Both" onkeypress="return ChangeAccrueValue(event);"></cc1:XUITextBox>
                                   <%-- <asp:RequiredFieldValidator ID="rfvAccruePct" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccruePct" Display="Dynamic"></asp:RequiredFieldValidator>--%> 
                                     <asp:RangeValidator ID="ravRate" runat="server" ErrorMessage="Value must be between 0 - 100" ControlToValidate="txtAccruePct" Display="Dynamic" MinimumValue="0" MaximumValue="100" Type="Double"></asp:RangeValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Accrue Amount *</label>
                                <div class="col-sm-7">                              
                                    <cc1:XUITextBox ID="txtAccrueAmount" Enabled = "false" runat="server" CssClass="form-control" DBColumnName="ACCRUED_AMOUNT" SPParameterName="p_accrued_amount" DataType="Number" Format="N2" BindType="Both" onkeypress="return ChangeAccrueValue(event);"></cc1:XUITextBox>
                                    <%--OnTextChanged="txtAccrueAmount_TextChanged" AutoPostBack="true"--%>
                                    <%--<asp:RequiredFieldValidator ID="rfvAccrueAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAccrueAmount" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Start Contract Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtStartContractDate" Enabled = "false" runat="server" CssClass="form-control default-date-picker" placeholder="Start Contract Date" DBColumnName="START_CONTRACT_DATE" SPParameterName="p_start_contract_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                   <%-- <asp:RequiredFieldValidator ID="rfvStartContractDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtStartContractDate" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                                    <asp:RegularExpressionValidator ID="revStartContractDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtStartContractDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                           
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">End Contract Date </label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtEndContractDate" Enabled = "false"  runat="server" CssClass="form-control default-date-picker" placeholder="Amortization Date" DBColumnName="END_CONTRACT_DATE" SPParameterName="p_end_contract_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                 
                                </div>
                                    <asp:RegularExpressionValidator ID="revEndContractDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtEndContractDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Modified</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName= "EMP_MOD" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName= "MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
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
    <asp:Panel runat="server" ID="pnlAmortization">
        <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <ul class="nav nav-tabs nav-justified">       
              <li class="active">
                  <a href="#schedule" id="amortschedule" onclick="javascript:fnSetTab('amortschedule');" data-toggle="tab" style="padding-bottom:28px">
                      Amortization Schedule
                  </a>
              </li>
 
          </ul>
        </header>    
        
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="schedule">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8">
                               <%-- --<cc1:XUILinkButton ID="btnDeleteDetail" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteDetail_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>--%>
                            </div>
                            <div class="col-sm-4">
                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">      
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                           </div>
                     </asp:Panel>
                    </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwList_PageIndexChanging" EmptyDataText="There Is No Data" Width="100%">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                          <%--  <asp:TemplateField>
                                <HeaderTemplate>
                                     <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField DataField="PERIOD" HeaderText="Period">
                                <ItemStyle Width="30%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="AMORTIZATION_DATE" HeaderText="Amortization Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="35%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ACCRUED_AMOUNT" HeaderText="Accrue Amount" DataFormatString="{0:N0}">
                                <ItemStyle Width="35%" HorizontalAlign="Right"  />
                            </asp:BoundField>
                           <%-- <asp:CommandField ShowSelectButton="true" />--%>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <%--<asp:AsyncPostBackTrigger ControlID="btnDeleteDetail" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
        </div>
                 
            </div>
        </div>
  <%--  </section>--%>
    </asp:Panel>
</asp:Content>
