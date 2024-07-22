<%@ Control Language="C#" AutoEventWireup="true" CodeFile="wcfaassetvehicle.ascx.cs" Inherits="module_asset_wcfaassetvehicle" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<section class="panel">
    <%--<header class="panel-heading">
      <span>Vehicle Info</span>
    </header>--%>        
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12">
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true" ValidationGroup="Vehicle"><i class="icon-save"></i>  Save</asp:LinkButton>
            </div>
        </div>
    </div>
    <div class="panel-body form-horizontal"><%--(+) Start - 2015/12/08 - Adi - mengatur kolom menjadi total ukuran 12.--%>
        <asp:Panel ID="pnlAll" runat="server">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
            
            
         <%--(+) Start - 2016/01/18 -  14:15  - Gleen - diganti menggunakan label --%>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                    <label class="col-sm-4">Merk</label>
                                    <div class="col-sm-7">
                                     <%--   <asp:LinkButton runat="server" ID="btnLookUpMerk" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtMerk" style="display:none" runat="server" CssClass="form-control" DBColumnName="ASSET_MERK_CODE" SPParameterName="p_asset_merk_code" MaxLength="8" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblMerk" runat="server"  DBColumnName="ASSET_MERK_CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>--%>
                                        <cc1:XUILabel ID="lblMerkName" runat="server"  DBColumnName="MERK_NAME" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                        <%--<asp:RequiredFieldValidator ID="rfvMerk" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMerk" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>       
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                <label class="col-sm-4">Model</label>
                                    <%--<asp:RequiredFieldValidator ID="rfvModelCode" runat="server" ErrorMessage="*" ControlToValidate="txtModelCode" Display="Dynamic" ValidationGroup="Furniture"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <%--<asp:LinkButton ID="btnLookUpModelCode" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false" Enabled="false"><i class = "icon-table" ></i> </asp:LinkButton>--%>
                                        <%--<cc1:XUITextBox ID="txtModelCodeDesc" CssClass="form-control" runat="server" DBColumnName="ASSET_MODEL_DESC" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox>--%>
                                       <cc1:XUILabel ID="lblModelCode" runat="server" DBColumnName="ASSET_MODEL_CODE" SPParameterName="p_asset_model_code" DataType="String"  BindType="DBToUIOnly" ></cc1:XUILabel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Type</label>
                                   <%-- <asp:RequiredFieldValidator ID="rfvTypeCode" runat="server" ErrorMessage="*" ControlToValidate="txtTypeCode" Display="Dynamic" ValidationGroup="Furniture"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                    <%--  <asp:LinkButton runat="server" ID="btnLookUpType" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                            <cc1:XUITextBox ID="txtType" style="display:none" runat="server" CssClass="form-control" DBColumnName="ASSET_TYPE_CODE" SPParameterName="p_asset_type_code" MaxLength="8" DataType="String" BindType="Both"></cc1:XUITextBox>
                                            <cc1:XUILabel ID="lblType" runat="server"  DBColumnName="ASSET_TYPE_CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>--%>
                                            <cc1:XUILabel ID="lblTypeName" runat="server"  DBColumnName="TYPE_NAME" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                            <%--<asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtType" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-6" style="display:none">
                            <div class="form-group">
                                <label class="col-sm-4">Category</label>
                                   <%-- <asp:RequiredFieldValidator ID="rfvCategoryCode" runat="server" ErrorMessage="*" ControlToValidate="txtCategoryCode" Display="Dynamic" ValidationGroup="Furniture"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <%--<asp:LinkButton ID="btnLookUpCategoryCode" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false" Enabled="false"><i class = "icon-table" ></i> </asp:LinkButton>--%>
                                        <cc1:XUITextBox ID="txtCategoryCodeDesc" CssClass="form-control" runat="server" DBColumnName="ASSET_CATEGORY_DESC" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                        <cc1:XUITextBox ID="txtCategoryCode" runat="server" CssClass="form-control" placeholder="Category Code" DBColumnName="ASSET_CATEGORY_CODE" SPParameterName="p_asset_category_code" MaxLength="3" DataType="String" BindType="Both" ></cc1:XUITextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Plat No</label>
                                <asp:RequiredFieldValidator ID="rfvPlatNo1" runat="server" ErrorMessage="*" ControlToValidate="txtPlatNo1" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="rfvPlatNo2" runat="server" ErrorMessage="*" ControlToValidate="txtPlatNo2" Display="Dynamic" ></asp:RequiredFieldValidator>
                               
                                <asp:RequiredFieldValidator ID="rfvPlatNo3" runat="server" ErrorMessage="*" ControlToValidate="txtPlatNo3" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <div class="col-sm-2">
                                    <cc1:XUITextBox ID="txtPlatNo1" runat="server" CssClass="form-control" placeholder="B" DBColumnName="PLAT_NO_1" SPParameterName="p_plat_no_1" MaxLength="3" DataType="String" BindType="Both" style="width: 80px;"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revPlatNo1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPlatNo1" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                                <div class="col-sm-2">    
                                    <cc1:XUITextBox ID="txtPlatNo2" runat="server" CssClass="form-control" placeholder="0000" DBColumnName="PLAT_NO_2" SPParameterName="p_plat_no_2" MaxLength="5" DataType="String" BindType="Both" style="width: 80px;"></cc1:XUITextBox>
                                     <asp:RegularExpressionValidator ID="revPlatNo2" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPlatNo2" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                 </div>
                                 <div class="col-sm-2">    
                                    <cc1:XUITextBox ID="txtPlatNo3" runat="server" CssClass="form-control" placeholder="ABC" DBColumnName="PLAT_NO_3" SPParameterName="p_plat_no_3" MaxLength="4" DataType="String" BindType="Both" style="width: 58px;"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revPlatNo3" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPlatNo3" ValidationExpression="^([\sA-Za-z]+)$"  Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>  
                    </div>
                    <%--(+) End - 2016/01/18 -  14:15  - Gleen - --%>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label>Chassis No</label>
                                    <asp:RequiredFieldValidator ID="rfvChassisNumber" runat="server" ErrorMessage="*" ControlToValidate="txtChassisNumber" Display="Dynamic" ValidationGroup="Vehicle"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtChassisNumber" placeholder="Chassis No" runat="server" CssClass="form-control" DBColumnName="CHASSIS_NO" SPParameterName="p_chassis_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label>Engine No</label>
                                    <asp:RequiredFieldValidator ID="rfvEngineNumber" runat="server" ErrorMessage="*" ControlToValidate="txtEngineNumber" Display="Dynamic" ValidationGroup="Vehicle"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtEngineNumber" placeholder="Engine No" runat="server" CssClass="form-control" DBColumnName="ENGINE_NO" SPParameterName="p_engine_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">BPKB No</label>
                               <%-- <asp:RequiredFieldValidator ID="rfvBPKBNumber" runat="server" ErrorMessage="*" ControlToValidate="txtBPKBNumber" Display="Dynamic" ValidationGroup="Vehicle"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtBPKBNumber" placeholder="BPKB No" runat="server" CssClass="form-control" DBColumnName="BPKB_NO" SPParameterName="p_bpkb_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">BPKB Name</label>
                                <asp:RequiredFieldValidator ID="rfvBPKBName" runat="server" ErrorMessage="*" ControlToValidate="txtBPKBName" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtBPKBName" placeholder="BPKB Name" runat="server" CssClass="form-control" DBColumnName="BPKB_NAME" SPParameterName="p_bpkb_name" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">BPKB Address</label>
                                <asp:RequiredFieldValidator ID="rfvBPKBAddress" runat="server" ErrorMessage="*" ControlToValidate="txtBPKBAddress" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtBPKBAddress" placeholder="BPKB Address" runat="server" CssClass="form-control" DBColumnName="BPKB_ADDRESS" SPParameterName="p_bpkb_address" MaxLength="1000" DataType="String" BindType="Both" TextMode="MultiLine" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Colour</label>
                                <asp:RequiredFieldValidator ID="rfvColour" runat="server" ErrorMessage="*" ControlToValidate="txtColour" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtColour" placeholder="Colour" runat="server" CssClass="form-control" DBColumnName="COLOUR" SPParameterName="p_colour" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">STNK No</label>
                                <asp:RequiredFieldValidator ID="rfvSTNKNumber" runat="server" ErrorMessage="*" ControlToValidate="txtSTNKNumber" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtSTNKNumber" placeholder="STNK No" runat="server" CssClass="form-control" DBColumnName="STNK_NO" SPParameterName="p_stnk_no" MaxLength="50" DataType="String" BindType="Both" Width="180px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">STNK Name</label>
                                <asp:RequiredFieldValidator ID="rfvSTNKName" runat="server" ErrorMessage="*" ControlToValidate="txtSTNKName" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtSTNKName" placeholder="STNK Name" runat="server" CssClass="form-control" DBColumnName="STNK_NAME" SPParameterName="p_stnk_name" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>  
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">STNK Expired Date</label>
                                <asp:RequiredFieldValidator ID="rfvSTNKExpiredDate" runat="server" ErrorMessage="*" ControlToValidate="txtSTNKExpiredDate" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtSTNKExpiredDate" placeholder="STNK Expired Date" runat="server" CssClass="form-control default-date-picker"  DBColumnName="STNK_EXPIRED_DATE" SPParameterName="p_stnk_expired_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" Width="180px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">STNK Tax Date</label>
                                <asp:RequiredFieldValidator ID="rfvSTNKTaxDate" runat="server" ErrorMessage="*" ControlToValidate="txtSTNKTaxDate" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtSTNKTaxDate" placeholder="STNK Tax Date" runat="server" CssClass="form-control default-date-picker" DBColumnName="STNK_TAX_DATE" SPParameterName="p_stnk_tax_date" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy" Width="180px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Manufacture Year</label>
                                <%--<asp:RequiredFieldValidator ID="rfvBuiltYear" runat="server" ErrorMessage="*" ControlToValidate="txtBuiltYear" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtBuiltYear" placeholder="Build Year" runat="server" CssClass="form-control" DBColumnName="BUILT_YEAR" SPParameterName="p_built_year" MaxLength="4" DataType="String" BindType="Both" Width="140px"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revBuiltYear" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtBuiltYear" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    <%--<cc1:XUILabel ID="lblBuiltYear" runat="server" DBColumnName="BUILT_YEAR" SPParameterName="p_built_year" DataType="String" BindType="Both" Text=""></cc1:XUILabel>--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Made In</label>
                                <%--<asp:RequiredFieldValidator ID="rfvColour" runat="server" ErrorMessage="*" ControlToValidate="txtColour" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-8">
                                    <%--<cc1:XUIDropDownList ID="ddlMadeIn" runat="server" CssClass="form-control" DBColumnName="MADE_IN_ID" SPParameterName="p_made_in_id" BindType="Both" DataType="String" Width="180px"></cc1:XUIDropDownList>--%>
                                    <%--<cc1:XUILabel ID="lblMadeInId" runat="server" DBColumnName="MADE_IN" SPParameterName="p_made_in" DataType="String" BindType="Both" Text="" Visible="False"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblMadeIn" runat="server" DBColumnName="MADE_IN_DESC" SPParameterName="p_made_in_desc" DataType="String" BindType="Both" Text=""></cc1:XUILabel>--%>
                                     <cc1:XUITextBox ID="txtMadeIn" placeholder="Made In" runat="server" CssClass="form-control" DBColumnName="MADE_IN" SPParameterName="p_made_in" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Faktur No</label>
                                <asp:RequiredFieldValidator ID="rfvFakturNumber" runat="server" ErrorMessage="*" ControlToValidate="txtFakturNumber" Display="Dynamic" ></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtFakturNumber" placeholder="Faktur No" runat="server" CssClass="form-control" DBColumnName="FAKTUR_NO" SPParameterName="p_faktur_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Faktur Type</label>
                               <%-- <asp:RequiredFieldValidator ID="rfvFakturType" runat="server" ErrorMessage="*" ControlToValidate="rblFakturType" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-8">
                                     <cc1:XUIRadioButtonList ID="rblFakturType" runat="server" DBColumnName="FAKTUR_TYPE" SPParameterName="p_faktur_type" DataType="String" BindType="Both" RepeatDirection="Horizontal" onselectedindexchanged="rblFakturType_SelectedIndexChanged">
                                     <asp:ListItem Value="A" Text="  Form A&nbsp&nbsp&nbsp"></asp:ListItem>
                                     <asp:ListItem Value="B" Text="  Form B&nbsp&nbsp&nbsp"></asp:ListItem>
                                     <asp:ListItem Value="C" Text="  Form C"></asp:ListItem>
                                     </cc1:XUIRadioButtonList>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6" style="display:none">
                            <div class="form-group">
                                <label class="col-sm-4" style="color:Blue">FA Type</label>
                                <div class="col-sm-8">
                                    <cc1:XUIDropDownList ID="ddlFAType" runat="server" CssClass="form-control" DBColumnName="FA_TYPE" SPParameterName="p_fa_type" BindType="Both" DataType="String" Width="250px"></cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Cylinder</label>
                                <asp:RequiredFieldValidator ID="rfvCylinder" runat="server" ErrorMessage="*" ControlToValidate="txtCylinder" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtCylinder" placeholder="Cylinder" runat="server" CssClass="form-control" DBColumnName="CYLINDER" SPParameterName="p_cylinder" MaxLength="20" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Fuel</label>
                                <asp:RequiredFieldValidator ID="rfvFuel" runat="server" ErrorMessage="*" ControlToValidate="ddlFuel" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <%--<cc1:XUITextBox ID="txtFuel" runat="server" CssClass="form-control" DBColumnName="FUEL" SPParameterName="p_fuel" MaxLength="20" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>--%>
                                    <cc1:XUIDropDownList ID="ddlFuel" runat="server" CssClass="form-control" DBColumnName="FUEL" SPParameterName="p_fuel" BindType="Both" DataType="String" Width="250px">
                                        <asp:ListItem Value="BENSIN" Text="Bensin"></asp:ListItem>
                                        <asp:ListItem Value="DIESEL" Text="Diesel"></asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Transmisi</label>
                                <asp:RequiredFieldValidator ID="rfvTransmisi" runat="server" ErrorMessage="*" ControlToValidate="ddlTransmisi" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-8">
                                    <cc1:XUIDropDownList ID="ddlTransmisi" runat="server" CssClass="form-control" DBColumnName="TRANSMISI" SPParameterName="p_transmisi" BindType="Both" DataType="String" Width="250px">
                                        <asp:ListItem Value="MANUAL" Text="Manual"></asp:ListItem>
                                        <asp:ListItem Value="AUTOMATIC" Text="Automatic"></asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="display:none">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Location</label>
                                <%--<asp:RequiredFieldValidator ID="rfvModelCode" runat="server" ErrorMessage="*" ControlToValidate="txtModelCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <asp:LinkButton ID="btnLookUpLocation" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                                        <cc1:XUITextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="City" DBColumnName="CITY_ID" SPParameterName="p_city_id" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                       <%-- <cc1:XUITextBox ID="txtLocationDesc" CssClass="form-control" runat="server" DBColumnName="CITY_DESC" DataType="String" BindType="DBToUIOnly" Enabled="false" Width="250px"></cc1:XUITextBox>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="display:none">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks1" runat="server" CssClass="form-control" DBColumnName="REMARKS_01" SPParameterName="p_remarks_01" MaxLength="1000" DataType="String" BindType="Both" TextMode="MultiLine" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6" style="display:none">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks 2</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks2" runat="server" CssClass="form-control" placeholder="Remarks 2" DBColumnName="REMARKS_02" SPParameterName="p_remarks_02" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="display:none">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks 3</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks3" runat="server" CssClass="form-control" placeholder="Remarks 3" DBColumnName="REMARKS_03" SPParameterName="p_remarks_03" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks 4</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks4" runat="server" CssClass="form-control" placeholder="Remarks 4" DBColumnName="REMARKS_04" SPParameterName="p_remarks_04" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="display:none">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks 5</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks5" runat="server" CssClass="form-control" placeholder="Remarks 5" DBColumnName="REMARKS_05" SPParameterName="p_remarks_05" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks 6</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks6" runat="server" CssClass="form-control" placeholder="Remarks 6" DBColumnName="REMARKS_06" SPParameterName="p_remarks_06" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <div class="row" style="display:none">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks 7</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks7" runat="server" CssClass="form-control" placeholder="Remarks 7" DBColumnName="REMARKS_07" SPParameterName="p_remarks_07" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks 8</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks8" runat="server" CssClass="form-control" placeholder="Remarks 8" DBColumnName="REMARKS_08" SPParameterName="p_remarks_08" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="display:none">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks 9</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks9" runat="server" CssClass="form-control" placeholder="Remarks 9" DBColumnName="REMARKS_09" SPParameterName="p_remarks_09" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2">Remarks 10</label>
                                <div class="col-sm-10">
                                    <cc1:XUITextBox ID="txtRemarks10" runat="server" CssClass="form-control" placeholder="Remarks 10" DBColumnName="REMARKS_10" SPParameterName="p_remarks_10" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    </Triggers>
            </asp:UpdatePanel>
        </asp:Panel>
    </div><%--(+) END - 2015/12/08 - Adi ---%>
</section>