<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="generatenobs.aspx.cs" Inherits="module_purchaseorder_generatenobs" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
 <section class="panel">
        <header class="panel-heading">
          <span>Generate No Bs</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R50000083O" ID="btnGenerate" runat="server" CssClass="btn btn-primary" OnClick="btnGenerate_Click"><i class="icon-save"></i>  Generate</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R50000083E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal" style="height:600px">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>        
                  
                       <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Barcode *</label>
                                 <div class="col-sm-2">    
                                    <asp:LinkButton runat="server" ID="btnLookUpInventoryRequestItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton> 
                                    <cc1:XUITextBox ID="txtBarcode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="BARCODE" SPParameterName="p_barcode" DataType="String" BindType="Both"></cc1:XUITextBox> 
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="BARCODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                     <cc1:XUILabel ID="lblstatus" runat="server" DBColumnName="STATUS"  DataType="String"  style="display:none;" BindType="DBToUIOnly" ></cc1:XUILabel> 
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBarcode" Display="Dynamic"></asp:RequiredFieldValidator>    
                                 </div>
                            </div>              
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Code Barcode</label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtVoucherCode" runat="server" CssClass="form-control"  DBColumnName="CODE_BARCODE" placeholder="No Bs" SPParameterName="p_code_barcode" MaxLength="50" DataType="String"  BindType="Both"></cc1:XUITextBox>
                                 <%--   <asp:RequiredFieldValidator ID="rfvVoucherCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtVoucherCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Start No BS *</label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtStart" runat="server" style="text-align:right" CssClass="form-control"  placeholder="Start Quantity"  DBColumnName="START" SPParameterName="p_start" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvStart" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtStart" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revStart" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtStart" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                
                                </div>
                                <div>Masukkan jumlah lembar awal pembelian</div>
                            </div>                            
                        </div>
                    </div>
                   <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">End No BS *</label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtEnd" runat="server" CssClass="form-control "  placeholder="End Quantity" SPParameterName="p_end" DBColumnName="END" MaxLength="50" DataType="Integer" BindType="Both" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvEnd" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtEnd" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEnd" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtEnd" ValidationExpression="[0-9]*[0-9]" Display="Dynamic" ></asp:RegularExpressionValidator>
                              
                                </div>
                                  <div>Masukkan jumlah lembar akhir pembelian</div>
                            </div>                            
                        </div>
                    </div>
                      <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Jumlah Quantity</label>
                                <div class="col-sm-2">
                                   <cc1:XUILabel ID="lblID" runat="server" DBColumnName="STOCK"  DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel> 
                            </div>                            
                        </div>
                    </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Generate Date *</label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtFirstDate" runat="server" CssClass="form-control default-date-picker" DBColumnName="GENERATE_DATE"  placeholder="Date" SPParameterName="p_generate_date" MaxLength="50" DataType="DateTime" BindType="Both" format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvFirstDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFirstDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <asp:RegularExpressionValidator ID="revFirstDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtFirstDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks </label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control "  placeholder="Remarks" DBColumnName="ISSUE" SPParameterName="p_issue" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                
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
    </section>
</asp:Content>

