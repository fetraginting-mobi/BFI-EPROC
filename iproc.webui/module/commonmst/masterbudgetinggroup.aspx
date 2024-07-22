<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterbudgetinggroup.aspx.cs" Inherits="module_commonmst_masterbudgetinggroup" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Budgeting Group Info</span>
        </header>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R60000070E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                   
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                   <%--  <cc1:XUILinkButton ID="btnUpload" RoleCode="R80000010O" runat="server" CssClass="btn btn-primary" OnClick="btnUpload_Click" ><i class="icon-save"></i>  Upload</cc1:XUILinkButton>--%>
                </div>
                  <div class="col-sm-4">    
                    <span>Upload Excel : </span>
                        <asp:FileUpload ID="FileUploadControlAmort" runat="server"/>
                        <cc1:XUIButton ID="btnUploadRowFormat" runat="server" CssClass="btn btn-primary" Text="Upload" OnClick="btnUploadRowFormat_Click"
                             Style="width: auto;" />       
                        <cc1:XUIButton ID="btnDownload" runat="server" Text="Download Template" CssClass="btn btn-primary" OnClick="btnDownload_Click" />

                </div>
            </div>
            
            
        </div>
        <div class="panel-body form-horizontal">
           <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
            <cc1:XUILabel ID="lblId" runat="server"  DBColumnName="CODE" SPParameterName="p_code" DataType="String" BindType="Both" Text="0" style="display:none" ></cc1:XUILabel>          
            <cc1:XUILabel ID="lblBranchCode" runat="server"  DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" Text="0" style="display:none" ></cc1:XUILabel>          
                    
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Branch</label>
                                <div class="col-sm-4">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <asp:UpdatePanel ID="updDiv" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE"  SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="revddlDivision" runat="server" ControlToValidate="ddlDivision"
                                                 ErrorMessage="Value Required!" InitialValue="-"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                    <div class="col-sm-6">
                                        <asp:UpdatePanel ID="updDep" runat="server">
                                            <ContentTemplate>
                                                <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                       <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlDivision" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                     </asp:UpdatePanel> 
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                           <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Sub Department</label>
                            <div class="col-sm-6">
                               <asp:UpdatePanel ID="updSub" runat="server">
                                 <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlSubDepartment" runat="server" CssClass="form-control" DBColumnName="SUB_DEPARTMENT_CODE" SPParameterName="p_sub_department_code" OnSelectedIndexChanged= "ddlSubDepartment_SelectedIndexChanged" AutoPostBack="true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvddlSubDepartment" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                 </ContentTemplate>
                                 <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="ddlDepartment" EventName="SelectedIndexChanged" />
                                 </Triggers>
                               </asp:UpdatePanel>
                            </div>
                         </div>                            
                      </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Units</label>
                                <div class="col-sm-6">
                                    <asp:UpdatePanel ID="updUn" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlUnits" runat="server" CssClass="form-control" DBColumnName="UNITS_CODE" SPParameterName="p_units_code"  DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="rfvddlUnits" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUnits" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                           <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlSubDepartment" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Year *</label>                             
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtYear" runat="server"  CssClass="form-control" placeholder="Year" DBColumnName="YEAR" SPParameterName="p_year" MaxLength="4" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revYear" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtYear" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvYear" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtYear" Display="Dynamic"></asp:RequiredFieldValidator>   
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Group Level</label>
                                <div class="col-sm-4">
                                    <cc1:XUIDropDownList ID="ddlGroupLevel" runat="server" CssClass="form-control" DBColumnName="GROUP_LEVEL" SPParameterName="p_group_level" DataType="Integer" BindType="Both"></cc1:XUIDropDownList>                     
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
        
        <asp:Panel runat="server" ID="pnlAllBudget">
        <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
        <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#Qty" id="Item" onclick="javascript:fnSetTab('Qty');" style="padding-bottom:28px" data-toggle="tab" >
                      Quantity
                  </a>
              </li>
               <li class="">
                  <a href="#Itm" id="Item" onclick="javascript:fnSetTab('Item');" style="padding-bottom:28px" data-toggle="tab" >
                      Amount
                  </a>
              </li>
          </ul>
        </header>
        
        <div class="panel-body"> 
       <div class="tab-content tasi-tab">
              <div class="tab-pane active" id="Qty">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton RoleCode="R60000070E" ID="btnAddGroup" runat="server" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                             <cc1:XUILinkButton RoleCode="R60000070E" ID="btnSaveQty" runat="server" CssClass="btn btn-primary" OnClick="btnSaveQty_Click"  CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                             <cc1:XUILinkButton RoleCode="R60000070E" ID="btnRevisiQty" runat="server" CssClass="btn btn-primary" OnClick="btnRevisiQty_Click"  CausesValidation="false"><i class="icon-save"></i>  Revisi</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDeleteQty" RoleCode="R60000070E" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteQty_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                        </div>
                        
                            <div class="col-sm-4">
                            </div>
                        <asp:Panel ID="pnlSearchQty" runat="server" DefaultButton="btnSearchQty" class="input-group">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearchQty" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchQty" runat="server" CssClass="btn btn-info" OnClick="btnSearchQty_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdQty" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListQty" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                 AllowPaging="true" PageSize="10" DataKeyNames="CODE, ITEM_GROUP_CODE"
                                OnPageIndexChanging="gvwListQty_PageIndexChanging"
                                OnRowDataBound="gvwListQty_OnRowDataBound"  EmptyDataText="There is no data">
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
                                            <asp:CheckBox runat="server" ID="chbCheckedAllQty" AutoPostBack="true" OnCheckedChanged="chbCheckedAllQty_CheckedChanged"/>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chbCheckedQty"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   <asp:BoundField DataField="ITEM_GROUP_NAME" HeaderText="Group Name">
                                            <ItemStyle Width="8%"/>
                                        </asp:BoundField>
                                   <asp:TemplateField HeaderText="Use">
                                        <ItemStyle Width="2%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbUse" runat="server" DBColumnName="IS_USE" SPParameterName="p_is_use" DataType="String" BindType="Both" />                               
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                         <HeaderTemplate>
                                            <span>Month</span>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table cellpadding="0px" cellspacing="0px" width="100%" class="display table table-bordered table-striped">
                                                <tr>
                                                    <td width="5%">
                                                        JAN
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_JAN_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyJan" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyJan" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyJan" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        FEB
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_FEB_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyFeb" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyFeb" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyFeb" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        MAR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_MAR_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyMar" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyMar" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyMar" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        APR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_APR_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyApr" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyApr" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyApr" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        MAY
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_MAI_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyMay" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyMay" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyMay" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        JUN
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_JUN_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyJun" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyJun" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyJun" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        JUL
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_JUL_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyJul" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyJul" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyJul" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        AUG
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_AGT_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyAug" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyAug" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyAug" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        SEP
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_SEP_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtySept" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtySept" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtySept" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        OCT
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_OKT_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyOct" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyOct" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyOct" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        NOV
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_NOV_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyNov" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyNov" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyNov" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        DEC
                                                    </td> 
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_DES_QTY","{0:N2}") %>'  style="text-align:right;" ID="txtQtyDes" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revQtyDes" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQtyDes" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>  
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <ItemStyle Width="90%" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchQty" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnDeleteQty" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
                              
           
              <div class="tab-pane" id="Itm">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-4" >
                                <!-- Subscription pop up here-->
                                <cc1:XUILinkButton RoleCode="R60000070E" ID="btnSaveItm" runat="server" CssClass="btn btn-primary" OnClick="btnSaveItm_Click"  CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R60000070E" ID="btnRevisiItm" runat="server" CssClass="btn btn-primary" OnClick="btnRevisiItm_Click"  CausesValidation="false"><i class="icon-save"></i>  Revisi</cc1:XUILinkButton>
                                <cc1:XUILinkButton ID="btnDeleteItm" RoleCode="R60000070E" runat="server" CssClass="btn btn-danger" onclick="btnDeleteItm_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>                                      
                            </div>
                            <div class="col-sm-4">
                            </div>
                            <div class="col-sm-4">
                                <asp:Panel ID="pnlSearchItm" runat="server" DefaultButton="btnSearchItm" class="input-group">
                                   
                                    <asp:TextBox ID="txtSearchItm" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchItm" runat="server" CssClass="btn btn-info" OnClick="btnSearchItm_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updItm" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListItm" runat="server" 
                                    AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListItm_PageIndexChanging" 
                                    OnRowDataBound="gvwListItm_OnRowDataBound"
                                    DataKeyNames="CODE, ITEM_GROUP_CODE" EmptyDataText="There is no data">
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
                                                <asp:CheckBox runat="server" ID="chbCheckedAllItm" AutoPostBack="true" OnCheckedChanged="chbCheckedAllItm_CheckedChanged"/>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chbCheckedItm"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ITEM_GROUP_NAME" HeaderText="Group Name">
                                            <ItemStyle Width="8%"/>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Use">
                                        <ItemStyle Width="2%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbUseAmount" runat="server" DBColumnName="IS_USE_AMOUNT" SPParameterName="p_is_use_amount" DataType="String" BindType="Both" />                               
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField>
                                         <HeaderTemplate>
                                            <span>Month</span>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table cellpadding="0px" cellspacing="0px" width="100%" class="display table table-bordered table-striped">
                                                <tr>
                                                    <td width="5%">
                                                        JAN
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_JAN_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtJan" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtJan" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtJan"  ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator> 
                                                    </td>
                                                    <td width="5%">
                                                        FEB
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_FEB_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtFeb" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtFeb" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtFeb" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td width="5%">
                                                        MAR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_MAR_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtMar" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtMar" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtMar" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td width="5%">
                                                        APR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_APR_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtApr" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtApr" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtApr" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        MAY
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_MAI_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtMei" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtMei" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtMei" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td width="5%">
                                                        JUN
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_JUN_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtJun" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtJun" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtJun" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td width="5%">
                                                        JUL
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_JUL_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtJul" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtJul" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtJul" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td width="5%">
                                                        AUG
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_AGT_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtAgust" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtAgust" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtAgust" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        SEP
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_SEP_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtSept" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtSept" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtSept" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td width="5%">
                                                        OCT
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_OKT_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtOkt" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtOkt" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtOkt" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td width="5%">
                                                        NOV
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_NOV_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtNov" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtNov" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtNov" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td width="5%">
                                                        DEC
                                                    </td> 
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_DES_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="txtAmtDes" MaxLength="15" CssClass="form-control"/>
                                                        <asp:RegularExpressionValidator ID="revAmtDes" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmtDes" ValidationExpression="[0-9 ,./()+]*[0-9 ,./()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                                    </td>  
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <ItemStyle Width="90%" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                  </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchItm" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteItm" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
    </section>
      </asp:Panel>
</asp:Content>

