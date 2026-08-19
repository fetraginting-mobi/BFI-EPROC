<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fadisposalheader.aspx.cs" Inherits="module_fa_fadisposalheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Fixed Asset Disposal Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R90000090E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R90000090O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R90000090O" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click" ><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnReject" RoleCode="R90000090O" runat="server" CssClass="btn btn-danger"  CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                     <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                     <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DBColumnName="OBJECT_AMOUNT" DataType="Number" Text="0"   style="display:none;" BindType="Both" ></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">FA Disposal No.</label>
                                <!--CODE BARCODE-->
                                <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String"  BindType="Both" style="display:none"></cc1:XUILabel>
                                <cc1:XUITextBox ID="txtCodeBarcode" runat="server" CssClass="form-control" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUITextBox>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                       <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></cc1:XUILinkButton>
                                </div>
                                
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_CODE" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Date *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDisposalDate" runat="server" CssClass="form-control default-date-picker" placeholder="Disposal Date" DBColumnName="DISPOSAL_DATE" SPParameterName="p_disposal_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDisposalDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDisposalDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtDisposalDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">From Cost Center</label>
                                <div class="col-sm-8">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" AutoPostBack="true" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-3">Reason *</label>
                                       <div class="col-sm-8">
                                        <cc1:XUIDropDownList ID="ddlReason" runat="server" CssClass="form-control" DBColumnName="REASON" SPParameterName="p_reason" BindType="Both" AutoPostBack="true" DataType="String">
                                           </cc1:XUIDropDownList>
                                    </div>
                                </div>                            
                            </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">From Location</label>
                               <div class="col-sm-8">
                                    <cc1:XUIDropDownList ID="ddlFromLocationCode" runat="server" CssClass="form-control" DBColumnName="FROM_LOCATION_CODE" SPParameterName="p_from_location_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>                                                 
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
                            <label class="col-sm-3">Approval To</label>
                                <div class="col-sm-8">
                                    <cc1:XUIDropDownList ID="ddlOwner" runat="server" CssClass="form-control" placeholder="" DBColumnName="OWNER" SPParameterName="p_owner"  MaxLength="10" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="rfvOwner" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlOwner" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>
                       </div> 
                   </div>  
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Description *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="100" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 100" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                         </div>     
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Remarks</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>    
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Created  </label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                             </div>
                          </div>
                          <div class="col-sm-6">
                              <div class="form-group">
                                    <label class="col-sm-3">Modified </label>
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
                    <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    
    <asp:Panel runat="server" ID="pnlDisposal">
    <section class="panel">
        <header class="panel-heading">
            <span>Asset List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton ID="btnAdd" RoleCode="R90000090E" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnDelete" RoleCode="R90000090E" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">
                     <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">      
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
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
                        onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There Is No Data" Width="100%">
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
                                    <asp:CheckBox runat="server" ID="chbCheckedAll" AutoPostBack="true" OnCheckedChanged="chbCheckedAll_CheckedChanged"/>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chbChecked"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ASSET_BARCODE" HeaderText="Asset Code">
                                <ItemStyle Width="30%" HorizontalAlign="Center"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="ASSET_NAME" HeaderText="Asset Name">
                                <ItemStyle Width="30%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="Description">
                                <ItemStyle Width="40%" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    </asp:Panel>
</asp:Content>

