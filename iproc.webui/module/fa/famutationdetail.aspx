<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="famutationdetail.aspx.cs" Inherits="module_fa_famutationdetail" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Item Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton RoleCode="R90000080E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal"> 
           <!--ID-->
           <cc1:XUILabel ID="lblID" runat="server" DBColumnName="ID" SPParameterName="p_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUILabel>
           <!--Barcode-->
           <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="FA_MUTATION_CODE" SPParameterName="p_fa_mutation_code" DataType="String" BindType="UIToDBOnly" style="Display:none;" ></cc1:XUILabel>
           <!--FA_Asset_ID-->
           <cc1:XUITextBox ID="txtFaID" runat="server" DBColumnName="FA_ASSET_ID" SPParameterName="p_fa_asset_id" DataType="Integer" BindType="Both" Text= "0" style="Display:none;" ></cc1:XUITextBox>
           <!--Location-->
           <cc1:XUITextBox ID="txtLocation" runat="server" DBColumnName="CURRENT_BRANCH" DataType="String" BindType="DBToUIOnly"  style= "display:none;"></cc1:XUITextBox> 
           <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">FM No.</label>
                        <div class="col-sm-8">
                            <cc1:XUILabel ID="lblFaMutationCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" ></cc1:XUILabel>
                            <cc1:XUILabel ID="lblFMStatus" runat="server" DBColumnName="FM_STATUS" DataType="String" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                        </div>
                    </div>                            
                </div> 
            </div> 
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Asset Code *</label>
                        <div class="col-sm-8">
                            <asp:LinkButton runat="server" ID="btnLookUpFaAsset" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>         
                            <cc1:XUILabel ID="lblBarcode" runat="server" DBColumnName="ASSET_BARCODE" SPParameterName="p_barcode" DataType="String" BindType="Both" ></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtBarcode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ASSET_BARCODE" SPParameterName="p_barcode" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvAssetCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtBarcode" Display="Dynamic"></asp:RequiredFieldValidator> 
                        </div>
                    </div>                            
                </div> 
            </div> 
            <div class="row">
                <div class="col-sm-6" style="display:none">
                    <div class="form-group">
                        <label class="col-sm-4">Asset Code *</label> 
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtAssetCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ASSET_CODE" SPParameterName="p_code_asset" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <cc1:XUILabel ID="lblAssetCode" runat="server"  DBColumnName="ASSET_CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>  
                            <%--<asp:RequiredFieldValidator ID="rfvAssetCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAssetCode" Display="Dynamic"></asp:RequiredFieldValidator> --%> 
                       </div>
                    </div>                            
                </div> 
                 <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 ">Asset Name</label>
                        <div class="col-sm-6">
                            <cc1:XUILabel ID="lblAssetName" runat="server" DBColumnName="ASSET_NAME" SPParameterName="p_name_asset" DataType="String" BindType="Both" MaxLength= "60" ></cc1:XUILabel>
                            <cc1:XUITextBox ID="txtNameAsset" style="display:none" runat="server"  CssClass="form-control" DBColumnName="ASSET_NAME" MaxLength="20" DataType="String" BindType="DBToUIOnly"></cc1:XUITextBox>
                       </div>
                    </div>                            
                </div>     
            </div>
             <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">From Cost Center</label>
                                <div class="col-sm-8">
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                   <%-- <cc1:XUIDropDownList ID="ddlFromcc" runat="server" CssClass="form-control" DBColumnName="FROM_COST_CENTER" SPParameterName="p_from_cost_center" DataType="String"  BindType="Both" ></cc1:XUIDropDownList>--%>
                                   <cc1:XUILabel ID="lblFromcc" runat="server" DBColumnName="COST_CENTER" DataType="String" BindType="DBToUIOnly" MaxLength= "60" ></cc1:XUILabel>
                                    <cc1:XUITextBox ID="txtFromcc" runat="server"  CssClass="form-control" DBColumnName="FROM_COST_CENTER" MaxLength="20" SPParameterName="p_from_cost_center" DataType="String" style="display:none;" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                             
                        </div> 
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">To Cost Center *</label>
                                <div class="col-sm-8">
                                  <asp:UpdatePanel ID="updDep" runat="server">
                                   <ContentTemplate>
                                    <%--<cc1:XUILabel ID="lblBranch" runat="server"  DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel> --%>
                                    <cc1:XUIDropDownList ID="ddlTocc" runat="server" CssClass="form-control" DBColumnName="TO_COST_CENTER" SPParameterName="p_to_cost_center" DataType="String" OnSelectedIndexChanged= "ddlTocc_SelectedIndexChanged" AutoPostBack= "true"  BindType="Both" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblTocc" runat="server"  DBColumnName="TO_COST_CENTER" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                    <asp:RequiredFieldValidator ID="rfvTocc" runat="server" ErrorMessage="Required Field!" InitialValue="0" ControlToValidate="ddlTocc" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </ContentTemplate>
                                  </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div> 
                     </div>
                <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">From Location</label>
                        <div class="col-sm-8">
                             <cc1:XUITextBox ID="txtFromLocation" runat="server"  CssClass="form-control" DBColumnName="FROM_LOCATION_CODE" Enabled="false" MaxLength="20" SPParameterName="p_from_location_code" DataType="String" BindType="Both" style="display:none;"></cc1:XUITextBox>
                             <cc1:XUILabel ID="lblFromLocation" runat="server" DBColumnName="LOCATION" DataType="String" BindType="DBToUIOnly" MaxLength= "60" ></cc1:XUILabel>
                           <%--<cc1:XUIDropDownList ID="ddlFromLocationCode" runat="server" CssClass="form-control" DBColumnName="FROM_LOCATION_CODE" SPParameterName="p_from_location_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>--%>                                                 
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-3">To Location *</label>
                        <div class="col-sm-8">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                           <ContentTemplate>
                           <cc1:XUIDropDownList ID="ddlToLocationCode" runat="server" CssClass="form-control" DBColumnName="TO_LOCATION_CODE" SPParameterName="p_to_location_code" BindType="Both" DataType="String" ></cc1:XUIDropDownList>
                           <asp:RequiredFieldValidator ID="rfvToLocationCode" runat="server" ErrorMessage="Required Field!" InitialValue="0" ControlToValidate="ddlToLocationCode" Display="Dynamic"></asp:RequiredFieldValidator>
                           </ContentTemplate>
                           <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlTocc" EventName="SelectedIndexChanged" />
                            </Triggers>
                         </asp:UpdatePanel>                                     
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row"> 
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Description *</label> 
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="100" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,100}$" ErrorMessage="Exceed maximum length 100" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div> 
             </div>
    </section>
</asp:Content>

