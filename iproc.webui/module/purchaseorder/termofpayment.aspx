<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="termofpayment.aspx.cs" Inherits="module_purchaseorder_termofpayment" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
<script type="text/javascript">
//    function ChangeAccrueValue(evt) {

//        var obj = evt.target;
//        var charCode = evt.keyCode;
//        
//        
//        var amount = document.getElementById("ctl00_cpb_txtAmount").value;
//        var percentage = document.getElementById("ctl00_cpb_txtPercentage").value;
//        var totalamount = document.getElementById("ctl00_cpb_txtTotalAmount").value;
////        var pct = document.getElementById("ctl00_cpb_txtAccruePct").value;
////        var accAmount = document.getElementById("ctl00_cpb_txtAccrueAmount").value;
//        
//        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 8) {

//            if (obj.id == "<%= txtAmount.ClientID %>") {
//                
//                var pctreal = amount / totalamount * 100;
//                 
//                $("#<%= txtPercentage.ClientID %>").val(pctreal);
//            }
//            else if (obj.id == "<%= txtPercentage.ClientID %>") {
//                var amoutreal = totalamount / percentage * 100;
//                 
//                $("#<%= txtAmount.ClientID %>").val(amoutreal);
//            }

//        }
//    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Term of Payment Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R50000070E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <%--ID--%>
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" Style="display:none"></cc1:XUILabel>
                    <%--Barcode--%>
                    <cc1:XUILabel ID="lblBarcode" runat="server"  DBColumnName="PO_BARCODE" SPParameterName="p_po_code" DataType="String" BindType="UIToDBOnly" MaxLength="14"  style = "Display:none;"></cc1:XUILabel>
                    <%--Status Flag--%>
                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly" style = "Display:none;"></cc1:XUILabel>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PO No.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" MaxLength="14" ></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtCodeBarcode" Style="display:none" runat="server"  CssClass="form-control" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>      
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Termin Type</label>
                                <div class="col-sm-5">    
                                    <cc1:XUIDropDownList ID="ddlTerminType" runat="server" CssClass="form-control" placeholder="TRX" DBColumnName="TERMIN_TYPE" SPParameterName="p_termin_type" AutoPostBack= "true" OnSelectedIndexChanged="ddlTerminType_SelectedIndex" DataType="String" BindType="Both">
                                    <asp:ListItem Value="0">-=Select=- </asp:ListItem>
                                    <asp:ListItem Value="PCT"> Percentage </asp:ListItem>
                                    <asp:ListItem Value="AMT"> Amount </asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvTerminType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlTerminType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Trx Code *</label>
                                <div class="col-sm-5">    
                                    <cc1:XUIDropDownList ID="ddlTRX" runat="server" CssClass="form-control" placeholder="TRX" DBColumnName="TRX_CODE" SPParameterName="p_trx_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Reference No.</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtReferenceNo" runat="server" CssClass="form-control" placeholder="Reference No" DBColumnName="REFF_CODE" Enabled="false" SPParameterName="p_reff_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <%--<asp:RequiredFieldValidator ID="rfvReferenceNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReferenceNo" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>
                    </div>
                   <%-- <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtReceiveDate" runat="server"  CssClass="form-control default-date-picker"  placeholder="Receive Date" DBColumnName="TRX_DATE" SPParameterName="p_trx_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvReceiveDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReceiveDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revDisbursementDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtReceiveDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>
                    </div>--%>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Percentage</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtPercentage" runat="server" placeholder="Percentage" CssClass="form-control" DBColumnName="PERCENTAGE" SPParameterName="p_percentage" DataType="Number" MaxLength="10" Format="N0"  AutoPostBack="true" BindType="Both"></cc1:XUITextBox> 
                                                                        <asp:RegularExpressionValidator ID="revPercentage" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPercentage" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="ravPercentage" runat="server" ErrorMessage="Value must be between 0 - 100" ControlToValidate="txtPercentage" Display="Dynamic" MinimumValue="0" MaximumValue="100" Type="Double"></asp:RangeValidator>
                                </div>
                                <div> %
                                </div>
                            </div>      
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Amount</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Amount" DBColumnName="AMOUNT" SPParameterName="p_amount" DataType="Number" BindType="Both" MaxLength="15"  AutoPostBack="true" Format="N2"></cc1:XUITextBox> 
                                    <cc1:XUITextBox ID="txtTotalAmount" runat="server" CssClass="form-control" placeholder="Total Amount" DBColumnName="TOTAL_AMOUNT" DataType="Number" BindType="DBToUIOnly" MaxLength="15"  Style="display:none"></cc1:XUITextBox>
                                    <%--<asp:RequiredFieldValidator ID="rfvAmount" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAmount" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <asp:RegularExpressionValidator ID="revAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtAmount" ValidationExpression="[0-9 .,]*[0-9 .,]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>                            
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" placeholder="Remarks" CssClass="form-control" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" MaxLength="200" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox> 
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
