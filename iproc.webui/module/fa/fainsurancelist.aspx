<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fainsurancelist.aspx.cs" Inherits="module_fa_fainsurancelist" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span> FA Asset List </span>
        </header>
         <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#faasset" id="asset"  onclick="javascript:fnSetTab('asset');"  data-toggle="tab">
                     FA Asset Non Insurance
                  </a>
              </li>
             <li class="">
                  <a href="#faassetnot" id="assetnot"  onclick="javascript:fnSetTab('assetnot');" data-toggle="tab">
                     FA Asset Policy Insurance Receipt
                  </a>
              </li>
              <li class="">
                  <a href="#faassetins" id="assetins"  onclick="javascript:fnSetTab('assetins');" data-toggle="tab">
                     FA Asset Insurance
                  </a>
              </li>
          </ul>
        </header>
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="faasset">
                    <header class="panel-heading">
                        <span></span>
                    </header>
            <div class="panel-heading">
            <div class="row">
                 <div class="col-sm-8">
                 <cc1:XUILinkButton ID="btnProcessInsurance" RoleCode="R90000086O" runat="server" CssClass="btn btn-primary" OnClick="btnProcessInsurance_Click" CausesValidation="false"><i  class="icon-envelope"></i> Regist Insurance</cc1:XUILinkButton>
                
                    <%--<asp:LinkButton ID="btnApprove" runat="server" CssClass="btn btn-primary" OnClick="btnApprove_Click"><i class="icon-ok"></i>  Approve</asp:LinkButton>--%>
                    <%--<cc1:XUILinkButton RoleCode="R07000006O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" CausesValidation="true" Visible="true"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>--%>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
             <%-- <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Status</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="AVAILABLE">AVAILABLE</asp:ListItem>
                                <asp:ListItem Value="SOLD">SOLD</asp:ListItem>
                                <asp:ListItem Value="DISPOSED">DISPOSED</asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
            </div>--%>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Cost Center</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                 <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Owner</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlOwnerNonIns" runat="server" CssClass="form-control" DBColumnName="OWNER" SPParameterName="p_owner_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlOwnerNonIns_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Period</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtFromDueDate" runat="server" CssClass="form-control default-date-picker-all" SPParameterName="p_start_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                        <label class="col-sm-1">-</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtToDueDate" runat="server" CssClass="form-control default-date-picker-all" SPParameterName="p_end_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>
              </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID,BARCODE,ASSET_TYPE,IDIN"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data">
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
                          
                        <%--    <asp:BoundField DataField="AST_CODE" HeaderText="Code">
                                <ItemStyle Width="10%" HorizontalAlign="center" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="BARCODE" HeaderText="Barcode">
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="AST_NAME" HeaderText="Asset Name">
                                <ItemStyle Width="30%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BRANCH_NAME" HeaderText="Cost Center">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="CURRENT_BRANCH" HeaderText="Location">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DATE_PURC" HeaderText="Purchase Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <%-- <asp:TemplateField HeaderText="Action">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                         <ItemTemplate>
                                        <asp:LinkButton ID="btnViewDocument" runat="server" CausesValidation="false" Text="View Asset"/>
                                        </ItemTemplate>
                            </asp:TemplateField>--%>
                           
                        <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /><%--
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
      </div>
      <div class="tab-pane" id="faassetnot">
                    <header class="panel-heading">
                        <span></span>
                    </header>
            <div class="panel-heading">
            <div class="row">
                 <div class="col-sm-8">
                 <cc1:XUILinkButton ID="btnProcess" RoleCode="R90000086O" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-save"></i> Receive Policy</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R60000090D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" style="Display:none;" ><i class="icon-trash" style="Display:none;"></i>Delete Insurance</cc1:XUILinkButton>
                    <%--<asp:LinkButton ID="btnApprove" runat="server" CssClass="btn btn-primary" OnClick="btnApprove_Click"><i class="icon-ok"></i>  Approve</asp:LinkButton>--%>
                    <%--<cc1:XUILinkButton RoleCode="R07000006O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" CausesValidation="true" Visible="true"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>--%>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtsearchnotin" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnsearchnotin" runat="server" CssClass="btn btn-info" OnClick="btnSearchnotin_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
             <%-- <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Status</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="AVAILABLE">AVAILABLE</asp:ListItem>
                                <asp:ListItem Value="SOLD">SOLD</asp:ListItem>
                                <asp:ListItem Value="DISPOSED">DISPOSED</asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
            </div>--%>
            <div class="row">
              
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Cost Center</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlcostcenternotin" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranchnotin_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                 <div class="col-sm-6">
                    <div class="form-group">
                        <div class="col-sm-6">    
                            <span>Insurance Input / Update By Upload Excel : </span>
                            <asp:FileUpload ID="FileUploadControlAmort" runat="server"/>
                            <cc1:XUIButton ID="btnUploadRowFormat" runat="server" CssClass="btn btn-primary" Text="Upload" OnClick="btnUploadRowFormat_Click"
                             Style="width: auto;" />       
                            <cc1:XUIButton ID="btnDownload" runat="server" Text="Download Template" CssClass="btn btn-primary" OnClick="btnDownload_Click" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Owner</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlOwnerIns" runat="server" CssClass="form-control" DBColumnName="OWNER" SPParameterName="p_owner_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlOwnerIns_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
              
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>
                </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListnotin" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID,BARCODE,ASSET_TYPE,IDIN"
                        OnPageIndexChanging="gvwListnotin_PageIndexChanging"  OnRowDataBound="gvwListnotin_RowDataBound"
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data">
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
                        <%--    <asp:BoundField DataField="AST_CODE" HeaderText="Code">
                                <ItemStyle Width="10%" HorizontalAlign="center" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="BARCODE" HeaderText="Barcode">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="AST_NAME" HeaderText="Asset Name">
                                <ItemStyle Width="14%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BRANCH_NAME" HeaderText="Cost Center">
                                <ItemStyle Width="6%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CURRENT_BRANCH" HeaderText="Location">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                           
                             <asp:TemplateField HeaderText="Policy Insurance No" SortExpression="POLICY_INSURANCE_NO">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("POLICY_INSURANCE_NO") %>' ID="txtPolicyNo" Height="35px" CssClass="form-control"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Insurance Company" SortExpression="POLICY_INSURANCE_COMPANY">
                                <ItemStyle Width="13%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("POLICY_INSURANCE_COMPANY") %>' ID="txtInsuranceCompany" Height="35px" CssClass="form-control"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Policy Start Date" SortExpression="POLICY_START_DATE">
                                <ItemStyle Width="12%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("POLICY_START_DATE", "{0:dd/MM/yyyy}") %>' ID="txtStartDate" Height="35px" CssClass="form-control default-date-picker-all date-only number-only"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Policy Date" SortExpression="POLICY_DUE_DATE">
                                <ItemStyle Width="12%" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Eval("POLICY_DUE_DATE", "{0:dd/MM/yyyy}") %>' ID="txtEndDate" Height="35px" CssClass="form-control default-date-picker date-only number-only"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Policy Premi">
                                    <ItemStyle Width="13%" HorizontalAlign="Right"/>
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Eval("POLICY_PREMIUM","{0:N2}") %>'  style="text-align:right;" ID="txtPolicyPremium" CssClass="form-control"/>
                                        <asp:RegularExpressionValidator ID="revPolicyPremium" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPolicyPremium" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                       <%-- <asp:RequiredFieldValidator ID="rfvApproveQtyPurchase" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQtyPurchase" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    </ItemTemplate>
                            </asp:TemplateField>
                            
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnsearchnotin" EventName="Click" /><%--
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
      </div>
    
     </div>
      <div class="tab-pane" id="faassetins">
                    <header class="panel-heading">
                        <span></span>
                    </header>
            <div class="panel-heading">
            <div class="row">
                 <div class="col-sm-8">
                 <cc1:XUILinkButton ID="btnUpdatePolicy" RoleCode="R90000086C" runat="server" CssClass="btn btn-primary" OnClick="btnProcessInsuranceAsset_Click" CausesValidation="false"><i  class="icon-envelope"></i> Change Policy</cc1:XUILinkButton>
                
                    <%--<asp:LinkButton ID="btnApprove" runat="server" CssClass="btn btn-primary" OnClick="btnApprove_Click"><i class="icon-ok"></i>  Approve</asp:LinkButton>--%>
                    <%--<cc1:XUILinkButton RoleCode="R07000006O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" CausesValidation="true" Visible="true"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>--%>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="Panel2" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtsearchins" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchIns" runat="server" CssClass="btn btn-info" OnClick="btnSearchIns_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
             <%-- <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-2">Status</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="AVAILABLE">AVAILABLE</asp:ListItem>
                                <asp:ListItem Value="SOLD">SOLD</asp:ListItem>
                                <asp:ListItem Value="DISPOSED">DISPOSED</asp:ListItem>
                            </cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
            </div>--%>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Cost Center</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlCostCenterIns" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                 <div class="col-sm-6">
                    <div class="form-group">
                    <label class="col-sm-3">Owner</label>
                        <div class="col-sm-5">
                          <cc1:XUIDropDownList ID="ddlOwnerList" runat="server" CssClass="form-control" DBColumnName="OWNER" SPParameterName="p_owner_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlOwnerList_SelectedIndexChanged" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListIns" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID,BARCODE,ASSET_TYPE,IDIN"
                        OnPageIndexChanging="gvwListIns_PageIndexChanging" 
                        onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data">
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
                          
                        <%--    <asp:BoundField DataField="AST_CODE" HeaderText="Code">
                                <ItemStyle Width="10%" HorizontalAlign="center" />
                            </asp:BoundField>--%>
                             <asp:BoundField DataField="BARCODE" HeaderText="Asset Barcode" >
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="AST_NAME" HeaderText="Asset Name" >
                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BRANCH_NAME" HeaderText="Cost Center">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CURRENT_BRANCH" HeaderText="Location">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                           
                            <asp:BoundField DataField="POLICY_INSURANCE_NO" HeaderText="Insurance No." >
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="POLICY_INSURANCE_COMPANY" HeaderText="Insurance Company" >
                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="POLICY_START_DATE" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="POLICY_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="POLICY_PREMIUM" HeaderText="Premium" DataFormatString="{0:N2}" >
                                <ItemStyle Width="10%" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <%-- <asp:TemplateField HeaderText="Action">
                                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                                         <ItemTemplate>
                                        <asp:LinkButton ID="btnViewDocument" runat="server" CausesValidation="false" Text="View Asset"/>
                                        </ItemTemplate>
                            </asp:TemplateField>--%>
                           
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchIns" EventName="Click" /><%--
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
      </div>
    </div> 
    </div>
    </section>
</asp:Content>

