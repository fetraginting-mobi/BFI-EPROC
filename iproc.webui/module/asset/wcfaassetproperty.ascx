<%@ Control Language="C#" AutoEventWireup="true" CodeFile="wcfaassetproperty.ascx.cs" Inherits="module_asset_wcfaassetproperty" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<section class="panel">
    <%--<header class="panel-heading">
      <span>Asset Property Info</span>
    </header>--%>        
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12">
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true" ValidationGroup="Property"><i class="icon-save"></i>  Save</asp:LinkButton>
            </div>
        </div>
    </div>
    <div class="panel-body form-horizontal"> <%--(+) Start - 2015/12/10 - 08:31 - Adi - mengatur kolom menjadi total ukuran 12--%>
        <div class="row">
             <div class="col-sm-6">
                <div class="form-group">
                    <div class="col-sm-4">
                        <label>Certificate No.</label>
                        <asp:RequiredFieldValidator ID="rfvCertificateNo" runat="server" ErrorMessage="*" ControlToValidate="txtCertificateNo" Display="Dynamic" ValidationGroup="Property"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtCertificateNo" runat="server" CssClass="form-control" placeholder="Certificate Number" DBColumnName="CERTIFICATE_NO" SPParameterName="p_certificate_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                     <label class="col-sm-4 ">Certificate Date</label>
                     <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtCertificateDate" runat="server" CssClass="form-control default-date-picker" placeholder="Certificate Date" DBColumnName="CERTIFICATE_DATE" SPParameterName="p_certificate_date" DataType="DateTime" Format="dd/MM/yyyy" BindType="Both" Width="160px"></cc1:XUITextBox>
                     </div>
                 </div>
             </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Land Size</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtLandSize" runat="server" CssClass="form-control" placeholder="Land Size" DBColumnName="LAND_SIZE" SPParameterName="p_land_size" DataType="Number" BindType="Both" Width="160px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Building Size</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtBuildingSize" runat="server" CssClass="form-control" placeholder="Building Size" DBColumnName="BUILDING_SIZE" SPParameterName="p_building_size" DataType="Number" BindType="Both" Width="160px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
         <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Surat Ukur No.</label>
                    <%--<asp:RequiredFieldValidator ID="rfvSuratUkurNo" runat="server" ErrorMessage="*" ControlToValidate="txtSuratUkurNo" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtSuratUkurNo" runat="server" CssClass="form-control" placeholder="Surat Ukur Number" DBColumnName="SURAT_UKUR_NO" SPParameterName="p_surat_ukur_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Site Plan No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtSitePlanNo" runat="server" CssClass="form-control" placeholder="Site Plan No" DBColumnName="SITE_PLAN_NO" SPParameterName="p_site_plan_no" DataType="String" MaxLength="50" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
         <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">PPJB No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtFakturNo" runat="server" CssClass="form-control" placeholder="PPJB Number" DBColumnName="PPJB_NO" SPParameterName="p_ppjb_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">AJB No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtAjbNo" runat="server" CssClass="form-control" placeholder="AJB Number" DBColumnName="AJB_NO" SPParameterName="p_ajb_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
         </div>
         <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">PHTB No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtPhtbNo" runat="server" CssClass="form-control" placeholder="PHTB Number" DBColumnName="PHTB_NO" SPParameterName="p_phtb_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">IMB No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="XUITextBox2" runat="server" CssClass="form-control" placeholder="IMB Number" DBColumnName="IMB_NO" SPParameterName="p_imb_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
             <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">KJPP No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtImbNo" runat="server" CssClass="form-control" placeholder="KJPP Number" DBColumnName="KJPP_NO" SPParameterName="p_kjpp_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">PBB No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtPbbNo" runat="server" CssClass="form-control" placeholder="PBB Number" DBColumnName="PBB_NO" SPParameterName="p_pbb_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
         <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Invoice No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtInvoiceNo" runat="server" CssClass="form-control" placeholder="Invoice No" DBColumnName="INVOICE_NO" SPParameterName="p_invoice_no" DataType="String" MaxLength="50" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
             <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Address</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtAddressAsset" runat="server" CssClass="form-control" placeholder="Address Asset" DBColumnName="ADDRESS_ASSET" SPParameterName="p_address_asset" MaxLength="1000" DataType="String" BindType="Both" TextMode="MultiLine" Width="300px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Kelurahan</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtKelurahan" runat="server" CssClass="form-control" placeholder="Kelurahan" DBColumnName="KELURAHAN" SPParameterName="p_kelurahan" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>    
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Kecamatan</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtKecamatan" runat="server" CssClass="form-control" placeholder="Kecamatan" DBColumnName="KECAMATAN" SPParameterName="p_kecamatan" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>      
        </div>
        <div class="row"> 
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Kabupaten</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtKabupaten" runat="server" CssClass="form-control" placeholder="Kabupaten" DBColumnName="KABUPATEN" SPParameterName="p_kabupaten" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Zip Code</label>
                        <asp:RequiredFieldValidator ID="rfvZipCode" runat="server" ErrorMessage="*" ControlToValidate="txtZipCode" Display="Dynamic" ValidationGroup="Property"></asp:RequiredFieldValidator>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <cc1:XUITextBox ID="txtZipCode" runat="server"  CssClass="form-control" DBColumnName="ZIP_CODE" SPParameterName="p_zip_code" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                        </div>
                    </div>
                </div>                            
            </div>
        </div>
        <%----------------------------%>
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
            <div class="col-sm-6">
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
         <div class="row" style="display:none">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">PIB No.</label>
                    <%--<asp:RequiredFieldValidator ID="rfvPIBNo" runat="server" ErrorMessage="*" ControlToValidate="txtPIBNo" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtPIBNo" runat="server" CssClass="form-control" placeholder="PIB Number" DBColumnName="PIB_NO" SPParameterName="p_pib_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Type Property</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtTypeProperty" runat="server" CssClass="form-control" placeholder="Type Property" DBColumnName="TYPE_PROPERTY" SPParameterName="p_type_property" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div> 
        </div>
        <div class="row" style="display:none">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Type Certification</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtTypeCertification" runat="server" CssClass="form-control" placeholder="Type Certification" DBColumnName="TYPE_CERTIFICATION" SPParameterName="p_type_certification" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
             <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Faktur No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="XUITextBox1" runat="server" CssClass="form-control" placeholder="Faktur Number" DBColumnName="FAKTUR_NO" SPParameterName="p_faktur_no" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="display:none">
            <div class="col-sm-6">
                <div class="form-group">
                     <label class="col-sm-4 ">Exp. Date SHGB</label>
                     <div class="col-sm-8">
                             <cc1:XUITextBox ID="txtExpDate" runat="server" CssClass="form-control default-date-picker" placeholder="Exp. Date SHGB" DBColumnName="EXP_DATE_SHGB" SPParameterName="p_exp_date_shgb" DataType="DateTime" Format="dd/MM/yyyy" BindType="Both" Width="160px"></cc1:XUITextBox>
                     </div>
                 </div>
             </div>
             <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Daya Listrik</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtDayaListrik" runat="server" CssClass="form-control" placeholder="Daya Listrik" DBColumnName="DAYA_LISTRIK" SPParameterName="p_daya_listrik" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="display:none">
            <div class="col-sm-6" style="display:none">
                <div class="form-group">
                    <label class="col-sm-4">Location</label>
                    <%--<asp:RequiredFieldValidator ID="rfvModelCode" runat="server" ErrorMessage="*" ControlToValidate="txtModelCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    <div class="col-sm-8">
                    <div class="input-group">
                        <cc1:XUITextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="City" DBColumnName="CITY_ID" SPParameterName="p_city_id" DataType="Integer" BindType="Both" style="display:none"></cc1:XUITextBox>
                    </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6" style="display:none">
                <div class="form-group">
                    <label class="col-sm-4">Made In</label>
                    <%--<asp:RequiredFieldValidator ID="rfvColour" runat="server" ErrorMessage="*" ControlToValidate="txtColour" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    <div class="col-sm-8">
                        <%--<cc1:XUIDropDownList ID="ddlMadeIn" runat="server" CssClass="form-control" DBColumnName="MADE_IN_ID" SPParameterName="p_made_in_id" BindType="Both" DataType="String" Width="180px"></cc1:XUIDropDownList>--%>
                        <cc1:XUILabel ID="lblMadeInId" runat="server" DBColumnName="MADE_IN" SPParameterName="p_made_in" DataType="String" BindType="Both" Text="" Visible="False"></cc1:XUILabel>
                    </div>
                </div>
            </div>
            <div class="col-sm-6"  style="display:none">
                <div class="form-group">
                    <label class="col-sm-4">Built Year</label>
                    <%--<asp:RequiredFieldValidator ID="rfvBuiltYear" runat="server" ErrorMessage="*" ControlToValidate="txtBuiltYear" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtBuiltYear" runat="server" CssClass="form-control" placeholder="Built Year" DBColumnName="BUILT_YEAR" SPParameterName="p_built_year" MaxLength="4" DataType="String" BindType="Both" Width="140px"></cc1:XUITextBox>
                        <%--<cc1:XUILabel ID="lblBuiltYear" runat="server" DBColumnName="BUILT_YEAR" SPParameterName="p_built_year" DataType="String" BindType="Both" Text=""></cc1:XUILabel>--%>
                    </div>
                </div>
            </div>
        </div>
        <div class="row"  style="display:none">
            <div class="col-sm-6">
                  <div class="form-group">
                        <label class="col-sm-4">Blue Print Flag</label>
                        <div class="col-sm-8">
                           <cc1:XUICheckBox ID="chbIsBluePrint" runat="server" DBColumnName="IS_BLUEPRINT" SPParameterName="p_is_blueprint" DataType="String" BindType="Both"></cc1:XUICheckBox>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                <div class="form-group">
                    <label class="col-sm-4">Blue Print No.</label>
                    <div class="col-sm-8">
                        <cc1:XUITextBox ID="txtBluePrint" runat="server" CssClass="form-control" placeholder="BluePrint Number" DBColumnName="BLUEPRINT" SPParameterName="p_blueprint" MaxLength="50" DataType="String" BindType="Both" Width="250px"></cc1:XUITextBox>
                    </div>
                </div>
            </div>
        </div> 
        <div class="row"  style="display:none">
            <div class="col-sm-6" >
                <div class="form-group">
                    <label class="col-sm-4" style="color:Blue">FA Type</label>
                    <div class="col-sm-8">
                        <cc1:XUIDropDownList ID="ddlFAType" runat="server" CssClass="form-control" DBColumnName="FA_TYPE" SPParameterName="p_fa_type" BindType="Both" DataType="String" Width="250px"></cc1:XUIDropDownList>
                    </div>
                </div>
            </div>
        </div>  
    </div>
</section>