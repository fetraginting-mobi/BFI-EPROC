<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masterbudgetinggroupinquiry.aspx.cs" Inherits="module_commonmst_masterbudgetinggroupinquiry" Title="Untitled Page" %>

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
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                   <%--  <cc1:XUILinkButton ID="btnUpload" RoleCode="R80000010O" runat="server" CssClass="btn btn-primary" OnClick="btnUpload_Click" ><i class="icon-save"></i>  Upload</cc1:XUILinkButton>--%>
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
                                OnPageIndexChanging="gvwListQty_PageIndexChanging" EmptyDataText="There is no data">
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
                                            <ItemStyle Width="10%"/>
                                        </asp:BoundField>
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
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_JAN_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyJan" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        FEB
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_FEB_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyFeb" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        MAR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_MAR_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyMar" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        APR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_APR_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyApr" CssClass="form-control"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        MAY
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_MAI_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyMay" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        JUN
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_JUN_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyJun" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        JUL
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_JUL_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyJul" CssClass="form-control"/>
                                                        
                                                    </td>
                                                    <td width="5%">
                                                        AUG
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_AGT_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyAug" CssClass="form-control"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        SEP
                                                    </td>
                                                    <td width="10%">
                                                        <asp:TextBox runat="server" Text='<%# Eval("BUDGET_SEP_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtySept" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        OCT
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_OKT_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyOct" CssClass="form-control"/> 
                                                    </td>
                                                    <td width="5%">
                                                        NOV
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_NOV_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyNov" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        DEC
                                                    </td> 
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_DES_QTY","{0:N2}") %>'  style="text-align:right;" ID="lblQtyDes" CssClass="form-control"/>
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
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
                              
           
              <div class="tab-pane" id="Itm">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-4" >
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
                                            <ItemStyle Width="10%"/>
                                        </asp:BoundField>
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
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_JAN_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtJan" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        FEB
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_FEB_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtFeb" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        MAR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_MAR_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtMar" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        APR
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_APR_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtApr" CssClass="form-control"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        MAY
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_MAI_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtMei" CssClass="form-control"/>
                                                         
                                                    </td>
                                                    <td width="5%">
                                                        JUN
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_JUN_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtJun" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        JUL
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_JUL_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtJul" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        AUG
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_AGT_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtAgust" CssClass="form-control"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                        SEP
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_SEP_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtSept" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        OCT
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_OKT_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtOkt" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        NOV
                                                    </td>
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_NOV_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtNov" CssClass="form-control"/>
                                                    </td>
                                                    <td width="5%">
                                                        DEC
                                                    </td> 
                                                    <td width="10%">
                                                        <asp:Label runat="server" Text='<%# Eval("BUDGET_DES_AMOUNT","{0:N2}") %>'  style="text-align:right;" ID="lblAmtDes" CssClass="form-control" />
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
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
    </section>
      </asp:Panel>
</asp:Content>

