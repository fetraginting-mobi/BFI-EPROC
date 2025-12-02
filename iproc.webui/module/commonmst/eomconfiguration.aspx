<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true"    CodeFile="eomconfiguration.aspx.cs" Inherits="module_commonmst_eomconfiguration" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>EOM Configuration</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R30000201C" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>

                </div>
            </div>
        </div>
       <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">EOM Start Date*</label>                              
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtEomStartDate" runat="server"  CssClass="form-control default-date-picker-time"  placeholder="Date" DBColumnName="START_DATE" SPParameterName="p_start_date" MaxLength="20" DataType="DateTime" BindType="Both"  Format="dd/MM/yyyy HH:mm"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">EOM End Date*</label>                              
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtEomEndDate" runat="server"  CssClass="form-control default-date-picker-time" placeholder="Date" DBColumnName="END_DATE" SPParameterName="p_end_date" MaxLength="20" DataType="DateTime" BindType="Both"  Format="dd/MM/yyyy HH:mm"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                </div>
                 <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-sm-4">Is Auto Post Depreciation</label>                              
                            <div class="col-sm-3">
                                <cc1:XUICheckBox ID="chbIsAutoPosting" runat="server" DBColumnName="IS_AUTO_POSTING" SPParameterName="p_is_auto_posting" DataType="String" BindType="Both" />
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
    <script>
//        document.querySelectorAll('.default-date-picker-time').forEach(function (el) {
//            el.removeAttribute("onkeydown");
//            flatpickr(el, {
//                enableTime: true,
//                dateFormat: "d/m/Y H:i",
//                time_24hr: true,
//                allowInput: true,
//                defaultHour: 8,
//                defaultMinute: 0,
//                onClose: function (selectedDates, dateStr, instance) {
//                    if (el.value) {
//                        var parsed = instance.parseDate(el.value, instance.config.dateFormat);
//                        if (parsed) {
//                            instance.setDate(parsed, true);
//                        }
//                    }
//                }
//            });
//        });

        function initializeFlatpickr() {
            document.querySelectorAll('.default-date-picker-time').forEach(function (el) {
                el.removeAttribute("onkeydown");

                flatpickr(el, {
                    enableTime: true,
                    dateFormat: "d/m/Y H:i",
                    time_24hr: true,
                    allowInput: true,
                    defaultHour: 8,
                    defaultMinute: 0,
                    onClose: function (selectedDates, dateStr, instance) {
                        if (el.value) {
                            var parsed = instance.parseDate(el.value, instance.config.dateFormat);
                            if (parsed) {
                                instance.setDate(parsed, true);
                            }
                        }
                    }
                });
            });
        }
        
        // Call it once on page load
        initializeFlatpickr();

        // Call it again after every UpdatePanel postback (if applicable)
        if (typeof Sys !== "undefined" && Sys.WebForms && Sys.WebForms.PageRequestManager) {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                initializeFlatpickr();
            });
        }
    </script>
</asp:Content>
