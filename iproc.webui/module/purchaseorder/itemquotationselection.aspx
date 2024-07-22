<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="itemquotationselection.aspx.cs" Inherits="module_purchaseorder_itemquotationselection" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
    <script type="text/javascript">
        function unit()
        {
            var unit = document.getElementById('ctl00_cpb_unit');
            var ddlUnit = document.getElementById('ctl00_cpb_ddlUnitID');
            var ddlUnit = document.getElementById('ctl00_cpb_ddlPurposeDepartment');
            
            var txtItem = document.getElementById('ctl00_cpb_txtItemCode');
            
            
            if (txtItem.value == '')
            {
               unit.style.display = 'none';
               ddlUnit.style.display = 'none';
               ddlPurposeDepartment.display = 'none';
            }
            else
            {
               
                unit.style.display = 'inline';
                ddlUnit.style.display = 'inline';
                ddlPurposeDepartment.style.display = 'inline';
            }
        }
        function jsDoAfterLookUp()
        {
            unit();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                   <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_pr_code" BindType="UIToDBOnly"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">IR No.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblPRCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblPRStatus" runat="server" DBColumnName="PR_STATUS" style="display:none" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label>
                                <div class="col-sm-5">
                                     <cc1:XUILabel ID="lblStatusDetail" runat="server" DataType="String" DBColumnName="status" BindType="DBToUIOnly"></cc1:XUILabel>
                    
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item *</label>
                                <div class="col-sm-5">    
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both" onchange="javascript:unit();"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6" id="owner" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">Item Owner</label>
                                <div class="col-sm-5">
                                     <cc1:XUIDropDownList ID="ddlPurposeDepartment" runat="server" CssClass="form-control" DBColumnName="PURPOSE_DEPARTMENT" SPParameterName="p_purpose_department" DataType="String" BindType="Both" Enabled="false" >
                                       <%-- <asp:ListItem Text="LOGISTIC" Value="LOGISTIC"></asp:ListItem>
                                        <asp:ListItem Text="INFRA DEV" Value="INFRA DEV"></asp:ListItem>
                                        <asp:ListItem Text="PROMOTION" Value="PROMOTION"></asp:ListItem>
                                        <asp:ListItem Text="INTERN CABANG" Value="INTERN CABANG"></asp:ListItem>--%>
                                     </cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Quantity *</label>  
						        <div class="col-sm-3">
                                    <cc1:XUILabel ID="lblQuantity" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="QUANTITY" SPParameterName="p_quantity" DataType="Number" BindType="Both" Format="N2" Text="0.00" MaxLength="6"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblApproveQuantity" runat="server" style="display:none"  CssClass="form-control" placeholder="Quantity" DBColumnName="APPROVE_QUANTITY" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUILabel>   
                                </div>
                            </div>
                        </div> 
                        <div class="col-sm-6" id="unit" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">UOM</label>
                                <div class="col-sm-4">                                    
                                    <cc1:XUIDropDownList ID="ddlUnitID" runat="server" CssClass="form-control" DBColumnName="UNIT_CODE" SPParameterName="p_unit_code" DataType="String" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                               </div>
                            </div>                               
                        </div>
                    </div>  
                    <div class="row" id="appqty" runat="server">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Approve Quantity</label>  
						        <div class="col-sm-3">
						            <cc1:XUILabel ID="lblAppQty" runat="server"  DBColumnName="APPROVE_QUANTITY" DataType="String" BindType="Both" SPParameterName="p_approve_quantity"  Text="0"></cc1:XUILabel>  
                                </div>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                        </div>
                    </div> 
                    <div class="row">  
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Specification *</label>
                                <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblSpecification" runat="server"  placeholder="Specification" DBColumnName="SPECIFICATION" SPParameterName="p_specification" DataType="String" BindType="Both" ></cc1:XUILabel>
                                </div>
                            </div>                            
                      </div>
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>                             
                                <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblDescription" runat="server"  CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" DataType="String" BindType="Both" ></cc1:XUILabel>
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
    <asp:Panel runat="server" ID="pnlItemList">
        <section class="panel">
            <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                <ul class="nav nav-tabs nav-justified">
                  <li class="active">
                      <a href="#HistoryList" id="history" onclick="javascript:fnSetTab('history');" data-toggle="tab" >
                          History Approval by Item
                      </a>
                  </li>
                </ul>
            </header>
            <div class="panel-body"> 
                <div class="tab-content tasi-tab">
                    <div class="tab-pane active" id="ItemList">
                        <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                 
                                <cc1:XUILinkButton RoleCode="" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                              <%--  <cc1:XUILinkButton RoleCode="" ID="btnDelete" runat="server" CssClass="btn btn-danger"  OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>--%>
                            </div>
                        <div class="col-sm-4 ">
                            <asp:Panel ID="pnlSearchList" runat="server" DefaultButton="btnSearch" class="input-group">
                                <asp:TextBox ID="txtSearchList" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search" ></i> Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>   
                </div>                   
                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID" OnRowDataBound="gvwList_RowDataBound"
                                OnPageIndexChanging="gvwList_PageIndexChanging" EmptyDataText="There is no data" Width="100%" >
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
                                    <asp:TemplateField HeaderText="Status">
                                      <ItemStyle Width="40%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control input-sm" >
                                                <asp:ListItem Value="APPROVED" Selected="True">APPROVED</asp:ListItem>
                                                <asp:ListItem Value="RETURNED" >RETURNED</asp:ListItem>
                                            </asp:DropDownList> 
                                        </ItemTemplate>
                                    </asp:TemplateField>                            
                                  <%--  <asp:TemplateField HeaderText="Remarks">
                                      <ItemStyle Width="40%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <cc1:XUITextBox runat="server" ID="txtRemarks" Text='<%# Eval("REMARKS") %>' CssClass="form-control input-sm" >
                                            </cc1:XUITextBox> 
                                        </ItemTemplate>
                                    </asp:TemplateField> --%>
                                    <asp:BoundField DataField="MOD_DATE" HeaderText="Status Date" DataFormatString="{0:dd/MM/yyyy hh:mm}" >
                                        <ItemStyle Width="20%" HorizontalAlign="Center"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="EMP_NAME" HeaderText="Approver" >
                                        <ItemStyle Width="40%" HorizontalAlign="Left"/>
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                    </div>
                    </div>
             
                </div>
            </div>
        </section>
    </asp:Panel>
</asp:Content>

