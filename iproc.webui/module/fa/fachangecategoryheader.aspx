<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fachangecategoryheader.aspx.cs" Inherits="module_fa_fachangecategoryheader" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   

    <section class="panel">
        <header class="panel-heading">
          <span>Fixed Asset Change Category Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R90000130E" runat="server" CssClass="btn btn-primary" ValidationGroup="Header" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <%--<cc1:XUILinkButton ID="btnPost" RoleCode="R90000130O" runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>--%>
                    <%--// (+) Ari 27-12-2022 ket : tampilkan btn POST saat NEW--%>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R90000130O" runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                      <cc1:XUILinkButton RoleCode="R90000130O" ID="btnApprovalTiered" Visible ="false" runat="server" CssClass="btn btn-success"><i class="icon-ok"></i>  Approval</cc1:XUILinkButton>
                    <%--<cc1:XUILinkButton ID="btnReject" RoleCode="R10000002O" runat="server" CssClass="btn btn-danger" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>--%>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
           <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">--%>
                <ContentTemplate>
                    <!--CODE BARCODE-->
                        <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String"  BindType="Both" style="display:none" ></cc1:XUILabel> 
                       
                        <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblAmount" runat="server" SPParameterName="p_object_amount" DataType="Number" Text="0.00" DBColumnName="OBJECT_AMOUNT" style="display:none;" BindType="Both"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                        <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                         <cc1:XUITextBox ID="txtUnits" runat="server" CssClass="form-control"  DBColumnName="UNITS" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">FA Change Category No.</label>
                                <div class="col-sm-6">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                          <div class="col-sm-4">
                                      <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></cc1:XUILinkButton>
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
                                <label class="col-sm-4">Date *</label>
                                <div class="col-sm-4">
                                    <cc1:XUITextBox ID="txtChangeDate" runat="server" CssClass="form-control default-date-picker" placeholder="Change Date" DBColumnName="CHANGE_DATE" SPParameterName="p_change_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvChangeDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtChangeDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revChangeDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtChangeDate" ValidationGroup="Header" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                            </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From Cost Center</label>
                                <div class="col-sm-6">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" OnSelectedIndexChanged= "ddlBranch_SelectedIndexChanged" AutoPostBack="true" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>--%>
                                </div>
                            </div>                             
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From Location</label>
                               <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlFromLocationCode" runat="server" CssClass="form-control" DBColumnName="FROM_LOCATION_CODE" SPParameterName="p_from_location_code" OnSelectedIndexChanged= "ddlLocation_SelectedIndexChanged" AutoPostBack="true" BindType="Both" DataType="String" ></cc1:XUIDropDownList>                                                 
                                </div>
                            </div>                            
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From Item*</label>
                                <div class="col-sm-5">
                                    <asp:LinkButton runat="server" ID="btnLookUpAsset" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton> 
                                    <cc1:XUITextBox ID="txtItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblItemCode" runat="server"  DBColumnName="ITEM_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblItemName" runat="server"  DBColumnName="ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvItemCode" ValidationGroup="Header" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtItemCode" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To Item*</label>
                                <div class="col-sm-5">
                                    <asp:LinkButton runat="server" ID="btnLookToUpAsset" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton> 
                                    <cc1:XUITextBox ID="txtToItemCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_ITEM_CODE" SPParameterName="p_to_item_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblToItemCode" runat="server"  DBColumnName="TO_ITEM_CODE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblToItemName" runat="server"  DBColumnName="TO_ITEM_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Header" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtToItemCode" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From FA Depre Category Fiscal</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblFAdeprefiscal" runat="server" DBColumnName="CATEGORY_FISCAL" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>                        
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To FA Depre Category Fiscal</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblToDepreFis" runat="server" DBColumnName="TO_DEPRE_FIS_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtToDepreFis" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_DEPRE_FIS" SPParameterName="p_to_depre_fis" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                        
                         <%--<div class="col-sm-6">
                            <div class="form-group">
                                <label runat="server" id="FaDeprFis" class="col-sm-3">To FA Depre. Category Fiscal *</label>
                                    <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlFACategoryFiscalCode" runat="server" CssClass="form-control" DBColumnName="TO_DEPRE_FIS" SPParameterName="p_to_depre_fis" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvFACategoryFiscalCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlFACategoryFiscalCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                            </div>                            
                        </div>--%>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From FA Depre Category Commercial</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblFadeprecommercial" runat="server" DBColumnName="CATEGORY_COMERCIAL" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>                        
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To FA Depre Category Commercial</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblToDpreCom" runat="server" DBColumnName="TO_DEPRE_COM_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtToDpreCom" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_DEPRE_COM" SPParameterName="p_to_depre_com" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                        
                        <%--<div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">To FA Depre. Category Commercial *</label>
                                    <div class="col-sm-7">
                                        <cc1:XUIDropDownList ID="ddlFACategoryBookCode" runat="server" CssClass="form-control" DBColumnName="TO_DEPRE_COM" SPParameterName="p_to_depre_com" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                                        <asp:RequiredFieldValidator ID="rfvFACategoryBookCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlFACategoryBookCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>--%>
                        
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From Category</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCategory" runat="server"  DBColumnName="FROM_CATEGORY_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtCategory" runat="server" style="display:none"  CssClass="form-control" DBColumnName="FROM_CATEGORY_CODE" SPParameterName="p_from_category_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox> 
                                                                                
                                </div>
                            </div>                            
                        </div>                
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To Category</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblToCategoryCode" runat="server" DBColumnName="TO_CATEGORY_CODE_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtToCategoryCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="TO_CATEGORY_CODE" SPParameterName="p_to_category_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>
                        
                        <%--<div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">To Category *</label>
                                <div class="col-sm-8">
                                    <cc1:XUIDropDownList ID="ddlToCategory" runat="server" CssClass="form-control" DBColumnName="TO_CATEGORY_CODE" SPParameterName="p_to_category_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>    
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Header" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlToCategory" Display="Dynamic"></asp:RequiredFieldValidator>                                            
                                </div>
                            </div>                            
                        </div>--%>
                        
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From Item Group</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblFromItemGroup" runat="server" DBColumnName="FROM_GROUP_NAME" DataType="String"  BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">To Item Group</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblItemGroup" runat="server" DBColumnName="GROUP_NAME" DataType="String"  BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Cost Price</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCostPrice" runat="server" DBColumnName="COST_PRICE" DataType="Number" Format="N2" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div> 
                     </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Net Book Value</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblNetBookValue" runat="server" DBColumnName="NET_BOOK_VALUE" Format="N2" DataType="Number" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>
                          <div class="col-sm-6">
                            <div class="form-group">
                            </div>
                          </div>
                    </div> 
                    <div class="row">
                        <div class="col-sm-6" style="Display:none;">
                            <div class="form-group">
                                <label class="col-sm-4">Asset Type *</label>
                                <div class="col-sm-8">
                                    <cc1:XUIRadioButtonList ID="rblTypeAsset" runat="server"  DBColumnName="TYPE_ASSET" SPParameterName="p_type_asset" DataType="String" BindType="Both" RepeatLayout="Table" AutoPostBack="true" RepeatDirection="Horizontal" >
                                        <asp:ListItem Value="FA">Fixed Asset&nbsp&nbsp</asp:ListItem>
                                        <asp:ListItem Value="OPL">Operating List&nbsp&nbsp</asp:ListItem>
                                    </cc1:XUIRadioButtonList>
                                     <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Header" runat="server" ErrorMessage="Required Field!" ControlToValidate="rblTypeAsset" Display="Dynamic"></asp:RequiredFieldValidator> --%>
                                </div>
                            </div>                            
                        </div> 
                                           
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Description *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="100" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ValidationGroup="Header" ID="RegularExpressionValidator1" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 100" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>    
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>                               
                            </div>  
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Created  </label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName= "EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                    <span>@</span>
                                    <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName= "CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Modified </label>
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
                </Triggers>
            <%--</asp:UpdatePanel>--%>
        </div>
    </section>
 </asp:Content>
    