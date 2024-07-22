<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="cancellationticketdetail.aspx.cs" Inherits="module_purchaseorder_cancellationticketdetail" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
 <section class="panel">
        <header class="panel-heading">
          <span>Cancellation Ticket Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R07000005E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Purchase Ticket No.</label>
                        <div class="col-sm-8">
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
                        <label class="col-sm-4">Reff No. *</label>    
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtReffNo" runat="server"  CssClass="form-control" placeholder="Reff No." DBColumnName="REFF_NO" SPParameterName="p_reff_no" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvReffNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtReffNo" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>                              
            </div> 
            <div class="row">                        
                 <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Requestor *</label>
                        <div class="col-sm-8">
                            <asp:LinkButton runat="server" ID="btnLookUpRequestor"  class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                            <cc1:XUITextBox ID="txtRequestorCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="NAMA" SPParameterName="p_nama" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblRequestorName" runat="server"  DBColumnName="REQUESTOR_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                            <asp:RequiredFieldValidator ID="rfvRequestorName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtRequestorCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Jabatan *</label>    
                        <div class="col-sm-8">
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
                        <div class="col-sm-8">
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
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Reff Type *</label>
                        <div class="col-sm-5">
                            <cc1:XUIDropDownList ID="ddlReffType" runat="server" CssClass="form-control" DBColumnName="REFF_TYPE"  AutoPostBack="true"  OnSelectedIndexChanged="ddlReffType_SelectedIndex" SPParameterName="p_reff_type" DataType="String" BindType="Both" MaxLength="15">
                              <asp:ListItem  Value="TP">Tiket Pesawat</asp:ListItem>
                              <asp:ListItem Value="TH">Tiket Hotel</asp:ListItem>
                            </cc1:XUIDropDownList>
                            <asp:RequiredFieldValidator ID="rfvReffType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlReffType" Display="Dynamic"></asp:RequiredFieldValidator>
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
                <div class="col-sm-6" ID="CBK" runat="server" >
                    <div class="form-group">
                        <label class="col-sm-4">Code Booking</label>    
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtCodeBooking" runat="server"  CssClass="form-control" placeholder="Code Booking" DBColumnName="CODE_BOOKING" SPParameterName="p_code_booking"  DataType="String" BindType="Both"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div>  
                <div class="col-sm-6" ID="TT" runat="server">
                    <div class="form-group">
                        
                    </div>                            
                </div>
             </div>
            <div class="row">
                <div class="col-sm-6" ID="TPR" runat="server">
                    <div class="form-group">
                        <label class="col-sm-4">Ticket Price</label>    
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtTicketPrice" runat="server"  CssClass="form-control" placeholder="Ticket Price" DBColumnName="HARGA_TIKET" SPParameterName="p_harga_tiket"  DataType="Number" BindType="Both"></cc1:XUITextBox>
                        </div>
                    </div>                            
                </div> 
             </div> 
            <div class="row">
                <div class="col-sm-6" ID="FRM" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">From</label>    
                            <div class="col-sm-8">
                                <cc1:XUITextBox ID="txtFrom" runat="server"  CssClass="form-control" placeholder="From" DBColumnName="DARI" SPParameterName="p_dari"  DataType="String" BindType="Both"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div> 
                     <div class="col-sm-6" ID="DTM" runat="server">
                        <div class="form-group">
                          
                        </div>                            
                    </div> 
              </div>
              <div class="row">
                    <div class="col-sm-6" ID="DTN" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Destiny</label>    
                            <div class="col-sm-8">
                                <cc1:XUITextBox ID="txtDestiny" runat="server"  CssClass="form-control" placeholder="Destiny" DBColumnName="TUJUAN" SPParameterName="p_tujuan"  DataType="String" BindType="Both"></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div> 
                    <div class="col-sm-6" ID="HNM" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Hotel Name</label>    
                            <div class="col-sm-8">
                                <cc1:XUITextBox ID="txtHotelName" runat="server"  CssClass="form-control" placeholder="Hotel Name" DBColumnName="NAMA_HOTEL" SPParameterName="p_nama_hotel"  DataType="String" BindType="Both" ></cc1:XUITextBox>
                            </div>
                        </div>                            
                    </div>
                  </div>
                  <div class="row">  
                     <div class="col-sm-6" ID="CID" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Check In Date</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtCheckIndate" runat="server" CssClass="form-control default-date-picker" placeholder="Departure Time" DBColumnName="WAKTU_KEBERANGKATAN" SPParameterName="p_waktu_keberangkatan" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtCheckIndate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                            
                    </div> 
                   <div class="col-sm-6" ID="CKS" runat="server">
                        <div class="form-group">
                            <label class="col-sm-4">Check Out Date</label>
                            <div class="col-sm-4">
                                <cc1:XUITextBox ID="txtCheckOutdate" runat="server" CssClass="form-control default-date-picker" placeholder="Departure Time" DBColumnName="WAKTU_TIBA" SPParameterName="p_waktu_tiba" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtCheckOutdate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
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
            </div>
    </section>
</asp:Content>

