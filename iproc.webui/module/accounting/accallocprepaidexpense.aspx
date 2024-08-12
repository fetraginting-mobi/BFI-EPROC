<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/iproc.master" CodeFile="accallocprepaidexpense.aspx.cs" Inherits="module_accounting_accallocprepaidexpense" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
            <span> Allocation Prepaid Expense Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <%--<cc1:XUILinkButton RoleCode="" ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print PDF</cc1:XUILinkButton>--%>
                      <cc1:XUILinkButton RoleCode="R12000168O" ID="btnApprovalTiered" Visible ="false" runat="server" CssClass="btn btn-success"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R12000168E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" ValidationGroup="validateprepaid"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R12000168O" ID="btnPost" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click" CausesValidation="false"><i class="icon-envelope"></i> Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton> 
                     <cc1:XUITextBox ID="txtEmpCode" style="display:none"  runat="server"  CssClass="form-control" DBColumnName="EMP_CODE"  DataType="String" BindType="UIToDBOnly"></cc1:XUITextBox>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:Panel ID="PnlHeader" runat="server" >
            <asp:UpdatePanel ID="updMain" runat="server">
                <ContentTemplate>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Transaction No</label>
                                <div class="col-sm-4">
                                 <cc1:XUILabel ID="lblTransactionNo" runat="server" DBColumnName="TRANSACTION_NO" SPParameterName="p_transaction_no" DataType="String"  BindType="Both" style="display:none;" Text="-"></cc1:XUILabel>
                                   <cc1:XUITextBox ID="txtTransactionNo" runat="server" CssClass="form-control" placeholder="" DBColumnName="TRANSACTION_NO" SPParameterName="p_transaction_no" MaxLength="15" DataType="String" BindType="Both" Enabled="false" style="border:0px; background:inherit" ></cc1:XUITextBox>
                                </div>
                                  <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></cc1:XUILinkButton>
                                 </div>
                            </div>                            
                        </div> 
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Branch *</label>
                                <div class="col-sm-6">
                                    <asp:LinkButton ID="btnLookUpBranch" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                                    <cc1:XUITextBox ID="txtBranchCode" runat="server" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblBranchCode" runat="server" DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly"  style="display:none"> </cc1:XUILabel>
                                    <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                       <asp:RequiredFieldValidator ID="rfvBranchCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBranchCode" ValidationGroup="validateprepaid" Display="Dynamic"></asp:RequiredFieldValidator>
                               <%--<cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH"  MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                                     <cc1:XUITextBox ID="txtItemCode" runat="server"   DBColumnName="ITEM_CODE" SPParameterName="p_item_code" MaxLength="10" DataType="String" BindType="Both" Style="display:none" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                        
                     </div>
                     <div class="row">
                       <div class="col-sm-6">
                            <div class="form-group">
                                <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                                <label class="col-sm-3">Invoice No</label>
                                <div class="col-sm-4">
                                  <div class="input-group"> 
                                    <asp:LinkButton ID="btnLookUpInvoiceNo" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                                     <cc1:XUITextBox ID="txtInvoiceNo" runat="server" CssClass="form-control" DBColumnName="INVOICE_NO" SPParameterName="p_invoice_no" MaxLength="20" DataType="String" BindType="Both" style="border:0px; background:inherit" ></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtInvoiceName" CssClass="form-control" runat="server" DBColumnName="INVOICE_NAME" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <%-- <cc1:XUIDropDownList ID="ddlBranchCode" runat="server" CssClass="form-control" DBColumnName="RV_BRANCH_CODE" SPParameterName="p_rv_branch_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>--%>
                                   </div>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Transaction Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtTransDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="Date" DBColumnName="TRANS_DATE" SPParameterName="p_trans_date" MaxLength="8" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvTransDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTransDate" ValidationGroup="validateprepaid" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revTransDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtTransDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                     </div>
                     <div class="row">
                       <%-- <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">COA No</label>
                                <asp:RequiredFieldValidator ID="rfvCoaNo" runat="server" ErrorMessage="*" ControlToValidate="txtACCNo" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-9">
                                <div class="input-group"> 
                                  <asp:LinkButton ID="btnLookupCOA" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                                    <cc1:XUITextBox ID="txtACCNo" runat="server" CssClass="form-control" DBColumnName="NO_COA" SPParameterName="p_acc_no" MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtACCName" CssClass="form-control" runat="server" DBColumnName="ACC_NAME" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                </div> 
                            </div>
                        </div>                            
                    </div>--%>
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" BindType="DBToUIOnly" DataType="String" ></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Description *</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" DBColumnName="DESCRIPTION" SPParameterName="p_description" BindType="Both" DataType="String" Display="Dynamic"  TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic" ValidationGroup="validateprepaid"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revDescription" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtDescription" ValidationGroup="validateprepaid" ValidationExpression="^([\sA-Za-z0-9]+)$" Display="Dynamic"></asp:RegularExpressionValidator>  
                                
                                </div>
                            </div>                            
                        </div>
                     </div>
                     <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Start Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtStartDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="Start Date" DBColumnName="START_DATE" SPParameterName="p_start_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtStartDate" ValidationGroup="validateprepaid" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revStartDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtStartDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" ValidationGroup="validateprepaid" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">End Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtEndDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="End Date" DBColumnName="END_DATE" SPParameterName="p_end_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtEndDate" ValidationGroup="validateprepaid" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revEndDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtEndDate" ValidationGroup="validateprepaid" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)"  Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Amount *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control" DBColumnName="AMOUNT" BindType="Both" SPParameterName="p_amount" DataType="Number" Display="Dynamic" Format="N2"  ></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAmount" runat="server" CssClass="form-control" Enabled="false" placeholder="" DBColumnName="AMOUNT" SPParameterName="p_amount" MaxLength="15" DataType="Number" Text="0.00" Format="N2" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmount" ValidationGroup="validateprepaid" Display="Dynamic"></asp:RequiredFieldValidator>
                               <asp:RegularExpressionValidator ID="revAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmount" ValidationGroup="validateprepaid" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                 </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Tenor (In Month)</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtTenor" runat="server" CssClass="form-control" DBColumnName="PERIOD" BindType="Both" SPParameterName="p_period" Enabled="false" DataType="Integer" Display="Dynamic" style="border:0px; background:inherit" ></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                     </div>
                     
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
       </asp:Panel>
        </div>
    </section>
    <asp:Panel runat="server" ID="pnlDetail">
    <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">       
              <li class="" runat="server" id="TabPencadangan">
                  <a href="#tabpencadanganlist" id="idpencadanganlist" onclick="javascript:fnSetTab('pencadanganlist');" data-toggle="tab" style="padding-bottom:28px">
                      Pencadangan Prepaid Detail List 
                  </a>
              </li>
              
              <li class="active" runat="server" id="TabAllocation">
                  <a href="#taballocList" id="idalloclist" onclick="javascript:fnSetTab('alloclist');" data-toggle="tab" style="padding-bottom:28px">
                      Allocation Prepaid Expense Detail List
                  </a>
              </li> 
              <li class="" runat="server" id="TabAmort">
                  <a href="#tabAmortList" id="idAmortlist" onclick="javascript:fnSetTab('Amortlist');" data-toggle="tab" style="padding-bottom:28px">
                      Amortization
                  </a>
              </li>
              <%--<li class="">
                  <a href="#UploadDoc" id="poupdoc" onclick="javascript:fnSetTab('poupdoc');" data-toggle="tab" style="padding-bottom:28px">
                       Upload Doc
                  </a>
              </li>--%>
          </ul>
        </header>    
        
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
               <div class="tab-pane" id="tabpencadanganlist">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8">
                                <cc1:XUILinkButton RoleCode="R12000168C" ID="btnAddPencadangan" runat="server" CssClass="btn btn-primary" OnClick="btnAddPencadangan_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R12000168D" ID="btnDeletePencadangan" runat="server" CssClass="btn btn-danger" OnClick="btnDeletePencadangan_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                <asp:Panel ID="pnlSearchPencadangan" runat="server" DefaultButton="btnSearchPencadangan" class="input-group">
                                    <asp:TextBox ID="txtSearchPencadangan" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchPencadangan" runat="server" CssClass="btn btn-info" OnClick="btnSearchPencadangan_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                       
                <asp:UpdatePanel ID="updPencadanganDetail" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListPencadanganDetail" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="100" DataKeyNames="ID,HEADER_NO"  ShowFooter="true"
                        OnPageIndexChanging="gvwListPencadanganDetail_PageIndexChanging" 
                        onselectedindexchanged="gvwListPencadanganDetail_SelectedIndexChanged" EmptyDataText="There is no data">
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
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblHeaderAccNo" Text="Acc No."></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="15%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblAccNo" Text='<%# Eval("ACC_NO") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblAccName" Text='<%# Eval("ACC_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" SortExpression="DESCRIPTION">
                                <ItemStyle Width="15%" HorizontalAlign="Left"/>
                                <ItemTemplate>
                                        <asp:Label runat="server" ID="lblDescription" Text='<%# Eval("DESCRIPTION") %>' TextMode="MultiLine"></asp:Label>
                                    <%--<asp:TextBox runat="server" Text='<%# Eval("INTERIM_INTEREST", "{0:N2}") %>' ID="txtInterimInterest" CssClass="form-control" style="text-align:right" MaxLength="20"/></asp:TextBox>--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DB_AMOUNT" HeaderText="Debit" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                             <asp:BoundField DataField="CR_AMOUNT" HeaderText="Credit" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RATE" HeaderText="Rate" DataFormatString="{0:N2}">
                                <ItemStyle Width="5%"  HorizontalAlign="Right" />
                                <FooterStyle Width="5%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BASE_AMOUNT_DB" HeaderText="Base Amount (D)" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BASE_AMOUNT_CR" HeaderText="Base Amount (C)" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                   <asp:AsyncPostBackTrigger ControlID="btnSearchPencadangan" EventName="Click" />
                   <asp:AsyncPostBackTrigger ControlID="btnDeletePencadangan" EventName="Click" />

                </Triggers>
                </asp:UpdatePanel>
                    </div>
                </div>
               <div class="tab-pane active" id="taballocList">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <cc1:XUILinkButton RoleCode="R12000168C" ID="btnAddAlloc" runat="server" CssClass="btn btn-primary" OnClick="btnAddAllocation_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R12000168D" ID="btnDeleteAlloc" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteAllocation_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchAlloc" runat="server" DefaultButton="btnSearchAlloc" class="input-group">
                                       <asp:TextBox ID="txtSearchAlloc" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchAlloc" runat="server" CssClass="btn btn-info" OnClick="btnSearchAllocation_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                                       </div>
                                   </asp:Panel>
                             </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updAlloc" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListAllocationDetail" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID,HEADER_NO"
                                    OnPageIndexChanging="gvwListAllocationDetail_PageIndexChanging" 
                                    onselectedindexchanged="gvwListAllocationDetail_SelectedIndexChanged" EmptyDataText="There Is No Data">
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
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblHeaderAccNo" Text="Acc No."></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="15%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblAccNo" Text='<%# Eval("ACC_NO") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblAccName" Text='<%# Eval("ACC_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" SortExpression="DESCRIPTION">
                                <ItemStyle Width="15%" HorizontalAlign="Left"/>
                                <ItemTemplate>
                                        <asp:Label runat="server" ID="lblDescription" Text='<%# Eval("DESCRIPTION") %>' TextMode="MultiLine"></asp:Label>
                                    <%--<asp:TextBox runat="server" Text='<%# Eval("INTERIM_INTEREST", "{0:N2}") %>' ID="txtInterimInterest" CssClass="form-control" style="text-align:right" MaxLength="20"/></asp:TextBox>--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DB_AMOUNT" HeaderText="Debit" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                             <asp:BoundField DataField="CR_AMOUNT" HeaderText="Credit" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RATE" HeaderText="Rate" DataFormatString="{0:N2}">
                                <ItemStyle Width="5%"  HorizontalAlign="Right" />
                                <FooterStyle Width="5%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BASE_AMOUNT_DB" HeaderText="Base Amount (D)" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BASE_AMOUNT_CR" HeaderText="Base Amount (C)" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                         </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchAlloc" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteAlloc" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            <div class="tab-pane" id="tabAmortList" >
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                <%--<cc1:XUILinkButton RoleCode="" ID="btngenerate"  runat="server" CssClass="btn btn-success" data-toggle="modal" CausesValidation="false" OnClick="btnAmortization_Click"><i class="icon-plus"></i>  Generate Amortization</cc1:XUILinkButton>--%>
                                <%--<cc1:XUILinkButton RoleCode="" ID="btnDeleteAmortization" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteAmortization_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>--%>
                                   <asp:LinkButton RoleCode="R12000168E" ID="btngenerate"  runat="server" CssClass="btn btn-success" OnClick="btnAmortization_Click" CausesValidation="false"><i class="icon-plus"></i> Generate Amortization</asp:LinkButton>
                                      
                                   </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchAmort" runat="server" DefaultButton="btnSearcAmortization" class="input-group">
                                       <asp:TextBox ID="txtSearchAmortization" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearcAmortization" runat="server" CssClass="btn btn-info" OnClick="btnSearchAmortization_Click" CausesValidation="false"><i class="icon-search"></i> Search</asp:LinkButton>
                                       </div>
                                   </asp:Panel>
                             </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updAmort" runat="server">
                            <ContentTemplate>
                               <asp:GridView ID="gvwListAmortizationDetail" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID,HEADER_NO"
                                    OnPageIndexChanging="gvwListAmortizationDetail_PageIndexChanging" OnRowDataBound="gvwListAmortizationDetail_RowDataBound"
                                    EmptyDataText="There Is No Data">
                                    <Columns>
                             <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                            <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                            </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField DataField="Period" HeaderText="Period" >
                                <ItemStyle Width="30%"  HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="AMORTIZATION_DATE" HeaderText="Amortization Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="25%"  HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AMORTIZATION_AMOUNT" HeaderText="Accrue Amount" DataFormatString="{0:N2}">
                                <ItemStyle Width="25%"  HorizontalAlign="Right" />
                               </asp:BoundField>
                               <asp:BoundField DataField="STATUS" HeaderText="Status">
                                <ItemStyle Width="20%"  HorizontalAlign="Center" />
                            </asp:BoundField>
                               <%--
                            <asp:CommandField ShowSelectButton="true" />--%>
                        </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearcAmortization" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                   </div>
                    
                </div>
             </div>
          </section>
      </asp:Panel>
</asp:Content>