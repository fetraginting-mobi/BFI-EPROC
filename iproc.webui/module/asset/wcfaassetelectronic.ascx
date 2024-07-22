<%@ Control Language="C#" AutoEventWireup="true" CodeFile="wcfaassetelectronic.ascx.cs" Inherits="module_asset_wcfaassetelectronic" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<section class="panel">
    <%--<header class="panel-heading">
      <span>Asset Electronic Info</span>
    </header>--%>        
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12">
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true" ValidationGroup="Electronic"><i class="icon-save"></i>  Save</asp:LinkButton>
            </div>
        </div>
    </div>
    <div class="panel-body form-horizontal"> <%--(+) Start - 2015/12/10 - 08:31 - Adi - mengatur kolom menjadi total ukuran 12--%>
        <%--(+) Start - 2016/01/18 -  14:15  - Gleen - diganti menggunakan label --%>
        <div class="row">
            <div class="col-sm-6" style="display:none">
                <div class="form-group">
                    <label class="col-sm-4">Category</label>
                        <%--<asp:RequiredFieldValidator ID="rfvCategoryCode" runat="server" ErrorMessage="*" ControlToValidate="txtCategoryCode" Display="Dynamic" ValidationGroup="Electronic"></asp:RequiredFieldValidator>--%>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <%--<asp:LinkButton ID="btnLookUpCategoryCode" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false" Enabled="false"><i class = "icon-table" ></i> </asp:LinkButton>--%>
                            <cc1:XUITextBox ID="txtCategoryCode" runat="server" CssClass="form-control" placeholder="Category Code" DBColumnName="ASSET_CATEGORY_CODE" SPParameterName="p_asset_category_code" MaxLength="3" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                            <cc1:XUITextBox ID="txtCategoryCodeDesc" CssClass="form-control" runat="server" DBColumnName="ASSET_CATEGORY_DESC" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="250px" style="border:0px; background:inherit"></cc1:XUITextBox> <%--(+) 2015/12/10 - 08:41- Adi - mengubah label lookup menjadi textbox--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Merk</label>
                    <div class="col-sm-7">
                        <asp:LinkButton runat="server" ID="btnLookUpMerk" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                        <cc1:XUITextBox ID="txtMerk" style="display:none" runat="server" CssClass="form-control" DBColumnName="ASSET_MERK_CODE" SPParameterName="p_asset_merk_code" MaxLength="8" DataType="String" BindType="Both"></cc1:XUITextBox>
                        <cc1:XUILabel ID="lblMerk" runat="server"  DBColumnName="ASSET_MERK_CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblMerkName" runat="server"  DBColumnName="MERK_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
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
                            <cc1:XUITextBox ID="XUITextBox1" runat="server" CssClass="form-control" placeholder="Model Code" DBColumnName="ASSET_MODEL_CODE" SPParameterName="p_asset_model_code" MaxLength="10" DataType="String" BindType="Both" ></cc1:XUITextBox>
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
                             <asp:LinkButton runat="server" ID="btnLookUpType" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtType" style="display:none" runat="server" CssClass="form-control" DBColumnName="ASSET_TYPE_CODE" SPParameterName="p_asset_type_code" MaxLength="8" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblType" runat="server"  DBColumnName="ASSET_TYPE_CODE" DataType="String" BindType="DBToUIOnly" Text="-" style="display:none;"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblTypeName" runat="server"  DBColumnName="TYPE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <%--<asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtType" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                        </div>
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
        <%--(+) End - 2016/01/18 -  14:15  - Gleen - --%>	
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Serial No</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtSerialNo" runat="server" CssClass="form-control" placeholder="Serial No" DBColumnName="SERIAL_NO" SPParameterName="p_serial_no" MaxLength="50" DataType="String" BindType="Both" Width="180px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Dimension</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtDimension" runat="server" CssClass="form-control" placeholder="Dimension" DBColumnName="DIMENSION" SPParameterName="p_dimension" MaxLength="50" DataType="String" BindType="Both" Width="180px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="display:none">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">FA Type</label>
                    <%--<asp:RequiredFieldValidator ID="rfvColour" runat="server" ErrorMessage="*" ControlToValidate="txtColour" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    <div class="col-sm-8">
                        <cc1:XUIDropDownList ID="ddlFAType" runat="server" CssClass="form-control" DBColumnName="FA_TYPE" SPParameterName="p_fa_type" BindType="Both" DataType="String" Width="250px"></cc1:XUIDropDownList>
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
                            <cc1:XUITextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="City" DBColumnName="CITY_ID" SPParameterName="p_city_id" DataType="Integer" BindType="Both" style="display:none"></cc1:XUITextBox>
                            <asp:LinkButton ID="btnLookUpLocation" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table" ></i> </asp:LinkButton>
                            <cc1:XUITextBox ID="txtLocationDesc" CssClass="form-control" runat="server" DBColumnName="CITY_DESC" DataType="String" BindType="DBToUIOnly" Enabled="false" Width="250px"></cc1:XUITextBox> <%--(+) 2015/12/10 - 08:41- Adi - mengubah label lookup menjadi textbox--%>
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
                        <cc1:XUITextBox ID="txtRemarks1" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS_01" SPParameterName="p_remarks_01" MaxLength="1000" DataType="String" BindType="Both" TextMode="MultiLine" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="display:none">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2">Remarks 2</label>
                    <div class="col-sm-10">
                        <cc1:XUITextBox ID="txtRemarks2" runat="server" CssClass="form-control" placeholder="Remarks 2" DBColumnName="REMARKS_02" SPParameterName="p_remarks_02" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="display:none">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2">Remarks 3</label>
                    <div class="col-sm-10">
                        <cc1:XUITextBox ID="txtRemarks3" runat="server" CssClass="form-control" placeholder="Remarks 3" DBColumnName="REMARKS_03" SPParameterName="p_remarks_03" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="display:none">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2">Remarks 4</label>
                    <div class="col-sm-10">
                        <cc1:XUITextBox ID="txtRemarks4" runat="server" CssClass="form-control" placeholder="Remarks 4" DBColumnName="REMARKS_04" SPParameterName="p_remarks_04" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div> 
        <div class="row" style="display:none">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2">Remarks 5</label>
                    <div class="col-sm-10">
                        <cc1:XUITextBox ID="txtRemarks5" runat="server" CssClass="form-control" placeholder="Remarks 5" DBColumnName="REMARKS_05" SPParameterName="p_remarks_05" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
       </div>
        <div class="row" style="display:none">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2">Remarks 6</label>
                    <div class="col-sm-10">
                        <cc1:XUITextBox ID="txtRemarks6" runat="server" CssClass="form-control" placeholder="Remarks 6" DBColumnName="REMARKS_06" SPParameterName="p_remarks_06" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div> 
        <div class="row" style="display:none">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2">Remarks 7</label>
                    <div class="col-sm-10">
                        <cc1:XUITextBox ID="txtRemarks7" runat="server" CssClass="form-control" placeholder="Remarks 7" DBColumnName="REMARKS_07" SPParameterName="p_remarks_07" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="display:none">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2">Remarks 8</label>
                    <div class="col-sm-10">
                        <cc1:XUITextBox ID="txtRemarks8" runat="server" CssClass="form-control" placeholder="Remarks 8" DBColumnName="REMARKS_08" SPParameterName="p_remarks_08" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div> 
        <div class="row" style="display:none">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2">Remarks 9</label>
                    <div class="col-sm-10">
                        <cc1:XUITextBox ID="txtRemarks9" runat="server" CssClass="form-control" placeholder="Remarks 9" DBColumnName="REMARKS_09" SPParameterName="p_remarks_09" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="display:none">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="col-sm-2">Remarks 10</label>
                    <div class="col-sm-10">
                        <cc1:XUITextBox ID="txtRemarks10" runat="server" CssClass="form-control" placeholder="Remarks 10" DBColumnName="REMARKS_10" SPParameterName="p_remarks_10" MaxLength="1000" DataType="String" BindType="Both" Width="80%"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
    </div> <%--(+) End - 2015/12/10 - 08:31 - Adi ---%>
</section>