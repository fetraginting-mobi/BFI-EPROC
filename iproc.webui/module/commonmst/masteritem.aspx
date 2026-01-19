<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="masteritem.aspx.cs" Inherits="module_commonmst_masteritem" %>

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
                    <cc1:XUILinkButton RoleCode="R30000130E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>

                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Code</label>
                            <div class="col-sm-7">
                                <cc1:XUILabel ID="lblItemCode" runat="server" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Item Type</label>
                            <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlJenisItem" runat="server" CssClass="form-control" DBColumnName="JENIS_ITEM" SPParameterName="p_jenis_item" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlJenisItem_OnSelectedIndex" DataType="String">
                                </cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Name *</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtItemName" runat="server" CssClass="form-control" placeholder ="Item Name" DBColumnName="ITEM_NAME" SPParameterName="p_item_name" MaxLength="200" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvItemName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Group*</label>                                
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookUpParentGroup" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtParentGroup" runat="server" CssClass="form-control" style="display:none" DBColumnName="GROUP_CODE" SPParameterName="p_group_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblParentGroup" runat="server"  DBColumnName="DESCRIPTIONPG" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                <asp:RequiredFieldValidator ID="rfvParentGroup" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtParentGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">UOM Dimension 1</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlPOUnitCode" runat="server" CssClass="form-control" DBColumnName="EXPENSE_UNIT_CODE" SPParameterName="p_expense_unit_code" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Merk</label>
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookUpMerk" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtMerk" style="display:none" runat="server" CssClass="form-control" DBColumnName="MERK_CODE" SPParameterName="p_merk_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblMerk" runat="server"  DBColumnName="MERK_CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblMerkName" runat="server"  DBColumnName="MERK_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <%--<asp:RequiredFieldValidator ID="rfvMerk" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMerk" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">UOM Dimension 2</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlUOM2" runat="server" CssClass="form-control" DBColumnName="UOM_DIMENSIONS_CODE_2" SPParameterName="p_uom_dimensions_code_2" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Type</label>
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookUpType" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtType" style="display:none" runat="server" CssClass="form-control" DBColumnName="TYPE_CODE" SPParameterName="p_type_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblType" runat="server"  DBColumnName="TYPE_CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblTypeName" runat="server"  DBColumnName="TYPE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <%--<asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtType" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">UOM Dimension 3</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlUOM3" runat="server" CssClass="form-control" DBColumnName="UOM_DIMENSIONS_CODE_3" SPParameterName="p_uom_dimensions_code_3" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Model</label>
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookUpModel" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtModel" style="display:none" runat="server" CssClass="form-control" DBColumnName="MODEL_CODE" SPParameterName="p_model_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblModel" runat="server"  DBColumnName="MODEL_CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblModelName" runat="server"  DBColumnName="MODEL_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <%--<asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtType" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">PO Latest Price</label>      
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtPOLatestCost" runat="server" CssClass="form-control" placeholder="PO Latest Cost" DBColumnName="EXPENSE_LATEST_COST" SPParameterName="p_expense_latest_cost" MaxLength="20" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="FaCategory" class="col-sm-4">FA Category *</label>
                                <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlFaCategory" runat="server" CssClass="form-control" DBColumnName="FA_CATEGORY_CODE" SPParameterName="p_fa_category_code" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvFaCategory" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlFaCategory" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                 </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">PO Average Price</label>       
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtPOAverageCost" runat="server" CssClass="form-control" placeholder="PO Average Cost" DBColumnName="EXPENSE_AVERAGE_COST" SPParameterName="p_expense_average_cost" MaxLength="20" DataType="Number" Format="N2" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="FaDeprFis" class="col-sm-4">FA Depre. Category Fiscal *</label>
                                <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlFACategoryFiscalCode" runat="server" CssClass="form-control" DBColumnName="FA_DEPRE_CATEGORY_FISCAL_CODE" SPParameterName="p_fa_depre_category_fiscal_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvFACategoryFiscalCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Category Type *</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlCategoryType" runat="server" CssClass="form-control" DBColumnName="CATEGORY_TYPE" SPParameterName="p_category_type" BindType="Both" DataType="String">
                                    <asp:ListItem Value="0">-=Select=-</asp:ListItem>
                                    <asp:ListItem Value="GOODS">GOODS</asp:ListItem>
                                    <asp:ListItem Value="SERVICES">SERVICES</asp:ListItem>
                                </cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvCategoryType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlCategoryType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                        </div>                            
                    </div>
                      <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="FaDepCat" class="col-sm-4">FA Depre. Category Commercial *</label>
                                <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlFACategoryBookCode" runat="server" CssClass="form-control" DBColumnName="FA_DEPRE_CATEGORY_BOOK_CODE" SPParameterName="p_fa_depre_category_book_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvFACategoryBookCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Item Flag *</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlGoodsFlag" runat="server" CssClass="form-control" DBColumnName="GOODS_FLAG" SPParameterName="p_goods_flag" BindType="Both" DataType="String">
                                    <asp:ListItem Value="0">-=Select=-</asp:ListItem>
                                    <asp:ListItem Value="MOVE">MOVEABLE</asp:ListItem>
                                    <asp:ListItem Value="NON">NON-MOVEABLE</asp:ListItem>
                                </cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvGoodsFlag" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlGoodsFlag" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Owner *</label>
                                <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlOwner" runat="server" CssClass="form-control" placeholder="" DBColumnName="OWNER" SPParameterName="p_owner"  MaxLength="10" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="rfvOwner" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlOwner" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>
                        </div>                            
                    </div>
                 <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="Maintc" class="col-sm-4">Maintenance *</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlMaintenance" runat="server" CssClass="form-control" DBColumnName="MAINTENANCE" SPParameterName="p_maintenance" BindType="Both" DataType="String">
                                    <asp:ListItem Value="0">-=Select=-</asp:ListItem>
                                    <asp:ListItem Value="RM">Repair Maintenance</asp:ListItem>
                                    <asp:ListItem Value="NR">No-Repair Maintenance</asp:ListItem>
                                </cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvMaintenance" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlMaintenance" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                        </div>                            
                    </div>
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="lblProcessby" class="col-sm-4">Process By *</label>
                               <div class="col-sm-7">
                                <cc1:XUIDropDownList ID="ddlProcessBy" runat="server" CssClass="form-control" DBColumnName="PROCESS_BY" SPParameterName="p_process_by" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvProcessBy" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlProcessBy" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Active</label>
                            <div class="col-sm-7">
                                <cc1:XUICheckBox ID="cbxIsActive" DBColumnName="IS_ACTIVE" SPParameterName="p_is_active" DataType="String" BindType="Both" runat="server" Checked="true" />
                            </div>
                        </div>                            
                     </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="lblGenerateBarcode" class="col-sm-4">Generate barcode</label>
                            <div class="col-sm-2">
                                <cc1:XUICheckBox ID="chbGenerateBarcode" runat="server"  DBColumnName="GENERATE_BARCODE_FLAG" SPParameterName="p_generate_barcode_flag" BindType="Both" DataType="String" ></cc1:XUICheckBox>    
                            </div>
                       </div>
                    </div>
                 </div>
                 <div class="row">
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="DatePromotion" class="col-sm-4">Use Date Promotion</label>
                            <div class="col-sm-7">
                                <cc1:XUICheckBox ID="cbxDatePromotion" DBColumnName="IS_DATE_PROMOTION" SPParameterName="p_is_date_promotion" DataType="String" BindType="Both" runat="server" Checked="true" />
                            </div>
                        </div>                            
                     </div>
                      <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="Rounding"  class="col-sm-4">Rounding</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtRounding" runat="server" CssClass="form-control" placeholder ="Rounding" DBColumnName="ROUNDING" SPParameterName="p_rounding" DataType="Integer" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                 </div>
                  <div class="row">
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="lblrentflag" class="col-sm-4">Rent Flag</label>
                            <div class="col-sm-7">
                                <cc1:XUICheckBox ID="cbxRentFlag" DBColumnName="RENT_FLAG" SPParameterName="p_rent_flag" DataType="String" BindType="Both" runat="server" Checked="true" />
                            </div>
                        </div>                            
                     </div> 
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label runat="server" id="lblexpenseflag" class="col-sm-4">Prepaid Expense Flag</label>
                            <div class="col-sm-7">
                                <cc1:XUICheckBox ID="cbxExpenseFlag" DBColumnName="EXPENSE_FLAG" SPParameterName="p_expense_flag" DataType="String" BindType="Both" runat="server" Checked="true" />
                            </div>
                        </div>                            
                     </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Remarks</label>
                            <div class="col-sm-7">
                                <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="fa_remarks" SPParameterName="p_fa_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator2" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Upload Data / Memo : </label>
                            <div class="col-sm-7">
                                <asp:FileUpload ID="FileUploadMemoItem" runat="server" />
                                <asp:Button
                                    ID="btnUploadMemoItem"
                                    runat="server"
                                    CssClass="btn btn-primary"
                                    Text="Upload"
                                    UseSubmitBehavior="true"
                                    OnClick="btnUploadMemoItem_Click" />
                            </div>
                        </div>
                    </div>
                   </div>  
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                    <asp:PostBackTrigger ControlID="btnUploadMemoItem" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    <asp:Panel runat="server" ID="pnlDetail">
         <section class="panel">
            <header class="panel-heading tab-bg-dark-navy-blue">
                <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
                <ul class="nav nav-tabs nav-justified">
                    <li class="active">
                        <a href="#UploadDoc" id="poupdoc" onclick="javascript:fnSetTab('poupdoc');" data-toggle="tab" style="padding-bottom:28px">
                            History Upload Data / Memo
                        </a>
                    </li>
                </ul>
            </header>
            <div class="panel-body">
                <div class="tab-content tasi-tab">
                    <div class="tab-pane active" id="UploadDoc">
                        <div class="panel-heading">
                            <div class="row">
                            <div class="col-sm-4 ">
                                <asp:Panel ID="pnlSearchDocReq" runat="server" DefaultButton="btnSearchDocReq" class="input-group">
                                <asp:TextBox ID="txtSearchDocReq" runat="server" CssClass="form-control" ></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchDocReq" runat="server" CssClass="btn btn-info" OnClick="btnSearchDocReq_Click"><i class="icon-search"></i> Search</asp:LinkButton>
                                </div>
                           </asp:Panel>
                            </div>
                        </div>
                        </div>
                        <div class="panel-body">
                        <asp:GridView ID="gvwListDocReq" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10"
                            <!-- OnPageIndexChanging="gvwListDocReq_PageIndexChanging" OnRowDataBound="gvwListDocReq_OnRowDataBound" OnRowCommand="gvwListDocReq_RowCommand"
                            onselectedindexchanged="gvwListDocReq_SelectedIndexChanged" EmptyDataText="There is no data"  AllowSorting="true"> -->
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <span>No</span>
                                    </HeaderTemplate>
                                    <%--<ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>--%>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DESCRIPTION" HeaderText="Document">
                                    <ItemStyle Width="40%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="File Name">
                                <ItemStyle Width="60%" HorizontalAlign="Left" />
                                <%--<ItemTemplate>
                                     <asp:Label runat="server" Text='<%# Eval("PATHS") %>' ID="lblFileName"/>
                                     <br />
                                    <asp:FileUpload runat="server" ID="fupFilename" />
                                </ItemTemplate>--%>
                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <%-- <asp:Label ID="btnPreviewDoc" runat="server">Preview</asp:Label>--%>
                                         <asp:LinkButton ID="btnPreviewDoc" runat="server" CausesValidation="false" Text="Preview"/>
                                    </ItemTemplate>
                                </asp:TemplateField>                               
                            </Columns>
                            </asp:GridView>
                    </div>
                    </div>
                </div>

            </div>
            

         </section>

    </asp:Panel>
</asp:Content>
