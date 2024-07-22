<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="documentreceiptheader.aspx.cs" Inherits="module_inventory_documentreceiptheader" Title="Untitled Page" %>

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
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R60000143C" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnApprove" RoleCode="R60000143O" runat="server" CssClass="btn btn-success"><i class="icon-envelope"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnReject" RoleCode="R60000143O" runat="server" CssClass="btn btn-danger"  CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                   
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Trx. Code</label>
                                <!--CODE BARCODE-->
                                <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="50" DataType="String" style="display:none" BindType="Both"></cc1:XUILabel>
                                <cc1:XUITextBox ID="txtBranch" runat="server" CssClass="form-control"  DBColumnName="BRANCH" DataType="String" BindType="None" style="display:none" ></cc1:XUITextBox>
                                <%--<cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="APPROVAL_REQUEST_TARGET_ID" DataType="Integer" BindType="None" style="display:none;"></cc1:XUILabel>--%>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" SPParameterName="p_code" DataType="String" BindType="Both" Text="--"></cc1:XUILabel>
                                </div>
                                 <div class="col-sm-3">
                                      <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Mutation History"></cc1:XUILinkButton>
                          </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblTransFlagCode" runat="server" DBColumnName="TRANS_FLAG_CODE" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                </div>
                                
                            </div>                            
                        </div>
                         
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Date *</label>
                                <div class="col-sm-3">
                                    <cc1:XUITextBox ID="txtTrxDate" runat="server" CssClass="form-control default-date-picker" placeholder="Date" DBColumnName="TRX_DATE" SPParameterName="p_trx_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvTrxDate" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtTrxDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                    <asp:RegularExpressionValidator ID="revTrxDate" runat="server" ErrorMessage="Format Date Invalid! Format = dd/MM/yyyy" ControlToValidate="txtTrxDate" ValidationExpression="(^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$)" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>                            
                        </div>    
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Branch *</label>
                                <div class="col-sm-8">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                </div>
                            </div>                             
                        </div>                     
                    </div>
                    <div class="row">
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Receiver Name *</label> 
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpUserRequest" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                </div>  
                                    <div class="col-sm-5">  
                                        <cc1:XUITextBox ID="txtSupplierID"  runat="server" CssClass="form-control" DBColumnName="EMPLOYEE_CODE" SPParameterName="p_employee_code" MaxLength="10" DataType="String" style="display:none;" BindType="Both"></cc1:XUITextBox>
                                        
                                        <cc1:XUILabel ID="lblSupplierName" runat="server"  DBColumnName="EMP_NAME" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>                       
                                   <%-- <asp:RequiredFieldValidator ID="rfvRequestorName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplierID" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>                            
                            </div>
                            <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Document Status</label>
                                <div class="col-sm-8">
                                    <cc1:XUILabel ID="lblDocStatus" runat="server" DBColumnName="STATUS" BindType="DBToUIOnly" DataType="String" Text="--"></cc1:XUILabel>
                                </div>
                            </div>                            
                        </div>      
                   </div>
                    <div class="row">
                      <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Document Name</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDocumentName" runat="server" CssClass="form-control" placeholder="Document Name" DBColumnName="DOCUMENT_NAME" SPParameterName="p_document_name" DataType="String" BindType="Both" MaxLength="250"></cc1:XUITextBox>
                                  
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
                      <div class="row">
                         <div class="col-sm-6">
                                <div class="form-group">
                                </div>
                         </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Document Pic </label> 
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpPIC" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                </div>
                                <div class="col-sm-5">     
                                        <cc1:XUITextBox ID="txtDocumentPIC" style="display:none" runat="server" CssClass="form-control" DBColumnName="DOCUMENT_PIC" SPParameterName="p_document_pic" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                          <cc1:XUITextBox ID="txtFreeRequestor"  runat="server" CssClass="form-control" DBColumnName="RECEIVER_FREE_NAME" SPParameterName="p_receiver_free_name" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                        <cc1:XUILabel ID="lblPIC" runat="server"  DBColumnName="PIC" DataType="String"  style="display:none" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> 
                                </div>                            
                            </div>
                          </div>
                       </div>
                       
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">No Resi *</label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtDocumentNo" runat="server" CssClass="form-control" placeholder="Document No" DBColumnName="DOCUMENT_NO" SPParameterName="p_document_no" DataType="String" BindType="Both" MaxLength="50"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvDocumentNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDocumentNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div> 
                    </div>    
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4"></label>
                                <div class="col-sm-8">
                                <cc1:XUILabel ID="lblFILE" runat="server" DBColumnName="FILE" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                                <cc1:XUILabel ID="lblPATH" runat="server" DBColumnName="PATHS" DataType="String" BindType="DBToUIOnly" style="display:none;"></cc1:XUILabel>
                                    <asp:FileUpload ID="fupFilename" runat="server" style="display:none"></asp:FileUpload>
                                    <asp:Label ID="btnPreviewDoc" runat="server" style="display:none"></asp:Label>
                                </div>                            
                            </div>
                        </div>
                          <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Expedition</label> 
                                <div class="col-sm-1">
                                    <asp:LinkButton runat="server" ID="btnLookUpShipper" class="btn btn-primary"  data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    </div>
                                     <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtTrxCode" runat="server"  CssClass="form-control" DBColumnName="EXPEDISI" SPParameterName="p_expedisi" DataType="String" MaxLength="18" BindType="Both" style="display:none"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDescription"  runat="server" DBColumnName="EXPEDISI" DataType="String" BindType="DBToUIOnly" Text="--"  Enabled="false" Width="200px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSupplier" Display="Dynamic"></asp:RequiredFieldValidator> --%>
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
                </ContentTemplate>
                <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnApprove" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnReject" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    
    <%--<section class="panel" id="ItemList">
        <header class="panel-heading">
          <span>Detail List</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8 ">
                     <cc1:XUILinkButton RoleCode="R60000143E" ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R60000143D" ID="btnDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDelete_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                  <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search" ></i>  Search</asp:LinkButton>
                        </div>
                   </asp:Panel>
                </div>
            </div>   
        </div>                   
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwList_PageIndexChanging" 
                        onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There is no data" Width="100%" >
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <span>No</span>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>                             
                            <asp:BoundField DataField="DOCUMENT_CATEGORY" HeaderText="Document Category">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField> 
                            <asp:BoundField DataField="DOCUMENT_NO" HeaderText="No Resi">
                                <ItemStyle Width="15%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                              <asp:BoundField DataField="AGING" HeaderText="Aging">
                                <ItemStyle Width="10%" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DOCUMENT_NAME" HeaderText="Document Name">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="EMP_NAME" HeaderText="Document PIC">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="CONFIRM_DATE" HeaderText="Confirm Date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="GOOD_STATUS" HeaderText="Document Status">
                                <ItemStyle Width="20%"/>
                            </asp:BoundField>
                     <%--        <asp:BoundField DataField="GOOD_STATUS" HeaderText="Status" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle Width="10%"/>
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>--%>
</asp:Content>