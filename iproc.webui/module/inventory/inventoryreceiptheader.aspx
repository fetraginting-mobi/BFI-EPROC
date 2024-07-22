<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventoryreceiptheader.aspx.cs" Inherits="module_inventory_inventoryreceiptheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <section class="panel">
        <header class="panel-heading">
          <span>Inventory Receipt Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</asp:LinkButton>
                    <asp:LinkButton ID="btnPost" runat="server" CssClass="btn btn-danger" OnClick="btnPost_Click"><i class="icon-save"></i>  Post</asp:LinkButton>
                    <asp:LinkButton ID="btnReject" runat="server" CssClass="btn btn-danger" OnClick="btnReject_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                    <div class="row">
                        <div class="col-sm-6">
                            <%--code barcode--%>
                                <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" style="display:none;" DataType="String"  BindType="Both"></cc1:XUILabel>
                            <div class="form-group">
                                <label class="col-sm-4">No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_DESC" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Date</label>
                                <asp:RequiredFieldValidator ID="rfvReceiptDate" runat="server" ErrorMessage="*" ControlToValidate="txtReceiptDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtReceiptDate" runat="server" CssClass="form-control default-date-picker" placeholder="Receipt Date" DBColumnName="RECEIPT_DATE" SPParameterName="p_receipt_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Inventory Issue No.</label>
                                <div class="col-sm-8">
                                     <asp:LinkButton runat="server" ID="btnLookUpIsCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                      <asp:RequiredFieldValidator ID="rfvIsCode" runat="server" ErrorMessage="*" ControlToValidate="txtIsCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <cc1:XUITextBox ID="txtIsCode" style="display:none" runat="server" CssClass="form-control" DBColumnName="IS_CODE" SPParameterName="p_is_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblCodeInventoryInsurance" runat="server"  DBColumnName="CODE_IS" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                               </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Location</label>
                                <div class="col-sm-4">
                                    <cc1:XUIDropDownList ID="ddlLocationCode" runat="server" CssClass="form-control" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>                                               
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" TextMode="MultiLine" Height="58px" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Modified</label>
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
    
    <section class="panel">
        <header class="panel-heading">
          <span>Item List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <asp:LinkButton ID="btnAddReceiptDetail" runat="server" CssClass="btn btn-primary" OnClick="btnAddReceiptDetail_Click" ><i class="icon-plus"></i>  Create</asp:LinkButton>
                    <asp:LinkButton ID="btnDeleteReceiptDetail" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteReceiptDetail_Click" ><i class="icon-trash"></i>  Delete</asp:LinkButton>
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
                                     <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:BoundField DataField="ITEM_NAME" HeaderText="Item">
                                <ItemStyle Width="25%" HorizontalAlign="Left"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="MERK_NAME" HeaderText="Merk">
                                <ItemStyle Width="25%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="QUANTITY" HeaderText="Quantity" DataFormatString="{0:N0}">
                                <ItemStyle Width="15%" HorizontalAlign="Right"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="ITEM_DESCRIPTION" HeaderText="Description">
                                <ItemStyle Width="35%" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteReceiptDetail" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
