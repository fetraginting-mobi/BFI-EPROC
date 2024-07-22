<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" 
CodeFile="~/module/purchaseorder/purchaserequestdetail.aspx.cs" Inherits="module_purchaseorder_purchaserequestdeatil" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <script type="text/javascript">
//        function unit()
//        {
//            var unit = document.getElementById('ctl00_cpb_unit');
//           // var ddlUnit = document.getElementById('ctl00_cpb_ddlUnitID');
//           // var ddlUnit = document.getElementById('ctl00_cpb_ddlPurposeDepartment');
//            
//            var txtItem = document.getElementById('ctl00_cpb_txtItemCode');
//            
//            
//            if (txtItem.value == '')
//            {
//               unit.style.display = 'none';
//              // ddlUnit.style.display = 'none';
//               ddlPurposeDepartment.display = 'none';
//            }
//            else
//            {
//               
//                unit.style.display = 'inline';
//               // ddlUnit.style.display = 'inline';
//                ddlPurposeDepartment.style.display = 'inline';
//            }
 //       }
        function jsDoAfterLookUp()
        {
            //unit();
            __doPostBack('ctl00$cpb$txtItemCode', '');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12">
                   <cc1:XUILinkButton ID="btnSave" RoleCode="R50000010E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0"></cc1:XUILabel>
                    <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_pr_code" BindType="UIToDBOnly"></cc1:XUILabel>
                      <cc1:XUILabel ID="lblRounding" runat="server" DataType="String" DBColumnName="ROUNDING" style="display:none;"  BindType="DBToUIOnly"></cc1:XUILabel>
                    
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">IR No.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblPRCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblPRStatus" runat="server" DBColumnName="PR_STATUS" style="display:none" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                </div>
                                 <div class="col-sm-2">
                                      <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Request Status"></cc1:XUILinkButton>
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
                                <div class="col-sm-6">    
                                    <asp:LinkButton runat="server" ID="btnLookUpItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both" AutoPostBack="true" OnTextChanged="txtItemCode_TextChanged"></cc1:XUITextBox>
                                      <cc1:XUITextBox ID="txtItemName" Enabled="false"  runat="server" DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" TextMode="MultiLine"  style="border:0; background:inherit;"></cc1:XUITextBox>
                                   <%-- <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  --%>
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6" id="owner" runat="server" style="display:none" >
                            <div class="form-group">
                                <label class="col-sm-4"></label>
                                <div class="col-sm-5">
                                    
                                      <cc1:XUITextBox ID="txtPurposeDepartment" style="display:none"  runat="server"  CssClass="form-control" DBColumnName="PURPOSE_DEPARTMENT" SPParameterName="p_purpose_department" DataType="String" Enabled="false" BindType="Both"></cc1:XUITextBox>
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
                                    <cc1:XUITextBox ID="txtQuantity" runat="server"  CssClass="form-control" placeholder="Quantity" DBColumnName="QUANTITY" SPParameterName="p_quantity" DataType="Number" BindType="Both" Format="N2" Text="0.00" MaxLength="6"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtApproveQuantity" runat="server" style="display:none"  CssClass="form-control" placeholder="Quantity" DBColumnName="APPROVE_QUANTITY" DataType="Number" BindType="DBToUIOnly" Format="N2"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblconversi" runat="server"  DBColumnName="CONVERSI" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>     
                                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuantity" InitialValue="0.00" Display="Dynamic"></asp:RequiredFieldValidator>                                
                                    <asp:RegularExpressionValidator ID="revQuantity" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQuantity" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>  
                                </div>
                            </div>
                        </div> 
                        <div class="col-sm-6" id="unit" runat="server">
                            <div class="form-group">
                               <label class="col-sm-4">UOM *</label>
                                <div class="col-sm-4">                                    
                                    <cc1:XUIDropDownList ID="ddlUnitID" runat="server" CssClass="form-control" DBColumnName="UNIT_CODE" SPParameterName="p_unit_code" DataType="String" BindType="Both"  ></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvddlUnitID" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUnitID" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                               </div>
                            </div>                               
                        </div>
                    </div>  
                    <div class="row" >
                        <div class="col-sm-6" id="appqty" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4">Approve Quantity</label>  
						        <div class="col-sm-3">
						            <cc1:XUILabel ID="lblAppQty" runat="server"  DBColumnName="APPROVE_QUANTITY" DataType="String" BindType="Both" SPParameterName="p_approve_quantity"  Text="0"></cc1:XUILabel>  
                                </div>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                               <label class="col-sm-4">Purchase By *</label>
                                  <div class="col-sm-4">
                                     <cc1:XUIDropDownList ID="ddlPurchaseBy" runat="server" CssClass="form-control" DBColumnName="BRANCH" SPParameterName="p_branch" BindType="Both" DataType="String">
                                       <asp:ListItem Value="0" Text="-=Select=-"></asp:ListItem>
                                        <asp:ListItem Text="HO" Value="HO"></asp:ListItem>
                                        <asp:ListItem Text="BRANCH" Value="BRANCH"></asp:ListItem>
                                     </cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="rfvPurchaseBy" runat="server" ErrorMessage="Required Field!"  InitialValue="0" ControlToValidate="ddlPurchaseBy" ></asp:RequiredFieldValidator>
                                </div>
                             </div>
                        </div>
                    </div>
                    <div class="row"> 
                          <div class="col-sm-6" >
                            <div class="form-group">
                                <label class="col-sm-4">Type Purchase</label>  
						        <div class="col-sm-3">
						            <cc1:XUILabel ID="lblType" runat="server"  DBColumnName="TYPE_PURCHASE" DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>  
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Is Review</label>  
						        <div class="col-sm-3">
						            <cc1:XUILabel ID="lblReview" runat="server"  DBColumnName="IS_REVIEW" DataType="String" BindType="DBToUIOnly"  ></cc1:XUILabel>  
                                </div>
                            </div>
                        </div>
                    </div> 
                    <div class="row">  
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Specification *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtSpecification" runat="server" CssClass="form-control" placeholder="Specification" DBColumnName="SPECIFICATION" SPParameterName="p_specification" MaxLength="4000" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="txtSpecification" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 4000" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvSpecification" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSpecification" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                      </div>
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>                             
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtDescription" runat="server"  CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="4000" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
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
                                <label class="col-sm-4">Remarks Unpost Procurement</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblRemaksUnpost" ForeColor = "Red" runat="server" DBColumnName="REMARKS_UNPOST" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                        
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
                                <%-- <cc1:XUILinkButton RoleCode="R50000010E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000010E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>--%>
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
                                AllowPaging="true" PageSize="10" DataKeyNames="ID" 
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
                                    </asp:TemplateField>                             
                                    <asp:BoundField DataField="FLAG_STATUS" HeaderText="Status">
                                        <ItemStyle Width="20%"/>
                                    </asp:BoundField> 
                                    <asp:BoundField DataField="REMARKS" HeaderText="Remarks">
                                        <ItemStyle Width="40%"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MOD_DATE" HeaderText="Status Date" DataFormatString="{0:dd/MM/yyyy hh:mm}" >
                                        <ItemStyle Width="20%" HorizontalAlign="Center"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="EMP_NAME" HeaderText="Approver" >
                                        <ItemStyle Width="20%" HorizontalAlign="Left"/>
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