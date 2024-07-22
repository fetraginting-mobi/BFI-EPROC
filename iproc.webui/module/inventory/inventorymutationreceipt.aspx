<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventorymutationreceipt.aspx.cs" Inherits="module_inventory_inventorymutationreceipt" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
 <section class="panel">
        <header class="panel-heading">
          <span>Inventory Mutation Receipt Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R60000115E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" style="display:none;" ><i class="icon-save"></i></cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R60000115E" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-12">
                            <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" Text="0"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_ir_code" DBColumnName="IR_CODE" BindType="DBToUIOnly"></cc1:XUILabel>
                            <div class="form-group">
                                <label class="col-sm-2">Inventory Request No.</label>
                                <div class="col-sm-5">
                                    <cc1:XUILabel ID="lblIRCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblIRStatus" runat="server" DBColumnName="IR_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>                            
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Item *</label>
                                 <div class="col-sm-5">    
                                    <%--<asp:LinkButton runat="server" ID="btnLookUpInventoryRequestItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                           
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUITextBox>--%>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                    <%--<asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>    
                                 </div>
                            </div>              
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Branch</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblBranch" runat="server" DBColumnName="BRANCH_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Division</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE" SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblDivision" runat="server" DBColumnName="DIVISION_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                     
                                </div>
                            </div>                             
                        </div> 
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Department</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblDepartement" runat="server" DBColumnName="DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                       <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Sub Department</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblSubDepartment" runat="server" DBColumnName="SUB_DEPARTMENT_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                         </div>                            
                       </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Units</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblUnits" runat="server" DBColumnName="UNITS_DESC" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Quantity *</label>
                                    <div class="col-sm-1">
                                    <cc1:XUITextBox ID="txtQuantity" runat="server" CssClass="form-control" placeholder="Quantity" DBColumnName="QUANTITY" SPParameterName="p_quantity" DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtQuantity" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revOrder" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtQuantity" ValidationExpression="[0-9 .,/()+]*[0-9 .,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">From Branch</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblFromBranch" runat="server" DBColumnName="FROM_BRANCH" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">From Location</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblLocation" runat="server" DBColumnName="FROM_LOCATION" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">From Rak</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblRak" runat="server" DBColumnName="FROM_RAK" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">From Lot</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblLot" runat="server" DBColumnName="FROM_LOT" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">From Slot</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblSlot" runat="server" DBColumnName="FROM_SLOT" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">To Branch</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblToBranch" runat="server" DBColumnName="TO_BRANCH" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">To Location</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblToLocation" runat="server" DBColumnName="TO_LOCATION" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">To Rak</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblToRak" runat="server" DBColumnName="TO_RAK" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">To Lot</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblToLot" runat="server" DBColumnName="TO_LOT" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">To Slot</label>
                                <div class="col-sm-5">
                                    <%--<cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>--%>
                                    <cc1:XUILabel ID="lblToSlot" runat="server" DBColumnName="TO_SLOT" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Description *</label>                    
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtItemDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="ITEM_DESCRIPTION" SPParameterName="p_item_description" MaxLength="50" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvItemDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemDescription" Display="Dynamic"></asp:RequiredFieldValidator>   
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtItemDescription" ValidationExpression="^[\s\S]{0,50}$" ErrorMessage="Exceed maximum length 50" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Receive Date *</label>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtReceiveDate" runat="server" CssClass="form-control default-date-picker" placeholder="Receive Date" DBColumnName="RECEIVE_DATE" SPParameterName="p_receive_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" ></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvReceiveDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReceiveDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <asp:RegularExpressionValidator ID="revReceiveDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtReceiveDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
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


