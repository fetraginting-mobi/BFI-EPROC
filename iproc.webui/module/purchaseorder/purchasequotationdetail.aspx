<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="purchasequotationdetail.aspx.cs" Inherits="module_purchaseorder_purchasequotationdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R50000050E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <%--ID--%>
                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style = "Display:none;" ></cc1:XUILabel>
                    <%--Barcode--%>
                    <cc1:XUILabel ID="lblBarcode" runat="server"  DBColumnName="PQ_BARCODE" SPParameterName="p_pq_code" DataType="String" BindType="UIToDBOnly" MaxLength="14"  style = "Display:none;"></cc1:XUILabel>            
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">PQ No.</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblPurchaseQuotationCode" runat="server" DBColumnName="PQ_CODE" DataType="String" BindType="DBToUIOnly" MaxLength="14" ></cc1:XUILabel>
                                    
                                    <cc1:XUILabel ID="lblPQStatus" runat="server" DBColumnName="PQ_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                     <cc1:XUILabel ID="XUILabel2" runat="server" DBColumnName="PQ_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                      <cc1:XUITextBox ID="txtPqCode" style="display:none" runat="server" CssClass="form-control"  DataType="String" BindType="None"></cc1:XUITextBox>
                                </div>
                            </div>      
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION"  DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel> 
                                </div>
                            </div>                             
                        </div>  
                    </div>     
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">PR No. *</label>
                                <div class="col-sm-6">    
                                    <asp:LinkButton runat="server" ID="btnLookUpPRCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false" OnClick="btnLookUpPRCode_Click"><i class="icon-table"></i></asp:LinkButton>                                   
                                    <cc1:XUITextBox ID="txtPRBarcode" style="display:none" runat="server" CssClass="form-control" DBColumnName="PR_BARCODE" SPParameterName="p_pr_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                      <cc1:XUITextBox ID="txtGroupCode" style="display:none" runat="server" CssClass="form-control" DataType="String" BindType="None"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblPrCode" runat="server"  DBColumnName="PR_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvPRBarcode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPRBarcode" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                                 <div class="col-sm-8">
                                      <cc1:XUILinkButton ID="btnViewDocument" runat="server" CausesValidation="false" Text="View Document Request"></cc1:XUILinkButton>
                               </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Division</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblDivision" runat="server" DBColumnName="DIVISION_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>   
                      </div> 
                      <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Item *</label>
                                <div class="col-sm-8"> 
                                    <asp:LinkButton runat="server" ID="btnLookUpItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                              
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>   
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>  
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Department</label>
                                <div class="col-sm-8">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblDepartement" runat="server" DBColumnName="DEPARTEMENT_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div> 
                   <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Supplier *</label> 
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpSupplierID" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                                    
                                    <cc1:XUITextBox ID="txtSupplierID" style="display:none" runat="server" CssClass="form-control" DBColumnName="SUPPLIER_CODE" SPParameterName="p_supplier_code" MaxLength="20" DataType="string" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblSupplierName" runat="server"  DBColumnName="SUPPLIER_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel><%--
                                    <asp:RequiredFieldValidator ID="rfvSupplierID" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplierID" Display="Dynamic"></asp:RequiredFieldValidator> --%>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">SubDepartment</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="XUILabel1" runat="server"  DBColumnName="SUB_DEPARTMENT_NAME"  DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel> 
                                </div>
                            </div>                             
                        </div>
                       </div>
                       <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Requestor</label>
                                <div class="col-sm-6">
                                  <cc1:XUILabel ID="lblRequestor" runat="server" DBColumnName="REQUESTOR" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                      <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4" style="display:none;">Payment</label>
                                <div class="col-sm-8">
                                    <cc1:XUIRadioButtonList ID="rblPaymentMethode" runat="server" style="display:none;"  DBColumnName="PAYMENT_METHODE_CODE" SPParameterName="p_payment_methode_code" DataType="String" BindType="Both" RepeatLayout="Table" RepeatDirection="Horizontal" >
                                        <asp:ListItem Value="DEBIT" Selected="True">Debit&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="CREDIT">Credit</asp:ListItem>
                                    </cc1:XUIRadioButtonList> 
                                </div>
                            </div>                            
                        </div>
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Units</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                  <cc1:XUILabel ID="lblUnits" runat="server" DBColumnName="UNITS_NAME" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>  
                    </div>
                    <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Quantity *</label>        
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtOrderQuantity" runat="server" CssClass="form-control" placeholder="Order Quantity" DBColumnName="QUANTITY" SPParameterName="p_quantity" DataType="Number" BindType="Both" MaxLength="8" Format="N2" Enabled ="false"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtApprovalQuantity" style="display:none"  runat="server" CssClass="form-control"  DBColumnName="APPROVAL_PO_QUANTITY" SPParameterName="p_approval_po_quantity"  DataType="Number" BindType="Both" Format="N2" ></cc1:XUITextBox> 
                                    <%--<cc1:XUITextBox ID="txtRemainingQuantity" style="display:none"  runat="server" CssClass="form-control"  DBColumnName="REMAINING_QUANTITY" SPParameterName="p_remaining_quantity"  DataType="Number" BindType="Both" Format="N0" ></cc1:XUITextBox>--%>
                                   <%-- <cc1:XUITextBox ID="txtTampunganQuantity" style="display:none" runat="server" CssClass="form-control" DBColumnName="PRQTY"  DataType="Number" Text="0.00" Format="N2" BindType="DBToUIOnly" ></cc1:XUITextBox>--%>
                                    <asp:RequiredFieldValidator ID="rfvOrderQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtOrderQuantity" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="refOrderQuantity" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtOrderQuantity" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                </div>
                                <div class="col-sm-3">                                    
                                    <cc1:XUIDropDownList ID="ddlUnitID" runat="server" CssClass="form-control" DBColumnName="UNIT_CODE" SPParameterName="p_unit_code" DataType="String" BindType="Both" Enabled="false"></cc1:XUIDropDownList>
                                </div>
                            </div>      
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Tax</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlTaxID" runat="server" CssClass="form-control" DBColumnName="TAX_CODE" SPParameterName="p_tax_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Unit Price *</label>      
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtUnitPrice" runat="server" CssClass="form-control" placeholder="Unit Price" DBColumnName="UNIT_PRICE" SPParameterName="p_unit_price" DataType="Number" MaxLength="14" BindType="Both" Format="N2"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvUnitPrice" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitPrice" Display="Dynamic"></asp:RequiredFieldValidator>         
                                    <asp:RegularExpressionValidator ID="revUnitPrice" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtUnitPrice" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>   
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Currency</label>
                                <div class="col-sm-5">
                                    <cc1:XUIDropDownList ID="ddlCurrencyCode" runat="server" CssClass="form-control" DBColumnName="CURRENCY_CODE" SPParameterName="p_currency_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                    </div>  
                    <div class="row">  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Guarantee</label>        
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <cc1:XUITextBox ID="txtGuarantee" runat="server" CssClass="form-control" placeholder="Guarantee (month)" DBColumnName="WARRANTY_MONTH" SPParameterName="p_warranty_month" DataType="Integer" BindType="Both" Width="100px" MaxLength="3"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblMonth" runat="server">&nbsp&nbsp Month</cc1:XUILabel>
                                       <%-- <asp:RequiredFieldValidator ID="rfvGuarantee" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtGuarantee" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                        <asp:RegularExpressionValidator ID="revguarantee" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtGuarantee" ValidationExpression="[0-9]*[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>  
                                    </div>
                                </div>    
                            </div> 
                        </div>    
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Guarantee Part</label>       
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <cc1:XUITextBox ID="txtGuaranteePart" runat="server" CssClass="form-control" placeholder="Guarantee Part (Month)" DBColumnName="WARRANTY_PART_MONTH" SPParameterName="p_warranty_part_month" DataType="Integer" BindType="Both" Width="100px" MaxLength="3"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblMonthPart" runat="server">&nbsp&nbsp Month</cc1:XUILabel>
                                       <%-- <asp:RequiredFieldValidator ID="rvfGuaranteePart" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtGuaranteePart" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                        <asp:RegularExpressionValidator ID="revGuaranteepart" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtGuaranteePart" ValidationExpression="[0-9]*[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>   
                                    </div>
                                </div>    
                            </div>
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both" MaxLength="400" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
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
    
    
    <%--<asp:Panel runat="server" ID="pnlDetail">
    <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">       
              <li class="active">
                  <a href="#doclist" id="documentlist" onclick="javascript:fnSetTab('documentlist');" data-toggle="tab" style="padding-bottom:28px">
                      Document List 
                  </a>
              </li>
          </ul>
        </header>    
        
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
               <div class="tab-pane active" id="doclist">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8">
                                <cc1:XUILinkButton RoleCode="R50000070E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R50000070E" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                            </div>
                            <div class="col-sm-4 ">
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
                            <asp:UpdatePanel ID="updDoc" runat="server">
                                <ContentTemplate></ContentTemplate>
                                <Triggers> 
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                            AllowPaging="true" PageSize="20" DataKeyNames="ID, FILEPATH" OnPageIndexChanging="gvwList_PageIndexChanging"
                            OnRowCommand="gvwListDoc_RowCommand" OnRowDataBound="gvwList_RowDataBound"
                            EmptyDataText="There is no data" AllowSorting="true">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <span>No</span>
                                        </HeaderTemplate>
                                        <ItemTemplate><%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DESCRIPTION" HeaderText="Description" SortExpression="DESCRIPTION">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="File Name" SortExpression="FILENAME">
                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Eval("FILENAME") %>' ID="lblFileName" />
                                            <br />
                                            <asp:FileUpload runat="server" ID="fupFilename" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Expired Date" SortExpression="DUE_DATE">
                                        <ItemStyle Width="25%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" Text='<%# Eval("DUE_DATE", "{0:dd/MM/yyyy}") %>' ID="txtDueDate" MaxLength="8" CssClass="form-control default-date-picker date-only number-only" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Promise Date" SortExpression="PROMISE_DATE">
                                        <ItemStyle Width="25%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" Text='<%# Eval("PROMISE_DATE", "{0:dd/MM/yyyy}") %>' ID="txtPromiseDate" MaxLength="8" CssClass="form-control default-date-picker date-only number-only" />
                                        </ItemTemplate>
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <cc1:XUILinkButton ID="btnSaveDoc" runat="server" CausesValidation="false" Text="Save" CommandName="save" RoleCode="LEA060336U"></cc1:XUILinkButton>
                                            <cc1:XUILinkButton ID="btnPreviewDoc" runat="server" RoleCode="">Preview</cc1:XUILinkButton>
                                            
                                            <cc1:XUILinkButton ID="btnDeleteDoc" runat="server" CausesValidation="false" Text="Delete" CommandName="del" RoleCode="LEA060315D"></cc1:XUILinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     
                                </Columns>
                            </asp:GridView>
                        </div>
                </div>
            </div>
        </div>
    </section>
    </asp:Panel>--%>
</asp:Content>

            