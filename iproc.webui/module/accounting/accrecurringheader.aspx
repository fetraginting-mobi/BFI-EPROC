<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accrecurringheader.aspx.cs" Inherits="module_accounting_accrecurringheader" Title="Untitled Page" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
<section class="panel">
        <header class="panel-heading">
            <div class="row">
                <div class="col-sm-11">
                <span>Recurring Info</span>
                </div>
                <div class="col-sm-1"> 
                    <asp:Label ID="lblLocked" runat="server" Visible="false" CssClass="icon-lock icon-2x"></asp:Label>
                </div>
            </div>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="ACC010400U" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <asp:LinkButton ID="btnGenerate" runat="server" CssClass="btn btn-success" OnClick="btnGenerate_Click" CausesValidation="false"><i class="icon-remove"></i>  Generate</asp:LinkButton>
                    <asp:LinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
         <asp:UpdatePanel ID="upd" runat="server">
             <ContentTemplate>
                 <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3 ">No.</label>
                            <div class="col-sm-8">
                                <cc1:XUILabel ID="lblRecNo" runat="server" DBColumnName="RECURRING_NO" SPParameterName="p_recurring_no" DataType="String" BindType="Both"></cc1:XUILabel>                          
                            </div>
                        </div>
                    </div>
                 </div>
                 <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Branch</label>
                                <asp:RequiredFieldValidator ID="rfvBranch" runat="server" ErrorMessage="*" ControlToValidate="txtBranchCode" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="col-sm-9">
                                <div class="input-group"> 
                                    <asp:LinkButton ID="btnLookUpBranch" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                                    <cc1:XUITextBox ID="txtBranchCode" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" MaxLength="50" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtBranch" CssClass="form-control" runat="server" DBColumnName="BRANCH_NAME" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                </div> 
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Frequency</label>
                            <div class="col-sm-8">
                                <cc1:XUIDropDownList ID="ddlFrequency" runat="server" CssClass="form-control" DBColumnName="FREQUENCY" SPParameterName="p_frequency" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>                             
                 </div>
                 <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <div class="col-sm-3">
                                <label>Start Date</label>
                                <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ErrorMessage="*" ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revStartDate" runat="server" ControlToValidate="txtStartDate" ErrorMessage="*" ToolTip="Format Invalid" Display="Dynamic" ValidationExpression= "^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"></asp:RegularExpressionValidator>
                            </div>    
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtStartDate" runat="server" CssClass="form-control default-date-picker date-only number-only" DBColumnName="START_DATE" SPParameterName="p_start_date" MaxLength="8" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <div class="col-sm-3">
                                <label>End Date</label>
                                <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ErrorMessage="*" ControlToValidate="txtEndDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEndDate" runat="server" ControlToValidate="txtEndDate" ErrorMessage="*" ToolTip="Format Invalid" Display="Dynamic" ValidationExpression= "^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"></asp:RegularExpressionValidator>
                            </div>    
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtEndDate" runat="server" CssClass="form-control default-date-picker date-only number-only" DBColumnName="END_DATE" SPParameterName="p_end_date" MaxLength="8" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                 </div>
                 <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Voucher Type</label>
                            <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="txtDesc" ValidationExpression="^[\s\S]{0,500}$" ErrorMessage="Exceed maximum length" Display="Dynamic"></asp:RegularExpressionValidator>
                            <div class="col-sm-4">
                                <cc1:XUIDropDownList ID="ddlVoucherType" runat="server" CssClass="form-control" SPParameterName="p_voucher_type" DBColumnName="VOUCHER_TYPE" DataType="String" BindType="Both">
                                <asp:ListItem Value="PV">Payment Voucher</asp:ListItem>
                                <asp:ListItem Value="RV">Receipt Voucher</asp:ListItem>
                                <asp:ListItem Value="JV">Jurnal Voucher</asp:ListItem>                       
                            </cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-3">
                            <label>Flag</label>
                        </div>
                        <div class="col-sm-4">
                            <cc1:XUICheckBox ID="chbFlag" runat="server" DBColumnName="FLAG" SPParameterName="p_flag" DataType="String" BindType="Both"></cc1:XUICheckBox>
                        </div>
                    </div>                            
                    </div>
                </div>
                <div class="row">   
                <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-3">Description</label>
                            <asp:RegularExpressionValidator runat="server" ID="valtxtDesc" ControlToValidate="txtDesc" ValidationExpression="^[\s\S]{0,500}$" ErrorMessage="Exceed maximum length" Display="Dynamic"></asp:RegularExpressionValidator>
                            <div class="col-sm-9">
                                <cc1:XUITextBox ID="txtDesc" runat="server" CssClass="form-control" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="500" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                            </div>
                        </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-3">
                            <label>Is Active</label>
                        </div>
                        <div class="col-sm-4">
                            <cc1:XUICheckBox ID="chbIsActive" runat="server" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both"></cc1:XUICheckBox>
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
   
   <asp:Panel runat="server" ID="pnlDetail">
   <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">       
              <li class="active">
                  <a href="#detail" id="detaillist" onclick="javascript:fnSetTab('detaillist');" data-toggle="tab" style="padding-bottom:28px">
                      Detail
                  </a>
              </li>
              
              <li class="">
                  <a href="#schedule" id="schedulelist" onclick="javascript:fnSetTab('schedulelist');" data-toggle="tab" style="padding-bottom:28px">
                      Schedule
                  </a>
              </li> 
          </ul>
        </header>   
        
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="detail">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton RoleCode="" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                        </div>
                        <div class="col-sm-4 ">
                            <asp:Panel ID="pnlSearchDetail" runat="server" DefaultButton="btnSearchDetail"  class="input-group">
                                <asp:TextBox ID="txtSearchDetail" runat="server" CssClass="form-control"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchDetail" runat="server" CssClass="btn btn-info" OnClick="btnSearchDetail_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListDetail" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="CODE"
                                OnPageIndexChanging="gvwListDetail_PageIndexChanging" 
                                onselectedindexchanged="gvwListDetail_SelectedIndexChanged" EmptyDataText="There is no data" OnSorting="gvwListDetail_Sorting" AllowSorting="true">
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
                                    <asp:BoundField DataField="COA_NAME" HeaderText="Coa No." SortExpression="COA_NAME">
                                        <ItemStyle Width="30%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AMOUNT" HeaderText="Amount" SortExpression="AMOUNT">
                                        <ItemStyle Width="30%"  HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" SortExpression="DESCRIPTION">
                                        <ItemStyle Width="40%" HorizontalAlign="Left"  />
                                    </asp:BoundField>
                                    <asp:CommandField ShowSelectButton="true" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnSearchDetail" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                </div>
                <div class="tab-pane" id="schedule">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8 ">
                                
                            </div>
                            <div class="col-sm-4 ">
                                  <asp:Panel ID="pnlSearchSchedule" runat="server" DefaultButton="btnSearchSchedule" class="input-group">
                                       <asp:TextBox ID="txtSearchSchedule" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                       <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearchSchedule" runat="server" CssClass="btn btn-info" OnClick="btnSearchSchedule_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                       </div>
                                   </asp:Panel>
                             </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updSchedule" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListSchedule" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                    OnPageIndexChanging="gvwListSchedule_PageIndexChanging" EmptyDataText="There Is No Data">
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
                                        <%--<asp:BoundField DataField="CODE_BARCODE" HeaderText="PO No.">
                                            <ItemStyle Width="25%" HorizontalAlign="center" />
                                        </asp:BoundField>--%>
                                        <asp:BoundField DataField="BRANCH_NAME" HeaderText="Branch" >
                                            <ItemStyle Width="40%" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TRX_DATE" HeaderText="Trx Date" DataFormatString="{0:dd/MM/yyyy}">
                                            <ItemStyle Width="30%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="VOUCHER_NO" HeaderText="Voucher" >
                                            <ItemStyle Width="30%" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchSchedule" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </asp:Panel>
</asp:Content>

