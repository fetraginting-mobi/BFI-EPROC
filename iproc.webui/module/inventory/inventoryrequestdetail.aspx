<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="inventoryrequestdetail.aspx.cs" Inherits="module_inventory_inventoryrequestdetail" %>

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
                    <cc1:XUILinkButton RoleCode="R60000080E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-12">
                            <cc1:XUILabel ID="lblId" runat="server" Visible="false" BindType="Both" DBColumnName="ID" SPParameterName="p_id" DataType="String" Text="0"></cc1:XUILabel>
                            <cc1:XUILabel ID="lblBarcode" runat="server" DataType="String" style="display:none;" SPParameterName="p_ir_code" DBColumnName="IR_CODE" BindType="UIToDBOnly"></cc1:XUILabel>
                              <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
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
                                <label class="col-sm-2">Branch</label>
                                <div class="col-sm-5">
                                     <asp:UpdatePanel ID="UpB" runat="server">
                                        <ContentTemplate>
                                        <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                        <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" AutoPostBack= "true" BindType="Both" ></cc1:XUIDropDownList>
                                        <cc1:XUILabel ID="XUILabel1" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                        </ContentTemplate>
                                     </asp:UpdatePanel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Division</label>
                                <div class="col-sm-5">
                                    <asp:UpdatePanel ID="updDiv" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE"  SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="revddlDivision" runat="server" ControlToValidate="ddlDivision"
                                                 ErrorMessage="Value Required!" InitialValue="-"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>                    
                                </div>
                            </div>                             
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Department</label>
                                <div class="col-sm-5">
                                    <asp:UpdatePanel ID="updDep" runat="server">
                                            <ContentTemplate>
                                                <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                       <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlDivision" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                     </asp:UpdatePanel> 
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Sub Department</label>
                                <div class="col-sm-5">
                                    <asp:UpdatePanel ID="updSub" runat="server">
                                     <ContentTemplate>
                                        <cc1:XUIDropDownList ID="ddlSubDepartment" runat="server" CssClass="form-control" DBColumnName="SUB_DEPARTMENT_CODE" SPParameterName="p_sub_department_code" OnSelectedIndexChanged= "ddlSubDepartment_SelectedIndexChanged" AutoPostBack="true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                        <asp:RequiredFieldValidator ID="rfvddlSubDepartment" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                     </ContentTemplate>
                                     <Triggers>
                                         <asp:AsyncPostBackTrigger ControlID="ddlDepartment" EventName="SelectedIndexChanged" />
                                     </Triggers>
                                    </asp:UpdatePanel>           
                                </div>
                            </div>                             
                        </div>
                    </div>
                       <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Units</label>
                                <div class="col-sm-5">
                                   <asp:UpdatePanel ID="updUn" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlUnits" runat="server" CssClass="form-control" DBColumnName="UNITS_CODE" SPParameterName="p_units_code"  DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="rfvddlUnits" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUnits" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                           <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlSubDepartment" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                    </asp:UpdatePanel>                       
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Item *</label>
                                 <div class="col-sm-5">    
                                    <asp:LinkButton runat="server" ID="btnLookUpInventoryRequestItem" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                           
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" style="border:0; background:inherit;" BindType="DBToUIOnly" Text="--"></cc1:XUITextBox> 
                                    <asp:RequiredFieldValidator ID="rfvItemCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator>    
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
                       
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Location *</label>
                                <div class="col-sm-1" id="lookupWarehouse" runat="server">
                                    <%--<cc1:XUILabel ID="lblLocation" runat="server"  DBColumnName="DESCRIPTION" SPParameterName="p_location" BindType="Both" DataType="String" ></cc1:XUILabel>--%>
                                    <%--<cc1:XUITextBox ID="txtLocation"  runat="server"  CssClass="form-control" DBColumnName="LOCATION" SPParameterName="p_location" MaxLength="20" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>--%>
                                    
                                    <asp:LinkButton runat="server" ID="btnLookUpWarehouseCode" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                </div>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtWarehouseCode" runat="server"  CssClass="form-control" DBColumnName="LOCATION_CODE" SPParameterName="p_location_code" style="display:none;" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtWarehouseName" runat="server"  DBColumnName="LOCATION_DESC" DataType="String" BindType="DBToUIOnly" Text="--" style="border:0; background:inherit;" ></cc1:XUITextBox>  <%----%>
                                    <asp:RequiredFieldValidator ID="rvfWarehouse" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtWarehouseName" Display="Dynamic"></asp:RequiredFieldValidator> 
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
