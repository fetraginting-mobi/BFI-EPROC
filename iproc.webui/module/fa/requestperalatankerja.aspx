<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="requestperalatankerja.aspx.cs" Inherits="module_fa_requestperalatankerja" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Request Peralatan Kerja Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R90000131C" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="false"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R90000131O" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click" ><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPrint" RoleCode="R90000131P" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print Tanda Terima</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="R90000131C" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false" Visible="true"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnBack" RoleCode="R90000131C" runat="server" CssClass="btn btn-danger" OnClick="btnBack_Click" CausesValidation="false"><i class="icon-remove"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Request No.</label> 
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblRequestNo" runat="server" DBColumnName="REQUEST_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                        
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="Both" SPParameterName="p_status" Text="NEW"></cc1:XUILabel>
                                     <cc1:XUITextBox ID="txtEmpCode" style="display:none"  runat="server"  CssClass="form-control" DBColumnName="EMP_CODE"  DataType="String" BindType="UIToDBOnly"></cc1:XUITextBox>
                                    
                                </div>
                            </div>                             
                        </div>                
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Request Date</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtReqDate" runat="server" CssClass="form-control default-date-picker" placeholder="Sale Date" DBColumnName="REQUEST_DATE" SPParameterName="p_request_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvReqDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReqDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revReqDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtReqDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                          <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpBranch"  class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtBranchCode" style="display:none"  runat="server"  CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblBranchName" runat="server"  DBColumnName="BRANCH_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvBranchName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBranchCode" ></asp:RequiredFieldValidator>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                <div class="col-sm-8">                                    
                                    <cc1:XUILabel ID="lblDepartment" runat="server"  DBColumnName="DEPARTMENT" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                </div>
                            </div>
                         </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Staff</label>
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpStaff"  class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtStaffCode" style="display:none"  runat="server"  CssClass="form-control" DBColumnName="STAFF" SPParameterName="p_staff" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <%--<cc1:XUILabel ID="lblStaffCode" runat="server"  DBColumnName="STAFF" DataType="String" BindType="Both"></cc1:XUILabel>--%>
                                    <%--<cc1:XUILabel ID="lblRequestorName" runat="server"  DBColumnName="REQUESTOR_DESC" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>--%>
                                    <cc1:XUILabel ID="lblStaffName" runat="server"  DBColumnName="EMP_NAME" DataType="String" BindType="DBToUIOnly" Text="-" Height="40"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvStaffName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtStaffCode" ></asp:RequiredFieldValidator>
                                    <%--<cc1:XUILabel ID="lblBranchCode" runat="server"  DBColumnName="BRANCH_CODE" DataType="String"  Text="--" Visible="false"></cc1:XUILabel>--%>
                                </div>
                            </div>                             
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Units</label>
                                <div class="col-sm-8">                                    
                                    <cc1:XUILabel ID="lblUnits" runat="server"  DBColumnName="UNITS" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblDivision" runat="server"  DBColumnName="DIVISION" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>                
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-6">
                                     <cc1:XUITextBox ID="txtRemarks" runat="server" Width="250px" DBColumnName="REMARKS" BindType="Both" DataType="String" SPParameterName="p_remarks" CssClass="form-control" TextMode="MultiLine"  style="border:1; background:inherit;"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Position</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblPosition" runat="server"  DBColumnName="POSITION" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>                
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-6">
                                </div>
                            </div>
                         </div>
                         <asp:Panel runat="server" ID="pnlupload">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Tanda Terima *</label>
                                <div class="col-sm-4">
                                    <cc1:XUILabel ID="lblReceipt" runat="server" DBColumnName="RECEIPT" BindType="Both" DataType="String" SPParameterName="p_receipt" Visible="true"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblPaths" runat="server" DBColumnName="PATHS" BindType="Both" DataType="String" SPParameterName="p_paths" Visible="false"></cc1:XUILabel>                                    
                                </div>
                                <div class="col-sm-2">
                                    <cc1:XUILinkButton RoleCode="R80000010E" ID="btnPreview" runat="server" CssClass="btn btn-warning" CausesValidation="false" OnClick="btnPreview_Click" ToolTip="View invoice"><i class="icon-eye-open"></i></cc1:XUILinkButton>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-8">
                                        
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:FileUpload ID="fuInvoice" runat="server"/>
                                    </div>
                                </div>
                            </div> 
                         </div>
                         </asp:Panel>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created</label>
                                <div class="col-sm-6">
                                     <cc1:XUILabel ID="lblCreated" runat="server"  DBColumnName="CRE_BY" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Modified</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblModified" runat="server"  DBColumnName="MOD_BY" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>                
                    </div>             
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    <asp:Panel runat="server" ID="pnl">
    <section class="panel">
        <header class="panel-heading">
          <span>Item</span>
        </header>
        <%--<header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">       
              <li class="active" runat="server" id="liInvoice">
                  <a href="#item" id="itemlist" onclick="javascript:fnSetTab('itemlist');" data-toggle="tab" style="padding-bottom:28px">
                      Item
                  </a>
              </li>
             <li id="Li1" class="" runat="server">
                  <a href="#list" id="A1" onclick="javascript:fnSetTab('list');" data-toggle="tab" style="padding-bottom:28px">
                      List
                  </a>
              </li>
          </ul>
        </header>--%>
        <div class="tab-content tasi-tab">
            <div class="tab-pane active" id="item">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton ID="btnAdd" RoleCode="R90000131C" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDelete" RoleCode="R90000131D" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click" Visible="true"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                        </div>
                        <div class="col-sm-4">
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
                    <asp:UpdatePanel ID="upd" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                OnPageIndexChanging="gvwList_PageIndexChanging"
                                onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There is no data" Width="100%" >
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
                                    <asp:BoundField DataField="ID" HeaderText="ID" Visible="false">
                                        <ItemStyle Width="0%"/>
                                    </asp:BoundField>                           
                                    <asp:BoundField DataField="ITEM_CODE" HeaderText="Asset Code">
                                        <ItemStyle Width="40%"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ITEM_NAME" HeaderText="Asset Name">
                                        <ItemStyle Width="60%"/>
                                    </asp:BoundField>
                                    <%--<asp:BoundField DataField="QTY" HeaderText="Qty" DataFormatString="{0:N2}">
                                        <ItemStyle Width="10%" HorizontalAlign="Right"/>
                                    </asp:BoundField>--%>
                                    <asp:CommandField ShowSelectButton="true" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <%--<asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />--%>
                            <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </section>
    </asp:Panel>
     
</asp:Content>
