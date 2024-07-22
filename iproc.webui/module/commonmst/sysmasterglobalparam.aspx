<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"    CodeFile="sysmasterglobalparam.aspx.cs" Inherits="module_commonmst_sysmasterglobalparam" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Global Parameter Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000190E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>

                </div>
            </div>
        </div>
       <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                 <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <cc1:XUILabel ID="lblId" runat="server"  CssClass="form-control" placeholder="Id" DBColumnName="ID" SPParameterName="p_id" MaxLength="5" DataType="Integer" BindType="Both" Visible="false" Text="0"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                   <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Inventory Method *</label>
                            <div class="col-sm-6">
                                <cc1:XUIDropDownList ID="ddlInventoryMetod" runat="server" CssClass="form-control" placeholder="" DBColumnName="INVENTORY_METOD" SPParameterName="p_inventory_metod"  MaxLength="50" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Stock Aging 1</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtStockAging1" runat="server" CssClass="form-control" placeholder="Stock Aging 1" DBColumnName="STOCK_AGING1" SPParameterName="p_stock_aging1"  DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Stock Aging 2</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtStockAging2" runat="server" CssClass="form-control" placeholder="Stock Aging 2" DBColumnName="STOCK_AGING2" SPParameterName="p_stock_aging2"  DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Stock Aging 3</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtStockAging3" runat="server" CssClass="form-control" placeholder="Stock Aging 3" DBColumnName="STOCK_AGING3" SPParameterName="p_stock_aging3"  DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Stock Aging 4</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtStockAging4" runat="server" CssClass="form-control" placeholder="Stock Aging 4" DBColumnName="STOCK_AGING4" SPParameterName="p_stock_aging4"  DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                 <div class="col-sm-6">
                         <div class="form-group">
                                <label class="col-sm-4">Acc Stock Variance No.</label>
                             <div class="col-sm-4">
                                    <asp:LinkButton runat="server" ID="btnLookUpAccStockVariance" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtAccStockVariance" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_STOCK_VARIANCE" SPParameterName="p_acc_stock_variance" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAccStockVariance" runat="server"  style="display:none" DBColumnName="ACC_STOCK_VARIANCE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNameAccStockVariance"  runat="server"  DBColumnName="ACC_STOCK_VARIANCE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                              </div>
                           </div>                            
                     </div>
                     <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Non Tax Code</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtNonTax" runat="server" CssClass="form-control" placeholder="Non tax" DBColumnName="NON_TAX" SPParameterName="p_non_tax"  DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">AP Aging 1</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtApAging1" runat="server" CssClass="form-control" placeholder="AP Aging 1" DBColumnName="AP_AGING1" SPParameterName="p_ap_aging1"  DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">AP Aging 2</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtApAging2" runat="server" CssClass="form-control" placeholder="AP Aging 2" DBColumnName="AP_AGING2" SPParameterName="p_ap_aging2"  DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">AP Aging 3</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtApAging3" runat="server" CssClass="form-control" placeholder="AP Aging 3" DBColumnName="AP_AGING3" SPParameterName="p_ap_aging3"  DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">AP Aging 4</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtApAging4" runat="server" CssClass="form-control" placeholder="AP Aging 4" DBColumnName="AP_AGING4" SPParameterName="p_ap_aging4"  DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                         <div class="form-group">
                                <label class="col-sm-4">Acc AP Variance No.</label>
                             <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookUpAccAPVariance" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtAccAPVariance" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_AP_VARIANCE" SPParameterName="p_acc_ap_variance" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblAccAPVariance" runat="server"  style="display:none" DBColumnName="ACC_AP_VARIANCE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblNameAccAPVariance"  runat="server"  DBColumnName="ACC_AP_VARIANCE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                              </div>
                           </div>                            
                     </div>
                     <div class="col-sm-6">
                         <div class="form-group">
                            <label class="col-sm-4">Acc Advance No.</label>
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookUpAccAdvance" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtAccAdvance" style="display:none" runat="server" CssClass="form-control" DBColumnName="ACC_ADVANCE_NO" SPParameterName="p_acc_advance_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblAccAdvance" runat="server"  style="display:none" DBColumnName="ACC_ADVANCE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblNameAccAdvance"  runat="server"  DBColumnName="ACC_ADVANCE_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                         <div class="form-group">
                                <label class="col-sm-4">Stamp Duty Code.</label>
                             <div class="col-sm-7">
                                    <asp:LinkButton runat="server" ID="btnLookTrxType" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtTrxType" style="display:none" runat="server" CssClass="form-control" DBColumnName="STAMP_DUTY_CODE" SPParameterName="p_stamp_duty_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblTrxTypeCode" style="display:none" runat="server"  DBColumnName="STAMP_DUTY" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                    <cc1:XUILabel ID="lblTrxType"  runat="server"  DBColumnName="STAMP_DUTY" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                              </div>
                           </div>                            
                     </div>
                     <div class="col-sm-6">
                         <div class="form-group">
                            <label class="col-sm-4">Discount Code.</label>
                            <div class="col-sm-7">
                                <asp:LinkButton runat="server" ID="btnLookTrxTypeDiscount" class="btn btn-primary" data-toggle="modal" CausesValidation="false" ><i class="icon-table"></i></asp:LinkButton>
                                <cc1:XUITextBox ID="txtTrxTypeDiscount" style="display:none" runat="server" CssClass="form-control" DBColumnName="DISCOUNT_CODE" SPParameterName="p_discount_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <cc1:XUILabel ID="lblTrxTypeCodeDiscount" style="display:none" runat="server"  DBColumnName="DISCOUNT" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                <cc1:XUILabel ID="lblTrxTypeDiscount"  runat="server"  DBColumnName="DISCOUNT" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                            </div>
                        </div>                            
                     </div>
                </div>
                <div class="row">
                   <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">COGS Method *</label>
                            <div class="col-sm-6">
                                <cc1:XUIDropDownList ID="ddlCogsMethod" runat="server" CssClass="form-control" placeholder="" DBColumnName="COGS_METHOD" SPParameterName="p_cogs_method"  MaxLength="50" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                            </div>
                        </div>                            
                    </div>  
                      <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Depre Start Useful < </label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtDepreUsefull" runat="server" CssClass="form-control" placeholder="Depre UseFull" DBColumnName="DEPRE_USEFUL" SPParameterName="p_depre_useful"  DataType="Number" BindType="Both" format="N0" MaxLength="8" ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>                  
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">File Upload Path *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtFileUploadPath" runat="server" CssClass="form-control" placeholder="File Upload Path" DBColumnName="FILE_UPLOAD_PATH" SPParameterName="p_file_upload_path"  DataType="String" BindType="Both" ></cc1:XUITextBox>
                           <%-- <asp:RequiredFieldValidator ID="rfvFileUploadPath" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFileUploadPath" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">URL Server</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtUrlServer" runat="server" CssClass="form-control" placeholder="URL Server" DBColumnName="URL_SERVER" SPParameterName="p_url_server"  DataType="String" BindType="Both"  ></cc1:XUITextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvUnitDesc" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtUnitdesc" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Min. Duedate AP *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtMinDuedateAP" runat="server" CssClass="form-control" placeholder="Min. Duedate AP" DBColumnName="MIN_DUEDATE_AP" SPParameterName="p_min_duedate_ap"  DataType="Integer" BindType="Both" MaxLength="4" ></cc1:XUITextBox>
                           <%-- <asp:RequiredFieldValidator ID="rfvMinDuedateAP" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMinDuedateAP" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Min. Duedate PO *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtMinDuedatePO" runat="server" CssClass="form-control" placeholder="Min. Duedate PO" DBColumnName="MIN_DUEDATE_PO" SPParameterName="p_min_duedate_po"  DataType="Integer" BindType="Both" MaxLength="4" ></cc1:XUITextBox>
                           <%-- <asp:RequiredFieldValidator ID="rfvMinDuedatePO" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMinDuedatePO" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            </div>
                        </div>                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Start Date Promotion *</label>                              
                            <div class="col-sm-3">
                                <cc1:XUITextBox ID="txtRequestDate" runat="server"  CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="START_DATE" SPParameterName="p_start_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvRequestDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRequestDate" Display="Dynamic"></asp:RequiredFieldValidator>  
                            </div>
                                <asp:RegularExpressionValidator ID="revRequesstDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy"  MinimumValue="GetDate"  ControlToValidate="txtRequestDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">End Date Promotion *</label>                              
                            <div class="col-sm-3">
                                <cc1:XUITextBox ID="txtEndDatePromotion" runat="server"  CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="END_DATE" SPParameterName="p_end_date" MaxLength="10" DataType="DateTime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtEndDatePromotion" Display="Dynamic"></asp:RequiredFieldValidator>  
                            </div>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy"  MinimumValue="GetDate"  ControlToValidate="txtEndDatePromotion" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>                            
                    </div>
                </div>
                 <div class="row">
                <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Masa Asset Hak Guna (Month)*</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtMasaAsset" runat="server" CssClass="form-control" placeholder="Masa Asset Hak Guna" DBColumnName="ASSET_PERIOD_HAK_GUNA" SPParameterName="p_asset_period_hak_guna"  DataType="Integer" BindType="Both" MaxLength="4" ></cc1:XUITextBox>
                           <asp:RequiredFieldValidator ID="rfvMasaAsset" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtMasaAsset" Display="Dynamic"></asp:RequiredFieldValidator>
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
