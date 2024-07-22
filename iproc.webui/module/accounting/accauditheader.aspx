<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="accauditheader.aspx.cs" Inherits="module_accounting_accauditheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Jurnal Audit Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R12000090E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R12000090O" ID="btnPost" runat="server" CssClass="btn btn-success" OnClick="btnPost_Click" CausesValidation="true"><i class="icon-save"></i>  Post</cc1:XUILinkButton>
                    <%--<cc1:XUILinkButton RoleCode="R37100005P" ID="btnPrint" runat="server" CssClass="btn btn-primary" OnClick="btnPrint_Click" CausesValidation="false"><i class="icon-print"></i>  Print</cc1:XUILinkButton>--%>
                    <%--<cc1:XUILinkButton RoleCode="R37100001O" ID="btnViewJurnal" runat="server" CssClass="btn btn-success" OnClick="btnViewJurnal_Click" CausesValidation="false"><i class="icon-ticket"></i>  View-Jurnal</cc1:XUILinkButton>--%>
                    <cc1:XUILinkButton RoleCode="R12000090O" ID="btnReject" runat="server" CssClass="btn btn-danger" OnClick="btnReject_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3 ">No.</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblAuditNo" runat="server" DBColumnName="AUDIT_NO" SPParameterName="p_audit_no" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                          
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Status</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblAuditStatus" runat="server"  DBColumnName="AUDIT_STATUS" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel> 
                        </div>
                    </div>                            
                </div>                             
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Branch</label>
                        <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlBranchCode" runat="server" CssClass="form-control" DBColumnName="AUDIT_BRANCH_CODE" SPParameterName="p_audit_branch_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                            <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="AUDIT_BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Trx. Date *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtAuditDate" runat="server" CssClass="form-control default-date-picker" placeholder="Audit Date" DBColumnName="AUDIT_DATE" SPParameterName="p_audit_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvAuditDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAuditDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <asp:RegularExpressionValidator ID="revAuditDate" runat="server" ControlToValidate="txtAuditDate" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)"/>
                    </div>                            
                </div>
             </div>
                    <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Remarks</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtUditRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                            <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtUditRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 40" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Value Date *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtValueDate" runat="server" CssClass="form-control default-date-picker" placeholder="Value Date" DBColumnName="VALUE_DATE" SPParameterName="p_value_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfv" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtValueDate" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <asp:RegularExpressionValidator ID="revValueDate" runat="server" ControlToValidate="txtValueDate" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)"/>
                    </div>                            
                </div>
            </div>
            </ContentTemplate>
                  <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                 </Triggers>
          </asp:UpdatePanel> 
        </div>
    </section>
    <section class="panel">
        <header class="panel-heading">
            <span>Detail List </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                    <cc1:XUILinkButton RoleCode="R12000090O" ID="btnAddDetail" runat="server" CssClass="btn btn-primary" OnClick="btnAddDetail_Click" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R12000090O" ID="btnDeleteDetail" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteDetail_Click" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchDetail" class="input-group">
                        <asp:TextBox ID="txtSearchDetail" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchDetail" runat="server" CssClass="btn btn-info" OnClick="btnSearchDetail_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                   </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="updDetail" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListDetail" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="ID" ShowFooter="true"
                        OnPageIndexChanging="gvwListDetail_PageIndexChanging"  OnRowDataBound="gvwListDetail_OnRowDataBound"
                        onselectedindexchanged="gvwListDetail_SelectedIndexChanged" EmptyDataText="There is no data">
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
                            <%--<asp:BoundField DataField="DIVISI" HeaderText="Div">
                                <ItemStyle Width="5%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DEPARTMENT" HeaderText="Dept">
                                <ItemStyle Width="5%"/>
                            </asp:BoundField>--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblDivisi" Text="Div/Dept"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="10%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblDivisi" Text='<%# Eval("DIVISI") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblDepartment" Text='<%# Eval("DEPARTMENT") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblAccNo" Text="Acc No./Acc Name"></asp:Label>
                                </HeaderTemplate>
                                <HeaderStyle Width="20%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblAccNo" Text='<%# Eval("ACC_NO") %>' Font-Bold="true"></asp:Label>
                                    </br>
                                    <asp:Label runat="server" ID="lblAccName" Text='<%# Eval("ACC_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="ACC_NO" HeaderText="ACC No.">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ACC_NAME" HeaderText="ACC Name">
                                <ItemStyle Width="15%"/>
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="ORIG_CURRENCY" HeaderText="">
                                <ItemStyle Width="0%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ORIG_AMOUNT_DB" HeaderText="Debit" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ORIG_AMOUNT_CR" HeaderText="Credit" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="EXCH_RATE" HeaderText="Rate" DataFormatString="{0:N2}">
                                <ItemStyle Width="10%"  HorizontalAlign="Right" />
                                <FooterStyle Width="10%" HorizontalAlign="Right" Font-Bold="true" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BASE_AMOUNT_DB" HeaderText="Debit (In Base Amount)" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="BASE_AMOUNT_CR" HeaderText="Credit (In Base Amount)" DataFormatString="{0:N2}">
                                <ItemStyle Width="15%"  HorizontalAlign="Right" />
                                <FooterStyle Width="15%" HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearchDetail" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteDetail" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnAddDetail" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


