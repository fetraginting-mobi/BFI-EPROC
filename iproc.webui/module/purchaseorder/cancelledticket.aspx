<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="cancelledticket.aspx.cs" Inherits="module_purchaseorder_cancelledticket" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
     <section class="panel">
        <header class="panel-heading">
          <span>Purchase Ticket/Hotel Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R07000005E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"  style="display:none"><i class="icon-save"></i>  </cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"  style="display:none"><i class="icon-remove"></i> </cc1:XUILinkButton>
                     <button CssClass="btn btn-danger" class="icon-remove" onclick="parent.fnHideGenericScreen();">Close</button>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
         <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
          <ContentTemplate>
          <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Purchase Ticket No.</label>
                        <div class="col-sm-6">
                            <!--ID-->
                            <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                            <!--Barcode-->
                            <cc1:XUILabel ID="lblTrxCode" runat="server" DBColumnName="BARCODE" SPParameterName="p_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
                            <!--Status Flag-->
                            <cc1:XUILabel ID="lblPTCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                        </div>
                    </div>
                </div>
                 <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Status</label>
                        <div class="col-sm-6">
                            <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" SPParameterName="p_status" DataType="String" BindType="Both" ></cc1:XUILabel>
                        </div>
                    </div>
                </div>
              </div>
              <div class="row">
                      
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">Code Booking</label> 
                        <span class="col-sm-1" id="mandatory" runat="server">*</span>
                         <span class="col-sm-1" id="spasi" runat="server"></span>    
                        <div class="col-sm-6">
                             <asp:LinkButton runat="server" ID="btnLookUpReffNo"  class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                            <cc1:XUITextBox ID="txtReffNo" runat="server"  CssClass="form-control" placeholder="Code Booking." DBColumnName="CODE_BOOKING" SPParameterName="p_code_booking"  DataType="String" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblReffNo" runat="server"  DBColumnName="CODE_BOOKING" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                           <%--   <cc1:XUILabel ID="lblRequestorName1" runat="server"  DBColumnName="REQUESTOR_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>--%>
                            <asp:RequiredFieldValidator ID="rfvReffNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReffNo" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        
                    </div>                            
                </div> 
                  <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Reff Type *</label>
                        <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlReffType" runat="server" CssClass="form-control" DBColumnName="REFF_TYPE"  AutoPostBack="true"  OnSelectedIndexChanged="ddlReffType_SelectedIndex" SPParameterName="p_reff_type" DataType="String" BindType="Both">
                              <asp:ListItem  Value="0">-=Select=-</asp:ListItem>
                              <asp:ListItem Selected Value="TP">Tiket Pesawat</asp:ListItem>
                              <asp:ListItem Value="TH">Voucher Hotel</asp:ListItem>
                            </cc1:XUIDropDownList>
                             <asp:RequiredFieldValidator ID="rfvddlReffType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlReffType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                           
                        </div>
                    </div>                            
                </div>              
            </div> 
            <div class="row">                        
                 <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Requestor *</label>
                        <div class="col-sm-6">
                            <asp:LinkButton runat="server" ID="btnLookUpRequestor"  class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table" ></i></asp:LinkButton>
                            <cc1:XUITextBox ID="txtRequestorCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="NAMA" SPParameterName="p_nama" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblRequestorName" runat="server"  DBColumnName="NAMA" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            
                            
                            <asp:RequiredFieldValidator ID="rfvRequestorName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRequestorCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Jabatan *</label>    
                        <div class="col-sm-6">
                            <cc1:XUITextBox ID="txtJabatan" runat="server"  CssClass="form-control" placeholder="Jabatan" DBColumnName="JABATAN" SPParameterName="p_jabatan"  DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvJabatan" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtJabatan" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div> 
            </div>
            <div class="row"> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Job Grade *</label>    
                        <div class="col-sm-6">
                            <cc1:XUITextBox ID="txtJG" runat="server"  CssClass="form-control" placeholder="Job Grade" DBColumnName="JOB_GRADE" SPParameterName="p_job_grade"  DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvJG" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtJG" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div> 
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Branch *</label>
                        <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                        </div>
                    </div>                             
                </div> 
            </div>
            <div class="row">
                <div class="col-sm-6" style="display:none">
                    <div class="form-group">
                        <label class="col-sm-4"> </label>
                        <div class="col-sm-6">
                        <cc1:XUILabel ID="lblFILE" runat="server" DBColumnName="FILE" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                        <cc1:XUILabel ID="lblPATH" runat="server" DBColumnName="PATHS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                            <asp:FileUpload ID="fupFilename" runat="server"></asp:FileUpload>
                           <%--<asp:RequiredFieldValidator ID="rfvFileName" runat="server" ErrorMessage="Required Field!" ControlToValidate="fupFilename" Display="Dynamic"></asp:RequiredFieldValidator> --%>
                            <asp:Label ID="btnPreviewDoc" runat="server">Preview</asp:Label>
                        </div>                            
                    </div>
                </div>
            </div>
          <div class="row">
            <div class="col-sm-6" ID="MKP" runat="server">
                   <div class="form-group">
                       <label class="col-sm-4">Airlines *</label>
                           <div class="col-sm-6">
                               <cc1:XUIDropDownList ID="ddlMaskapai" runat="server" CssClass="form-control" placeholder="" DBColumnName="MASKAPAI" SPParameterName="p_maskapai"  DataType="String" BindType="Both"></cc1:XUIDropDownList>
                               <asp:RequiredFieldValidator ID="rfvddlMaskapai" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlMaskapai" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                           </div>
                       </div>
                   </div> 
                <div class="col-sm-6" ID="DT" runat="server">
                    <div class="form-group">
                        <label class="col-sm-4">Date</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtDate" runat="server" CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="DATE" SPParameterName="p_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                            <asp:RegularExpressionValidator ID="revDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
             </div>
            <div class="row">
            <div class="col-sm-6" ID="Div1" runat="server">
                    <div class="form-group">
                        <label class="col-sm-4">Purpose Ticket *</label>
                            <div class="col-sm-6">
                                <cc1:XUIDropDownList ID="ddlPurpose" runat="server" CssClass="form-control" placeholder="" DBColumnName="PURPOSE_TICKET" SPParameterName="p_purpose_ticket"  DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                <asp:RequiredFieldValidator ID="rfvddlPurpose" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlPurpose" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                        </div>
                    </div>  
             </div>
            <div class="row">
                <div class="col-sm-6" ID="CBK" runat="server" >
                    <div class="form-group">
                        <%--<label class="col-sm-4">Code Booking</label>    
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtCodeBooking" runat="server"  CssClass="form-control" placeholder="Code Booking" DBColumnName="CODE_BOOKING" SPParameterName="p_code_booking"  DataType="String" BindType="Both"></cc1:XUITextBox>
                        </div>--%>
                    </div>                            
                </div>  
                <div class="col-sm-6" ID="TT" runat="server">
                    <div class="form-group">
                        <label class="col-sm-4">Ticket Type *</label>
                           <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlTicketType" runat="server" CssClass="form-control" DBColumnName="TIKET_TYPE" SPParameterName="p_tiket_type" BindType="Both" DataType="String">
                                 <asp:ListItem Value="0" >-=Select=-</asp:ListItem>
                                <asp:ListItem Value="DEPART">DEPART</asp:ListItem>
                                <asp:ListItem Value="TRANS">TRANSIT</asp:ListItem>
                                <asp:ListItem Value="RETURN">RETURN</asp:ListItem>
                            </cc1:XUIDropDownList>
                             <asp:RequiredFieldValidator ID="rfvddlTicketType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlTicketType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                            
                        </div>
                    </div>                            
                </div>
             </div>
            <div class="row">
                <div class="col-sm-6" ID="PLA" runat="server">
                    <div class="form-group">
                        <label class="col-sm-4">Plafond Amount</label>    
                        <div class="col-sm-6">
                            <cc1:XUITextBox ID="txtPlafondAmount" runat="server"  CssClass="form-control" placeholder="Plafond Amount" DBColumnName="PLAFOND_AMOUNT" SPParameterName="p_plafond_amount"  DataType="Number" Format="N2" Text="0.00"  BindType="Both"></cc1:XUITextBox>
                              <asp:RegularExpressionValidator ID="revPlafondAmount" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPlafondAmount" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>   
                        </div>
                    </div>                            
                </div> 
                <div class="col-sm-6" ID="LPR" runat="server">
                    <div class="form-group">
                        <label class="col-sm-4">Lowest Price</label>    
                        <div class="col-sm-6">
                            <cc1:XUITextBox ID="txtLowestPrice" runat="server"  CssClass="form-control" placeholder="Lowest Price" DBColumnName="HARGA_TERMURAH" SPParameterName="p_harga_termurah"  DataType="Number" Format="N2" Text="0.00" BindType="Both"></cc1:XUITextBox>
                            <asp:RegularExpressionValidator ID="revLowestPrice" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtLowestPrice" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>   
                        </div>
                    </div>                            
                </div> 
            </div>  
            <div class="row">
              
                <div class="col-sm-6" ID="TPR" runat="server">
                    <div class="form-group">
                        <label class="col-sm-4">Ticket Price *</label>    
                        <div class="col-sm-6">
                            <cc1:XUITextBox ID="txtTicketPrice" runat="server"  CssClass="form-control" placeholder="Ticket Price" DBColumnName="HARGA_TIKET" SPParameterName="p_harga_tiket"  DataType="Number" Format="N2" Text="0.00" BindType="Both"></cc1:XUITextBox>
                            <asp:RegularExpressionValidator ID="revTicketPrice" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtTicketPrice" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTicketPrice" InitialValue="0.00" Display="Dynamic"></asp:RequiredFieldValidator>    
                        </div>
                    </div>                            
                </div> 
             </div> 
            <div class="row">
                <div class="col-sm-6" ID="FRM" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">From *</label>    
                            <div class="col-sm-6">
                                <cc1:XUITextBox ID="txtFrom" runat="server"  CssClass="form-control" placeholder="From" DBColumnName="DARI" SPParameterName="p_dari"  DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvFrom" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtFrom" Display="Dynamic"></asp:RequiredFieldValidator> 
                            </div>
                        </div>                            
                    </div> 
                     <div class="col-sm-6" ID="DTM" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Departure Date *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtdeparturetime" runat="server" CssClass="form-control default-date-picker" placeholder="Departure Date" DBColumnName="WAKTU_KEBERANGKATAN" SPParameterName="p_waktu_keberangkatan" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="revDepartureTime" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="rfvDepartureTime" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDepartureTime"  Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div> 
              </div>
            <div class="row">
                    <div class="col-sm-6" ID="DTN" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Destination *</label>    
                            <div class="col-sm-6">
                                <cc1:XUITextBox ID="txtDestiny" runat="server"  CssClass="form-control" placeholder="Destiny" DBColumnName="TUJUAN" SPParameterName="p_tujuan"  DataType="String" BindType="Both"></cc1:XUITextBox>
                                 <asp:RequiredFieldValidator ID="rfvDestination" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDestiny"  Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div> 
                    <div class="col-sm-6" ID="WKB" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Arrived Date *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtTimeArrived" runat="server" CssClass="form-control default-date-picker" placeholder="Arrived Date" DBColumnName="WAKTU_TIBA" SPParameterName="p_waktu_tiba"  DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="rfvTimeArrived" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTimeArrived"  Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div> 
                 </div>
            <div class="row">   
                    <div class="col-sm-6" ID="HNM" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Hotel Name *</label>    
                            <div class="col-sm-6">
                                <cc1:XUITextBox ID="txtHotelName" runat="server"  CssClass="form-control" placeholder="Hotel Name" DBColumnName="NAMA_HOTEL" SPParameterName="p_nama_hotel"  DataType="String" BindType="Both" ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvHotelName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtHotelName"  Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div>   
                      <div class="col-sm-6" ID="NML" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Price *</label>    
                            <div class="col-sm-6">
                                <cc1:XUITextBox ID="txtNominal" runat="server"  CssClass="form-control" placeholder="Nominal" DBColumnName="NOMINAL" SPParameterName="p_nominal"  DataType="Number" Format="N2" Text="0.00" BindType="Both"  ></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rvfNominal" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtNominal" InitialValue="0.00"  Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revNominal" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtNominal" ValidationExpression="[0-9 .,/()]*[0-9 .,/()]" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                    </div> 
                 </div>  
            <div class="row">  
                     <div class="col-sm-6" ID="CID" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Check In Date *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtCheckIndate" runat="server" CssClass="form-control default-date-picker" placeholder="Check In Date" DBColumnName="CHECK_IN" SPParameterName="p_check_in"  DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtCheckIndate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="rfvCheckIndate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCheckIndate"  Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div> 
                   <div class="col-sm-6" ID="CKS" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Check Out Date *</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtCheckOutdate" runat="server" CssClass="form-control default-date-picker" placeholder="Check Out Date" DBColumnName="CHECK_OUT" SPParameterName="p_check_out"  DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtCheckOutdate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="rfvCheckOutDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCheckOutdate"  Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>                            
                    </div> 
                 </div>             
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Remarks *</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvRemarks" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRemarks" Display="Dynamic"></asp:RequiredFieldValidator>
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
            </div>
         </ContentTemplate>
       </asp:UpdatePanel>
    </section>
  </asp:Content>

