<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fareconhistorylist.aspx.cs" Inherits="module_fa_fareconhistorylist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span> FA Reconciliatiion History </span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                 <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                 <cc1:XUILinkButton RoleCode="R90000065O" ID="btnApprovalTiered" runat="server" CssClass="btn btn-success" Visible="false"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox> 
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String"  BindType="Both" style="display:none"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="DBToUIOnly"  style="display:none;"></cc1:XUILabel>
                                 <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DataType="Number" Text="100" style="display:none;" BindType="UIToDBOnly"></cc1:XUILabel> 
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-heading">
            <div class="row">
                <asp:UpdatePanel ID ="updRakDDL" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="col-sm-1">
                            Branch:
                        </div>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="ddlBranch"  runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" ></asp:DropDownList>
                        </div>
                        <div class="col-sm-1">
                            Location:
                        </div>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="ddlLocation"  runat="server" CssClass="form-control" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged" ></asp:DropDownList>
                        </div>
                        <div class="col-sm-1">
                            Period :
                        </div>
                        <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtFromDueDate" runat="server" CssClass="form-control default-date-picker-all" SPParameterName="p_from_due_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox> 
                        </div>
                        <label class="col-sm-1">-</label>
                        <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtToDueDate" runat="server" CssClass="form-control default-date-picker-all" SPParameterName="p_to_due_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="FA_RECON_CODE"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                      EmptyDataText="There is no data">
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
                            <asp:BoundField DataField="CODE" HeaderText="Code">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="CODE_ASSET" HeaderText="Item Code">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="NAME_ASSET" HeaderText="Asset Name">
                                <ItemStyle Width="25%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_CODE" HeaderText="Cost Center">
                                <ItemStyle Width="20%" HorizontalAlign = Center />
                            </asp:BoundField>
                             <asp:BoundField DataField="LOCATION_CODE" HeaderText="Location">
                                <ItemStyle Width="20%" HorizontalAlign = Center />
                            </asp:BoundField>
                              <asp:BoundField DataField="RECON_DATE" HeaderText="Reconciliation Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="5%" HorizontalAlign = Right/>
                            </asp:BoundField>
                             <asp:BoundField DataField="STOCK" HeaderText="Stock" DataFormatString= {0:N2}>
                                <ItemStyle Width="5%" HorizontalAlign = Right/>
                            </asp:BoundField>
                             <asp:BoundField DataField="QTY" HeaderText="QTY" DataFormatString= {0:N2}>
                                <ItemStyle Width="5%" HorizontalAlign = Right/>
                            </asp:BoundField>
                             <asp:BoundField DataField="DEVIATION" HeaderText="Quantity Deviation" DataFormatString= {0:N2}>
                                <ItemStyle Width="5%" HorizontalAlign = Right/>
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
    </section>
</asp:Content>

