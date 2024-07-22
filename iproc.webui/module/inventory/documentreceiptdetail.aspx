<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="documentreceiptdetail.aspx.cs" Inherits="module_inventory_documentreceiptdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Document Receipt Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R60000143E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
            
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Document Receipt No.</label>
                                <div class="col-sm-8">
                                    <!--ID-->
                                    <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="String" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
                                    <!--Barcode-->
                                    <cc1:XUILabel ID="lblTrxCode" runat="server" DBColumnName="TRX_CODE" SPParameterName="p_trx_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
                                    <!--Status Flag-->
                                    <cc1:XUILabel ID="lblIECode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                                     <cc1:XUILabel ID="lblIEStatus" runat="server" DBColumnName="IE_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="STATUS" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>                  
                    </div> 
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">No Resi *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDocumentNo" runat="server" CssClass="form-control" placeholder="Document No" DBColumnName="DOCUMENT_NO" SPParameterName="p_document_no" DataType="String" BindType="Both" MaxLength="50"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDocumentNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDocumentNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>  
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Document Category *</label>    
                                <div class="col-sm-8">
                                    <cc1:XUIDropDownList ID="ddlDocumentCategory" runat="server"  CssClass="form-control" DBColumnName="DOCUMENT_CATEGORY" SPParameterName="p_document_category"  DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="rfvddlRequirementType" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlDocumentCategory" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>       
                    </div>
                     <div class="row">
                         <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-4">Shipper Name *</label>
                                    <div class="col-sm-8">
                                        <cc1:XUITextBox ID="txtShipperName" runat="server" CssClass="form-control" placeholder="Shipper Name" DBColumnName="SHIPPER" SPParameterName="p_shipper" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvShipperName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtShipperName" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>                            
                          </div>
                           <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Document Name *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDocumentName" runat="server" CssClass="form-control" placeholder="Document Name" DBColumnName="DOCUMENT_NAME" SPParameterName="p_document_name" DataType="String" BindType="Both" MaxLength="250"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDocumentName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDocumentName" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>  
                    </div>    
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Document Pic *</label> 
                                <div class="col-sm-8">
                                    <asp:LinkButton runat="server" ID="btnLookUpUserRequest" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                        <cc1:XUITextBox ID="txtDocumentPIC" style="display:none" runat="server" CssClass="form-control" DBColumnName="DOCUMENT_PIC" SPParameterName="p_document_pic" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblSupplierName" runat="server"  DBColumnName="PIC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                       
                                    <asp:RequiredFieldValidator ID="rfvDocumentPIC" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDocumentPIC" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>                            
                            </div>  
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">File Name</label>
                                <div class="col-sm-8">
                                <cc1:XUILabel ID="lblFILE" runat="server" DBColumnName="FILE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblPATH" runat="server" DBColumnName="PATHS" DataType="String" BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                                    <asp:FileUpload ID="fupFilename" runat="server"></asp:FileUpload>
                                    <asp:Label ID="btnPreviewDoc" runat="server">Preview</asp:Label>
                                </div>                            
                            </div>
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-6" ID="RL" runat="server">
                            <div class="form-group">
                                <label class="col-sm-4" >Receive Location * </label>
                                <div class="col-sm-8">
                  <%--                  <asp:LinkButton runat="server" ID="btnReceiveLocation" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>                             
                                    <cc1:XUITextBox ID="txtReceiveLocation" runat="server" style="display:none"  CssClass="form-control" DBColumnName="RECEIVE_LOCATION" SPParameterName="p_receive_location" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblReceiveLocation" runat="server"  DBColumnName="FROM_LOCATION_DESC" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  --%>
                                    <cc1:XUIDropDownList ID="ddlReceiveLocation" runat="server" CssClass="form-control" placeholder="" DBColumnName="RECEIVE_LOCATION" SPParameterName="p_receive_location"  MaxLength="10" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlReceiveLocation" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                </div>
                            </div>                            
                        </div>
                         <div id="Div1" class="col-sm-6" runat="server">
                                <div class="form-group">
                                    <label class="col-sm-4">Floor *</label>
                                       <div class="col-sm-8">
                                        <cc1:XUIDropDownList ID="ddlRating" runat="server" CssClass="form-control" DBColumnName="FLOOR" SPParameterName="p_floor" BindType="Both"  DataType="String">
                                            <asp:ListItem Value="0" >-=Select=-</asp:ListItem>
                                            <asp:ListItem Value="1" >1</asp:ListItem>
                                            <asp:ListItem Value="2" >2</asp:ListItem>
                                            <asp:ListItem Value="3" >3</asp:ListItem>
                                            <asp:ListItem Value="5" >5</asp:ListItem>
                                            <asp:ListItem Value="6" >6</asp:ListItem>
                                            <asp:ListItem Value="7" >7</asp:ListItem>
                                            <asp:ListItem Value="8" >8</asp:ListItem>
                                            <asp:ListItem Value="9" >9</asp:ListItem>
                                        </cc1:XUIDropDownList>
                                        <asp:RequiredFieldValidator ID="rfvRating" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlRating" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                    </div>
                                </div>
                            </div>
                         </div>
                        <div class="row"> 
                             <div id="Div2" class="col-sm-6" runat="server">
                                <div class="form-group">
                                    <label class="col-sm-4">Type *</label>
                                       <div class="col-sm-8">
                                        <cc1:XUIDropDownList ID="ddlType" runat="server" CssClass="form-control" DBColumnName="TYPE" SPParameterName="p_type" BindType="Both" DataType="String">
                                            <asp:ListItem Value="0" >-=Select=-</asp:ListItem>
                                            <asp:ListItem Value="Doc" >Document</asp:ListItem>
                                            <asp:ListItem Value="Pac" >Package</asp:ListItem>
                                        </cc1:XUIDropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>                       
                            <div class="col-sm-6">
                                <div class="form-group">
                                <label class="col-sm-4">Remarks</label>
                                <div class="col-sm-6">
                                <cc1:XUITextBox ID="txtRemarks" runat="server"  CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" MaxLength="400" DataType="String" BindType="Both" TextMode="MultiLine" ></cc1:XUITextBox>
                                <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>                             
                    </div> 
                </div>       
            </div>
           
    </section>
</asp:Content>

